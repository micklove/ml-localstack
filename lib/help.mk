DEFAULT_HELP_WIDTH=20
DEFAULT_COLOR=32

help: ## This help.
	@grep -E -h "^[a-zA-Z_-]+:.*?## " $(MAKEFILE_LIST) \
	  | sort \
	  | awk -v width=$(DEFAULT_HELP_WIDTH) 'BEGIN {FS = ":.*?## "} {printf "\033[$(DEFAULT_COLOR)m%-*s\033[0m %s\n", width, $$1, $$2}'
