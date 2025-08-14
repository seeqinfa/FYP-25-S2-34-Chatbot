# Railway Deployment Guide for LuxFurn

## Overview
Your application consists of three components:
1. **PHP Web Application** - Main website with furniture catalog and user management
2. **Rasa Chatbot** - AI-powered customer service bot
3. **MySQL Database** - Data storage for users, orders, furniture, etc.

## Deployment Strategy

### Option 1: Single Service with Docker Compose (Recommended for Development)
Deploy all components together using the provided `docker-compose.yml`.

### Option 2: Separate Services (Recommended for Production)
Deploy each component as a separate Railway service for better scalability and maintenance.

## Step-by-Step Deployment

### 1. Prepare Your Repository

1. **Create a new branch for Railway deployment:**
   ```bash
   git checkout -b railway-deployment
   ```

2. **Add the configuration files** (already created above)

3. **Update your database configuration** in `Src/db_config.php`:
   ```php
   <?php
   // Use Railway's DATABASE_URL if available, otherwise fall back to local config
   if (isset($_ENV['DATABASE_URL'])) {
       $url = parse_url($_ENV['DATABASE_URL']);
       define('DB_HOST', $url['host']);
       define('DB_NAME', ltrim($url['path'], '/'));
       define('DB_USER', $url['user']);
       define('DB_PASS', $url['pass']);
   } else {
       define('DB_HOST', 'localhost');
       define('DB_NAME', 'luxfurn');
       define('DB_USER', 'root');
       define('DB_PASS', '');
   }
   ?>
   ```

### 2. Deploy Database Service

1. **Create a new Railway project**
2. **Add MySQL service:**
   - Go to Railway dashboard
   - Click "New Project"
   - Add "MySQL" from the template gallery
   - Note the connection details provided

### 3. Deploy Rasa Service

1. **Create new service in your Railway project**
2. **Connect your GitHub repository**
3. **Set build configuration:**
   - Build command: `docker build -f Dockerfile.rasa -t rasa-app .`
   - Start command: `rasa run --enable-api --cors '*' --port 5005`
4. **Set environment variables:**
   ```
   PORT=5005
   DB_HOST=[your-mysql-host]
   DB_NAME=luxfurn
   DB_USER=[your-mysql-user]
   DB_PASS=[your-mysql-password]
   ```

### 4. Deploy Web Application

1. **Create another service in your Railway project**
2. **Connect your GitHub repository**
3. **Set environment variables:**
   ```
   DATABASE_URL=mysql://user:pass@host:port/luxfurn
   RASA_URL=https://[your-rasa-service].railway.app
   ```

### 5. Update Application Configuration

Update your `Src/config.php` to handle Railway environment:

```php
<?php
// Railway-compatible configuration
$isRailway = isset($_ENV['RAILWAY_ENVIRONMENT']);

if ($isRailway) {
    // Railway environment
    $databaseUrl = $_ENV['DATABASE_URL'] ?? '';
    if ($databaseUrl) {
        $url = parse_url($databaseUrl);
        define('DB_HOST', $url['host']);
        define('DB_NAME', ltrim($url['path'], '/'));
        define('DB_USER', $url['user']);
        define('DB_PASS', $url['pass']);
    }
    
    define('BASE_URL', '');
    define('RASA_URL', $_ENV['RASA_URL'] ?? 'http://localhost:5005');
} else {
    // Local development
    define('DB_HOST', 'localhost');
    define('DB_NAME', 'luxfurn');
    define('DB_USER', 'root');
    define('DB_PASS', '');
    define('BASE_URL', '/FYP-25-S2-34-Chatbot/Src');
    define('RASA_URL', 'http://localhost:5005');
}

// Rest of your existing config...
?>
```

## Important Notes

### Database Migration
- Railway MySQL will be empty initially
- Import your database schema using Railway's MySQL client or phpMyAdmin
- You can use the SQL files in your `DB/` folder

### Environment Variables
Set these in Railway dashboard for each service:

**Web Service:**
- `DATABASE_URL`: Connection string to your Railway MySQL
- `RASA_URL`: URL of your deployed Rasa service

**Rasa Service:**
- `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASS`: MySQL connection details

### CORS Configuration
Update your chatbot JavaScript to use the Railway Rasa URL:
```javascript
const rasaUrl = window.RASA_URL || "http://localhost:5005";
```

### File Uploads
Railway has ephemeral storage. Consider using:
- Railway's persistent volumes for file uploads
- External storage service (AWS S3, Cloudinary) for product images

## Testing Your Deployment

1. **Database**: Verify tables are created and data is accessible
2. **Web App**: Test login, product viewing, cart functionality
3. **Rasa**: Test chatbot responses and database integration
4. **Integration**: Ensure web app can communicate with Rasa service

## Troubleshooting

- Check Railway logs for each service
- Verify environment variables are set correctly
- Ensure database connection strings are properly formatted
- Test CORS settings if chatbot isn't responding

## Cost Optimization

- Use Railway's free tier for development
- Consider scaling down services during low usage
- Monitor resource usage in Railway dashboard