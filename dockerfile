FROM php:8.1-apache

# Set working directory
WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install -y libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    && a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the application files to the container
COPY . .

# Install application dependencies
RUN composer install --no-interaction --no-scripts --no-suggest


# Expose port 8000 
EXPOSE 8000
