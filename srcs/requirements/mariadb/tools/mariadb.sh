#!/bin/sh

# On crée les dossiers nécessaires pour qu'Alpine puisse lancer MariaDB
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# On initialise la base de données système de MariaDB si elle n'existe pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# On lance le serveur MariaDB en arrière-plan pour pouvoir lui envoyer des commandes
/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql &
sleep 5 # On attend un peu qu'il soit bien démarré

# On crée la base de données, l'utilisateur et on lui donne les droits
# (Les variables avec un $ proviendront de notre futur fichier .env)
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# On éteint le processus en arrière-plan proprement
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# On relance MariaDB en premier plan (foreground) pour que le conteneur reste en vie
exec /usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql