<?php
/**
 * ChatbotEntity  –  contains:
 *   • getBotResponse()         → returns bot reply text
 *   • saveMessage()            → inserts one row
 *   • fetchRecentMessages()    → array of {sender, message_text}
 */
require_once dirname(__DIR__) . '/config.php';   // defines global $pdo

class ChatbotEntity
{
    private PDO $db;

    public function __construct(PDO $db = null)
    {
        $this->db = $db ?? $GLOBALS['pdo'];
    }

    /* ---------- 1. Business logic (reply) ---------- */
    public function getBotResponse(string $input): string
    {
        $input = strtolower(trim($input));

        if ($input === '') {
            return "Say something and I'll try to help!";
        }
        if (str_contains($input, 'furniture')) {
            return 'Check the "View Furniture" page for our catalogue.';
        }
        if (str_contains($input, 'order')) {
            return 'Use the “My Orders ▾” menu to view your cart or order.';
        }
        return "ask me about furniture or orders.";
    }

    /* ---------- 2. Persistence helpers ---------- */
    public function saveMessage(
        string $username,
        string $sender,  // 'user' | 'bot'
        string $text
    ): void {
        $stmt = $this->db->prepare(
            "INSERT INTO chat_messages (username, sender, message_text)
             VALUES (:u, :s, :t)"
        );
        $stmt->execute([':u'=>$username, ':s'=>$sender, ':t'=>$text]);
    }

    public function fetchRecentMessages(string $username, int $limit = 100): array
    {
        $limit = (int)$limit;
        $stmt = $this->db->prepare(
            "SELECT sender, message_text
               FROM chat_messages
              WHERE username = :u
              ORDER BY created_at ASC
              LIMIT $limit"
        );
        $stmt->execute([':u'=>$username]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
