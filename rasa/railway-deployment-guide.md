# Railway Deployment Guide for Rasa

## Services to Create

You need to create **TWO** separate Railway services:

### 1. Rasa Server Service
- **Root Directory**: `rasa/`
- **Build Command**: `docker build -f Dockerfile.rasa -t rasa-server .`
- **Start Command**: `rasa run --enable-api --cors "*" --port 5005`
- **Environment Variables**:
  - `PORT=5005`
  - `DB_HOST=mysql.railway.internal`
  - `DB_USER=root`
  - `DB_PASS=qRWWKoYkMSIxBKCCFtYETdSdLFterWpb`
  - `DB_NAME=railway`
  - `DB_PORT=3306`

### 2. Rasa Action Server Service
- **Root Directory**: `rasa/`
- **Build Command**: `docker build -f Dockerfile.actions -t rasa-actions .`
- **Start Command**: `rasa run actions --port 5055`
- **Environment Variables**:
  - `PORT=5055`
  - `DB_HOST=mysql.railway.internal`
  - `DB_USER=root`
  - `DB_PASS=qRWWKoYkMSIxBKCCFtYETdSdLFterWpb`
  - `DB_NAME=railway`
  - `DB_PORT=3306`

## Important Steps

1. **Update endpoints.yml**: After deploying the Action Server, update the URL in `endpoints.yml` to point to your deployed action server (replace `your-rasa-actions-service.railway.app` with the actual URL).

2. **Update your PHP application**: Update the `RASA_URL` in your PHP application's configuration to point to your deployed Rasa server.

3. **Database Setup**: Make sure your Railway MySQL database contains the `luxfurn` tables. You may need to import your database schema.

## Testing

1. Test the Rasa server: `https://your-rasa-server.railway.app/webhooks/rest/webhook`
2. Test the action server: `https://your-rasa-actions-service.railway.app/webhook`
3. Test from your PHP application by using the chatbot interface.