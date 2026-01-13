# 🚀 Railway Deployment Guide - Perfume Palace

## Step-by-Step Setup (15 minutes)

---

## 📋 Part 1: Create Railway Project (3 minutes)

### 1. Go to Railway
- Open: https://railway.app
- Click **"Login"** (use GitHub account)

### 2. Create New Project
- Click **"New Project"** button
- Select **"Deploy from GitHub repo"**
- Find and select: **`Feynman-0/PerfumePalace`**
- Click **"Deploy Now"**

✅ Railway will start building automatically!

---

## 🗄️ Part 2: Add MySQL Database (2 minutes)

### 1. Add Database
- In your Railway project dashboard
- Click **"+ New"** button (top right)
- Select **"Database"**
- Choose **"Add MySQL"**

✅ MySQL database will provision in ~30 seconds

### 2. Link Database to Your App
- Click on your **PerfumePalace service** (the main app)
- Go to **"Variables"** tab
- Railway auto-injects these variables:
  - `MYSQLHOST`
  - `MYSQLPORT`
  - `MYSQLDATABASE`
  - `MYSQLUSER`
  - `MYSQLPASSWORD`

✅ Database is now connected!

---

## ⚙️ Part 3: Configure Environment Variables (5 minutes)

### 1. Go to Variables Tab
- Click your **PerfumePalace service**
- Click **"Variables"** tab
- Click **"+ New Variable"**

### 2. Add These Variables One by One:

**Copy and paste each one:**

```bash
APP_KEY=base64:Wt8mYPxtPbckNEq0W7/sthKljl2PJWtTNSpbquDN7L4=
```
Click "Add"

```bash
APP_ENV=production
```
Click "Add"

```bash
APP_DEBUG=false
```
Click "Add"

```bash
APP_NAME=Perfume Palace
```
Click "Add"

```bash
DB_CONNECTION=mysql
```
Click "Add"

```bash
BAGISTO_INSTALLED=true
```
Click "Add"

### 3. Get Your Railway URL
- Go to **"Settings"** tab
- Scroll to **"Networking"** section
- Click **"Generate Domain"**
- Copy the URL (looks like: `perfume-palace-production.up.railway.app`)

### 4. Add APP_URL Variable
```bash
APP_URL=https://your-generated-url-here.up.railway.app
```
**⚠️ Replace with YOUR actual Railway URL!**

Click "Add"

✅ All variables configured!

---

## 🚀 Part 4: Deploy & Install (5 minutes)

### 1. Wait for Deployment
- Go to **"Deployments"** tab
- Wait for build to complete (~2-3 minutes)
- Status should show: **"Success ✅"**

### 2. Open Your Site
- Click the **generated domain URL**
- Or go to: `https://your-url.up.railway.app`

### 3. Complete Bagisto Installation
You'll see the Bagisto installer screen:

**Fill in:**
- Application Name: `Perfume Palace`
- Default URL: `https://your-railway-url.up.railway.app`
- Default Timezone: `UTC` or your timezone
- Default Locale: `English`
- Default Currency: `United States Dollar (USD)`

Click **"Continue"** through all steps

**⚠️ IMPORTANT:** Skip admin creation (we'll create later)

### 4. Complete Installation
- Click through all installation steps
- When done, you'll see **"Installation Completed"**
- Click **"Customer Panel"**

✅ **YOUR SITE IS NOW LIVE!** 🎉

---

## 🔐 Part 5: Create Admin Account (2 minutes)

### 1. Open Railway Shell
- In Railway dashboard
- Click your **PerfumePalace service**
- Click **three dots (⋮)** menu (top right)
- Select **"Shell"** or **"Terminal"**

### 2. Create Admin User
Run this command in the Railway shell:

```bash
php artisan tinker
```

Then paste this (replace with YOUR email/password):

```php
$admin = new \Webkul\User\Models\Admin();
$admin->name = 'Admin';
$admin->email = 'admin@perfumepalace.com';
$admin->password = bcrypt('your-secure-password-here');
$admin->role_id = 1;
$admin->status = 1;
$admin->save();
exit
```

Press Enter

✅ Admin created!

---

## 🧪 Part 6: Test Everything (3 minutes)

### 1. Test Storefront
- Visit: `https://your-url.up.railway.app`
- Should see Perfume Palace homepage
- Check if images load
- Click on products

### 2. Test Admin Panel
- Visit: `https://your-url.up.railway.app/admin`
- Login with:
  - Email: `admin@perfumepalace.com`
  - Password: (the one you set)

### 3. Check Products
- Admin → Catalog → Products
- You should see products loaded

✅ **EVERYTHING WORKING!** 🎉

---

## 📊 Summary

**Your Live URLs:**
- **Storefront:** `https://your-url.up.railway.app`
- **Admin:** `https://your-url.up.railway.app/admin`

**Database:**
- Type: MySQL (managed by Railway)
- Auto-backup: Included

**Cost:**
- FREE for 2-3 months ($5 credit)
- After: $5-20/month depending on usage

---

## 🐛 Troubleshooting

### Problem: Installer keeps appearing
**Solution:** Make sure you added:
```bash
BAGISTO_INSTALLED=true
```
in Variables tab

### Problem: Database connection error
**Solution:** 
1. Check MySQL service is running
2. Verify database is linked to your app
3. Redeploy: Click "Redeploy" in Deployments

### Problem: Images not loading
**Solution:** Run in Railway Shell:
```bash
php artisan storage:link
```

### Problem: 500 Error
**Solution:** Check logs:
- Deployments tab → Click latest deployment → View logs

---

## 📧 Need Help?

Check deployment logs:
1. Go to **"Deployments"** tab
2. Click latest deployment
3. View build/runtime logs

---

**🎉 Congratulations! Your Perfume Palace is LIVE on Railway!**
