# On part d'une version stable d'Alpine
FROM alpine:3.18

# On utilise apk pour installer mariadb et son client
RUN apk update && apk add --no-cache mariadb mariadb-client

# Sur Alpine, les fichiers de configuration sont souvent dans /etc/my.cnf.d/
COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# On copie notre script d'initialisation
COPY tools/mariadb.sh /mariadb.sh
RUN chmod +x /mariadb.sh

# On expose le port
EXPOSE 3306

# On précise bien /bin/sh car bash n'est pas installé par défaut
ENTRYPOINT ["/bin/sh", "/mariadb.sh"]