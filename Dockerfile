ARG NGINX_VERSION=1.16.0
ARG PHP_VERSION=7.3

# PHP-FPM
FROM wordpress:php${PHP_VERSION}-fpm-alpine as php-fpm

#COPY . /var/www/html/
# Entrypoint fixes correct permissions here
COPY . /usr/src/wordpress

# PHP CLI
FROM wordpress:cli-php${PHP_VERSION} as php-cli

#COPY . /var/www/html/
# Entrypoint fixes correct permissions here
COPY . /usr/src/wordpress


# Nginx
FROM nginx:${NGINX_VERSION}-alpine as nginx

COPY doc/docker/nginx/wordpress.conf /etc/nginx/conf.d/default.conf
COPY --from=php-fpm /var/www/html/ /var/www/html
