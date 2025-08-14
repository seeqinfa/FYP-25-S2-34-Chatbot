<?php
// Define the project root as the Src directory
define('PROJECT_ROOT', dirname(__FILE__));

// Define other important paths relative to PROJECT_ROOT
define('CONTROLLERS_PATH', PROJECT_ROOT . '\Controllers');
define('ENTITIES_PATH', PROJECT_ROOT . '\Entities');
define('BOUNDARY_PATH', PROJECT_ROOT . '\Boundary');

// Railway-compatible base URL configuration
$isRailway = isset($_ENV['RAILWAY_ENVIRONMENT']) || isset($_ENV['RAILWAY_PROJECT_ID']);

// Also check for Railway's standard environment variable
if (!$isRailway && isset($_ENV['RAILWAY_STATIC_URL'])) {
    $isRailway = true;
}

if ($isRailway) {
    define('BASE_URL', '');
    define('RASA_URL', $_ENV['RASA_URL'] ?? 'http://localhost:5005');
} else {
    define('BASE_URL', '/FYP-25-S2-34-Chatbot/Src');
    define('RASA_URL', 'http://localhost:5005');
}

// Define other URL paths relative to BASE_URL
define('BOUNDARY_URL', BASE_URL . '/Boundary');
define('CONTROLLERS_URL',  BASE_URL . '/Controllers');
define('ADMIN_CONTROLLERS_URL',  BASE_URL . '/Controllers/admin');
define('IMAGE_PATH',  BASE_URL . '/img');
define('JAVASCRIPT_PATH',  BASE_URL . '/Javascripts');
define('CSS_PATH',  BASE_URL . '/CSS');

// Helper function for requiring files
function requireOnce($path) {
    $absolutePath = PROJECT_ROOT . '/' . ltrim($path, '/');
    if (!file_exists($absolutePath)) {
        throw new Exception("Required file not found: " . $absolutePath);
    }
    require_once $absolutePath;
}

// Error reporting (set to 0 in production)
ini_set('display_errors', $isRailway ? 0 : 1);
error_reporting($isRailway ? E_ERROR : E_ALL);

// Database connection for PDO
if (isset($_ENV['DATABASE_URL'])) {
    $url = parse_url($_ENV['DATABASE_URL']);
    $dsn = sprintf(
        'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
        $url['host'],
        $url['port'] ?? 3306,
        ltrim($url['path'], '/')
    );
    $user = $url['user'];
    $pass = $url['pass'];
} else {
    $dsn = 'mysql:host=localhost;dbname=luxfurn;charset=utf8mb4';
    $user = 'root';
    $pass = '';
}

$pdo = new PDO($dsn, $user, $pass, [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);

?>