<?php
require_once dirname(__DIR__, 2) . '/Controllers/Admin/AdminAddProductCtrl.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_GET['id'])) {
    $controller = new AdminAddProductCtrl();
    $result = $controller->removeFurniture($_GET['id']);
    
    header('Content-Type: application/json');
    echo json_encode($result);
    exit();
}

header('Content-Type: application/json');
echo json_encode(['success' => false, 'message' => 'Invalid request']);