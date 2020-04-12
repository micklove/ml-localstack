.PHONY: ls-bash ls-up ls-invoke ls-ui

LOCALSTACK_FOLDER:=./.localstack
LOCALSTACK_DOCKER_COMPOSE_PATH:=$(LOCALSTACK_FOLDER)/docker-compose.yaml
LOCALSTACK_CONTAINER_NAME:=localstack_main
COMPOSE_CMD=docker-compose -f $(LOCALSTACK_DOCKER_COMPOSE_PATH)
OUTPUT_FOLDER=output
LAMBDA_RESPONSE=$(OUTPUT_FOLDER)/response.json

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

ls-bash:
	docker exec -it localstack_main bash

$(OUTPUT_FOLDER):
	@mkdir -p $@

ls-invoke: $(OUTPUT_FOLDER) ## Invoke the lambda, now running in localstack, echo the response with jq
	@awslocal lambda invoke \
		--function-name my-app-function \
		--cli-binary-format raw-in-base64-out \
		--payload '{"hello":"world"}' \
		${LAMBDA_RESPONSE}
	@jq "." ${LAMBDA_RESPONSE}
