# alfresco-process-services

![Version: 1.0.0-alpha.3](https://img.shields.io/badge/Version-1.0.0--alpha.3-informational?style=flat-square) ![AppVersion: 24.1.0](https://img.shields.io/badge/AppVersion-24.1.0-informational?style=flat-square)

A Helm chart for Alfresco Process Services

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.2 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.8.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| adminApp.affinity | object | `{}` |  |
| adminApp.database.driver | string | `nil` | JDBC driver Class |
| adminApp.database.existingConfigMap.keys.driver | string | `"DATABASE_DRIVER"` | configmap key where to find the JDBC driver Class for admin app |
| adminApp.database.existingConfigMap.keys.url | string | `"DATABASE_URL"` | configmap key where to find the URL of the database for admin app |
| adminApp.database.existingConfigMap.name | string | `nil` |  |
| adminApp.database.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password for admin app |
| adminApp.database.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username for admin app |
| adminApp.database.existingSecret.name | string | `nil` | Name of a pre-existing secret containing database credentials for admin app |
| adminApp.database.password | string | `nil` | JDBC password to use to connect to the DB for admin app |
| adminApp.database.url | string | `nil` | JDBC url to connect to the external DB for admin app |
| adminApp.database.username | string | `nil` | JDBC username to use to connect to the DB for admin app |
| adminApp.environment.ACTIVITI_ADMIN_REST_APP_HOST | string | `"http://localhost"` | activiti-app address |
| adminApp.environment.ACTIVITI_ADMIN_REST_APP_PASSWORD | string | `"admin"` | activiti-app password |
| adminApp.environment.ACTIVITI_ADMIN_REST_APP_PORT | string | `"80"` | activiti-app port |
| adminApp.environment.ACTIVITI_ADMIN_REST_APP_USERNAME | string | `"admin@app.activiti.com"` | activiti-app username |
| adminApp.image.internalPort | int | `8080` |  |
| adminApp.image.pullPolicy | string | `"IfNotPresent"` |  |
| adminApp.image.repository | string | `"quay.io/alfresco/alfresco-process-services-admin"` |  |
| adminApp.image.tag | string | `"24.1.0"` |  |
| adminApp.ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| adminApp.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| adminApp.ingress.className | string | `"nginx"` | supported ingress class |
| adminApp.ingress.enabled | bool | `true` | Toggle ingress for APS admin |
| adminApp.ingress.hosts[0].paths[0].path | string | `"/activiti-admin"` |  |
| adminApp.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| adminApp.ingress.tls | list | `[]` |  |
| adminApp.livenessProbe.failureThreshold | int | `5` |  |
| adminApp.livenessProbe.initialDelaySeconds | int | `25` |  |
| adminApp.livenessProbe.path | string | `"/activiti-admin/"` |  |
| adminApp.livenessProbe.periodSeconds | int | `10` |  |
| adminApp.livenessProbe.timeoutSeconds | int | `5` |  |
| adminApp.nodeSelector | object | `{}` |  |
| adminApp.podAnnotations | object | `{}` |  |
| adminApp.podLabels | object | `{}` |  |
| adminApp.podSecurityContext | object | `{}` |  |
| adminApp.readinessProbe.failureThreshold | int | `5` |  |
| adminApp.readinessProbe.initialDelaySeconds | int | `25` |  |
| adminApp.readinessProbe.path | string | `"/activiti-admin/"` |  |
| adminApp.readinessProbe.periodSeconds | int | `10` |  |
| adminApp.readinessProbe.timeoutSeconds | int | `5` |  |
| adminApp.replicacount | int | `1` |  |
| adminApp.service.externalPort | int | `80` |  |
| adminApp.service.name | string | `"aps-admin"` |  |
| adminApp.service.type | string | `"ClusterIP"` |  |
| adminApp.tolerations | list | `[]` |  |
| adminApp.volumeMounts | list | `[]` |  |
| adminApp.volumes | list | `[]` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| license.secretName | string | `nil` |  |
| processEngine.affinity | object | `{}` |  |
| processEngine.database.driver | string | `nil` | JDBC driver Class |
| processEngine.database.existingConfigMap.keys.driver | string | `"DATABASE_DRIVER"` | configmap key where to find the JDBC driver Class for aps app |
| processEngine.database.existingConfigMap.keys.url | string | `"DATABASE_URL"` | configmap key where to find the URL of the database for aps app |
| processEngine.database.existingConfigMap.name | string | `nil` |  |
| processEngine.database.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password for aps app |
| processEngine.database.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username for aps app |
| processEngine.database.existingSecret.name | string | `nil` | Name of a pre-existing secret containing database credentials for aps app |
| processEngine.database.password | string | `nil` | JDBC password to use to connect to the DB for aps app |
| processEngine.database.url | string | `nil` | JDBC url to connect to the external DB for aps app |
| processEngine.database.username | string | `nil` | JDBC username to use to connect to the DB for aps app |
| processEngine.environment.ACTIVITI_CORS_ALLOWED_HEADERS | string | `"Authorization,Content-Type,Cache-Control,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,X-CSRF-Token"` | Cross Origin Resource Sharing configuration allowed http headers |
| processEngine.environment.ACTIVITI_CORS_ALLOWED_METHODS | string | `"GET,POST,HEAD,OPTIONS,PUT,DELETE"` | Cross Origin Resource Sharing configuration allowed http methods |
| processEngine.environment.ACTIVITI_CORS_ALLOWED_ORIGIN_PATTERNS | string | `"*"` | Cross Origin Resource Sharing configuration allowed origins (list of glob-like patterns) |
| processEngine.environment.ACTIVITI_CORS_ENABLED | string | `"true"` | Cross Origin Resource Sharing configuration toggle |
| processEngine.environment.ACTIVITI_CSRF_DISABLED | string | `"true"` | Cross Site Resource Forgery configuration toggle |
| processEngine.environment.IDENTITY_CREDENTIALS_SECRET | string | `""` | Alfresco Identity Service application secret |
| processEngine.environment.IDENTITY_SERVICE_ALWAYS_REFRESH_TOKEN | string | `"true"` | Alfresco Identity Service refresh service token |
| processEngine.environment.IDENTITY_SERVICE_AUTH | string | `"http://localhost:8080/auth"` | Alfresco Identity Service address |
| processEngine.environment.IDENTITY_SERVICE_AUTODETECT_BEARER_ONLY | string | `"true"` | Alfresco Identity Service Bearer only toggle |
| processEngine.environment.IDENTITY_SERVICE_ENABLED | string | `"false"` | Alfresco Identity Service configuration toggle |
| processEngine.environment.IDENTITY_SERVICE_ENABLE_BASIC_AUTH | string | `"true"` | Alfresco Identity Service allow basic authentication (should only be used over SSL) |
| processEngine.environment.IDENTITY_SERVICE_PRINCIPAL_ATTRIBUTE | string | `"email"` | Alfresco Identity Service Attribute to map to user login |
| processEngine.environment.IDENTITY_SERVICE_PUBLIC_CLIENT | string | `"true"` | Alfresco Identity Service public client toggle |
| processEngine.environment.IDENTITY_SERVICE_REALM | string | `"alfresco"` | Alfresco Identity Service Realm |
| processEngine.environment.IDENTITY_SERVICE_RESOURCE | string | `"alfresco"` | Alfresco Identity Service resource name to use |
| processEngine.environment.IDENTITY_SERVICE_SSL_REQUIRED | string | `"none"` | Alfresco Identity Service force using SSL |
| processEngine.environment.IDENTITY_SERVICE_TOKEN_STORE | string | `"session"` | Alfresco Identity Service token storage configuration |
| processEngine.environment.IDENTITY_SERVICE_USE_BROWSER_BASED_LOGOUT | string | `"true"` | Alfresco Identity Service browser initiated logout toggle |
| processEngine.image.internalPort | int | `8080` |  |
| processEngine.image.pullPolicy | string | `"IfNotPresent"` |  |
| processEngine.image.repository | string | `"quay.io/alfresco/alfresco-process-services"` |  |
| processEngine.image.tag | string | `"24.1.0"` |  |
| processEngine.ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| processEngine.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| processEngine.ingress.className | string | `"nginx"` | supported ingress class |
| processEngine.ingress.enabled | bool | `true` | Toggle ingress for APS application |
| processEngine.ingress.hosts[0].paths[0].path | string | `"/activiti-app"` |  |
| processEngine.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| processEngine.ingress.tls | list | `[]` |  |
| processEngine.livenessProbe.failureThreshold | int | `5` |  |
| processEngine.livenessProbe.initialDelaySeconds | int | `25` |  |
| processEngine.livenessProbe.path | string | `"/activiti-app/app/rest/locale"` |  |
| processEngine.livenessProbe.periodSeconds | int | `10` |  |
| processEngine.livenessProbe.timeoutSeconds | int | `5` |  |
| processEngine.nodeSelector | object | `{}` |  |
| processEngine.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| processEngine.persistence.baseSize | string | `"20Gi"` | Initial default size of dynamically provisioned storage |
| processEngine.persistence.data | object | `{"mountPath":"/usr/local/data","subPath":"alfresco-process-services/process-data"}` | Where to mount data into the container |
| processEngine.persistence.enabled | bool | `false` | Persist processEngine data |
| processEngine.persistence.existingClaim | string | `nil` | Define if you want to reuse an already existing PVC |
| processEngine.persistence.storageClass | string | `nil` | Define if you already have a custom storage class defined for dynamically provisioned storage |
| processEngine.podAnnotations | object | `{}` |  |
| processEngine.podLabels | object | `{}` |  |
| processEngine.podSecurityContext.fsGroup | int | `33007` |  |
| processEngine.podSecurityContext.runAsGroup | int | `33007` |  |
| processEngine.podSecurityContext.runAsUser | int | `33007` |  |
| processEngine.readinessProbe.failureThreshold | int | `5` |  |
| processEngine.readinessProbe.initialDelaySeconds | int | `25` |  |
| processEngine.readinessProbe.path | string | `"/activiti-app/app/rest/locale"` |  |
| processEngine.readinessProbe.periodSeconds | int | `10` |  |
| processEngine.readinessProbe.timeoutSeconds | int | `5` |  |
| processEngine.replicaCount | int | `1` |  |
| processEngine.service.externalPort | int | `80` |  |
| processEngine.service.name | string | `"aps"` |  |
| processEngine.service.type | string | `"ClusterIP"` |  |
| processEngine.tolerations | list | `[]` |  |
| processEngine.volumeMounts | list | `[]` |  |
| processEngine.volumes | list | `[]` |  |
