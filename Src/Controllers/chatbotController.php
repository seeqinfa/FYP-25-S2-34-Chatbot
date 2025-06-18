<?php
session_start();
header('Content-Type: application/json');

if (empty($_SESSION['is_logged_in'])) {
    echo json_encode(['error' => 'not_logged_in']);
    exit;
}

require_once __DIR__ . '/../Entities/ChatbotEntity.php';

$username = $_SESSION['username'];
$message  = trim($_POST['message'] ?? '');
if ($message === '') {
    echo json_encode(['error' => 'empty']);
    exit;
}

$bot = new ChatbotEntity();

/* 1. save user msg */
$bot->saveMessage($username, 'user', $message);

/* 2. get reply + save it */
$reply = $bot->getBotResponse($message);
$bot->saveMessage($username, 'bot', $reply);

/* 3. return reply */
echo json_encode(['response' => $reply]);
