<?php
require_once dirname(__DIR__, 2) . '/src/db_connect.php';

class Order {
    private $conn;

    public function __construct() {
        global $conn;
        $this->conn = $conn;
    }

    public function findById($orderID) {
        $query = "SELECT * FROM orders WHERE order_id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param('i', $orderID);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }
}
