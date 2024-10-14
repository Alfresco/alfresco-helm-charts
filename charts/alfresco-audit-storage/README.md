---
title: alfresco-audit-storage
parent: Charts Reference
---

# alfresco-audit-storage

![Version: 0.0.1-alpha.0](https://img.shields.io/badge/Version-0.0.1--alpha.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1-A8](https://img.shields.io/badge/AppVersion-0.0.1--A8-informational?style=flat-square)

A Helm chart for Kubernetes to deploy Alfresco Audit Storage

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.5.5 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.3 |
| https://helm.elastic.co | elasticsearch | 7.17.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| environment.AUDIT_EVENTINGESTION_DLQ_CONSUMEPERIOD | int | `60000` |  |
| environment.AUDIT_EVENTINGESTION_DLQ_CONSUMPTIONCOUNT | int | `1000` |  |
| environment.AUDIT_EVENTINGESTION_URI | string | `"activemq:topic:alfresco.repo.event2"` |  |
| environment.SPRING_PROFILES_ACTIVE | string | `"durable-subscriptions"` |  |
| fullnameOverride | string | `""` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-audit-storage"` |  |
| image.tag | string | `"0.0.1-A8"` |  |
| imagePullSecrets | list | `[]` |  |
| messageBroker.existingConfigMap.keys.url | string | `"BROKER_URL"` | Key within the configmap holding the URL of the message broker |
| messageBroker.existingConfigMap.name | string | `nil` | Alternatively, provide message broker connection details via an existing configmap |
| messageBroker.existingSecret | object | `{"keys":{"password":"BROKER_PASSWORD","username":"BROKER_USERNAME"},"name":null}` | Provide connection details alternatively via an existing secret that contains BROKER_URL, BROKER_USERNAME and BROKER_PASSWORD keys |
| messageBroker.password | string | `nil` | Broker password |
| messageBroker.url | string | `nil` | Broker URL formatted as per: https://activemq.apache.org/failover-transport-reference |
| messageBroker.username | string | `nil` | Broker username |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsUser | int | `33000` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1"` |  |
| resources.limits.memory | string | `"512Mi"` |  |
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
| service.port | int | `8081` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |
