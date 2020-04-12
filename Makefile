.PHONY: clean validate-env-vars

# List of tools to be used in this build. Will be validated by validate.mk tools
BUILD_TOOLS:=awk aws curl docker envsubst git jq node npm openssl sed whoami

include lib/common.mk
include $(PROJECT_ROOT)/lib/localstack.mk
include $(PROJECT_ROOT)/lib/debug.mk
include $(PROJECT_ROOT)/lib/validate.mk

# nb: Include help last, so that all Makefiles can be parsed for help
include $(PROJECT_ROOT)/lib/help.mk

export SRC_FOLDER=./src
LOCAL_STACK_SETUP_FOLDER:=$(PROJECT_ROOT)/.localstack/setup
ZIP_OUTPUT_FOLDER:=$(LOCAL_STACK_SETUP_FOLDER)
LAMBDA_SRC_PATH:=$(SRC_FOLDER)/lambda.js
LAMBDA_SRC_ZIP_PATH:=$(ZIP_OUTPUT_FOLDER)/lambda.zip
LOCAL_STACK_RESOURCES_SCRIPT_PATH:=$(LOCAL_STACK_SETUP_FOLDER)/aws-setup.sh

$(ZIP_OUTPUT_FOLDER):
	mkdir -p $@

clean: $(ZIP_OUTPUT_FOLDER)
	@-rm -f $(LAMBDA_SRC_ZIP_PATH)

$(LAMBDA_SRC_ZIP_PATH): $(ZIP_OUTPUT_FOLDER) $(LAMBDA_SRC_PATH)
	@zip -j $(LAMBDA_SRC_ZIP_PATH) $(LAMBDA_SRC_PATH)
	@ls -al $(LAMBDA_SRC_ZIP_PATH)
	@zipinfo $(LAMBDA_SRC_ZIP_PATH)

package: validate-env-vars $(LAMBDA_SRC_ZIP_PATH) ## package the lambda files

update: $(LAMBDA_SRC_PATH) package ## update the lambda source
	@$(LOCAL_STACK_RESOURCES_SCRIPT_PATH)
#	@$(MAKE) --no-print-directory ls-invoke

invoke: update ls-invoke

validate-env-vars: check-SRC_FOLDER

dump: ## Dump vars to stdout
	$(call print_header, $(DEFAULT_HEADER_WIDTH), "VARS", $(DEFAULT_HEADER_CHAR), $(DEFAULT_HEADER_FG))
	$(call pretty_var, PROJECT_ROOT,      					$(PROJECT_ROOT))
	$(call pretty_var, LAMBDA_SRC_PATH,           			$(LAMBDA_SRC_PATH))
	$(call pretty_var, LAMBDA_SRC_ZIP_PATH,            		$(LAMBDA_SRC_ZIP_PATH))
	$(call pretty_var, BUILD_TOOLS,             			$(BUILD_TOOLS))

