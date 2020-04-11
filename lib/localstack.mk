LOCALSTACK_FOLDER:=./.localstack
LOCALSTACK_DOCKER_COMPOSE_PATH:=$(LOCALSTACK_FOLDER)/docker-compose.yaml
LOCALSTACK_CONTAINER_NAME:=localstack_main
COMPOSE_CMD=docker-compose -f $(LOCALSTACK_DOCKER_COMPOSE_PATH)

export PORT_WEB_UI=1971

compose-%:
	$(COMPOSE_CMD) "$(subst compose-,,$@)"

ls-stop: compose-stop ## Stop localstack, without losing container

ls-logs: compose-logs ## View the logs for the localstack container

ls-up: ## Start localstack container
	ls $(LOCALSTACK_DOCKER_COMPOSE_PATH)
	$(COMPOSE_CMD) up -d

ls-ui:
	open "http://localhost:$(PORT_WEB_UI)"
