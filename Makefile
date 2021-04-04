# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help start log status stop clean

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

ENV ?= local

start: ## Run app in a local environment
	@echo "Starting app locally..."
	@docker compose build --no-cache
	@docker compose run --rm --no-deps tickerizer_app rails db:migrate
	@docker compose run --rm --no-deps tickerizer_app rails credentials:edit
	@docker compose up -d
	@echo "Your app is now available at http://localhost:3000"

log: ## Stream the logs from the running environment
	@echo "Streaming logs from the running environment"
	@docker compose logs -f

status: ## Check if the local environment is running already - aka status
	@docker compose ps

stop: ## Stop a running local environment
	@echo "Stopping your local environment"
	@docker compose down --remove-orphans

clean: ## stop the local environment + delete all containers, volumes and tmp files
	@echo "this should cleanup"
	@docker compose down --remove-orphans -v --rmi all
	@rm -f db/*.sqlite3*
	@rm -f config/credentials.yml.enc
