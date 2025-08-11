from typing import Any, Text, Dict, List, Optional
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import SlotSet, EventType
import urllib.parse
import re
import string

# -------------------------------------------------------------------
# Shared data / constants
# -------------------------------------------------------------------

# Canonical product names
CANON = {
    "ergo chair": "Ergo Chair",
    "coffee table": "Coffee Table",
    "tv console": "TV Console",
    "bookshelf classic": "Bookshelf Classic",
    "queen bed frame": "Queen Bed Frame",
    "recliner seat": "Recliner Seat",
}

# Words to ignore when trying to pull a name from free text
GENERIC_WORDS = {
    "manual", "instructions", "instruction", "guide", "assembly",
    "please", "pls", "for", "the", "a", "an"
}

# example orders
mock_orders = {
    "12345": {"status": "processing"},
    "56789": {"status": "shipped"},
    "987654": {"status": "processing"},
    "23057": {"status": "shipped"},
    "23058": {"status": "delivered"},
}

# -------------------------------------------------------------------
# Existing actions (keep these as-is for your teammates)
# -------------------------------------------------------------------

class ActionCancelOrder(Action):
    def name(self) -> Text:
        return "action_cancel_order"

    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]
    ) -> List[Dict[Text, Any]]:

        order_id = tracker.get_slot("order_id")
        print(f"DEBUG: order_id slot value = {order_id}")

        if not order_id:
            dispatcher.utter_message(text="I need your order ID to cancel your order.")
            return []

        order = mock_orders.get(order_id)

        if not order:
            dispatcher.utter_message(response="utter_no_order_found")
            return []

        if order["status"] == "shipped":
            dispatcher.utter_message(
                text=f"Sorry, order {order_id} has already been shipped and cannot be canceled."
            )
        else:
            dispatcher.utter_message(
                response="utter_order_canceled",
                text=f"Your order {order_id} has been canceled successfully.",
            )

        return []


class ActionCheckOrder(Action):
    def name(self) -> Text:
        return "action_check_order"

    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]
    ) -> List[Dict[Text, Any]]:

        order_id = tracker.get_slot("order_id")
        print(f"DEBUG: order_id slot value = {order_id}")

        if not order_id:
            dispatcher.utter_message(text="I need your order ID to check the status.")
            return []

        order = mock_orders.get(order_id)

        if order:
            dispatcher.utter_message(text=f"Your order {order_id} is currently {order['status']}.")
        else:
            dispatcher.utter_message(response="utter_no_order_found")

        return []


class SubmitFeedbackForm(Action):
    def name(self) -> str:
        return "action_store_feedback"

    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[str, Any]
    ) -> List[Dict[str, Any]]:

        feedback = tracker.get_slot("feedback_text")
        print("Collected feedback:", feedback)
        print("All slots:", tracker.slots)

        return []


# -------------------------------------------------------------------
# NEW (grouped): Manual search helpers & actions
# -------------------------------------------------------------------

BASE_MANUAL_URL = (
    "http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php"
)

def _normalize_name(text: Optional[str]) -> Optional[str]:
    """Map free text to a canonical product name using CANON + simple cleanup."""
    if not text:
        return None
    t = re.sub(r"[^a-zA-Z0-9\s]", " ", text.lower())
    tokens = [w for w in t.split() if w and w not in GENERIC_WORDS]
    if not tokens:
        return None
    s = " ".join(tokens)
    # longest-key-first contains check
    for k in sorted(CANON.keys(), key=len, reverse=True):
        if k in s:
            return CANON[k]
    # exact token match
    for tok in tokens:
        if tok in CANON:
            return CANON[tok]
    return None

def _manual_link_from_query(raw_query: str) -> str:
    """Build the manual search link with the user's query."""
    return f"{BASE_MANUAL_URL}?q={urllib.parse.quote(raw_query)}"

def _extract_product(raw_text: str, entities: Optional[List[Dict[str, Any]]]) -> Optional[str]:
    """Resolve a product from latest message via entity → regex → normalization."""
    # 1) Entity (latest turn)
    for e in (entities or []):
        if e.get("entity") == "furniture_name" and e.get("value"):
            n = _normalize_name(e["value"])
            if n:
                return n

    # 2) Regex exact match over our known product names (keys of CANON are lower-case)
    pattern = r"\b(?:%s)\b" % "|".join(re.escape(k) for k in CANON.keys())
    m = re.search(pattern, raw_text.lower())
    if m:
        return CANON[m.group(0)]

    # 3) Fallback: normalization heuristic
    return _normalize_name(raw_text)

def _send_clickable_link(dispatcher: CollectingDispatcher, title: str, link: str) -> None:
    """
    Send an HTML anchor and a URL button (channels that support it),
    plus include the plain URL as fallback.
    """
    html_text = f'{title}:<br><a href="{link}" target="_blank" rel="noopener noreferrer">Open manual search</a><br>{link}'
    try:
        dispatcher.utter_message(
            text=html_text,
            buttons=[{"title": "Open manual search", "url": link}]
        )
    except Exception:
        dispatcher.utter_message(text=f"{title}: {link}")

class ActionGetManual(Action):
    def name(self) -> Text:
        return "action_get_manual"

    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]
    ) -> List[EventType]:
        import string

        raw = tracker.latest_message.get("text") or ""
        raw_query = raw.strip().strip(string.punctuation)

        # Resolve product ONLY from the latest user message (entity → regex → normalize)
        canonical = _extract_product(raw, tracker.latest_message.get("entities"))

        if not canonical:
            # No product found in this turn → ask which item (don’t reuse old slot)
            try:
                dispatcher.utter_message(response="utter_ask_manual_furniture")
            except Exception:
                dispatcher.utter_message(text="Which furniture item do you need the instruction manual for?")
            # clear any stale value just in case
            return [SlotSet("manual_furniture", None)]

        # Build link using the detected product (so the search box is clean)
        link = _manual_link_from_query(canonical)

        # Send clickable link (HTML + plain URL as fallback via helper)
        title = f"Here’s the instruction manual search for <b>{canonical}</b>"
        _send_clickable_link(dispatcher, title, link)

        # Remember the latest product for follow-ups (e.g., “now for TV Console”)
        return [SlotSet("manual_furniture", canonical)]
    
class ActionResetManualSlot(Action):
    def name(self) -> Text:
        return "action_reset_manual_slot"

    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]
    ) -> List[EventType]:
        return [SlotSet("manual_furniture", None)]