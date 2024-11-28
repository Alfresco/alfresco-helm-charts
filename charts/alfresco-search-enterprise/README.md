---
title: alfresco-search-enterprise
parent: Charts Reference
---

# alfresco-search-enterprise

![Version: 4.2.0](https://img.shields.io/badge/Version-4.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.2.0](https://img.shields.io/badge/AppVersion-4.2.0-informational?style=flat-square)

A Helm chart for deploying Alfresco Elasticsearch connector

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.6.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |
| https://helm.elastic.co | elasticsearch | 7.17.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ats.existingConfigMap.keys.sfs_url | string | `"SFS_URL"` | Key within the configmap holding the URL of the alfresco shared filestore |
| ats.existingConfigMap.keys.transform_url | string | `"ATS_URL"` | Key within the configmap holding the URL of the alfresco transform |
| ats.existingConfigMap.name | string | `nil` | Alternatively, provide ATS details via an existing configmap |
| ats.sfs_url | string | `nil` | URL of the alfresco shared filestore |
| ats.transform_url | string | `nil` | URL of the alfresco transform (trouter or tengine-aio) |
| contentMediaTypeCache.enabled | bool | `true` |  |
| contentMediaTypeCache.refreshTime | string | `"0 0 * * * *"` |  |
| fullnameOverride | string | `""` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| imagePullSecrets | list | `[]` |  |
| indexName | string | `"alfresco"` | Name of the existing search index, usually created by repo |
| liveIndexing.content.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-search-enterprise.content.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| liveIndexing.content.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-search-enterprise.content.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| liveIndexing.content.environment | object | `{}` | Set environment variables for the content component |
| liveIndexing.content.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.content.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-content"` |  |
| liveIndexing.content.image.tag | string | `"4.2.0"` |  |
| liveIndexing.content.livenessProbe.httpGet.path | string | `"/actuator/health"` |  |
| liveIndexing.content.livenessProbe.httpGet.port | string | `"http"` |  |
| liveIndexing.content.livenessProbe.initialDelaySeconds | int | `300` |  |
| liveIndexing.content.livenessProbe.timeoutSeconds | int | `60` |  |
| liveIndexing.content.readinessProbe.httpGet.path | string | `"/actuator/health"` |  |
| liveIndexing.content.readinessProbe.httpGet.port | string | `"http"` |  |
| liveIndexing.content.readinessProbe.initialDelaySeconds | int | `60` |  |
| liveIndexing.content.readinessProbe.timeoutSeconds | int | `60` |  |
| liveIndexing.content.replicaCount | int | `1` |  |
| liveIndexing.environment | object | `{}` | Set environment variables for all the live indexing components (mediation, content, metadata, path) |
| liveIndexing.mediation.environment | object | `{}` | Set environment variables for the mediation component |
| liveIndexing.mediation.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.mediation.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-mediation"` |  |
| liveIndexing.mediation.image.tag | string | `"4.2.0"` |  |
| liveIndexing.metadata.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-search-enterprise.metadata.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| liveIndexing.metadata.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-search-enterprise.metadata.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| liveIndexing.metadata.environment | object | `{}` | Set environment variables for the metadata component |
| liveIndexing.metadata.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.metadata.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-metadata"` |  |
| liveIndexing.metadata.image.tag | string | `"4.2.0"` |  |
| liveIndexing.metadata.livenessProbe.httpGet.path | string | `"/actuator/health"` |  |
| liveIndexing.metadata.livenessProbe.httpGet.port | string | `"http"` |  |
| liveIndexing.metadata.livenessProbe.initialDelaySeconds | int | `300` |  |
| liveIndexing.metadata.livenessProbe.timeoutSeconds | int | `60` |  |
| liveIndexing.metadata.readinessProbe.httpGet.path | string | `"/actuator/health"` |  |
| liveIndexing.metadata.readinessProbe.httpGet.port | string | `"http"` |  |
| liveIndexing.metadata.readinessProbe.initialDelaySeconds | int | `60` |  |
| liveIndexing.metadata.readinessProbe.timeoutSeconds | int | `60` |  |
| liveIndexing.metadata.replicaCount | int | `1` |  |
| liveIndexing.path.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-search-enterprise.path.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| liveIndexing.path.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-search-enterprise.path.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| liveIndexing.path.environment | object | `{}` | Set environment variables for the path component |
| liveIndexing.path.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.path.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-path"` |  |
| liveIndexing.path.image.tag | string | `"4.2.0"` |  |
| liveIndexing.path.livenessProbe.httpGet.path | string | `"/actuator/health"` |  |
| liveIndexing.path.livenessProbe.httpGet.port | string | `"http"` |  |
| liveIndexing.path.livenessProbe.initialDelaySeconds | int | `300` |  |
| liveIndexing.path.livenessProbe.timeoutSeconds | int | `60` |  |
| liveIndexing.path.readinessProbe.httpGet.path | string | `"/actuator/health"` |  |
| liveIndexing.path.readinessProbe.httpGet.port | string | `"http"` |  |
| liveIndexing.path.readinessProbe.initialDelaySeconds | int | `60` |  |
| liveIndexing.path.readinessProbe.timeoutSeconds | int | `60` |  |
| liveIndexing.path.replicaCount | int | `1` |  |
| messageBroker.existingConfigMap.keys.url | string | `"BROKER_URL"` | Key within the configmap holding the URL of the message broker |
| messageBroker.existingConfigMap.name | string | `nil` | Alternatively, provide message broker connection details via an existing configmap |
| messageBroker.existingSecret | object | `{"keys":{"password":"BROKER_PASSWORD","username":"BROKER_USERNAME"},"name":null}` | Provide connection details alternatively via an existing secret that contains BROKER_URL, BROKER_USERNAME and BROKER_PASSWORD keys |
| messageBroker.password | string | `nil` | Broker password |
| messageBroker.url | string | `nil` | Broker URL formatted as per: https://activemq.apache.org/failover-transport-reference |
| messageBroker.username | string | `nil` | Broker username |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| pathIndexingComponent.enabled | bool | `true` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| reindexing.db.existingConfigMap.keys.url | string | `"DATABASE_URL"` | Key within the configmap holding the full JDBC url to connect to database service |
| reindexing.db.existingConfigMap.name | string | `nil` | Alternatively, provide database connection details via an existing configmap |
| reindexing.db.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password |
| reindexing.db.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username |
| reindexing.db.existingSecret.name | string | `nil` | Alternatively, provide database credentials via an existing secret |
| reindexing.db.password | string | `nil` | The password required to access the service |
| reindexing.db.url | string | `nil` | Provide the full JDBC url to connect to database service e.g.: `jdbc:postgresql://hostname:5432/database` |
| reindexing.db.username | string | `nil` | The username required to access the service |
| reindexing.enabled | bool | `true` | Create the one-shot job to trigger the reindexing of repo contents |
| reindexing.environment | object | `{}` |  |
| reindexing.hookExecution | string | `"post-install"` | When to execute the reindexing job (e.g. `post-install` or `post-upgrade` or set to false to apply as a standard resource) |
| reindexing.image.pullPolicy | string | `"IfNotPresent"` |  |
| reindexing.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-reindexing"` |  |
| reindexing.image.tag | string | `"4.2.0"` |  |
| reindexing.initcontainers.waitForRepository.image.pullPolicy | string | `"IfNotPresent"` |  |
| reindexing.initcontainers.waitForRepository.image.repository | string | `"curlimages/curl"` |  |
| reindexing.initcontainers.waitForRepository.image.tag | string | `"8.11.0"` |  |
| reindexing.initcontainers.waitForRepository.resources.limits.cpu | string | `"250m"` |  |
| reindexing.initcontainers.waitForRepository.resources.limits.memory | string | `"20Mi"` |  |
| reindexing.pathIndexingEnabled | bool | `true` |  |
| reindexing.repository.existingConfigMap.keys.url | string | `"REPOSITORY_URL"` | Key within the configmap holding the full url to connect to the alfresco repository |
| reindexing.repository.existingConfigMap.name | string | `nil` | Alternatively, provide repository connection details via an existing configmap |
| reindexing.repository.url | string | `nil` | URL of the Alfresco repository |
| reindexing.resources.limits.cpu | string | `"2"` |  |
| reindexing.resources.limits.memory | string | `"512Mi"` |  |
| reindexing.resources.requests.cpu | string | `"0.5"` |  |
| reindexing.resources.requests.memory | string | `"128Mi"` |  |
| reindexing.ttlSecondsAfterFinished | int | `3600` | Time to live for the job after it has finished to run |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2048Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| search.existingConfigMap.keys.url | string | `"SEARCH_URL"` | Key within the configmap holding the URL of the search/indexing service |
| search.existingConfigMap.name | string | `nil` | Alternatively, provide search/indexing service connection details via an existing configmap |
| search.existingSecret.keys.password | string | `"SEARCH_PASSWORD"` | Key within the secret that holds the search/indexing password |
| search.existingSecret.keys.username | string | `"SEARCH_USERNAME"` | Key within the secret that holds the search/indexing username |
| search.existingSecret.name | string | `nil` | Alternatively, provide search/indexing credentials via an existing secret |
| search.password | string | `nil` | The password required to access the search/indexing service, if any |
| search.url | string | `nil` | The URL where the search/indexing service is available |
| search.username | string | `nil` | The username required to access the search/indexing service, if any |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"alfresco-search-enterprise-sa"` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| tolerations | list | `[]` |  |
