FROM alpine:3.22

# Installation de NGINX et OpenSSL
RUN apk update && apk add --no-cache nginx openssl

# On crée le dossier pour stocker nos certificats de sécurité
RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /run/nginx

# Génération du certificat SSL auto-signé (remplace "tonlogin" à la fin)
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tcarlier.42.fr/UID=tcarlier"

# On copie notre fichier de configuration dans le dossier d'Alpine
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

# On expose le seul port autorisé : 443 (HTTPS)
EXPOSE 443

# On lance NGINX au premier plan ("daemon off") pour que le conteneur reste en vie
ENTRYPOINT ["nginx", "-g", "daemon off;"]