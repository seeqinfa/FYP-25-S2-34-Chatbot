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

     public function cancelOrder($orderId)
    {
        $order = $this->order->findById($orderId);

        if (!$order) {
            return ['error' => 'Order not found.'];
        }

        if (in_array($order['order_status'], ['Cancelled', 'Shipped', 'Delivered'])) {
            return ['error' => 'This order can no longer be cancelled.'];
        }

        return $this->order->updateStatus($orderId, 'Cancelled')
            ? ['success' => true]
            : ['error' => 'Failed to cancel order.'];
    }
}
