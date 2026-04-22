#!/bin/bash -e

# Manages external test dependencies for chart-testing.
# Reads test-deps.yaml to determine which dependencies a chart needs,
# then deploys or tears them down using Helm.
#
# Usage:
#   scripts/ci-deps.sh setup <chart-path> <namespace>
#   scripts/ci-deps.sh teardown <chart-path> <namespace>
#
# Dependencies are deployed with values from <chart-path>/ci/deps/<dep-name>-values.yaml if present.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_FILE="$REPO_ROOT/test-deps.yaml"

ACTION=${1:?Usage: $0 setup|teardown <chart-path> <namespace>}
CHART_PATH=${2:?Usage: $0 setup|teardown <chart-path> <namespace>}
NAMESPACE=${3:?Usage: $0 setup|teardown <chart-path> <namespace>}

CHART_NAME=$(basename "$CHART_PATH")

get_deps() {
  yq eval ".charts.\"$CHART_NAME\" | .[]" "$CONFIG_FILE"
}

helm_install_dep() {
  local dep=$1
  local chart_ref version repo values_file release_name
  chart_ref=$(yq eval ".deps.\"$dep\".chart" "$CONFIG_FILE")
  version=$(yq eval ".deps.\"$dep\".version" "$CONFIG_FILE")
  repo=$(yq eval ".deps.\"$dep\".repository // \"\"" "$CONFIG_FILE")
  values_file="$CHART_PATH/ci/deps/${dep}-values.yaml"
  release_name="${dep}"

  local -a helm_args=(upgrade --install "$release_name" --namespace "$NAMESPACE" --wait)

  if [ -n "$repo" ]; then
    helm_args+=("$chart_ref" --repo "$repo" --version "$version")
  else
    helm_args+=("$chart_ref" --version "$version")
  fi

  if [ -f "$values_file" ]; then
    helm_args+=(-f "$values_file")
  fi

  echo "Installing $dep (release: $release_name) for $CHART_NAME..."
  helm "${helm_args[@]}"
}

helm_uninstall_dep() {
  local dep=$1
  local release_name="${dep}"

  echo "Uninstalling $dep (release: $release_name) for $CHART_NAME..."
  helm uninstall "$release_name" --namespace "$NAMESPACE" --ignore-not-found || true
}

case $ACTION in
  setup)
    DEPS=$(get_deps)
    if [ -n "$DEPS" ]; then
      for dep in $DEPS; do
        helm_install_dep "$dep"
      done
    fi
    echo "Test dependencies ready for $CHART_NAME"
    ;;
  teardown)
    DEPS=$(get_deps)
    if [ -n "$DEPS" ]; then
      for dep in $DEPS; do
        helm_uninstall_dep "$dep"
      done
    fi
    echo "Test dependencies cleaned up for $CHART_NAME"
    ;;
  *)
    echo "Usage: $0 setup|teardown <chart-path> <namespace>"
    exit 1
    ;;
esac
