---
title: alfresco-connector-hxi
parent: Charts Reference
---

# alfresco-connector-hxi

![Version: 0.0.1-alpha.0](https://img.shields.io/badge/Version-0.0.1--alpha.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for deploying Alfresco connector hxi services

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ats.existingConfigMap.keys.sfsUrl | string | `"SFS_URL"` | Key within the configmap holding the URL of the alfresco shared filestore |
| ats.existingConfigMap.keys.transformUrl | string | `"ATS_URL"` | Key within the configmap holding the URL of the alfresco transform |
| ats.existingConfigMap.name | string | `nil` | Alternatively, provide ATS details via an existing configmap |
| ats.sfsUrl | string | `nil` | URL of the alfresco shared filestore |
| ats.transformUrl | string | `nil` | URL of the alfresco transform (trouter or tengine-aio) |
| fullnameOverride | string | `""` |  |
| hxi.existingConfigMap.keys.hxAuthTokenUrl | string | `"HX_AUTH_TOKEN_URL"` |  |
| hxi.existingConfigMap.keys.hxInsightUrl | string | `"HX_INSIGHT_URL"` |  |
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
| hxi.hxEnvKey | string | `nil` |  |
| hxi.hxInsightUrl | string | `nil` |  |
| imagePullSecrets | list | `[]` |  |
| liveIngester.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-hxi.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule the content pod on a different zone |
| liveIngester.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-hxi.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule the content pod on a different node |
| liveIngester.environment | string | `nil` |  |
| liveIngester.image.internalPort | int | `8080` |  |
| liveIngester.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIngester.image.repository | string | `"quay.io/alfresco/alfresco-hxinsight-connector-live-ingester"` |  |
| liveIngester.image.tag | string | `"1.0.0-A10"` |  |
| liveIngester.replicaCount | int | `1` |  |
| liveIngester.service.externalPort | int | `8080` |  |
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
| repository.existingConfigMap.keys.url | string | `"REPOSITORY_URL"` | Key within the configmap holding the full url to connect to the alfresco repository |
| repository.existingConfigMap.name | string | `nil` | Alternatively, provide repository connection details via an existing configmap |
| repository.url | string | `nil` | URL of the Alfresco repository |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2048Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"alfresco-connector-hxi-sa"` |  |
| tolerations | list | `[]` |  |