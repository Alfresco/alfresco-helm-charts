---
title: alfresco-connector-cic
parent: Charts Reference
---

# alfresco-connector-cic

![Version: 0.1.0-alpha.2](https://img.shields.io/badge/Version-0.1.0--alpha.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.1](https://img.shields.io/badge/AppVersion-1.0.1-informational?style=flat-square)

A Helm chart for deploying Alfresco connector cic services

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 5.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Additional labels to be added to all resources (deployments, statefulsets, services, pods, etc.) Example:   Product: k8s   Environment: DEV |
| ats.existingConfigMap.keys.sfsUrl | string | `"SFS_URL"` | Key within the configmap holding the URL of the alfresco shared filestore |
| ats.existingConfigMap.name | string | `nil` | Alternatively, provide ATS details via an existing configmap |
| ats.sfsUrl | string | `nil` | URL of the alfresco shared filestore |
| bulkIngester.affinity | object | `{}` |  |
| bulkIngester.enabled | bool | `true` |  |
| bulkIngester.environment.ALFRESCO_BULK_INGEST_PUBLISHER_ENDPOINT | string | `"activemq:queue:bulk-ingester-events"` |  |
| bulkIngester.image.pullPolicy | string | `"IfNotPresent"` |  |
| bulkIngester.image.repository | string | `"quay.io/alfresco/alfresco-cic-connector-bulk-ingester"` |  |
| bulkIngester.image.tag | string | `"1.0.1"` |  |
| bulkIngester.initContainers.waitForRepository.enabled | bool | `true` |  |
| bulkIngester.initContainers.waitForRepository.image.pullPolicy | string | `"IfNotPresent"` |  |
| bulkIngester.initContainers.waitForRepository.image.repository | string | `"curlimages/curl"` |  |
| bulkIngester.initContainers.waitForRepository.image.tag | string | `"8.11.0"` |  |
| bulkIngester.initContainers.waitForRepository.resources.limits.cpu | string | `"250m"` |  |
| bulkIngester.initContainers.waitForRepository.resources.limits.memory | string | `"20Mi"` |  |
| bulkIngester.resources.limits.cpu | string | `"2"` |  |
| bulkIngester.resources.limits.memory | string | `"512Mi"` |  |
| bulkIngester.resources.requests.cpu | string | `"0.5"` |  |
| bulkIngester.resources.requests.memory | string | `"128Mi"` |  |
| cic.existingConfigMap.keys.hxAuthTokenUrl | string | `"HX_AUTH_TOKEN_URL"` |  |
| cic.existingConfigMap.keys.hxInsightIngestionUrl | string | `"HX_INSIGHT_INGESTION_URL"` |  |
| cic.existingConfigMap.keys.nucleusBaseUrl | string | `"NUCLEUS_BASE_URL"` |  |
| cic.existingConfigMap.keys.nucleusIdpBaseUrl | string | `"NUCLEUS_IDP_BASE_URL"` |  |
| cic.existingConfigMap.keys.nucleusSystemId | string | `"NUCLEUS_SYSTEM_ID"` |  |
| cic.existingConfigMap.name | string | `nil` |  |
| cic.existingSecret.keys.hxAppSourceId | string | `"HX_APP_SOURCE_ID"` |  |
| cic.existingSecret.keys.hxClientId | string | `"HX_CLIENT_ID"` |  |
| cic.existingSecret.keys.hxClientSecret | string | `"HX_CLIENT_SECRET"` |  |
| cic.existingSecret.keys.hxEnvKey | string | `"HX_ENV_KEY"` |  |
| cic.existingSecret.name | string | `nil` |  |
| cic.hxAppSourceId | string | `nil` |  |
| cic.hxAuthTokenUrl | string | `nil` |  |
| cic.hxClientId | string | `nil` |  |
| cic.hxClientSecret | string | `nil` |  |
| cic.hxEnvKey | string | `nil` |  |
| cic.hxInsightIngestionUrl | string | `nil` |  |
| cic.nucleusBaseUrl | string | `nil` | Nucleus connection settings (nucleus-sync only) |
| cic.nucleusIdpBaseUrl | string | `nil` |  |
| cic.nucleusSystemId | string | `nil` |  |
| db.existingConfigMap.keys.url | string | `"DATABASE_URL"` | Key within the configmap holding the full JDBC url to connect to database service |
| db.existingConfigMap.name | string | `nil` | Alternatively, provide database connection details via an existing configmap |
| db.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password |
| db.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username |
| db.existingSecret.name | string | `nil` | Alternatively, provide database credentials via an existing secret |
| db.password | string | `nil` | The password required to access the service |
| db.url | string | `nil` | Provide the full JDBC url to connect to database service e.g.: `jdbc:postgresql://hostname:5432/database` |
| db.username | string | `nil` | The username required to access the service |
| fullnameOverride | string | `""` |  |
| global.additionalLabels | object | `{}` | Global additional labels that can be set at parent/umbrella chart level These will be merged with chart-level additionalLabels, with chart-level taking precedence |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| imagePullSecrets | list | `[]` |  |
| liveIngester.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-cic.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| liveIngester.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-cic.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| liveIngester.environment.ALFRESCO_BULKINGESTER_DEADLETTERENABLED | string | `"false"` |  |
| liveIngester.environment.ALFRESCO_BULKINGESTER_DEADLETTERURI | string | `"activemq:queue:ActiveMQ.DLQ"` |  |
| liveIngester.environment.ALFRESCO_BULKINGESTER_ENDPOINT | string | `"activemq:queue:bulk-ingester-events"` |  |
| liveIngester.environment.ALFRESCO_BULKINGESTER_MAXIMUMREDELIVERIES | string | `"6"` |  |
| liveIngester.environment.ALFRESCO_BULKINGESTER_REDELIVERYDELAYMS | string | `"1000"` |  |
| liveIngester.environment.CAMEL_COMPONENT_ACTIVEMQ_TRANSACTED | string | `"true"` |  |
| liveIngester.environment.SERVER_PORT | int | `8080` |  |
| liveIngester.image.internalPort | int | `8080` |  |
| liveIngester.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIngester.image.repository | string | `"quay.io/alfresco/alfresco-cic-connector-live-ingester"` |  |
| liveIngester.image.tag | string | `"1.0.1"` |  |
| liveIngester.livenessProbe.httpGet.path | string | `"/actuator/health/liveness"` |  |
| liveIngester.livenessProbe.initialDelaySeconds | int | `30` |  |
| liveIngester.readinessProbe.httpGet.path | string | `"/actuator/health/readiness"` |  |
| liveIngester.readinessProbe.initialDelaySeconds | int | `40` |  |
| liveIngester.replicaCount | int | `1` |  |
| liveIngester.resources.limits.cpu | string | `"2"` |  |
| liveIngester.resources.limits.memory | string | `"2048Mi"` |  |
| liveIngester.resources.requests.cpu | string | `"0.5"` |  |
| liveIngester.resources.requests.memory | string | `"256Mi"` |  |
| liveIngester.service.annotations | object | `{}` |  |
| liveIngester.service.externalPort | int | `80` |  |
| liveIngester.service.name | string | `"cic-live-ingester-service"` |  |
| liveIngester.service.type | string | `"ClusterIP"` |  |
| liveIngester.strategy.rollingUpdate.maxSurge | int | `1` |  |
| liveIngester.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| messageBroker.existingConfigMap.keys.url | string | `"BROKER_URL"` | Key within the configmap holding the URL of the message broker |
| messageBroker.existingConfigMap.name | string | `nil` | Alternatively, provide message broker connection details via an existing configmap |
| messageBroker.existingSecret | object | `{"keys":{"password":"BROKER_PASSWORD","username":"BROKER_USERNAME"},"name":null}` | Provide connection details alternatively via an existing secret that contains BROKER_URL, BROKER_USERNAME and BROKER_PASSWORD keys |
| messageBroker.password | string | `nil` | Broker password |
| messageBroker.url | string | `nil` | Broker URL formatted as per: https://activemq.apache.org/failover-transport-reference |
| messageBroker.username | string | `nil` | Broker username |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| nucleusSync.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-cic.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| nucleusSync.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-cic.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| nucleusSync.enabled | bool | `true` |  |
| nucleusSync.environment.AUTH_HX_TYPE | string | `"oauth2"` |  |
| nucleusSync.environment.SERVER_PORT | int | `8080` |  |
| nucleusSync.image.internalPort | int | `8080` |  |
| nucleusSync.image.pullPolicy | string | `"IfNotPresent"` |  |
| nucleusSync.image.repository | string | `"quay.io/alfresco/alfresco-cic-connector-nucleus-sync"` |  |
| nucleusSync.image.tag | string | `"1.0.1"` |  |
| nucleusSync.livenessProbe.httpGet.path | string | `"/actuator/health/liveness"` |  |
| nucleusSync.livenessProbe.initialDelaySeconds | int | `30` |  |
| nucleusSync.readinessProbe.httpGet.path | string | `"/actuator/health/readiness"` |  |
| nucleusSync.readinessProbe.initialDelaySeconds | int | `40` |  |
| nucleusSync.replicaCount | int | `1` |  |
| nucleusSync.resources.limits.cpu | string | `"2"` |  |
| nucleusSync.resources.limits.memory | string | `"2048Mi"` |  |
| nucleusSync.resources.requests.cpu | string | `"0.5"` |  |
| nucleusSync.resources.requests.memory | string | `"256Mi"` |  |
| nucleusSync.strategy.rollingUpdate.maxSurge | int | `1` |  |
| nucleusSync.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| repository.authGrantType | string | `nil` |  |
| repository.authTokenUrl | string | `nil` |  |
| repository.authType | string | `"basic"` |  |
| repository.clientId | string | `nil` |  |
| repository.clientSecret | string | `nil` |  |
| repository.existingConfigMap.keys.apiUrl | string | `"REPOSITORY_API_BASE_URL"` | Key within the configmap holding the full Alfresco REST API v1 base url (used by nucleus-sync) |
| repository.existingConfigMap.keys.authGrantType | string | `"REPOSITORY_AUTH_GRANT_TYPE"` |  |
| repository.existingConfigMap.keys.authTokenUrl | string | `"REPOSITORY_AUTH_TOKEN_URL"` |  |
| repository.existingConfigMap.keys.authType | string | `"REPOSITORY_AUTH_TYPE"` |  |
| repository.existingConfigMap.keys.url | string | `"REPOSITORY_URL"` | Key within the configmap holding the full url to connect to the alfresco repository |
| repository.existingConfigMap.keys.versionOverride | string | `"REPOSITORY_VERSION_OVERRIDE"` |  |
| repository.existingConfigMap.name | string | `nil` | Alternatively, provide repository connection details via an existing configmap |
| repository.existingSecret.keys.clientId | string | `"REPOSITORY_CLIENT_ID"` |  |
| repository.existingSecret.keys.clientSecret | string | `"REPOSITORY_CLIENT_SECRET"` |  |
| repository.existingSecret.keys.password | string | `"REPOSITORY_PASSWORD"` |  |
| repository.existingSecret.keys.username | string | `"REPOSITORY_USERNAME"` |  |
| repository.existingSecret.name | string | `nil` |  |
| repository.nucleusSyncApiUrl | string | `nil` | Base URL for the Alfresco REST API v1, used by nucleus-sync. Defaults to `{url}/api/-default-/public/alfresco/versions/1` when not set. |
| repository.password | string | `nil` |  |
| repository.url | string | `nil` | URL of the Alfresco repository (e.g. http://alfresco:8080/alfresco) |
| repository.username | string | `nil` |  |
| repository.versionOverride | string | `nil` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"alfresco-connector-cic-sa"` |  |
| tolerations | list | `[]` |  |
