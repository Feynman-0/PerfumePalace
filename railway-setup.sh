#!/bin/bash

echo "Starting Railway deployment setup..."

# Wait for database to be ready
echo "Waiting for database connection..."
sleep 5

# Run migrations
echo "Running database migrations..."
php artisan migrate --force --no-interaction

# Seed the database
echo "Seeding database..."
php artisan db:seed --force --no-interaction

# Create storage link
echo "Creating storage link..."
php artisan storage:link --force

# Clear and cache config
echo "Optimizing application..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Setup complete! Starting application..."
