# DEV_DOC

## Environment Setup From Scratch
### Prerequisites
- Linux VM
- Docker Engine
- Docker Compose plugin
- make

### Required Files
- srcs/.env

Example srcs/.env:

```env
# Mots de passe pour MariaDB
SQL_DATABASE=wordpress
SQL_USER=username
SQL_PASSWORD=mot_de_passe
SQL_ROOT_PASSWORD=root_password

# Variables pour WordPress
DOMAIN_NAME=domain_name
WP_TITLE=Inception
WP_ADMIN_USER=username
WP_ADMIN_PASSWORD=password
WP_ADMIN_EMAIL=admin@domain_name.42.fr
WP_USER=username
WP_USER_PASSWORD=password
WP_USER_EMAIL=user@domain_name.42.fr
```

## Build and Launch
Build and start:

```bash
make all
```

Stop:

```bash
make down
```

Full rebuild:

```bash
make re
```

Cleanup:

```bash
make clean
make fclean
```

Reset volumes:

```bash
make reset
```

## Useful Container and Volume Commands
Container status:

```bash
docker compose -f srcs/docker-compose.yml ps
```

Logs by service:

```bash
docker compose -f srcs/docker-compose.yml logs -f nginx
docker compose -f srcs/docker-compose.yml logs -f wordpress
docker compose -f srcs/docker-compose.yml logs -f mariadb
```

Open shell in service container:

```bash
docker exec -it wordpress bash
docker exec -it mariadb bash
docker exec -it nginx bash
```

List named volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect srcs_wordpress_data
docker volume inspect srcs_mariadb_data
```

## Data Persistence
Persistent data is stored in Docker named volumes:
- srcs_mariadb_data -> MariaDB data (/var/lib/mysql)
- srcs_wordpress_data -> WordPress files (/var/www/html)

Data survives container recreation until volumes are explicitly removed.

## Architecture Notes
- NGINX is the only public entrypoint and exposes 443.
- NGINX forwards PHP requests to wordpress:9000 via FastCGI.
- WordPress waits for MariaDB health and then initializes site/users.
- Secrets are mounted under /run/secrets inside containers.