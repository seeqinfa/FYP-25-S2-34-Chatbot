from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher

# example orders
mock_orders = {
    "12345": {"status": "processing"},
    "56789": {"status": "shipped"},
    "987654": {"status": "processing"},
    "23057": {"status": "shipped"},
    "23058": {"status": "delivered"}
}

class ActionCancelOrder(Action):
    def name(self) -> Text:
        return "action_cancel_order"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

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
            dispatcher.utter_message(text=f"Sorry, order {order_id} has already been shipped and cannot be canceled.")
        else:
            dispatcher.utter_message(response="utter_order_canceled", text=f"Your order {order_id} has been canceled successfully.")

        return []

class ActionCheckOrder(Action):
    def name(self) -> Text:
        return "action_check_order"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

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
