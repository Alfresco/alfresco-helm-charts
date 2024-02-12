#!/bin/bash -e

for chart_file in charts/*/Chart.yaml; do
    chart_version=$(yq eval '.version' "$chart_file")  # Assuming you have yq installed
    if [[ "$chart_version" == *-* ]]; then
        continue
    fi

    dependencies=$(yq eval '.dependencies[] | select(.version | test("-"))' "$chart_file")
    if [ -n "$dependencies" ]; then
        echo "Chart $chart_file has dependencies with a pre-release version, but the main chart version doesn't."
        exit 1
    fi
done

echo "All charts passed the check."
