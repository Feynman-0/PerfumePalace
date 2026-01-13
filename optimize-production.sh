#!/bin/bash
# Production Optimization Script for Perfume Palace

echo "🚀 Optimizing Perfume Palace for Production..."

# Clear all caches
echo "📦 Clearing caches..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Optimize for production
echo "⚡ Optimizing..."
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize

# Create storage link
echo "🔗 Creating storage link..."
php artisan storage:link --force

# Set proper permissions
echo "🔐 Setting permissions..."
chmod -R 775 storage bootstrap/cache
chmod -R 775 public/storage

echo "✅ Production optimization complete!"
echo "🌐 Your Perfume Palace is ready for production!"
