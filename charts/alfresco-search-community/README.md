---
title: alfresco-search-community
parent: Charts Reference
---

# alfresco-search-community

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.7.0-A.5](https://img.shields.io/badge/AppVersion-5.7.0--A.5-informational?style=flat-square)

A Helm chart for deploying the Alfresco Elasticsearch Community batch indexing component

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 5.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Additional labels to be added to all resources (deployments, services, pods, etc.) Example:   Product: k8s   Environment: DEV |
| affinity | object | `{}` |  |
| db.existingConfigMap.keys.url | string | `"DATABASE_URL"` | Key within the configmap holding the full JDBC url to connect to database service |
| db.existingConfigMap.name | string | `nil` | Alternatively, provide database connection details via an existing configmap |
| db.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password |
| db.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username |
| db.existingSecret.name | string | `nil` | Alternatively, provide database credentials via an existing secret |
| db.password | string | `nil` | The password required to access the database service |
| db.url | string | `nil` | Provide the full JDBC url to connect to database service e.g.: `jdbc:postgresql://hostname:5432/database` |
| db.username | string | `nil` | The username required to access the database service |
| environment | object | `{}` | Set additional environment variables for the batch indexing container (e.g. `ALFRESCO_REINDEX_*` tunables or `JAVA_OPTS`) |
| fullnameOverride | string | `""` |  |
| global.additionalLabels | object | `{}` | Global additional labels that can be set at parent/umbrella chart level These will be merged with chart-level additionalLabels, with chart-level taking precedence |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.io/alfresco/alfresco-elasticsearch-batch-indexing"` |  |
| image.tag | string | `"5.7.0-A.5"` |  |
| imagePullSecrets | list | `[]` |  |
| index.existingConfigMap.keys.url | string | `"SEARCH_URL"` | Key within the configmap holding the URL of the elasticsearch service |
| index.existingConfigMap.name | string | `nil` | Alternatively, provide elasticsearch service connection details via an existing configmap |
| index.existingSecret.keys.password | string | `"SEARCH_PASSWORD"` | Key within the secret that holds the elasticsearch password |
| index.existingSecret.keys.username | string | `"SEARCH_USERNAME"` | Key within the secret that holds the elasticsearch username |
| index.existingSecret.name | string | `nil` | Alternatively, provide elasticsearch credentials via an existing secret |
| index.password | string | `nil` | The password required to access the elasticsearch service, if any |
| index.url | string | `nil` | The URL where the elasticsearch service is available |
| index.username | string | `nil` | The username required to access the elasticsearch service, if any |
| indexName | string | `"alfresco"` | Name of the search index, usually created by the repository |
| livenessProbe.httpGet.path | string | `"/actuator/health"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `120` |  |
| livenessProbe.timeoutSeconds | int | `60` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.httpGet.path | string | `"/actuator/health"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `60` |  |
| readinessProbe.timeoutSeconds | int | `60` |  |
| replicaCount | int | `1` | The batch indexing component is a singleton; this value must remain 1 (a second instance conflicts on the shared watermark and self-terminates) |
| repository.existingConfigMap.keys.url | string | `"REPOSITORY_URL"` | Key within the configmap holding the full url to connect to the alfresco repository |
| repository.existingConfigMap.name | string | `nil` | Alternatively, provide repository connection details via an existing configmap |
| repository.url | string | `nil` | URL of the Alfresco repository (ACS) |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2048Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| sharedSecret.existingSecret.keys.sharedSecret | string | `"ALFRESCO_CONTENT_TRANSFORM_SHAREDSECRET"` | Key within the secret holding the shared secret |
| sharedSecret.existingSecret.name | string | `nil` | Alternatively, provide the shared secret via an existing secret |
| sharedSecret.value | string | `nil` | Shared secret used to authenticate content requests against the repository (must match the repository's `solr.sharedSecret`) |
| tolerations | list | `[]` |  |
| transform.existingConfigMap.keys.url | string | `"TRANSFORM_URL"` | Key within the configmap holding the URL of the transform config endpoint |
| transform.existingConfigMap.name | string | `nil` | Alternatively, provide transform config endpoint details via an existing configmap |
| transform.url | string | `nil` | URL of the alfresco transform config endpoint (e.g. `http://transform-core-aio:8090/transform/config`) |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |
