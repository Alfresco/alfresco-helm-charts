# alfresco-connector-msteams

![Version: 0.4.1](https://img.shields.io/badge/Version-0.4.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart for deploying Alfresco connector msteams service

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alfresco.baseUrl | string | `"change_me_alf_base_url"` |  |
| alfresco.digitalWorkspace.contextPath | string | `"/workspace/"` |  |
| environment | string | `nil` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.internalPort | int | `3978` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-ms-teams-service"` |  |
| image.tag | string | `"2.0.0"` |  |
| ingress.extraAnnotations | object | `{}` |  |
| ingress.path | string | `"/ms-teams-service"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `20` |  |
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
