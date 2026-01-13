#!/bin/bash

# ======================================
# PERFUME PALACE - PRODUCTION DEPLOYMENT SCRIPT
# ======================================
# Usage: bash deploy-production.sh
# ======================================

set -e # Exit on error

echo "========================================="
echo "🚀 Perfume Palace Production Deployment"
echo "========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if running in production
if [ "$APP_ENV" != "production" ]; then
    print_error "APP_ENV is not set to production!"
    print_info "Set APP_ENV=production in your environment variables"
    exit 1
fi

print_success "Environment: Production"
echo ""

# ======================================
# 1. PRE-DEPLOYMENT CHECKS
# ======================================
print_info "Step 1: Pre-deployment checks..."

# Check PHP version
PHP_VERSION=$(php -r "echo PHP_VERSION;")
print_info "PHP Version: $PHP_VERSION"

if [ -z "$APP_KEY" ]; then
    print_error "APP_KEY not set!"
    print_info "Run: php artisan key:generate"
    exit 1
fi

print_success "APP_KEY is configured"

# Check database connection
print_info "Checking database connection..."
php artisan db:monitor || {
    print_error "Database connection failed!"
    exit 1
}
print_success "Database connected"

echo ""

# ======================================
# 2. CLEAR ALL CACHES
# ======================================
print_info "Step 2: Clearing all caches..."

php artisan optimize:clear
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan event:clear

print_success "All caches cleared"
echo ""

# ======================================
# 3. DATABASE MIGRATIONS
# ======================================
print_info "Step 3: Running database migrations..."

# Check if Bagisto is installed
if [ "$BAGISTO_INSTALLED" = "true" ]; then
    print_info "Bagisto already installed, running migrations only..."
    php artisan migrate --force --no-interaction
else
    print_info "First time installation detected..."
    php artisan bagisto:install --skip-env-check --skip-admin-creation --skip-github-star --no-interaction || {
        print_error "Bagisto installation failed!"
        exit 1
    }
fi

print_success "Database migrations completed"
echo ""

# ======================================
# 4. OPTIMIZE FOR PRODUCTION
# ======================================
print_info "Step 4: Optimizing for production..."

# Cache configuration
php artisan config:cache
print_success "Configuration cached"

# Cache routes
php artisan route:cache
print_success "Routes cached"

# Cache views
php artisan view:cache
print_success "Views cached"

# Cache events
php artisan event:cache
print_success "Events cached"

# Optimize autoloader
composer dump-autoload --optimize --no-dev
print_success "Autoloader optimized"

echo ""

# ======================================
# 5. STORAGE & PERMISSIONS
# ======================================
print_info "Step 5: Setting up storage..."

# Create storage link
php artisan storage:link --force
print_success "Storage link created"

# Set permissions (if needed - Railway handles this)
# chmod -R 775 storage bootstrap/cache
# print_success "Permissions set"

echo ""

# ======================================
# 6. ASSET COMPILATION
# ======================================
print_info "Step 6: Compiling assets..."

if [ -f "package.json" ]; then
    print_info "Installing node modules..."
    npm ci --production
    
    print_info "Building assets..."
    npm run build
    
    print_success "Assets compiled"
else
    print_info "No package.json found, skipping asset compilation"
fi

echo ""

# ======================================
# 7. BAGISTO-SPECIFIC OPTIMIZATIONS
# ======================================
print_info "Step 7: Bagisto optimizations..."

# Publish Bagisto assets
php artisan bagisto:publish --force
print_success "Bagisto assets published"

# Reindex products for search
print_info "Reindexing products..."
php artisan bagisto:indexer:reindex --no-interaction
print_success "Products reindexed"

echo ""

# ======================================
# 8. SECURITY CHECKS
# ======================================
print_info "Step 8: Security checks..."

# Check if APP_DEBUG is false
if [ "$APP_DEBUG" = "false" ]; then
    print_success "APP_DEBUG is false"
else
    print_error "APP_DEBUG should be false in production!"
fi

# Check if APP_ENV is production
if [ "$APP_ENV" = "production" ]; then
    print_success "APP_ENV is production"
else
    print_error "APP_ENV should be production!"
fi

# Check if HTTPS is being used
if [ "$APP_URL" = "https://"* ]; then
    print_success "HTTPS is configured"
else
    print_error "APP_URL should use HTTPS in production!"
fi

echo ""

# ======================================
# 9. HEALTH CHECK
# ======================================
print_info "Step 9: Running health check..."

# Test database connection
php artisan tinker --execute="echo DB::connection()->getPdo() ? 'Database OK' : 'Database FAIL';"

# Test cache
php artisan tinker --execute="Cache::put('health_check', true, 60); echo Cache::get('health_check') ? 'Cache OK' : 'Cache FAIL';"

print_success "Health check completed"
echo ""

# ======================================
# 10. POST-DEPLOYMENT TASKS
# ======================================
print_info "Step 10: Post-deployment tasks..."

# Queue restart (if using queues)
if [ "$QUEUE_CONNECTION" != "sync" ]; then
    print_info "Restarting queue workers..."
    php artisan queue:restart
    print_success "Queue workers restarted"
fi

# Clear expired sessions
php artisan session:gc

print_success "Post-deployment tasks completed"
echo ""

# ======================================
# DEPLOYMENT COMPLETE
# ======================================
echo "========================================="
echo -e "${GREEN}✓ DEPLOYMENT SUCCESSFUL!${NC}"
echo "========================================="
echo ""
echo "🎉 Perfume Palace is now running in production!"
echo ""
echo "📊 Next steps:"
echo "  1. Test the website: $APP_URL"
echo "  2. Test admin panel: $APP_URL/$APP_ADMIN_URL"
echo "  3. Monitor logs for errors"
echo "  4. Set up automated backups"
echo "  5. Configure monitoring/alerts"
echo ""
echo "📝 Production checklist:"
echo "  • SSL certificate valid"
echo "  • Database backups configured"
echo "  • Email notifications working"
echo "  • Payment gateway tested"
echo "  • Mobile responsive checked"
echo "  • Performance monitoring active"
echo ""
echo "========================================="
