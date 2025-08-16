<?php

require_once dirname(__DIR__, 2) . '/Entities/furniture.php';

class AdminManageProductCtrl {
    public function countFurniture($searchTerm = '') {
        return Furniture::count($searchTerm);
    }

    public function getFurniturePaginated($offset, $limit, $searchTerm = '') {
        return Furniture::findPaginated($offset, $limit, $searchTerm);
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