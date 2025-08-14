<?php
ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);
ini_set('log_errors', '1');
ini_set('error_log', '/dev/stderr');

// Main entry point for Railway deployment
define('APP_ROOT', __DIR__); // This will be /app in the container
require_once APP_ROOT . '/Src/Boundary/index.php';
?>