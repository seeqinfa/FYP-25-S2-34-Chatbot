<?php
require_once dirname(__DIR__, 2) . '/Entities/furniture.php';
require_once dirname(__DIR__, 2) . '/db_connect.php'; // assumes DB connection

class FurnitureController {
    public function getAllFurniture() {
        global $conn;
        $furnitures = [];

        $sql = "SELECT * FROM furnitures";
        $result = mysqli_query($conn, $sql);

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
    
    public function getFurnitureById($id) {
    global $conn;

    $sql = "SELECT * FROM furnitures WHERE furnitureID = ?";
    $stmt = mysqli_prepare($conn, $sql);
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
}
?>