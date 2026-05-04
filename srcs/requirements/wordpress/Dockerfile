FROM alpine:3.22

# Installation de PHP et de ses dépendances nécessaires pour WordPress
RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-phar \
    php82-mbstring \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-xml \
    php82-zip \
    mariadb-client \
    curl

# On crée un raccourci pour que la commande 'php' pointe vers 'php82'
RUN ln -s /usr/bin/php82 /usr/bin/php

# Téléchargement de WP-CLI (l'outil en ligne de commande pour WordPress)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# On crée le dossier qui contiendra le site
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# Copie de la configuration PHP et du script d'initialisation
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY tools/wp_config.sh /wp_config.sh
RUN chmod +x /wp_config.sh

EXPOSE 9000

ENTRYPOINT ["/bin/sh", "/wp_config.sh"]