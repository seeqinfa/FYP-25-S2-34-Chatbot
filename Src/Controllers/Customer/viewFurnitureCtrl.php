<?php
require_once dirname(__DIR__, 2) . '/db_connect.php';
require_once dirname(__DIR__, 2) . '/Entities/furniture.php';

class FurnitureController {
    public function countFurniture($searchTerm = '') {
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

    public function getFurniturePaginated($offset, $limit, $searchTerm = '') {
        global $conn;

        $furnitures = [];
        $searchTerm = '%' . $searchTerm . '%';
        $sql = "SELECT * FROM furnitures WHERE name LIKE ? OR category LIKE ? LIMIT ?, ?";
        $stmt = mysqli_prepare($conn, $sql);
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
