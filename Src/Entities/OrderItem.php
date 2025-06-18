<?php
require_once dirname(__DIR__, 2) . '/src/db_config.php';

class OrderItem {
    private $orderItemId;
    private $orderId;
    private $furnitureId;
    private $furnitureName;
    private $unitPrice;
    private $quantity;
    private $totalPrice;
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
    public function getOrderItemId() { return $this->orderItemId; }
    public function getOrderId() { return $this->orderId; }
    public function getFurnitureId() { return $this->furnitureId; }
    public function getFurnitureName() { return $this->furnitureName; }
    public function getUnitPrice() { return $this->unitPrice; }
    public function getQuantity() { return $this->quantity; }
    public function getTotalPrice() { return $this->totalPrice; }
    
    // Setters
    public function setOrderItemId($id) { $this->orderItemId = $id; }
    public function setOrderId($orderId) { $this->orderId = $orderId; }
    public function setFurnitureId($furnitureId) { $this->furnitureId = $furnitureId; }
    public function setFurnitureName($name) { $this->furnitureName = $name; }
    public function setUnitPrice($price) { $this->unitPrice = $price; }
    public function setQuantity($quantity) { $this->quantity = $quantity; }
    public function setTotalPrice($totalPrice) { $this->totalPrice = $totalPrice; }
    
    // Database Operations
    public function save() {
        if ($this->orderItemId) {
            return $this->update();
        } else {
            return $this->create();
        }
    }
    
    private function create() {
        $query = "INSERT INTO order_items (
            order_id, furniture_id, furniture_name, unit_price, quantity, total_price
        ) VALUES (?, ?, ?, ?, ?, ?)";
        
        $stmt = self::$db->prepare($query);
        $stmt->bind_param(
            "iisdid",
            $this->orderId, $this->furnitureId, $this->furnitureName,
            $this->unitPrice, $this->quantity, $this->totalPrice
        );
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to create order item: " . $stmt->error);
        }
        
        $this->orderItemId = self::$db->insert_id;
        return $this->orderItemId;
    }
    
    private function update() {
        $query = "UPDATE order_items SET 
            order_id = ?, furniture_id = ?, furniture_name = ?, 
            unit_price = ?, quantity = ?, total_price = ?
            WHERE order_item_id = ?";
        
        $stmt = self::$db->prepare($query);
        $stmt->bind_param(
            "iisdidi",
            $this->orderId, $this->furnitureId, $this->furnitureName,
            $this->unitPrice, $this->quantity, $this->totalPrice, $this->orderItemId
        );
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to update order item: " . $stmt->error);
        }
        
        return $this->orderItemId;
    }
    
    public static function findById($orderItemId) {
        $orderItem = new self();
        
        $query = "SELECT * FROM order_items WHERE order_item_id = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("i", $orderItemId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $data = $result->fetch_assoc();
        if (!$data) {
            return null;
        }
        
        $orderItem->setOrderItemId($data['order_item_id']);
        $orderItem->setOrderId($data['order_id']);
        $orderItem->setFurnitureId($data['furniture_id']);
        $orderItem->setFurnitureName($data['furniture_name']);
        $orderItem->setUnitPrice($data['unit_price']);
        $orderItem->setQuantity($data['quantity']);
        $orderItem->setTotalPrice($data['total_price']);
        
        return $orderItem;
    }
    
    public static function findByOrderId($orderId) {
        $query = "SELECT * FROM order_items WHERE order_id = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("i", $orderId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $items = [];
        while ($row = $result->fetch_assoc()) {
            $orderItem = new self();
            $orderItem->setOrderItemId($row['order_item_id']);
            $orderItem->setOrderId($row['order_id']);
            $orderItem->setFurnitureId($row['furniture_id']);
            $orderItem->setFurnitureName($row['furniture_name']);
            $orderItem->setUnitPrice($row['unit_price']);
            $orderItem->setQuantity($row['quantity']);
            $orderItem->setTotalPrice($row['total_price']);
            
            $items[] = $orderItem;
        }
        
        return $items;
    }
    
    public function delete() {
        if (!$this->orderItemId) {
            throw new Exception("Cannot delete order item: Order Item ID not set");
        }
        
        $query = "DELETE FROM order_items WHERE order_item_id = ?";
        $stmt = self::$db->prepare($query);
        $stmt->bind_param("i", $this->orderItemId);
        
        if (!$stmt->execute()) {
            throw new Exception("Failed to delete order item: " . $stmt->error);
        }
        
        return $stmt->affected_rows > 0;
    }
}
?>