<?php

require_once dirname(__DIR__, 2) . '/Entities/furniture.php';

class AdminManageProductCtrl {
    public function countFurniture($searchTerm = '') {
        return Furniture::count($searchTerm);
    }

    public function getFurniturePaginated($offset, $limit, $searchTerm = '') {
        return Furniture::findPaginated($offset, $limit, $searchTerm);
    }

    public function getFurnitureById    ($id) {
        return Furniture::findById($id);
    }

    public function addProduct($name, $category, $tags, $description, $price, $quantity, $imagePath) {
        global $conn;
    
    // Verify the image path is not empty
        if (empty($imagePath)) {
            throw new Exception("Image path cannot be empty");
        }

        $sql = "INSERT INTO furnitures 
            (name, category, tags, description, price, stock_quantity, image_url) 
            VALUES (?, ?, ?, ?, ?, ?, ?)";
    
        $stmt = mysqli_prepare($conn, $sql);
        if (!$stmt) {
            throw new Exception(mysqli_error($conn));
        }
        $price = round((float)$price, 2);
        mysqli_stmt_bind_param($stmt, "sssdiis", 
            $name, $category, $tags, $description, $price, $quantity, $imagePath);
    
        $success = mysqli_stmt_execute($stmt);
        mysqli_stmt_close($stmt);
    
        return $success;
    }
    public function editProduct($id, $name, $category, $tags, $description, $price, $quantity, $imagePath = null) {
        $furniture = Furniture::findById($id);
        if (!$furniture) {
            throw new Exception("Product not found");
        }

        $furniture->name = $name;
        $furniture->category = $category;
        $furniture->tags = $tags;
        $furniture->description = $description;
        $furniture->price = $price;
        $furniture->stock_quantity = $quantity;
        
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

        try {
            $deleted = $furniture->delete();
            return ['success' => true];
        } catch (Exception $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
}