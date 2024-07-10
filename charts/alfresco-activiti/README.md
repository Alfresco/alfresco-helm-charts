---
title: alfresco-activiti
parent: Charts Reference
---

# alfresco-activiti

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![AppVersion: 24.2.1](https://img.shields.io/badge/AppVersion-24.2.1-informational?style=flat-square)

A Helm chart for Alfresco Activiti

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.3 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.8.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-activiti.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule pods in different zones |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-activiti.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule pods in different nodes |
| database.driver | string | `nil` | JDBC driver Class |
| database.existingConfigMap.keys.driver | string | `"DATABASE_DRIVER"` | configmap key where to find the JDBC driver Class for aps app |
| database.existingConfigMap.keys.url | string | `"DATABASE_URL"` | configmap key where to find the URL of the database for aps app |
| database.existingConfigMap.name | string | `nil` |  |
| database.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password for aps app |
| database.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username for aps app |
| database.existingSecret.name | string | `nil` | Name of a pre-existing secret containing database credentials for aps app |
| database.password | string | `nil` | JDBC password to use to connect to the DB for aps app |
| database.url | string | `nil` | JDBC url to connect to the external DB for aps app |
| database.username | string | `nil` | JDBC username to use to connect to the DB for aps app |
| envFromExistingConfigMap | string | `nil` | Name of a pre-existing configmap to load env vars from (overrides .environment values) |
| environment.ACTIVITI_CORS_ALLOWED_HEADERS | string | `"Authorization,Content-Type,Cache-Control,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,X-CSRF-Token"` | Cross Origin Resource Sharing configuration allowed http headers |
| environment.ACTIVITI_CORS_ALLOWED_METHODS | string | `"GET,POST,HEAD,OPTIONS,PUT,DELETE"` | Cross Origin Resource Sharing configuration allowed http methods |
| environment.ACTIVITI_CORS_ALLOWED_ORIGIN_PATTERNS | string | `"*"` | Cross Origin Resource Sharing configuration allowed origins (list of glob-like patterns) |
| environment.ACTIVITI_CORS_ENABLED | string | `"true"` | Cross Origin Resource Sharing configuration toggle |
| environment.ACTIVITI_CSRF_DISABLED | string | `"true"` |  |
| environment.IDENTITY_CREDENTIALS_SECRET | string | `""` | Alfresco Identity Service application secret |
| environment.IDENTITY_SERVICE_ALWAYS_REFRESH_TOKEN | string | `"true"` | Alfresco Identity Service refresh service token |
| environment.IDENTITY_SERVICE_AUTH | string | `"http://localhost:8080/auth"` | Alfresco Identity Service address |
| environment.IDENTITY_SERVICE_AUTODETECT_BEARER_ONLY | string | `"true"` | Alfresco Identity Service Bearer only toggle |
| environment.IDENTITY_SERVICE_ENABLED | string | `"false"` | Alfresco Identity Service configuration toggle |
| environment.IDENTITY_SERVICE_ENABLE_BASIC_AUTH | string | `"true"` | Alfresco Identity Service allow basic authentication (should only be used over SSL) |
| environment.IDENTITY_SERVICE_PRINCIPAL_ATTRIBUTE | string | `"email"` | Alfresco Identity Service Attribute to map to user login |
| environment.IDENTITY_SERVICE_PUBLIC_CLIENT | string | `"true"` | Alfresco Identity Service public client toggle |
| environment.IDENTITY_SERVICE_REALM | string | `"alfresco"` | Alfresco Identity Service Realm |
| environment.IDENTITY_SERVICE_RESOURCE | string | `"alfresco"` | Alfresco Identity Service resource name to use |
| environment.IDENTITY_SERVICE_SSL_REQUIRED | string | `"none"` | Alfresco Identity Service force using SSL |
| environment.IDENTITY_SERVICE_TOKEN_STORE | string | `"session"` | Alfresco Identity Service token storage configuration |
| environment.IDENTITY_SERVICE_USE_BROWSER_BASED_LOGOUT | string | `"true"` | Alfresco Identity Service browser initiated logout toggle |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.internalPort | int | `8080` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-process-services"` |  |
| image.tag | string | `"24.2.1"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| ingress.className | string | `"nginx"` | supported ingress class |
| ingress.enabled | bool | `true` | Toggle ingress for APS application |
| ingress.hosts[0].paths[0].path | string | `"/activiti-app"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| license.secretName | string | `nil` |  |
| livenessProbe.failureThreshold | int | `5` |  |
| livenessProbe.initialDelaySeconds | int | `25` |  |
| livenessProbe.path | string | `"/activiti-app/actuator/health/liveness"` | For APS prior to 24.3.0, path must be set to `/activiti-app/app/rest/locale` |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.baseSize | string | `"20Gi"` | Initial default size of dynamically provisioned storage |
| persistence.data.mountPath | string | `"/usr/local/data"` |  |
| persistence.data.subPath | string | `"alfresco-process-services/process-data"` |  |
| persistence.enabled | bool | `false` | Persist Alfresco Process data |
| persistence.existingClaim | string | `nil` | Define if you want to reuse an already existing PVC |
| persistence.storageClass | string | `nil` | Define if you already have a custom storage class defined for dynamically provisioned storage |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `33007` |  |
| podSecurityContext.runAsGroup | int | `33007` |  |
| podSecurityContext.runAsUser | int | `33007` |  |
| readinessProbe.failureThreshold | int | `5` |  |
| readinessProbe.initialDelaySeconds | int | `25` |  |
| readinessProbe.path | string | `"/activiti-app/actuator/health/readiness"` | For APS prior to 24.3.0, path must be set to `/activiti-app/app/rest/locale` |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"4000m"` |  |
| resources.limits.memory | string | `"8Gi"` |  |
| resources.requests.cpu | string | `"500m"` |  |
| resources.requests.memory | string | `"1Gi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"aps"` |  |
| service.type | string | `"ClusterIP"` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |
| workaround.ACTIVITI-5113 | bool | `false` |  |
