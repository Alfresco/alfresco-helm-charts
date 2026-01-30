---
title: alfresco-connector-hxi
parent: Charts Reference
---

# alfresco-connector-hxi

![Version: 0.4.0](https://img.shields.io/badge/Version-0.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.2](https://img.shields.io/badge/AppVersion-2.0.2-informational?style=flat-square)

A Helm chart for deploying Alfresco connector hxi services

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.7.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 4.0.0 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Additional labels to be added to all resources (deployments, statefulsets, services, pods, etc.) Example:   Product: k8s   Environment: DEV |
| ats.existingConfigMap.keys.sfsUrl | string | `"SFS_URL"` | Key within the configmap holding the URL of the alfresco shared filestore |
| ats.existingConfigMap.keys.transformUrl | string | `"ATS_URL"` | Key within the configmap holding the URL of the alfresco transform |
| ats.existingConfigMap.name | string | `nil` | Alternatively, provide ATS details via an existing configmap |
| ats.sfsUrl | string | `nil` | URL of the alfresco shared filestore |
| ats.transformUrl | string | `nil` | URL of the alfresco transform (trouter or tengine-aio) |
| bulkIngester.affinity | object | `{}` |  |
| bulkIngester.enabled | bool | `true` |  |
| bulkIngester.environment.ALFRESCO_BULK_INGEST_PUBLISHER_ENDPOINT | string | `"activemq:queue:bulk-ingester-events"` |  |
| bulkIngester.image.pullPolicy | string | `"IfNotPresent"` |  |
| bulkIngester.image.repository | string | `"quay.io/alfresco/alfresco-hxinsight-connector-bulk-ingester"` |  |
| bulkIngester.image.tag | string | `"2.0.2"` |  |
| bulkIngester.initContainers.waitForRepository.image.pullPolicy | string | `"IfNotPresent"` |  |
| bulkIngester.initContainers.waitForRepository.image.repository | string | `"curlimages/curl"` |  |
| bulkIngester.initContainers.waitForRepository.image.tag | string | `"8.11.0"` |  |
| bulkIngester.initContainers.waitForRepository.resources.limits.cpu | string | `"250m"` |  |
| bulkIngester.initContainers.waitForRepository.resources.limits.memory | string | `"20Mi"` |  |
| bulkIngester.resources.limits.cpu | string | `"2"` |  |
| bulkIngester.resources.limits.memory | string | `"512Mi"` |  |
| bulkIngester.resources.requests.cpu | string | `"0.5"` |  |
| bulkIngester.resources.requests.memory | string | `"128Mi"` |  |
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
| hxi.existingConfigMap.keys.hxAuthTokenUrl | string | `"HX_AUTH_TOKEN_URL"` |  |
| hxi.existingConfigMap.keys.hxInsightIngestionUrl | string | `"HX_INSIGHT_INGESTION_URL"` |  |
| hxi.existingConfigMap.keys.hxInsightPredictionsUrl | string | `"HX_INSIGHT_PREDICTIONS_URL"` |  |
| hxi.existingConfigMap.name | string | `nil` |  |
| hxi.existingSecret.keys.hxAppSourceId | string | `"HX_APP_SOURCE_ID"` |  |
| hxi.existingSecret.keys.hxClientId | string | `"HX_CLIENT_ID"` |  |
| hxi.existingSecret.keys.hxClientSecret | string | `"HX_CLIENT_SECRET"` |  |
| hxi.existingSecret.keys.hxEnvKey | string | `"HX_ENV_KEY"` |  |
| hxi.existingSecret.name | string | `nil` |  |
| hxi.hxAppSourceId | string | `nil` |  |
| hxi.hxAuthTokenUrl | string | `nil` |  |
| hxi.hxClientId | string | `nil` |  |
| hxi.hxClientSecret | string | `nil` |  |
| hxi.hxEnv | string | `nil` |  |
| hxi.hxEnvKey | string | `nil` |  |
| hxi.hxInsightIngestionUrl | string | `nil` |  |
| hxi.hxInsightPredictionsUrl | string | `nil` |  |
| imagePullSecrets | list | `[]` |  |
| liveIngester.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-hxi.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| liveIngester.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-hxi.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| liveIngester.environment.ALFRESCO_BULKINGESTER_ENDPOINT | string | `"activemq:queue:bulk-ingester-events"` |  |
| liveIngester.environment.SERVER_PORT | int | `8080` |  |
| liveIngester.image.internalPort | int | `8080` |  |
| liveIngester.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIngester.image.repository | string | `"quay.io/alfresco/alfresco-hxinsight-connector-live-ingester"` |  |
| liveIngester.image.tag | string | `"2.0.2"` |  |
| liveIngester.livenessProbe.httpGet.path | string | `"/actuator/health/liveness"` |  |
| liveIngester.livenessProbe.httpGet.port | int | `8080` |  |
| liveIngester.livenessProbe.initialDelaySeconds | int | `30` |  |
| liveIngester.readinessProbe.httpGet.path | string | `"/actuator/health/readiness"` |  |
| liveIngester.readinessProbe.httpGet.port | int | `8080` |  |
| liveIngester.readinessProbe.initialDelaySeconds | int | `40` |  |
| liveIngester.replicaCount | int | `1` |  |
| liveIngester.resources.limits.cpu | string | `"2"` |  |
| liveIngester.resources.limits.memory | string | `"2048Mi"` |  |
| liveIngester.resources.requests.cpu | string | `"0.5"` |  |
| liveIngester.resources.requests.memory | string | `"256Mi"` |  |
| liveIngester.service.externalPort | int | `80` |  |
| liveIngester.service.name | string | `"hxi-live-ingester-service"` |  |
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
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| predictionApplier.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-hxi.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| predictionApplier.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-hxi.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| predictionApplier.enabled | bool | `true` |  |
| predictionApplier.environment."HYLANDEXPERIENCE.INSIGHT.PREDICTIONS.BUFFERENDPOINT" | string | `"activemq:queue:predictions-buffer"` |  |
| predictionApplier.environment."HYLANDEXPERIENCE.INSIGHT.PREDICTIONS.POLLPERIODMILLIS" | int | `300000` |  |
| predictionApplier.environment.SERVER_PORT | int | `8080` |  |
| predictionApplier.image.internalPort | int | `8080` |  |
| predictionApplier.image.pullPolicy | string | `"IfNotPresent"` |  |
| predictionApplier.image.repository | string | `"quay.io/alfresco/alfresco-hxinsight-connector-prediction-applier"` |  |
| predictionApplier.image.tag | string | `"2.0.2"` |  |
| predictionApplier.livenessProbe.httpGet.path | string | `"/actuator/health/liveness"` |  |
| predictionApplier.livenessProbe.httpGet.port | int | `8080` |  |
| predictionApplier.livenessProbe.initialDelaySeconds | int | `30` |  |
| predictionApplier.readinessProbe.httpGet.path | string | `"/actuator/health/readiness"` |  |
| predictionApplier.readinessProbe.httpGet.port | int | `8080` |  |
| predictionApplier.readinessProbe.initialDelaySeconds | int | `40` |  |
| predictionApplier.replicaCount | int | `1` |  |
| predictionApplier.resources.limits.cpu | string | `"2"` |  |
| predictionApplier.resources.limits.memory | string | `"2048Mi"` |  |
| predictionApplier.resources.requests.cpu | string | `"0.5"` |  |
| predictionApplier.resources.requests.memory | string | `"256Mi"` |  |
| predictionApplier.service.externalPort | int | `80` |  |
| predictionApplier.service.name | string | `"hxi-prediction-applier-service"` |  |
| predictionApplier.service.type | string | `"ClusterIP"` |  |
| predictionApplier.strategy.rollingUpdate.maxSurge | int | `1` |  |
| predictionApplier.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| repository.authGrantType | string | `nil` |  |
| repository.authTokenUrl | string | `nil` |  |
| repository.authType | string | `nil` |  |
| repository.clientId | string | `nil` |  |
| repository.clientSecret | string | `nil` |  |
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
| repository.password | string | `nil` |  |
| repository.url | string | `nil` | URL of the Alfresco repository |
| repository.username | string | `nil` |  |
| repository.versionOverride | string | `nil` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"alfresco-connector-hxi-sa"` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| tolerations | list | `[]` |  |
