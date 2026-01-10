#!/bin/bash

echo "Starting Railway deployment setup..."

# Wait for database to be ready
echo "Waiting for database connection..."
sleep 5

# Check if already installed
if [ ! -f "storage/installed" ]; then
    echo "First time setup - running migrations and seeding..."
    
    # Run migrations
    echo "Running database migrations..."
    php artisan migrate --force --no-interaction
    
    # Seed the database
    echo "Seeding database..."
    php artisan db:seed --force --no-interaction
    
    # Create installed marker
    echo "Creating installed marker..."
    touch storage/installed
    echo "Installation marker created at storage/installed"
else
    echo "Already installed - skipping migrations and seeding"
fi

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
