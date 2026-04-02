NAMESPACE ?= default
CHARTS_DIR := charts

# List of all installable charts (excluding library chart alfresco-common)
CHARTS := $(notdir $(wildcard $(CHARTS_DIR)/*))
INSTALLABLE_CHARTS := $(filter-out alfresco-common,$(CHARTS))

# Auto-detect chart name from command line (e.g. make install alfresco-repository)
CHART ?= $(firstword $(filter $(INSTALLABLE_CHARTS),$(MAKECMDGOALS)))

.PHONY: help setup teardown test lint install clean $(INSTALLABLE_CHARTS)

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  Or use a chart name directly:"
	@echo "    make install alfresco-repository"
	@echo "    make test alfresco-repository"

setup: ## Deploy test dependencies (make setup alfresco-repository)
	@test -n "$(CHART)" || (echo "Usage: make setup <chart-name>"; exit 1)
	./scripts/ci-deps.sh setup $(CHARTS_DIR)/$(CHART) $(NAMESPACE)

teardown: ## Remove test dependencies (make teardown alfresco-repository)
	@test -n "$(CHART)" || (echo "Usage: make teardown <chart-name>"; exit 1)
	./scripts/ci-deps.sh teardown $(CHARTS_DIR)/$(CHART) $(NAMESPACE)

lint: ## Lint a chart (make lint alfresco-repository)
	@test -n "$(CHART)" || (echo "Usage: make lint <chart-name>"; exit 1)
	ct lint --config ct.yaml --charts $(CHARTS_DIR)/$(CHART)

test: ## Run unit tests (make test alfresco-repository)
	@test -n "$(CHART)" || (echo "Usage: make test <chart-name>"; exit 1)
	helm unittest --color $(CHARTS_DIR)/$(CHART)

install: setup ## Deploy deps + install chart (make install alfresco-repository)
	helm upgrade --install $(CHART) $(CHARTS_DIR)/$(CHART) \
		--namespace $(NAMESPACE) \
		-f $(CHARTS_DIR)/$(CHART)/ci/default-values.yaml \
		--wait

clean: teardown ## Alias for teardown

# Chart names as targets are no-ops (CHART is extracted via MAKECMDGOALS above)
$(INSTALLABLE_CHARTS):
	@:
