# USER_DOC

## Services Provided
This stack provides three services:
- NGINX: HTTPS entrypoint on port 443.
- WordPress + PHP-FPM: website application runtime.
- MariaDB: relational database for WordPress.

## Start and Stop
From project root:

```bash
make all
```

Stop services:

```bash
make down
```

Rebuild and restart:

```bash
make re
```

## Access the Website and Administration Panel
1. Ensure your host resolves tcarlier.42.fr to your local machine IP.
2. Open:
- https://tcarlier.42.fr
3. WordPress admin panel:
- https://tcarlier.42.fr/wp-admin

## Credentials Location and Management
All credentials are defined in `srcs/.env`:

```env
DOMAIN_NAME=user.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=your_db_password
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_HOSTNAME=mariadb
WP_TITLE=Inception by user
WP_ADMIN_USER=wp_admin_user
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_EMAIL=user@student.42perpignan.fr
WP_USER_NAME=user42
WP_USER_EMAIL=user42@42.fr
```

Notes:
- Keep `srcs/.env` local and out of public repositories.
- Update passwords before deployment.

## Check Services Health
List running containers:

```bash
docker compose -f srcs/docker-compose.yml ps
```

Check logs:

```bash
docker compose -f srcs/docker-compose.yml logs -f
```

Quick DB health status:

```bash
docker inspect --format='{{json .State.Health}}' mariadb
```

## Troubleshooting Basics
- If website is unreachable: check port 443 availability and DNS/hosts mapping.
- If WordPress fails startup: verify DB secrets and MariaDB health.
- If admin login fails: confirm secrets/credentials.txt content and restart with make re.