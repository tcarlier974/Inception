# Nom du projet
NAME = inception

# Commandes
all:
	@printf "Lancement de l'infrastructure ${NAME}...\n"
	@docker-compose -f srcs/docker-compose.yml up -d --build

down:
	@printf "Arrêt de l'infrastructure ${NAME}...\n"
	@docker-compose -f srcs/docker-compose.yml down

re: down all

clean: down
	@printf "Nettoyage des conteneurs...\n"
	@docker system prune -a --force

fclean: clean
	@printf "Nettoyage total (volumes et images)...\n"
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf /home/tcarlier/data/mariadb/*
	@sudo rm -rf /home/tcarlier/data/wordpress/*

.PHONY: all down re clean fclean