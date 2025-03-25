build: ## Build docs locally
	mkdocs build --strict --clean

serve: ## Serve live version of your docs
	mkdocs serve --strict

all: build
