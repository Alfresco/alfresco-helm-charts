---
title: alfresco-connector-msteams
parent: Charts Reference
---

# alfresco-connector-msteams

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.4](https://img.shields.io/badge/AppVersion-2.0.4-informational?style=flat-square)

A Helm chart for deploying Alfresco connector msteams service

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-msteams.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10},{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-msteams.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}]}}` | Affinity settings for pod assignment (can contain templates if passed as string) |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-msteams.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule pods in different zones |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-connector-msteams.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule pods in different nodes |
| alfresco.baseUrl | string | `"change_me_alf_base_url"` |  |
| alfresco.digitalWorkspace.contextPath | string | `"/workspace/"` |  |
| environment | string | `nil` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.internalPort | int | `3978` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-ms-teams-service"` |  |
| image.tag | string | `"2.0.4"` |  |
| ingress.className | string | `"nginx"` |  |
| ingress.extraAnnotations | object | `{}` |  |
| ingress.path | string | `"/ms-teams-service"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.failureThreshold | int | `1` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.tcpSocket.port | string | `"service-port"` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| microsoft.app.existingSecret.keys.id | string | `"MICROSOFT_APP_ID"` |  |
| microsoft.app.existingSecret.keys.password | string | `"MICROSOFT_APP_PASSWORD"` |  |
| microsoft.app.existingSecret.name | string | `nil` |  |
| microsoft.app.id | string | `nil` |  |
| microsoft.app.oauth.connectionName | string | `"alfresco"` |  |
| microsoft.app.password | string | `nil` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33041` |  |
| readinessProbe.initialDelaySeconds | int | `20` |  |
| readinessProbe.periodSeconds | int | `60` |  |
| readinessProbe.tcpSocket.port | string | `"service-port"` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `2` |  |
| repository.existingConfigMap.keys.url | string | `"ALFRESCO_BASE_URL"` | Key within the configmap holding the full url to connect to the alfresco repository |
| repository.existingConfigMap.name | string | `nil` | Alternatively, provide repository connection details via an existing configmap |
| repository.url | string | `nil` | URL of the Alfresco repository |
| resources.limits.cpu | string | `"1"` |  |
| resources.limits.memory | string | `"1000Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"1000Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"ms-teams-service"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `"msteams-sa"` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| strategy.rollingUpdate.maxSurge | int | `1` |  |
| strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| teams.chat.filenameEnabled | bool | `true` |  |
| teams.chat.imageEnabled | bool | `true` |  |
| teams.chat.metadataEnabled | bool | `true` |  |
