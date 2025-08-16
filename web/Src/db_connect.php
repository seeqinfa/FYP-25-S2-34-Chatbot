<?php
require_once 'db_config.php';

$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT);

if (!$conn) {
    die("Database connection failed: " . mysqli_connect_error());
}