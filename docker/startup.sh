#!/bin/bash
set -e

echo "Starting Perfume Palace deployment..."

# Wait for database
echo "Waiting for database..."
sleep 5

# Run Bagisto installer if not already installed
if [ ! -f storage/installed ]; then
    echo "Running Bagisto installer..."
    php artisan bagisto:install --skip-env-check --skip-admin-creation --skip-github-star --no-interaction || echo "Already installed"
    touch storage/installed
fi

# Clear and optimize
echo "Optimizing application..."
php artisan optimize:clear
php artisan optimize

# Create storage link
php artisan storage:link --force

echo "Starting services..."
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
