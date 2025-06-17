<?php
require_once dirname(__DIR__, 2) . '/Entities/Order.php';

class ViewOrderCtrl {
    private $order;

    public function __construct() {
        $this->order = new Order();
    }

    public function getOrderDetails($orderID) {
        if (!is_numeric($orderID) || intval($orderID) <= 0) {
            return ['error' => 'Invalid order number.'];
        }

        $order = $this->order->findById($orderID);
        if (!$order) {
            return ['error' => 'No order found with that ID.'];
        }

        return ['data' => $order];
    }
}
