FROM php:8.1-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip

# Extensiones PHP necesarias para Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Crear carpeta de trabajo
WORKDIR /var/www

# Copiar código
COPY . .

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV APP_ENV=production
ENV APP_DEBUG=false

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader --no-scripts

CMD ["php-fpm"]
