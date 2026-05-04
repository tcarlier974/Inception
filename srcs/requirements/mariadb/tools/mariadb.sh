#!/bin/sh

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

/usr/bin/mariadbd --user=mysql --datadir=/var/lib/mysql &
sleep 5

# On envoie toutes les commandes en une seule connexion !
mariadb -e "
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;"

mariadb-admin -u root -p${SQL_ROOT_PASSWORD} shutdown

exec /usr/bin/mariadbd --user=mysql --datadir=/var/lib/mysql