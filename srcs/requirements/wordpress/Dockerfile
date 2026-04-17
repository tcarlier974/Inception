FROM alpine:3.18

# Installation de PHP et de ses dépendances nécessaires pour WordPress
RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-phar \
    php81-mbstring \
    php81-curl \
    php81-dom \
    php81-exif \
    php81-fileinfo \
    php81-xml \
    php81-zip \
    mariadb-client \
    curl

# Téléchargement de WP-CLI (l'outil en ligne de commande pour WordPress)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# On crée le dossier qui contiendra le site
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# Copie de la configuration PHP et du script d'initialisation
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY tools/wp_config.sh /wp_config.sh
RUN chmod +x /wp_config.sh

EXPOSE 9000

ENTRYPOINT ["/bin/sh", "/wp_config.sh"]