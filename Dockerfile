FROM php:8.3-apache

WORKDIR /var/www/html


#Config apache
RUN a2enmod rewrite
ENV APACHE_DOCUMENT_ROOT /var/www/html/public


RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# git install
RUN apt-get update && apt-get install -y \
build-essential \
libzip-dev \
libpng-dev \
libjpeg62-turbo-dev \    
libfreetype6-dev \
    libonig-dev \
    locales \    
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    git \
    curl \
    ffmpeg 

RUN docker-php-ext-install pdo pdo_mysql zip exif pcntl bcmath
RUN echo "max_input_vars = 5000" >> /usr/local/etc/php/php.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .
RUN rm -rf /app/vendor
RUN rm -rf /app/composer.lock
RUN composer install
COPY .env.example .env
RUN mkdir -p /app/storage/logs
RUN php artisan cache:clear
RUN php artisan view:clear
RUN php artisan config:clear
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80", "&", "php", "artisan", "migrate"]
#CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]


EXPOSE 80