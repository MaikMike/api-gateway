SHELL=/bin/bash

ENV := "local"
 
help: ## Display this help screen.
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

lint: ## Execute krakend linter
	FC_ENABLE=1 \
	FC_SETTINGS="./src/$(ENV)/settings" \
	FC_PARTIALS="./src/partials" \
	FC_TEMPLATES="./src/templates" \
	FC_OUT=out.json \
	krakend check -t -d -c src/krakend.json

run: ## Run api gateway
	FC_ENABLE=1 \
	FC_SETTINGS="./src/$(ENV)/settings" \
	FC_PARTIALS="./src/partials" \
	FC_TEMPLATES="./src/templates" \
	krakend run -c src/krakend.json
