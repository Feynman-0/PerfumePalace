# Perfume Palace - Production Deployment Guide

## 🚀 Quick Deploy to Railway

### Prerequisites
- Railway account
- GitHub repository connected

### Environment Variables (Required)

Add these in Railway Dashboard → Your Service → Variables:

```bash
APP_KEY=base64:Wt8mYPxtPbckNEq0W7/sthKljl2PJWtTNSpbquDN7L4=
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-domain.up.railway.app
BAGISTO_INSTALLED=true
DB_CONNECTION=mysql
```

### Database Setup

1. Add MySQL Database:
   - Railway Dashboard → + New → Database → MySQL
   - Railway auto-injects: MYSQLHOST, MYSQLPORT, MYSQLDATABASE, MYSQLUSER, MYSQLPASSWORD

2. Link database to your service:
   - Your Service → Settings → Service Variables → Connect MySQL

### Deployment Steps

1. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Production ready"
   git push origin main
   ```

2. **Railway Auto-deploys**:
   - Detects nixpacks.toml
   - Installs PHP 8.2 + extensions
   - Runs composer install
   - Builds assets
   - Starts server

3. **Access Your Site**:
   - Storefront: https://your-domain.up.railway.app
   - Admin: https://your-domain.up.railway.app/admin

### Admin Credentials

Default admin login:
- Email: `admin@example.com`
- Password: `admin123`

**⚠️ CHANGE THESE IMMEDIATELY IN PRODUCTION!**

### Post-Deployment

1. **Clear caches**:
   ```bash
   php artisan optimize
   ```

2. **Test the site**:
   - Visit storefront
   - Login to admin
   - Check product images load
   - Test add to cart

3. **Monitor logs**:
   - Railway → Your Service → Deployments → Logs

## 🔒 Security Checklist

- [x] APP_DEBUG=false
- [x] APP_ENV=production
- [x] Strong APP_KEY generated
- [x] HTTPS enabled (automatic on Railway)
- [x] Session encryption enabled
- [x] Secure cookies enabled
- [ ] Change default admin credentials
- [ ] Set up email (MAIL_* variables)
- [ ] Add custom domain (optional)

## ⚡ Performance Optimization

### Automatic Optimizations
- ✅ OPcache enabled (PHP 8.2)
- ✅ Composer optimized autoloader
- ✅ Laravel caches (config, routes, views)
- ✅ Assets minified and bundled

### Image Optimization
1. Keep product images under 500KB
2. Use WebP format when possible
3. Images auto-served from `public/storage`

### Database
- Indexes created automatically by Bagisto
- Connection pooling handled by Railway MySQL

## 🐛 Troubleshooting

### Installer Loop Issue
**Problem**: Site redirects to /install repeatedly

**Solution**: Add environment variable:
```bash
BAGISTO_INSTALLED=true
```

### Images Not Loading
**Problem**: Product images return 404

**Solution**: Run in Railway shell:
```bash
php artisan storage:link --force
```

### Database Connection Error
**Problem**: SQLSTATE[HY000] [2002] Connection refused

**Solution**: 
1. Ensure MySQL database is linked to service
2. Check Railway → MySQL → Variables are injected
3. Redeploy after linking

### 500 Internal Server Error
**Problem**: White screen or 500 error

**Solution**:
1. Check logs: Railway → Deployments → Logs
2. Ensure APP_KEY is set
3. Run: `php artisan optimize:clear`

## 📊 Monitoring

### Railway Metrics
- CPU usage
- Memory usage
- Response times
- Error rates

### Logs
- Application logs: Railway dashboard
- Laravel logs: `storage/logs/laravel.log`

## 🔄 Updates

To deploy changes:
```bash
git add .
git commit -m "Your changes"
git push origin main
```

Railway auto-deploys on every push.

## 💰 Costs

**Railway Free Tier**:
- $5/month credit
- Shared CPU
- 512MB RAM
- Good for demo/testing

**Pro Tier** (recommended for production):
- $20/month
- Dedicated resources
- Better performance

## 🆘 Support

- Bagisto Docs: https://devdocs.bagisto.com
- Railway Docs: https://docs.railway.app
- GitHub Issues: Your repository

---

**Your Perfume Palace is production-ready! 🎉**
