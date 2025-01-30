# Makefile for Git workflows with personalized commit messages

# Variables
REMOTE ?= origin
BRANCH ?= $(shell git branch --show-current)
TIMESTAMP ?= $(shell date +"%Y-%m-%d %H:%M:%S")
GIT_USERNAME ?= $(shell git config user.name)
CHANGES ?= $(shell git diff --unified=0)

# Phony targets
.PHONY: gt git-add-commit-push

# Git add, commit, and push with personalized commit message
gt:
	@echo "Adding all changes to staging..."
	git add .
	@echo "Generating personalized commit message..."
	@if [ -z "$(CHANGES)" ]; then \
		echo "No changes to commit."; \
		exit 1; \
	else \
		echo "Changes detected:"; \
		echo "$(CHANGES)"; \
		COMMIT_MESSAGE="$(GIT_USERNAME) commit on $(TIMESTAMP)\n\nChanges:\n$(CHANGES)"; \
		echo "Committing changes with message: $$COMMIT_MESSAGE"; \
		git commit -m "$$COMMIT_MESSAGE"; \
		echo "Pushing changes to $(REMOTE)/$(BRANCH)..."; \
		git push $(REMOTE) $(BRANCH); \
	fi