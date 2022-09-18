.DEFAULT_GOAL := test
## GENERAL ##

up:
	@docker compose up -d
	@make log

down:
	@docker compose down

ps:
	@docker compose ps

log:
	@docker compose logs -f

docker-prune:
	@make down
	@docker rm -f $$(docker ps -a -q) || true
	@docker volume prune -f
	@docker network prune -f

help:
	@printf "\033[31m%-16s %-59s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-16s %-59s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.## .$$' $(MAKEFILE_LIST) | sed -e 's/:.##\s/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-16s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'