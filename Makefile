build: ## Build docs locally
	properdocs build --strict --clean

serve: ## Serve live version of your docs
	properdocs serve --strict

all: build
