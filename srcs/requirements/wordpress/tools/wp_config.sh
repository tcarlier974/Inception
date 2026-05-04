#!/bin/sh

# On attend que MariaDB soit prêt avant de lancer l'installation
while ! mariadb-admin ping -h"mariadb" -u"${SQL_USER}" -p"${SQL_PASSWORD}" --silent; do
    sleep 1
done
# Si le fichier wp-config.php n'existe pas, c'est qu'on n'a pas encore installé WordPress
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Installation de WordPress en cours..."
    
    # 1. Télécharger les fichiers de WordPress
    # 1. Télécharger les fichiers de WordPress avec plus de RAM
    php82 -d memory_limit=512M /usr/local/bin/wp core download --allow-root

    # 2. Créer le fichier de configuration relié à la base de données
    wp config create --dbname="${SQL_DATABASE}" \
                     --dbuser="${SQL_USER}" \
                     --dbpass="${SQL_PASSWORD}" \
                     --dbhost="mariadb" \
                     --allow-root

    # 3. Installer WordPress (création du site et du compte Admin)
    wp core install --url="${DOMAIN_NAME}" \
                    --title="${WP_TITLE}" \
                    --admin_user="${WP_ADMIN_USER}" \
                    --admin_password="${WP_ADMIN_PASSWORD}" \
                    --admin_email="${WP_ADMIN_EMAIL}" \
                    --allow-root

    # 4. Créer un deuxième utilisateur (exigence du sujet)
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
                   --user_pass="${WP_USER_PASSWORD}" \
                   --role=author \
                   --allow-root
    
    # On donne les bons droits sur les fichiers pour le serveur web
    chown -R nobody:nobody /var/www/html
fi

# On lance PHP-FPM au premier plan pour maintenir le conteneur en vie
exec /usr/sbin/php-fpm82 -F