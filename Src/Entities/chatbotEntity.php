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

    public function fetchRecentMessages(string $username, int $limit = 1000): array
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
    /* ---------- 3. Admin helpers (listing & drill-down) ---------- */

    /**
     * List conversations grouped by username with counts and timestamps.
     * Returns: ['rows' => [...], 'total' => int]
     *
     * Each row: [
     *   'username'   => string,
     *   'started_at' => string (YYYY-MM-DD HH:MM:SS),
     *   'last_at'    => string,
     *   'msg_count'  => int
     * ]
     */
    public function listConversations(
        string $search = '',
        int $page = 1,
        int $perPage = 20,
        string $order = 'last'  // 'last' or 'started'
    ): array {
        $page = max(1, (int)$page);
        $perPage = min(max(5, (int)$perPage), 100);
        $offset = ($page - 1) * $perPage;

        // sanitize order
        $orderBy = ($order === 'started') ? 'started_at DESC' : 'last_at DESC';

        // search filter on username or message_text
        $where = '';
        $params = [];
        if ($search !== '') {
            $where = "WHERE (username LIKE :like OR message_text LIKE :like)";
            $params[':like'] = '%' . $search . '%';
        }

        // total conversations (grouped by username)
        $sqlTotal = "
            SELECT COUNT(*) AS c FROM (
                SELECT username
                FROM chat_messages
                $where
                GROUP BY username
            ) t
        ";
        $stmt = $this->db->prepare($sqlTotal);
        foreach ($params as $k => $v) $stmt->bindValue($k, $v);
        $stmt->execute();
        $total = (int)($stmt->fetchColumn() ?: 0);
        $stmt->closeCursor();

        // page of grouped rows
        $sql = "
            SELECT
                username,
                MIN(created_at) AS started_at,
                MAX(created_at) AS last_at,
                COUNT(*) AS msg_count
            FROM chat_messages
            $where
            GROUP BY username
            ORDER BY $orderBy
            LIMIT :offset, :limit
        ";
        $stmt = $this->db->prepare($sql);
        foreach ($params as $k => $v) $stmt->bindValue($k, $v);
        $stmt->bindValue(':offset', (int)$offset, PDO::PARAM_INT);
        $stmt->bindValue(':limit', (int)$perPage, PDO::PARAM_INT);
        $stmt->execute();
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();

        return ['rows' => $rows, 'total' => $total];
    }

    /**
     * Fetch the full message thread for one "conversation" (by username),
     * ordered chronologically.
     *
     * Returns: array of rows [
     *   'sender'       => 'user'|'bot',
     *   'message_text' => string,
     *   'created_at'   => string
     * ]
     */
    public function getConversationByUsername(string $username, int $limit = 1000): array {
        $limit = max(1, (int)$limit);

        $sql = "
            SELECT sender, message_text, created_at
            FROM chat_messages
            WHERE username = :u
            ORDER BY created_at ASC
            LIMIT :lim
        ";
        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':u', $username, PDO::PARAM_STR);
        $stmt->bindValue(':lim', $limit, PDO::PARAM_INT);
        $stmt->execute();
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $rows;
    }

}
