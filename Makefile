help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


build: ## Builds docker image
	@echo "Builds the docker image"
	@docker build -t fabricekabongo/php7-apache .
	@echo "Build done."

tag: ## Tags the build as latest
	@echo "Tags the build as latest"
	@docker tag fabricekabongo/php7-apache fabricekabongo/php7-apache:latest
	@echo "Tagging done."

push: ## Pushes the build to hub.docker.com
	@echo "Pushes the build to hub.docker.com"
	@docker push fabricekabongo/php7-apache
	@echo "Pushing done."