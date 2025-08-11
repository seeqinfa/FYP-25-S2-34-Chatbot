<?php
require_once dirname(__DIR__) . '/db_connect.php';

class Support_Tickets {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    /** Fetch all tickets, newest first */
    public function getAllTickets(): array {
        $sql = "SELECT id, user_id, assigned_admin_id, subject, message, status, created_at
                FROM support_tickets
                ORDER BY created_at DESC";
        $result = mysqli_query($this->conn, $sql);
        if (!$result) {
            throw new Exception("DB error fetching tickets: " . mysqli_error($this->conn));
        }
        $tickets = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $tickets[] = $row;
        }
        return $tickets;
    }

    /** Single ticket by id */
    public function getTicketById(int $ticketId): ?array {
        $stmt = mysqli_prepare($this->conn, "SELECT id, user_id, assigned_admin_id, subject, message, status, created_at FROM support_tickets WHERE id = ?");
        mysqli_stmt_bind_param($stmt, "i", $ticketId);
        if (!mysqli_stmt_execute($stmt)) {
            throw new Exception("DB error fetching ticket: " . mysqli_error($this->conn));
        }
        $res = mysqli_stmt_get_result($stmt);
        $row = mysqli_fetch_assoc($res);
        return $row ?: null;
    }

    /** Assign to an admin (column may be NULL) */
    public function assignToAdmin(int $ticketId, ?int $adminId): bool {
        $stmt = mysqli_prepare($this->conn, "UPDATE support_tickets SET assigned_admin_id = ? WHERE id = ?");
        mysqli_stmt_bind_param($stmt, "ii", $adminId, $ticketId);
        return mysqli_stmt_execute($stmt);
    }

    /** Update ticket status: open/responded/resolved */
    public function updateStatus(int $ticketId, string $status): bool {
        $allowed = ['open','responded','resolved'];
        if (!in_array($status, $allowed, true)) {
            throw new InvalidArgumentException("Invalid status");
        }
        $stmt = mysqli_prepare($this->conn, "UPDATE support_tickets SET status = ? WHERE id = ?");
        mysqli_stmt_bind_param($stmt, "si", $status, $ticketId);
        return mysqli_stmt_execute($stmt);
    }

    /** Add a reply from an admin; also records created_at */
    public function addReply(int $ticketId, ?int $adminId, string $message): bool {
        $stmt = mysqli_prepare($this->conn, "INSERT INTO ticket_replies (ticket_id, admin_id, message) VALUES (?, ?, ?)");
        mysqli_stmt_bind_param($stmt, "iis", $ticketId, $adminId, $message);
        return mysqli_stmt_execute($stmt);
    }

    /** Get all replies for a ticket */
    public function getReplies(int $ticketId): array {
        $stmt = mysqli_prepare($this->conn, "SELECT id, ticket_id, admin_id, message, created_at FROM ticket_replies WHERE ticket_id = ? ORDER BY created_at ASC");
        mysqli_stmt_bind_param($stmt, "i", $ticketId);
        if (!mysqli_stmt_execute($stmt)) {
            throw new Exception("DB error fetching replies: " . mysqli_error($this->conn));
        }
        $res = mysqli_stmt_get_result($stmt);
        $rows = [];
        while ($row = mysqli_fetch_assoc($res)) {
            $rows[] = $row;
        }
        return $rows;
    }
}
?>