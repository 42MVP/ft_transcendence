NAME = ft_transcendence

all: build

dev: set-env
	@echo "🏗️  Building ${NAME}-dev ...\n"
	@git switch develop
	@cd frontend && git switch develop
	@cd backend && git switch develop
	@mkdir -p ${HOME}/transcendence/data/upload
	@mkdir -p ${HOME}/transcendence/data/postgresql
	@mkdir -p ${HOME}/transcendence/data/postgresql-log
	@docker compose -f .docker/docker-compose.yml up --build

build: set-env
	@echo "🏗️  Building ${NAME} ...\n"
	@mkdir -p ${HOME}/transcendence/data/upload
	@mkdir -p ${HOME}/transcendence/data/postgresql
	@mkdir -p ${HOME}/transcendence/data/postgresql-log
	@docker compose -f docker-compose.yml up --build

up: set-env
	@echo "🔺  Starting ${NAME} ...\n"
	@mkdir -p ${HOME}/transcendence/data/upload
	@mkdir -p ${HOME}/transcendence/data/postgresql
	@mkdir -p ${HOME}/transcendence/data/postgresql-log
	@docker compose -f ./docker-compose.yml up

dev-up: set-env
	@echo "🔺  Starting ${NAME}-dev ...\n"
	@mkdir -p ${HOME}/transcendence/data/upload
	@mkdir -p ${HOME}/transcendence/data/postgresql
	@mkdir -p ${HOME}/transcendence/data/postgresql-log
	@docker compose -f .docker/docker-compose.yml up

start:
	@echo "💨  Starting ${NAME} ...\n"
	@docker compose -f ./docker-compose.yml start

stop:
	@echo "🛑  Stopping ${NAME} ...\n"
	@docker compose -f ./docker-compose.yml stop

down:
	@echo "🔻  Shuting Down ${NAME} ...\n"
	@docker compose -f ./docker-compose.yml down

dev-down:
	@echo "🔻  Shuting Down ${NAME}-dev ...\n"
	@docker compose -f .docker/docker-compose.yml down

stop-all:
	@docker stop $$(docker ps -aq)

clear:
	@sudo rm -rf ${HOME}/transcendence

set-env:
	@chmod u+x set_cluster_local_ip_script.sh
	@./set_cluster_local_ip_script.sh


clean: down dev-down
	@echo "🧹  Cleaning ${name} ... (keep images)\n"
	@docker volume rm ft_tsen_db_volumes ft_tsen_uploads_volumes

fclean: clean
	@echo "🧼  Total Cleaning ...\n"
	@docker system prune --all --force --volumes
	@docker network prune --force
	@echo "📢  To delete data: make clear\n"

re: fclean all

.PHONY	: all build down re clean fclean
