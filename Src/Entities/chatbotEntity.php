<?php
class ChatbotEntity {
    public function getBotResponse($message) {
        $msg = strtolower(trim($message));

        if (empty($msg)) return "Please type something so I can help!";

        if (strpos($msg, 'hello') !== false || strpos($msg, 'hi') !== false) {
            return "Hello there! How can I assist you today?";
        } elseif (strpos($msg, 'price') !== false) {
            return "Prices vary depending on the item. Can you tell me which furniture you're looking at?";
        } elseif (strpos($msg, 'table') !== false) {
            return "We offer wooden, glass, and folding tables. Do you have a preference?";
        } elseif (strpos($msg, 'delivery') !== false) {
            return "We offer free delivery on orders above $100!";
        } elseif (strpos($msg, 'bye') !== false) {
            return "Goodbye! Have a great day!";
        }

        return "I'm not sure how to respond to that. You can ask me about furniture, pricing, or delivery.";
    }
}
?>
