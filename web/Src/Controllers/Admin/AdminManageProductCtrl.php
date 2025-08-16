<?php

require_once dirname(__DIR__, 2) . '/Entities/furniture.php';

class AdminManageProductCtrl {
    // Product Management Methods
    public function countFurniture($searchTerm = '') {
        return Furniture::count($searchTerm);
    }

    public function getFurniturePaginated($offset, $limit, $searchTerm = '') {
        return Furniture::findPaginated($offset, $limit, $searchTerm);
    }

    public function getFurnitureById($id) {
        return Furniture::findById($id);
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

    public function editProduct($id, $name, $category, $price, $stock_quantity, $description, $imagePath = null) {
        $furniture = Furniture::findById($id);
        if (!$furniture) {
            throw new Exception("Product not found");
        }

        $furniture->name = $name;
        $furniture->category = $category;
        $furniture->price = $price;
        $furniture->stock_quantity = $stock_quantity;
        $furniture->description = $description;
        
        if ($imagePath) {
            $furniture->image_url = $imagePath;
        }

        return $furniture->save();
    }

    public function removeFurniture(int $id): array
    {
        $furniture = Furniture::findById($id);

        if (!$furniture) {
            return ['success' => false, 'message' => 'Furniture not found'];
        }

        $deleted = $furniture->delete();

        if (!$deleted) {
            return ['success' => false, 'message' => 'Failed to delete furniture'];
        }

        return ['success' => true];
    }
}
?>