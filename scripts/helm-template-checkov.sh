#!/bin/bash -e
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for chart_file in charts/*/Chart.yaml; do
    chart_type=$(yq eval '.type' "$chart_file")
    if [ "$chart_type" = "library" ]; then
        continue
    fi
    cd "$(dirname "$chart_file")"
    if [ ! -d charts ]; then
        helm dep build
    fi
    helm template . --values $BASE_DIR/../.checkov-values.yml > /dev/null
    cd - > /dev/null
done

echo "All charts can be rendered succesfully."
