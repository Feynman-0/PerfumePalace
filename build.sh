#!/bin/bash

# Railway Build Script for Perfume Palace
# This script installs PHP GD extension and builds the application

set -e

echo "🚀 Starting Perfume Palace build..."

# Install GD extension if not present
echo "📦 Installing PHP GD extension..."
if command -v apt-get &> /dev/null; then
    apt-get update
    apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev
    docker-php-ext-configure gd --with-freetype --with-jpeg
    docker-php-ext-install gd
fi

# Install Composer dependencies
echo "📦 Installing Composer dependencies..."
composer install --no-dev --optimize-autoloader --no-interaction

# Install Node dependencies
echo "📦 Installing Node dependencies..."
npm install --production

# Build assets
echo "🔨 Building assets..."
npm run build

# Laravel optimizations
echo "⚡ Optimizing Laravel..."
php artisan storage:link
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "✅ Build complete!"
