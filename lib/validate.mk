ifndef BUILD_TOOLS
$(error BUILD_TOOLS variable should be set in the main Makefile, before including this file)
endif

## Test if a command is available in the current env (based on an example from the gnu make book)
command-present=$(if $(shell which $1),,$(error command ['$1'] is required for this build))

.PHONY: validate-env
validate-env: ## Validate, early, that the commands required by this makefile are available in the current env.
	$(foreach B,$(BUILD_TOOLS),$(call command-present, $B))

command-version-info: validate-env ## Get versions of the various commands, ignore some commands that have no --version flag
	@for i in `echo $(filter-out openssl sed whoami, $(BUILD_TOOLS))`; do printf "\n%s\n    " $$i; $$i --version;done;

check-%:
	@echo "validate env var: [$*]"
	@if [ -z '${${*}}' ]; then echo 'Environment variable $* not set' && exit 1; fi
