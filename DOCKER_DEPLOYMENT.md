# 🐳 Docker Deployment Guide - Perfume Palace

## Why Docker is Better

- ✅ **Consistent builds** - Works everywhere
- ✅ **Pre-built image** - Faster deployments
- ✅ **No build failures** - Everything bundled
- ✅ **Easy rollback** - Just redeploy old image

---

## 🚀 Railway Deployment with Docker (10 minutes)

### Step 1: Push Docker Configuration (1 min)

Code is already updated with Dockerfile. Just verify in GitHub:
- ✅ `Dockerfile` exists
- ✅ `.dockerignore` exists  
- ✅ `railway.json` uses DOCKERFILE builder

### Step 2: Create Railway Project (2 min)

1. Go to https://railway.app
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose: **`Feynman-0/PerfumePalace`**
5. Railway will detect Dockerfile automatically

### Step 3: Add MySQL Database (1 min)

1. In Railway project, click **"+ New"**
2. Select **"Database"** → **"Add MySQL"**
3. Wait 30 seconds for provisioning

**⚠️ IMPORTANT: You MUST have a separate database!**
- Docker containers are ephemeral (data gets deleted)
- Database must be external and persistent
- Railway MySQL is managed and backed up

### Step 4: Configure Environment Variables (3 min)

Click your service → **"Variables"** tab

Add these variables:

```bash
APP_KEY=base64:Wt8mYPxtPbckNEq0W7/sthKljl2PJWtTNSpbquDN7L4=
APP_ENV=production
APP_DEBUG=false
APP_NAME=Perfume Palace
DB_CONNECTION=mysql
BAGISTO_INSTALLED=true
```

**Get your Railway URL:**
1. Go to **"Settings"** → **"Networking"**
2. Click **"Generate Domain"**
3. Copy the URL

**Add APP_URL:**
```bash
APP_URL=https://your-railway-url.up.railway.app
```

### Step 5: Wait for Docker Build (3 min)

1. Go to **"Deployments"** tab
2. Watch the build process:
   ```
   Building Docker image...
   Installing PHP dependencies...
   Installing Node dependencies...
   Building assets...
   Creating image...
   Deploying...
   ```
3. Wait for **"Success ✅"**

**Build time:** ~3-5 minutes (first time only)

### Step 6: Complete Bagisto Installation (2 min)

1. Open your Railway URL
2. Complete Bagisto installer:
   - Application Name: `Perfume Palace`
   - URL: Your Railway URL
   - Timezone: `UTC`
   - Currency: `USD`
3. Click through all steps
4. Done! ✅

---

## 📦 Docker Image Details

### What's Included in the Image:

✅ PHP 8.2 with all extensions (GD, MySQL, etc.)  
✅ Composer dependencies (optimized)  
✅ Node.js and npm  
✅ Built frontend assets (CSS/JS)  
✅ All application code  
✅ Configured for production  

### What's NOT Included (External):

❌ MySQL Database → Railway MySQL service  
❌ Uploaded files → Use Railway volumes or S3  
❌ Session data → Uses database sessions  
❌ Cache → Uses database cache  

---

## 🔄 Updates & Redeployment

### To Deploy Changes:

```bash
git add .
git commit -m "Your changes"
git push origin main
```

Railway will:
1. Rebuild Docker image
2. Deploy new container
3. Keep database (persistent)
4. Zero downtime

---

## 🗄️ About the Database

### Why Separate Database is Required:

**Docker containers are ephemeral:**
- When container restarts → files deleted
- When you redeploy → old container destroyed
- No data persistence inside container

**Solution:**
- Use Railway MySQL (separate service)
- Data stays persistent
- Survives restarts and redeployments
- Automatic backups included

### Database Connection:

Railway auto-injects these variables:
- `MYSQLHOST`
- `MYSQLPORT`
- `MYSQLDATABASE`
- `MYSQLUSER`
- `MYSQLPASSWORD`

Your app reads these automatically via `config/database.php`

---

## 🐛 Troubleshooting

### Build Failed

**Check:**
1. Dockerfile syntax is correct
2. All files are committed to GitHub
3. Check build logs in Railway

**Common fixes:**
```bash
# Rebuild without cache
Railway: Settings → Redeploy → Check "Clear build cache"
```

### Database Connection Error

**Solution:**
1. Ensure MySQL service is running
2. Check database is linked to your app
3. Verify environment variables are set

### Images Not Loading

**Solution:**
Run in Railway shell:
```bash
php artisan storage:link
```

### 500 Error

**Check logs:**
1. Deployments → Latest → Logs
2. Look for PHP errors

**Common fix:**
```bash
# In Railway shell
php artisan optimize:clear
php artisan storage:link
```

---

## 💰 Cost Breakdown

### Railway Free Tier:
- $5/month credit
- Lasts 2-3 months for this app
- Includes:
  - Docker container
  - MySQL database
  - Domain with SSL

### After Free Tier:
- **Hobby Plan:** $5/month
- **Pro Plan:** $20/month (recommended for production)

---

## 🎯 Deployment Checklist

```
☐ Code pushed to GitHub
☐ Railway project created
☐ MySQL database added
☐ Environment variables configured
☐ APP_URL set correctly
☐ Docker image built successfully
☐ Site accessible
☐ Bagisto installer completed
☐ Admin account created
☐ Products visible
☐ Images loading
```

---

## 🆘 Need Help?

**View logs:**
```
Railway Dashboard → Your Service → Deployments → Latest → Logs
```

**Access shell:**
```
Railway Dashboard → Your Service → ⋮ (three dots) → Shell
```

**Rebuild:**
```
Railway Dashboard → Deployments → Redeploy
```

---

**Your Perfume Palace is now running in a Docker container on Railway! 🐳🚀**
