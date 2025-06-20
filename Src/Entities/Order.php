<?php
require_once dirname(__DIR__, 2) . '/src/db_config.php';

class Order {
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
    private $updatedAt;
    private $items = []; // Array of order items
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
    public function getUpdatedAt() { return $this->updatedAt; }
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
    public function setUpdatedAt($updatedAt) { $this->updatedAt = $updatedAt; }
    public function setItems($items) { $this->items = $items; }
    
    // Order Item Management Methods
    public function addItem($furnitureId, $furnitureName, $unitPrice, $quantity) {
        $totalPrice = $unitPrice * $quantity;
        
        $item = [
            'furniture_id' => $furnitureId,
            'furniture_name' => $furnitureName,
            'unit_price' => $unitPrice,
            'quantity' => $quantity,
            'total_price' => $totalPrice
        ];
        
        $this->items[] = $item;
        return $item;
    }
    
    public function removeItem($index) {
        if (isset($this->items[$index])) {
            unset($this->items[$index]);
            $this->items = array_values($this->items); // Re-index array
            return true;
        }
        return false;
    }
    
    public function updateItemQuantity($index, $quantity) {
        if (isset($this->items[$index]) && $quantity > 0) {
            $this->items[$index]['quantity'] = $quantity;
            $this->items[$index]['total_price'] = $this->items[$index]['unit_price'] * $quantity;
            return true;
        }
        return false;
    }
    
    public function clearItems() {
        $this->items = [];
    }
    
    public function getItemCount() {
        return count($this->items);
    }
    
    public function getTotalItemsQuantity() {
        $total = 0;
        foreach ($this->items as $item) {
            $total += $item['quantity'];
        }
        return $total;
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
            order_status = ?, special_instructions = ?, updated_at = NOW()
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
        if (!empty($this->items)) {
            $itemQuery = "INSERT INTO order_items (
                order_id, furniture_id, furniture_name, unit_price, quantity, total_price
            ) VALUES (?, ?, ?, ?, ?, ?)";
            
            $itemStmt = self::$db->prepare($itemQuery);
            
            foreach ($this->items as $item) {
                $itemStmt->bind_param(
                    "iisdid",
                    $this->orderId, $item['furniture_id'], $item['furniture_name'],
                    $item['unit_price'], $item['quantity'], $item['total_price']
                );
                
                if (!$itemStmt->execute()) {
                    throw new Exception("Failed to add order item: " . $itemStmt->error);
                }
            }
        }
    }
    
    public static function findById($orderId) {
        if (!self::$db) {
            $temp = new self(); // Initialize connection
        }
        
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
        
        // Set updated_at if it exists
        if (isset($orderData['updated_at'])) {
            $order->setUpdatedAt($orderData['updated_at']);
        }
        
        // Load order items
        $order->loadItems();
        
        return $order;
    }
    
    private function loadItems() {
        $query = "SELECT * FROM order_items WHERE order_id = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("i", $this->orderId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $this->items = [];
        while ($row = $result->fetch_assoc()) {
            $item = [
                'item_id' => $row['item_id'],
                'furniture_id' => $row['furniture_id'],
                'furniture_name' => $row['furniture_name'],
                'unit_price' => $row['unit_price'],
                'quantity' => $row['quantity'],
                'total_price' => $row['total_price']
            ];
            
            $this->items[] = $item;
        }
    }
    
    // Static methods for finding order items
    public static function findOrderItems($orderId) {
        if (!self::$db) {
            $temp = new self(); // Initialize connection
        }
        
        $query = "SELECT * FROM order_items WHERE order_id = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("i", $orderId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $items = [];
        while ($row = $result->fetch_assoc()) {
            $items[] = [
                'order_item_id' => $row['order_item_id'],
                'order_id' => $row['order_id'],
                'furniture_id' => $row['furniture_id'],
                'furniture_name' => $row['furniture_name'],
                'unit_price' => $row['unit_price'],
                'quantity' => $row['quantity'],
                'total_price' => $row['total_price']
            ];
        }
        
        return $items;
    }
    
    // Status update method
    public function updateStatus($orderId, $newStatus) {
        $validStatuses = ['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'];
        if (!in_array($newStatus, $validStatuses)) {
            throw new Exception("Invalid order status: " . $newStatus);
        }
        
        $stmt = self::$db->prepare("UPDATE orders SET order_status = ?, updated_at = NOW() WHERE order_id = ?");
        $stmt->bind_param("si", $newStatus, $orderId);

        if ($stmt->execute()) {
            $this->orderStatus = $newStatus;
            return true;
        } else {
            error_log("Order::updateStatus failed - " . $stmt->error);
            return false;
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
    
    // Additional utility methods
    public static function findByStatus($status) {
        if (!self::$db) {
            $temp = new self(); // Initialize connection
        }
        
        $query = "SELECT order_id FROM orders WHERE order_status = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("s", $status);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $orders = [];
        while ($row = $result->fetch_assoc()) {
            $orders[] = self::findById($row['order_id']);
        }
        
        return $orders;
    }
    
    public static function findByCustomerEmail($email) {
        if (!self::$db) {
            $temp = new self(); // Initialize connection
        }
        
        $query = "SELECT order_id FROM orders WHERE customer_email = ? ORDER BY created_at DESC";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $orders = [];
        while ($row = $result->fetch_assoc()) {
            $orders[] = self::findById($row['order_id']);
        }
        
        return $orders;
    }
}
?>