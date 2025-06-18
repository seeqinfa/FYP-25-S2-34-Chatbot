<?php
require_once dirname(__DIR__, 2) . '/src/db_config.php';

class OrderCheckout {
    private $orderId;
    private $customerFirstName;
    private $customerLastName;
    private $customerEmail;
    private $customerPhone;
    private $shippingAddress;
    private $shippingCity;
    private $shippingState;
    private $shippingZip;
    private $subtotal;
    private $taxAmount;
    private $shippingFee;
    private $totalAmount;
    private $orderStatus;
    private $specialInstructions;
    private $createdAt;
    private $items = [];
    private static $db;
    
    public function __construct() {
        if (!self::$db) {
            self::$db = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
            if (!self::$db) {
                die("Database connection failed: " . mysqli_connect_error());
            }
            
            if (self::$db->connect_error) {
                throw new Exception("Database connection failed: " . self::$db->connect_error);
            }
        }
    }
    
    // Getters
    public function getOrderId() { return $this->orderId; }
    public function getCustomerFirstName() { return $this->customerFirstName; }
    public function getCustomerLastName() { return $this->customerLastName; }
    public function getCustomerEmail() { return $this->customerEmail; }
    public function getCustomerPhone() { return $this->customerPhone; }
    public function getShippingAddress() { return $this->shippingAddress; }
    public function getShippingCity() { return $this->shippingCity; }
    public function getShippingState() { return $this->shippingState; }
    public function getShippingZip() { return $this->shippingZip; }
    public function getSubtotal() { return $this->subtotal; }
    public function getTaxAmount() { return $this->taxAmount; }
    public function getShippingFee() { return $this->shippingFee; }
    public function getTotalAmount() { return $this->totalAmount; }
    public function getOrderStatus() { return $this->orderStatus; }
    public function getSpecialInstructions() { return $this->specialInstructions; }
    public function getCreatedAt() { return $this->createdAt; }
    public function getItems() { return $this->items; }
    
    // Setters
    public function setOrderId($orderId) { $this->orderId = $orderId; }
    public function setCustomerFirstName($firstName) { $this->customerFirstName = $firstName; }
    public function setCustomerLastName($lastName) { $this->customerLastName = $lastName; }
    public function setCustomerEmail($email) { $this->customerEmail = $email; }
    public function setCustomerPhone($phone) { $this->customerPhone = $phone; }
    public function setShippingAddress($address) { $this->shippingAddress = $address; }
    public function setShippingCity($city) { $this->shippingCity = $city; }
    public function setShippingState($state) { $this->shippingState = $state; }
    public function setShippingZip($zip) { $this->shippingZip = $zip; }
    public function setSubtotal($subtotal) { $this->subtotal = $subtotal; }
    public function setTaxAmount($taxAmount) { $this->taxAmount = $taxAmount; }
    public function setShippingFee($shippingFee) { $this->shippingFee = $shippingFee; }
    public function setTotalAmount($totalAmount) { $this->totalAmount = $totalAmount; }
    public function setOrderStatus($status) { $this->orderStatus = $status; }
    public function setSpecialInstructions($instructions) { $this->specialInstructions = $instructions; }
    public function setCreatedAt($createdAt) { $this->createdAt = $createdAt; }
    public function setItems($items) { $this->items = $items; }
    
    public function addItem($item) {
        $this->items[] = $item;
    }
    
    // Database Operations
    public function save() {
        try {
            self::$db->begin_transaction();
            
            if ($this->orderId) {
                // Update existing order
                $this->update();
            } else {
                // Create new order
                $this->create();
            }
            
            // Save order items
            $this->saveItems();
            
            self::$db->commit();
            return $this->orderId;
            
        } catch (Exception $e) {
            self::$db->rollback();
            throw $e;
        }
    }
    
    private function create() {
        $orderQuery = "INSERT INTO orders (
            customer_first_name, customer_last_name, customer_email, customer_phone,
            shipping_address, shipping_city, shipping_state, shipping_zip,
            subtotal, tax_amount, shipping_fee, total_amount,
            order_status, special_instructions, created_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        
        $stmt = self::$db->prepare($orderQuery);
        $stmt->bind_param(
            "ssssssssddddss",
            $this->customerFirstName, $this->customerLastName, 
            $this->customerEmail, $this->customerPhone,
            $this->shippingAddress, $this->shippingCity, 
            $this->shippingState, $this->shippingZip,
            $this->subtotal, $this->taxAmount, $this->shippingFee, $this->totalAmount,
            $this->orderStatus, $this->specialInstructions
        );
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to create order: " . $stmt->error);
        }
        
