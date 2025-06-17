<?php
require_once dirname(__DIR__) . '/db_connect.php';

class Furniture {
    public $furnitureID;
    public $name;
    public $category;
    public $description;
    public $price;
    public $stock_quantity;
    public $image_url;

    public function __construct($data = []) {
        foreach ($data as $key => $value) {
            if (property_exists($this, $key)) {
                $this->$key = $value;
            }
        }
    }

    public static function count($searchTerm = '') {
        global $conn;
        $searchTerm = '%' . $searchTerm . '%';
        $sql = "SELECT COUNT(*) AS total FROM furnitures WHERE name LIKE ? OR category LIKE ?";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "ss", $searchTerm, $searchTerm);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        $row = mysqli_fetch_assoc($result);
        return $row['total'];
    }

    public static function getPaginated($offset, $limit, $searchTerm = '') {
        global $conn;
        $furnitures = [];
        $searchTerm = '%' . $searchTerm . '%';
        $sql = "SELECT * FROM furnitures WHERE name LIKE ? OR category LIKE ? LIMIT ?, ?";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "ssii", $searchTerm, $searchTerm, $offset, $limit);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        while ($row = mysqli_fetch_assoc($result)) {
            $furnitures[] = new self($row);
        }

        return $furnitures;
    }

    public static function findById($id) {
        global $conn;
        $sql = "SELECT * FROM furnitures WHERE furnitureID = ?";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "i", $id);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if ($row = mysqli_fetch_assoc($result)) {
            return new self($row);
        }
        return null;
    }

    public function save() {
        global $conn;
        
        if (empty($this->image_url)) {
            throw new Exception("Image path cannot be empty");
        }

        if ($this->furnitureID) {
            // Update existing record
            $sql = "UPDATE furnitures SET name=?, category=?, price=?, stock_quantity=?, description=?, image_url=? WHERE furnitureID=?";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ssdissi", 
                $this->name, $this->category, $this->price, $this->stock_quantity, 
                $this->description, $this->image_url, $this->furnitureID);
        } else {
            // Insert new record
            $sql = "INSERT INTO furnitures (name, category, price, stock_quantity, description, image_url) VALUES (?, ?, ?, ?, ?, ?)";
            $stmt = mysqli_prepare($conn, $sql);
            mysqli_stmt_bind_param($stmt, "ssdiss", 
                $this->name, $this->category, $this->price, $this->stock_quantity, 
                $this->description, $this->image_url);
        }

        $success = mysqli_stmt_execute($stmt);
        if (!$this->furnitureID) {
            $this->furnitureID = mysqli_insert_id($conn);
        }
        mysqli_stmt_close($stmt);
        
        return $success;
    }

    public function delete() {
        global $conn;
        $sql = "DELETE FROM furnitures WHERE furnitureID = ?";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "i", $this->furnitureID);
        $success = mysqli_stmt_execute($stmt);
        mysqli_stmt_close($stmt);
        return $success;
    }
}
?>