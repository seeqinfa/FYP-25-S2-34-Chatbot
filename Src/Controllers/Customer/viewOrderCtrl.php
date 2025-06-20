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
        // Fixed: Use getter method instead of array access
        if (in_array($order->getOrderStatus(), ['Cancelled', 'Shipped', 'Delivered'])) {
            return ['error' => 'This order can no longer be cancelled.'];
        }
        
        if ($this->order->updateStatus($orderId, 'Cancelled')) {
            // Return updated order data so UI can refresh
            $updatedOrder = $this->order->findById($orderId);
            return ['data' => $updatedOrder];
        } else {
            return ['error' => 'Failed to cancel order.'];
        }
    }
}