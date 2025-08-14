<?php
// Railway-compatible entry point
$requestUri = $_SERVER['REQUEST_URI'] ?? '/';

// Handle static assets
if (preg_match('/\.(css|js|png|jpg|jpeg|gif|ico|svg)$/', $requestUri)) {
    $filePath = __DIR__ . $requestUri;
    if (file_exists($filePath)) {
        $mimeTypes = [
            'css' => 'text/css',
            'js' => 'application/javascript',
            'png' => 'image/png',
            'jpg' => 'image/jpeg',
            'jpeg' => 'image/jpeg',
            'gif' => 'image/gif',
            'ico' => 'image/x-icon',
            'svg' => 'image/svg+xml'
        ];
        $ext = pathinfo($filePath, PATHINFO_EXTENSION);
        if (isset($mimeTypes[$ext])) {
            header('Content-Type: ' . $mimeTypes[$ext]);
        }
        readfile($filePath);
        exit;
    }
}

// Handle application routes
if (strpos($requestUri, '/Src/') === 0) {
    // Direct Src requests
    $srcPath = __DIR__ . $requestUri;
    if (file_exists($srcPath) && is_file($srcPath)) {
        include $srcPath;
        exit;
    }
} else {
    // Root requests - redirect to main application
    header('Location: /Src/Boundary/index.php');
    exit;
}

// 404 fallback
http_response_code(404);
echo "Page not found";
?>