        $this->orderId = self::$db->insert_id;
    }
    
    private function update() {
        $orderQuery = "UPDATE orders SET 
            customer_first_name = ?, customer_last_name = ?, customer_email = ?, customer_phone = ?,
            shipping_address = ?, shipping_city = ?, shipping_state = ?, shipping_zip = ?,
            subtotal = ?, tax_amount = ?, shipping_fee = ?, total_amount = ?,
            order_status = ?, special_instructions = ?
            WHERE order_id = ?";
        
        $stmt = self::$db->prepare($orderQuery);
        $stmt->bind_param(
            "ssssssssddddssi",
            $this->customerFirstName, $this->customerLastName, 
            $this->customerEmail, $this->customerPhone,
            $this->shippingAddress, $this->shippingCity, 
            $this->shippingState, $this->shippingZip,
            $this->subtotal, $this->taxAmount, $this->shippingFee, $this->totalAmount,
            $this->orderStatus, $this->specialInstructions, $this->orderId
        );
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to update order: " . $stmt->error);
        }
    }
    
    private function saveItems() {
        // Delete existing items if updating
        if ($this->orderId) {
            $deleteQuery = "DELETE FROM order_items WHERE order_id = ?";
            $deleteStmt = self::$db->prepare($deleteQuery);
            $deleteStmt->bind_param("i", $this->orderId);
            $deleteStmt->execute();
        }
        
        // Insert order items
        $itemQuery = "INSERT INTO order_items (
            order_id, furniture_id, furniture_name, unit_price, quantity, total_price
        ) VALUES (?, ?, ?, ?, ?, ?)";
        
        $itemStmt = self::$db->prepare($itemQuery);
        
        foreach ($this->items as $item) {
            $itemStmt->bind_param(
                "iisdid",
                $this->orderId, $item->getFurnitureId(), $item->getFurnitureName(),
                $item->getUnitPrice(), $item->getQuantity(), $item->getTotalPrice()
            );
            
            if (!$itemStmt->execute()) {
                throw new Exception("Failed to add order item: " . $itemStmt->error);
            }
        }
    }
    
    public static function findById($orderId) {
        $order = new self();
        
        $query = "SELECT * FROM orders WHERE order_id = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("i", $orderId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $orderData = $result->fetch_assoc();
        if (!$orderData) {
            return null;
        }
        
        // Populate order object
        $order->setOrderId($orderData['order_id']);
        $order->setCustomerFirstName($orderData['customer_first_name']);
        $order->setCustomerLastName($orderData['customer_last_name']);
        $order->setCustomerEmail($orderData['customer_email']);
        $order->setCustomerPhone($orderData['customer_phone']);
        $order->setShippingAddress($orderData['shipping_address']);
        $order->setShippingCity($orderData['shipping_city']);
        $order->setShippingState($orderData['shipping_state']);
        $order->setShippingZip($orderData['shipping_zip']);
        $order->setSubtotal($orderData['subtotal']);
        $order->setTaxAmount($orderData['tax_amount']);
        $order->setShippingFee($orderData['shipping_fee']);
        $order->setTotalAmount($orderData['total_amount']);
        $order->setOrderStatus($orderData['order_status']);
        $order->setSpecialInstructions($orderData['special_instructions']);
        $order->setCreatedAt($orderData['created_at']);
        
        // Load order items
        $order->loadItems();
        
        return $order;
    }
    
    private function loadItems() {
        require_once 'OrderItem.php';
        
        $query = "SELECT * FROM order_items WHERE order_id = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("i", $this->orderId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $this->items = [];
        while ($row = $result->fetch_assoc()) {
            $orderItem = new OrderItem();
            $orderItem->setOrderItemId($row['order_item_id']);
            $orderItem->setOrderId($row['order_id']);
            $orderItem->setFurnitureId($row['furniture_id']);
            $orderItem->setFurnitureName($row['furniture_name']);
            $orderItem->setUnitPrice($row['unit_price']);
            $orderItem->setQuantity($row['quantity']);
            $orderItem->setTotalPrice($row['total_price']);
            
            $this->items[] = $orderItem;
        }
    }
    
    public function delete() {
        if (!$this->orderId) {
            throw new Exception("Cannot delete order: Order ID not set");
        }
        
        try {
            self::$db->begin_transaction();
            
            // Delete order items first
            $deleteItemsQuery = "DELETE FROM order_items WHERE order_id = ?";
            $stmt = self::$db->prepare($deleteItemsQuery);
            $stmt->bind_param("i", $this->orderId);
            $stmt->execute();
            
            // Delete order
            $deleteOrderQuery = "DELETE FROM orders WHERE order_id = ?";
            $stmt = self::$db->prepare($deleteOrderQuery);
            $stmt->bind_param("i", $this->orderId);
            $stmt->execute();
            
            self::$db->commit();
            return true;
            
        } catch (Exception $e) {
            self::$db->rollback();
            throw $e;
        }
    }
}
?>