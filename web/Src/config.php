<?php
// Define the project root as the Src directory
define('PROJECT_ROOT', dirname(__FILE__));

// Define other important paths relative to PROJECT_ROOT
define('CONTROLLERS_PATH', PROJECT_ROOT . '/Controllers');
define('ENTITIES_PATH', PROJECT_ROOT . '/Entities');
define('BOUNDARY_PATH', PROJECT_ROOT . '/Boundary');

// Railway-compatible base URL configuration
$isRailway = isset($_ENV['RAILWAY_ENVIRONMENT']) || isset($_ENV['RAILWAY_PROJECT_ID']);

// Also check for Railway's standard environment variable
if (!$isRailway && isset($_ENV['RAILWAY_STATIC_URL'])) {
    $isRailway = true;
}

if ($isRailway) {
    define('BASE_URL', '/');
    define('RASA_URL', 'https://rasa-server.up.railway.app');
} else {
    define('BASE_URL', '/FYP-25-S2-34-Chatbot/Src');
    define('RASA_URL', 'http://localhost:5005');
}

// Define other URL paths relative to BASE_URL
if ($isRailway) {
    define('BOUNDARY_URL', '/Src/Boundary');
    define('CONTROLLERS_URL',  '/Src/Controllers');
    define('ADMIN_CONTROLLERS_URL',  '/Src/Controllers/admin');
    define('IMAGE_PATH',  '/Src/img');
    define('JAVASCRIPT_PATH',  '/Src/Javascripts');
    define('CSS_PATH',  '/Src/CSS');
    define('MANUAL_PATH', '/Src/assets/manuals');
} else {
    // Local development paths
    define('BOUNDARY_URL', BASE_URL . '/Boundary');
    define('CONTROLLERS_URL',  BASE_URL . '/Controllers');
    define('ADMIN_CONTROLLERS_URL',  BASE_URL . '/Controllers/admin');
    define('IMAGE_PATH',  BASE_URL . '/img');
    define('JAVASCRIPT_PATH',  BASE_URL . '/Javascripts');
    define('CSS_PATH',  BASE_URL . '/CSS');
    define('MANUAL_PATH', BASE_URL . '/assets/manuals');
}

// Helper function for requiring files
function requireOnce($path) {
    $absolutePath = PROJECT_ROOT . '/' . ltrim($path, '/');
    if (!file_exists($absolutePath)) {
        throw new Exception("Required file not found: " . $absolutePath);
    }
    require_once $absolutePath;
}

// Error reporting (set to 0 in production)
// TEMPORARY: For debugging, set to 1 and E_ALL
ini_set('display_errors', 1); // Always display errors for debugging
error_reporting(E_ALL);     // Report all errors for debugging
// END TEMPORARY

// Database connection for PDO (Railway-aware)
try {
    if (!extension_loaded('pdo_mysql')) {
        throw new RuntimeException('Missing pdo_mysql PHP extension.');
    }

    $dsn = null; $user = null; $pass = null;

    // Prefer full URLs if present
    if (!empty($_ENV['MYSQL_URL'])) {
        $url = parse_url($_ENV['MYSQL_URL']);
        $dsn = sprintf(
            'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
            $url['host'],
            $url['port'] ?? 3306,
            ltrim($url['path'], '/')
        );
        $user = $url['user'] ?? 'root';
        $pass = $url['pass'] ?? '';
    } elseif (!empty($_ENV['MYSQL_PUBLIC_URL'])) {
        $url = parse_url($_ENV['MYSQL_PUBLIC_URL']);
        $dsn = sprintf(
            'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
            $url['host'],
            $url['port'] ?? 3306,
            ltrim($url['path'], '/')
        );
        $user = $url['user'] ?? 'root';
        $pass = $url['pass'] ?? '';
    } elseif (!empty($_ENV['DATABASE_URL'])) {
        $url = parse_url($_ENV['DATABASE_URL']);
        $dsn = sprintf(
            'mysql:host=%s;port=%d;dbname=%s;charset=utf8mb4',
            $url['host'],
            $url['port'] ?? 3306,
            ltrim($url['path'], '/')
        );
        $user = $url['user'] ?? 'root';
        $pass = $url['pass'] ?? '';
    } elseif (!empty($_ENV['MYSQLHOST'])) {
        // Railway's split vars
        $host = $_ENV['MYSQLHOST'];
        $port = (int)($_ENV['MYSQLPORT'] ?? 3306);
        $db   = $_ENV['MYSQLDATABASE'] ?? $_ENV['MYSQL_DATABASE'] ?? 'railway';
        $user = $_ENV['MYSQLUSER'] ?? 'root';
        $pass = $_ENV['MYSQLPASSWORD'] ?? '';
        $dsn  = "mysql:host={$host};port={$port};dbname={$db};charset=utf8mb4";
    } else {
        // Local fallback
        $dsn  = 'mysql:host=localhost;dbname=luxfurn;charset=utf8mb4';
        $user = 'root';
        $pass = '';
    }

    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (Throwable $e) {
    http_response_code(500);
    die('DB bootstrap error: ' . $e->getMessage());
}

?>