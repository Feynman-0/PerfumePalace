# Railway Deployment Environment Variables

Add these in Railway Dashboard → Your Service → Variables:

## Required Variables

```
APP_KEY=base64:Wt8mYPxtPbckNEq0W7/sthKljl2PJWtTNSpbquDN7L4=
APP_ENV=production
APP_DEBUG=false
APP_URL=https://perfumepalace-ecom-production.up.railway.app
DB_CONNECTION=mysql
```

## Database Setup

1. In Railway, click **"+ New"** → **"Database"** → **"Add MySQL"**
2. Railway will automatically create `DATABASE_URL` variable
3. The app will parse DATABASE_URL automatically

## Optional Variables (for email, etc.)

```
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@perfumepalace.com
MAIL_FROM_NAME="Perfume Palace"
```

## After Adding Variables

1. Save the variables
2. Railway will automatically redeploy
3. The setup script will run migrations and seed the database
4. Your site will be live!
