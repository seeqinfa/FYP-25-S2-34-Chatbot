<?php
require_once dirname(__DIR__, 2) . '/db_connect.php';
require_once dirname(__DIR__, 2) . '/Entities/furniture.php';

class AdminController {
    private $db;

    public function __construct() {
        global $conn;
        $this->db = $conn;
    }

    // Product Management Methods
    public function countFurniture($searchTerm = '') {
        $searchTerm = '%' . $searchTerm . '%';
        $sql = "SELECT COUNT(*) AS total FROM furnitures WHERE name LIKE ? OR category LIKE ?";
        $stmt = mysqli_prepare($this->db, $sql);
        mysqli_stmt_bind_param($stmt, "ss", $searchTerm, $searchTerm);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        $row = mysqli_fetch_assoc($result);
        return $row['total'];
    }

    public function getFurniturePaginated($offset, $limit, $searchTerm = '') {
        $furnitures = [];
        $searchTerm = '%' . $searchTerm . '%';
        $sql = "SELECT * FROM furnitures WHERE name LIKE ? OR category LIKE ? LIMIT ?, ?";
        $stmt = mysqli_prepare($this->db, $sql);
        mysqli_stmt_bind_param($stmt, "ssii", $searchTerm, $searchTerm, $offset, $limit);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        while ($row = mysqli_fetch_assoc($result)) {
            $furnitures[] = new Furniture(
                $row['furnitureID'],
                $row['name'],
                $row['category'],
                $row['description'],
                $row['price'],
                $row['stock_quantity'],
                $row['image_url']
            );
        }

        return $furnitures;
    }

    public function getFurnitureById    ($id) {
        $sql = "SELECT * FROM furnitures WHERE furnitureID = ?";
        $stmt = mysqli_prepare($this->db, $sql);
        mysqli_stmt_bind_param($stmt, "i", $id);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if ($row = mysqli_fetch_assoc($result)) {
            return new Furniture(
                $row['furnitureID'],
                $row['name'],
                $row['category'],
                $row['description'],
                $row['price'],
                $row['stock_quantity'],
                $row['image_url']
            );
        }

        return null;
    }

    public function addProduct($name, $category, $price, $quantity, $description, $imagePath) {
        global $conn;
    
    // Verify the image path is not empty
        if (empty($imagePath)) {
            throw new Exception("Image path cannot be empty");
        }

        $sql = "INSERT INTO furnitures 
            (name, category, price, stock_quantity, description, image_url) 
            VALUES (?, ?, ?, ?, ?, ?)";
    
        $stmt = mysqli_prepare($conn, $sql);
        if (!$stmt) {
            throw new Exception(mysqli_error($conn));
        }
        $price = round((float)$price, 2);
        mysqli_stmt_bind_param($stmt, "ssdiss", 
            $name, $category, $price, $quantity, $description, $imagePath);
    
        $success = mysqli_stmt_execute($stmt);
        mysqli_stmt_close($stmt);
    
        return $success;
    }
    public function editProduct($name, $category, $price, $quantity, $description) {
        global $conn;

        $sql = "INSERT INTO furnitures 
            (name, category, price, stock_quantity, description) 
            VALUES (?, ?, ?, ?, ?)";
    
        $stmt = mysqli_prepare($conn, $sql);
        if (!$stmt) {
            throw new Exception(mysqli_error($conn));
        }
        $price = round((float)$price, 2);
        mysqli_stmt_bind_param($stmt, "ssdis", 
            $name, $category, $price, $quantity, $description);
    
        $success = mysqli_stmt_execute($stmt);
        mysqli_stmt_close($stmt);
    
        return $success;
    }
}