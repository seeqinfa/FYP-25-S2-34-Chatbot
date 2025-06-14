<?php
require_once dirname(__DIR__, 2) . '/db_connect.php';
require_once dirname(__DIR__, 2) . '/Entities/userAccount.php';

$controller = new AdminController(); 

// Handle suspend/unsuspend actions
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $userId = intval($_POST['user_id']);
    
    try {
        if ($_POST['action'] === 'suspend') {
            $result = $controller->suspendUser($userId);
            $success = $result ? "User suspended successfully" : "Failed to suspend user";
        } elseif ($_POST['action'] === 'unsuspend') {
            $result = $controller->unsuspendUser($userId);
            $success = $result ? "User unsuspended successfully" : "Failed to unsuspend user";
        }
    } catch (Exception $e) {
        $error = $e->getMessage();
    }
}


class AdminController {
    private $db;

    public function getAllUsers() {
        global $conn;
    
        $sql = "SELECT id, username, email, is_suspended FROM users";
        $result = mysqli_query($conn, $sql);
    
        $users = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $users[] = $row;
        }
    
        return $users;
    }

    public function suspendUser($userId) {
        global $conn;
    
        $sql = "UPDATE users SET is_suspended = 1 WHERE id = ?";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "i", $userId);
        return mysqli_stmt_execute($stmt);
    }

    public function unsuspendUser($userId) {
        global $conn;
    
        $sql = "UPDATE users SET is_suspended = 0 WHERE id = ?";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "i", $userId);
        return mysqli_stmt_execute($stmt);
    }
}