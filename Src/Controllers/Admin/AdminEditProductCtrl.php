<?php
require_once dirname(__DIR__, 2) . '/Entities/furniture.php';

class AdminEditProductCtrl {
    public function editProduct($id, $name, $category, $price, $quantity, $description, $imagePath = null) {
        $furniture = Furniture::findById($id);
        if (!$furniture) {
            throw new Exception("Product not found");
        }

        $furniture->name = $name;
        $furniture->category = $category;
        $furniture->price = $price;
        $furniture->stock_quantity = $quantity;
        $furniture->description = $description;
        
        if ($imagePath) {
            $furniture->image_url = $imagePath;
        }

        return $furniture->save();
    }
}
?>