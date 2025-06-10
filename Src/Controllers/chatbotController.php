<?php
require_once dirname(__DIR__) . '/Entities/chatbotEntity.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $message = trim($_POST['message'] ?? '');

    $chatbot = new ChatbotEntity();
    $response = $chatbot->getBotResponse($message);

    echo json_encode(['response' => $response]);
    exit();
}
?>
