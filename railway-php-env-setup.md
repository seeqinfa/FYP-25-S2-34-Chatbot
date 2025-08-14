# Railway PHP Web Application Service - Environment Variables

Add these environment variables to your PHP web application service in Railway:

## Database Connection
```
DATABASE_URL=mysql://root:qRWWKoYkMSIxBKCCFtYETdSdLFterWpb@mysql.railway.internal:3306/railway
```

## Rasa Chatbot Connection (Update after Rasa deployment)
```
RASA_URL=https://your-rasa-service-name.railway.app
```

## Railway Environment Detection
```
RAILWAY_ENVIRONMENT=production
```

## Optional: Individual Database Components (for compatibility)
```
DB_HOST=mysql.railway.internal
DB_NAME=railway
DB_USER=root
DB_PASS=qRWWKoYkMSIxBKCCFtYETdSdLFterWpb
DB_PORT=3306
```

---

## How to Add These Variables:

1. Go to your Railway dashboard
2. Click on your PHP web application service
3. Go to the "Variables" tab
4. Click "New Variable" for each one above
5. Enter the variable name and value
6. Click "Add" for each variable

## Important Notes:

- **DATABASE_URL**: This is the primary connection string your PHP app will use
- **RASA_URL**: You'll need to update this after you deploy your Rasa service (it will be something like `https://rasa-service-xxxx.railway.app`)
- **Internal vs Public URLs**: Use the internal MySQL URL (`mysql.railway.internal`) for better performance and security within Railway's network

## Next Steps:

1. Add these variables to your PHP service
2. Deploy your Rasa service next
3. Update the RASA_URL variable with your deployed Rasa service URL
4. Test the connections between services