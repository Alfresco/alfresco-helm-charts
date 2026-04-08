NAMESPACE ?= default
CHARTS_DIR := charts

# List of all installable charts (type: application, excludes library charts)
INSTALLABLE_CHARTS := $(notdir $(patsubst %/Chart.yaml,%,$(shell grep -l 'type: application' $(CHARTS_DIR)/*/Chart.yaml)))

# Auto-detect chart name from command line (e.g. make install alfresco-repository)
CHART ?= $(firstword $(filter $(INSTALLABLE_CHARTS),$(MAKECMDGOALS)))

.PHONY: help list-charts setup teardown test lint install uninstall clean $(INSTALLABLE_CHARTS)

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  Or use a chart name directly:"
	@echo "    make install alfresco-repository"
	@echo "    make test alfresco-repository"

list-charts: ## List all installable charts
	@for chart in $(INSTALLABLE_CHARTS); do \
		echo "charts/$$chart"; \
	done

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
	helm dependency build $(CHARTS_DIR)/$(CHART)
	helm upgrade --install $(CHART) $(CHARTS_DIR)/$(CHART) \
		--namespace $(NAMESPACE) \
		-f $(CHARTS_DIR)/$(CHART)/ci/default-values.yaml \
		--wait

uninstall: ## Uninstall chart + teardown deps (make uninstall alfresco-repository)
	@test -n "$(CHART)" || (echo "Usage: make uninstall <chart-name>"; exit 1)
	helm uninstall $(CHART) --namespace $(NAMESPACE) --ignore-not-found
	./scripts/ci-deps.sh teardown $(CHARTS_DIR)/$(CHART) $(NAMESPACE)

clean: teardown ## Alias for teardown

# Chart names as targets are no-ops (CHART is extracted via MAKECMDGOALS above)
$(INSTALLABLE_CHARTS):
	@:
