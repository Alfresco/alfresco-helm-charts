# alfresco-connector-ms365

![Version: 0.5.1](https://img.shields.io/badge/Version-0.5.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

A Helm chart for deploying Alfresco connector ms365 service

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | string | `"podAntiAffinity:\n  preferredDuringSchedulingIgnoredDuringExecution:\n    - weight: 10\n      podAffinityTerm:\n        labelSelector:\n          matchExpressions:\n            - key: app.kubernetes.io/name\n              operator: In\n              values:\n                - {{ template \"alfresco-connector-ms365.name\" . }}\n            - key: app.kubernetes.io/instance\n              operator: In\n              values:\n                - {{ .Release.Name }}\n        topologyKey: failure-domain.beta.kubernetes.io/zone\n    - weight: 5\n      podAffinityTerm:\n        labelSelector:\n          matchExpressions:\n            - key: app.kubernetes.io/name\n              operator: In\n              values:\n                - {{ template \"alfresco-connector-ms365.name\" . }}\n            - key: app.kubernetes.io/instance\n              operator: In\n              values:\n                - {{ .Release.Name }}\n        topologyKey: kubernetes.io/hostname"` | Pod affinity, passed thru tpl function |
| environment | object | `{}` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.internalPort | int | `9095` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-ooi-service"` |  |
| image.tag | string | `"2.0.0"` |  |
| ingress.extraAnnotations | object | `{}` |  |
| ingress.path | string | `"/ooi-service"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33006` |  |
| readinessProbe.initialDelaySeconds | int | `20` |  |
| readinessProbe.periodSeconds | int | `60` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `2` |  |
| repository.existingConfigMap.keys.host | string | `"REPO_HOST"` | name of the key in the configMap where to find the repository service host |
| repository.existingConfigMap.keys.port | string | `"REPO_PORT"` | name of the key in the configMap where to find the repository service port |
| repository.existingConfigMap.name | string | `nil` | a pre-existing configmap which provides expected configuration for ms365 |
| repository.host | string | `"acs-alfresco-cs-repository"` | ACS repository host |
| repository.port | int | `80` | ACS repository port |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"1000Mi"` |  |
| resources.requests.cpu | string | `"0.25"` |  |
| resources.requests.memory | string | `"1000Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"ms365-service"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `"ms365-sa"` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| strategy.rollingUpdate.maxSurge | int | `1` |  |
| strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| tolerations | list | `[]` |  |
