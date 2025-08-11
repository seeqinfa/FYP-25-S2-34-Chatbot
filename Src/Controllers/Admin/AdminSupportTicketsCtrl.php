<?php
require_once dirname(__DIR__, 2) . '/Entities/Support_Tickets.php';

class AdminSupportTicketsCtrl {
    private $ticketEntity;

    public function __construct() {
        global $conn;
        $this->ticketEntity = new Support_Tickets($conn);
    }

    public function getAllTickets(): array {
        return $this->ticketEntity->getAllTickets();
    }

    public function getTicketDetails(int $ticketId): ?array {
        return $this->ticketEntity->getTicketById($ticketId);
    }

    public function getTicketReplies(int $ticketId): array {
        return $this->ticketEntity->getReplies($ticketId);
    }

    public function respondToTicket(int $ticketId, ?int $adminId, string $message): bool {
        $message = trim($message);
        if ($message === '') {
            throw new InvalidArgumentException("Please fill in message.");
        }
        $ok = $this->ticketEntity->addReply($ticketId, $adminId, $message);
        if ($ok) {
            // Mark ticket as responded
            $this->ticketEntity->updateStatus($ticketId, 'responded');
        }
        return $ok;
    }

    public function assignTicket(int $ticketId, ?int $adminId): bool {
        return $this->ticketEntity->assignToAdmin($ticketId, $adminId);
    }

    public function updateTicketStatus(int $ticketId, string $status): bool {
        return $this->ticketEntity->updateStatus($ticketId, $status);
    }
}
?>