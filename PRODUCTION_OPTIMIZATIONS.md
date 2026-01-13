# 🚀 Production Optimization Guide

## Current Issues Fixed

### 1. Image Loading Performance ✅
- **Status**: Already optimized
- **Features**:
  - Lazy loading implemented (`v-shimmer-image` component)
  - Image caching configured (small/medium/large)
  - Responsive images with srcset
  - Cache lifetime: 525,600 minutes (1 year)

### 2. Database Performance

**Redis Caching** (Recommended for Railway):
```bash
# Add to Railway environment variables:
CACHE_STORE=redis
REDIS_HOST=<redis-host>
REDIS_PASSWORD=<redis-password>
REDIS_PORT=6379
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
```

**Database Indexing**:
```sql
-- Run these for better query performance:
CREATE INDEX idx_products_status ON products(status);
CREATE INDEX idx_products_visible_individually ON products(visible_individually);
CREATE INDEX idx_product_flat_status ON product_flat(status);
CREATE INDEX idx_product_flat_price ON product_flat(price);
CREATE INDEX idx_channels_hostname ON channels(hostname);
```

### 3. Asset Optimization

**Already Configured**:
- ✅ Vite bundling and minification
- ✅ CSS/JS compression
- ✅ Tree shaking enabled

**Additional Recommendations**:
```bash
# Install image optimization for uploads
composer require intervention/imagecache

# Configure automatic WebP conversion
# Add to config/image.php:
'webp_quality' => 80,
'auto_convert' => true
```

### 4. OPcache Configuration

Create `config/opcache.php`:
```php
<?php
return [
    'opcache.enable' => 1,
    'opcache.memory_consumption' => 256,
    'opcache.interned_strings_buffer' => 16,
    'opcache.max_accelerated_files' => 20000,
    'opcache.validate_timestamps' => 0, // Important for production!
    'opcache.revalidate_freq' => 0,
    'opcache.fast_shutdown' => 1,
];
```

### 5. Security Hardening

**Environment Variables** (Railway):
```env
APP_ENV=production
APP_DEBUG=false
APP_KEY=<your-generated-key>

# Security Headers
SECURE_HEADERS=true
HTTPS_ONLY=true

# Session Security
SESSION_SECURE_COOKIE=true
SESSION_SAME_SITE=strict

# Rate Limiting
THROTTLE_REQUESTS=60
THROTTLE_DECAY_MINUTES=1
```

**Add Security Middleware**:
```php
// In bootstrap/app.php or config/middlew are.php
return Application::configure(basePath: dirname(__DIR__))
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->web(append: [
            \App\Http\Middleware\SecurityHeaders::class,
        ]);
    })
```

### 6. CDN Configuration

For static assets (images, CSS, JS):
```env
# Add to .env
ASSET_URL=https://cdn.yourdomacom
CDN_URL=https://cdn.yourdomain.com
```

Configure in `config/filesystems.php`:
```php
'cdn' => [
    'driver' => 's3',
    'key' => env('AWS_ACCESS_KEY_ID'),
    'secret' => env('AWS_SECRET_ACCESS_KEY'),
    'region' => env('AWS_DEFAULT_REGION'),
    'bucket' => env('AWS_BUCKET'),
    'url' => env('CDN_URL'),
],
```

### 7. Database Connection Pooling

**For Railway MySQL**:
```env
DB_CONNECTION=mysql
DB_POOL_MIN=2
DB_POOL_MAX=10
DB_TIMEOUT=30
```

### 8. Queue Configuration

**For Background Jobs**:
```env
QUEUE_CONNECTION=redis
QUEUE_FAILED_DRIVER=database

# In Railway, run worker:
php artisan queue:work --tries=3 --timeout=90
```

### 9. Monitoring & Logging

**Sentry Integration** (Error Tracking):
```bash
composer require sentry/sentry-laravel
php artisan sentry:publish --dsn=<your-sentry-dsn>
```

**Log Management**:
```env
LOG_CHANNEL=stack
LOG_LEVEL=error # Production should only log errors
LOG_DEPRECATIONS_CHANNEL=null
```

### 10. Performance Testing

**Run these benchmarks**:
```bash
# Clear all caches first
php artisan optimize:clear

# Then optimize for production
php artisan optimize

# Test page load speed
curl -w "@curl-format.txt" -o /dev/null -s https://your-domain.com

# Test database query performance
php artisan telescope:install # Development only
```

## Pre-Deployment Checklist

- [ ] Run `php artisan optimize`
- [ ] Clear all caches: `php artisan optimize:clear`
- [ ] Test image lazy loading
- [ ] Verify Redis connection (if using)
- [ ] Check database indexes
- [ ] Test payment gateway (if configured)
- [ ] Verify SSL certificate
- [ ] Enable GZIP compression on server
- [ ] Set up automated backups
- [ ] Configure monitoring/alerts
- [ ] Test mobile performance
- [ ] Run security scan
- [ ] Verify environment variables
- [ ] Test error pages (404, 500)
- [ ] Check robots.txt and sitemap
- [ ] Verify email configuration

## Railway-Specific Optimizations

### 1. Environment Variables Already Set
```env
BAGISTO_INSTALLED=true
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:...
DB_CONNECTION=mysql
# MYSQL variables auto-provided by Railway
```

### 2. Build Optimization
Already configured in `nixpacks.toml`:
- ✅ PHP 8.2 with all required extensions
- ✅ Composer optimization
- ✅ NPM production build
- ✅ Asset caching

### 3. Health Checks
Add to Railway:
- Health check path: `/health`
- Expected status: 200
- Interval: 30s

Create health check route in `routes/web.php`:
```php
Route::get('/health', function () {
    return response()->json([
        'status' => 'healthy',
        'database' => DB::connection()->getPdo() ? 'connected' : 'disconnected',
        'cache' => Cache::has('health_check'),
    ]);
});
```

## Performance Metrics

**Target Goals**:
- First Contentful Paint (FCP): < 1.8s
- Largest Contentful Paint (LCP): < 2.5s
- Time to Interactive (TTI): < 3.8s
- Total Blocking Time (TBT): < 300ms
- Cumulative Layout Shift (CLS): < 0.1

## Troubleshooting Common Issues

### Images Loading Slow
1. Check image cache is working: `storage/cache/small|medium|large`
2. Verify lazy loading is active
3. Optimize source images (< 500KB recommended)

### Database Slow Queries
1. Enable query logging temporarily
2. Check missing indexes
3. Consider adding Redis cache

### High Memory Usage
1. Increase PHP memory_limit
2. Enable OPcache
3. Use Redis for sessions

### Session Issues
1. Verify session driver configuration
2. Check Redis connection if using
3. Clear old sessions: `php artisan session:gc`

## Post-Deployment

1. Monitor error logs for 24 hours
2. Check Sentry/error tracking dashboard
3. Test all critical user paths
4. Verify analytics are tracking
5. Check SSL certificate validity
6. Monitor database performance
7. Watch server resource usage

## Continuous Optimization

- Weekly: Review error logs
- Monthly: Check performance metrics
- Quarterly: Security audit
- Annually: Dependency updates

---

**Last Updated**: January 2026  
**Bagisto Version**: 2.x  
**PHP Version**: 8.2+  
**Laravel Version**: 11.x
