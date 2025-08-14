<?php
// Railway-compatible database configuration
if (isset($_ENV['DATABASE_URL'])) {
    // Railway environment - parse DATABASE_URL
    $url = parse_url($_ENV['DATABASE_URL']);
    define('DB_HOST', $url['host']);
    define('DB_NAME', ltrim($url['path'], '/'));
    define('DB_USER', $url['user']);
    define('DB_PASS', $url['pass']);
    define('DB_PORT', $url['port'] ?? 3306);
} else {
    // Local development
    define('DB_HOST', 'localhost');
    define('DB_NAME', 'luxfurn');
    define('DB_USER', 'root');
    define('DB_PASS', '');
    define('DB_PORT', 3306);
}
?>