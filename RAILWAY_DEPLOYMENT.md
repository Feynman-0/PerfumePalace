# Railway Deployment Guide for Perfume Palace

## ✅ Files Already Configured:

1. **nixpacks.toml** - Includes PHP GD extension and all required extensions
2. **Procfile** - Defines the start command
3. **railway.json** - Railway-specific configuration
4. **.gitignore** - Protects sensitive files

## 🚀 Deployment Steps:

### Step 1: Connect to Railway

1. Go to [Railway.app](https://railway.app)
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose **"Feynman-0/PerfumePalace-Ecom"**

### Step 2: Add MySQL Database

1. In your Railway project, click **"+ New"**
2. Select **"Database" → "Add MySQL"**
3. Railway will create a MySQL database and set environment variables automatically

### Step 3: Configure Environment Variables

Click on your service → **"Variables"** tab → Add these:

```env
APP_NAME="Perfume Palace"
APP_ENV=production
APP_KEY=base64:YOUR_KEY_HERE
APP_DEBUG=false
APP_URL=https://your-app.up.railway.app

# Database (Railway auto-fills these from MySQL service)
DB_CONNECTION=mysql
DB_HOST=${{MySQL.MYSQLHOST}}
DB_PORT=${{MySQL.MYSQLPORT}}
DB_DATABASE=${{MySQL.MYSQLDATABASE}}
DB_USERNAME=${{MySQL.MYSQLUSER}}
DB_PASSWORD=${{MySQL.MYSQLPASSWORD}}

# Cache & Session
CACHE_STORE=file
SESSION_DRIVER=file
QUEUE_CONNECTION=database

# Mail (Optional - configure if needed)
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=your-email@gmail.com
MAIL_FROM_NAME="${APP_NAME}"
```

### Step 4: Generate APP_KEY

**Option 1: Using Railway Shell**
1. Open your service
2. Click **"Shell"** tab (or **"Terminal"**)
3. Run:
   ```bash
   php artisan key:generate --show
   ```
4. Copy the output (e.g., `base64:abc123...`)
5. Add it to `APP_KEY` variable in Railway

**Option 2: Local Generation**
```bash
cd d:\Bagisto
php artisan key:generate --show
```
Copy the output and add to Railway.

### Step 5: Run Migrations (First Deploy)

After first deployment, open Railway Shell and run:

```bash
php artisan migrate --force
php artisan db:seed --force
php artisan storage:link
```

### Step 6: Update APP_URL

After Railway gives you a URL (e.g., `https://perfume-palace-production.up.railway.app`):

1. Update the `APP_URL` variable in Railway
2. Redeploy if needed

---

## 🔧 Troubleshooting

### If GD Extension Error Persists:

Railway should automatically read `nixpacks.toml`, but if not:

1. **Check Build Logs**: Look for "Using nixpacks" in the logs
2. **Force Nixpacks**: In Railway dashboard:
   - Click your service → **"Settings"**
   - Scroll to **"Build Command"**
   - Leave empty (Railway auto-detects nixpacks.toml)

3. **Verify PHP Version**: Railway should use PHP 8.2 with GD extension

### Common Issues:

**1. APP_KEY not set:**
```bash
php artisan key:generate --show
```
Add the output to Railway variables.

**2. Database connection error:**
- Make sure MySQL service is linked
- Verify database variables are set: `${{MySQL.MYSQLHOST}}`, etc.

**3. Storage/Cache permissions:**
```bash
chmod -R 775 storage bootstrap/cache
```

**4. Assets not building:**
```bash
npm install
npm run build
```

### Check PHP Extensions:

In Railway Shell, run:
```bash
php -m | grep gd
```
Should output: `gd`

---

## 📊 Post-Deployment Checklist:

- [ ] Site loads at Railway URL
- [ ] Database connected (check products page)
- [ ] Images display correctly
- [ ] Logo appears
- [ ] Sorting works
- [ ] Add to cart works
- [ ] Admin panel accessible at `/admin`
- [ ] Admin login works (email: `admin@example.com`, password: `admin123`)

---

## 🔄 Updating Your Site:

After making changes locally:

```bash
git add .
git commit -m "Your update message"
git push origin main
```

Railway will automatically detect the push and redeploy! 🚀

---

## 💰 Railway Pricing:

- **Free Tier**: $5/month credit (enough for demo)
- **Usage-based**: Only pay for what you use
- **Sleeping**: Not on Railway (always running)

---

## 🎯 Custom Domain (Optional):

1. In Railway, click your service
2. Go to **"Settings"** → **"Domains"**
3. Click **"Generate Domain"** or **"Custom Domain"**
4. Add your custom domain (e.g., `perfumepalace.com`)
5. Update DNS records as shown
6. Update `APP_URL` variable

---

## 📞 Need Help?

- Railway Docs: https://docs.railway.app
- Bagisto Docs: https://devdocs.bagisto.com
- Railway Discord: https://discord.gg/railway

---

## ✅ Your Configuration is Ready!

All files are configured correctly:
- ✅ nixpacks.toml (includes GD extension)
- ✅ Procfile (start command)
- ✅ .gitignore (protects .env)
- ✅ .env.example (template)

Just push to GitHub and Railway will handle the rest!
