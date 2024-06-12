---
title: alfresco-activiti-admin
parent: Charts Reference
---

# alfresco-activiti-admin

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![AppVersion: 24.2.0](https://img.shields.io/badge/AppVersion-24.2.0-informational?style=flat-square)

A Helm chart for Alfresco Activiti

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.2 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.8.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| database.driver | string | `nil` | JDBC driver Class |
| database.existingConfigMap.keys.driver | string | `"DATABASE_DRIVER"` | configmap key where to find the JDBC driver Class for admin app |
| database.existingConfigMap.keys.url | string | `"DATABASE_URL"` | configmap key where to find the URL of the database for admin app |
| database.existingConfigMap.name | string | `nil` |  |
| database.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password for admin app |
| database.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username for admin app |
| database.existingSecret.name | string | `nil` | Name of a pre-existing secret containing database credentials for admin app |
| database.password | string | `nil` | JDBC password to use to connect to the DB for admin app |
| database.url | string | `nil` | JDBC url to connect to the external DB for admin app |
| database.username | string | `nil` | JDBC username to use to connect to the DB for admin app |
| envFromExistingConfigMap | string | `nil` | Name of a pre-existing configmap to load env vars from (overrides .environment values) |
| environment.ACTIVITI_ADMIN_REST_APP_HOST | string | `"http://localhost"` | activiti-app address |
| environment.ACTIVITI_ADMIN_REST_APP_PASSWORD | string | `"admin"` | activiti-app password |
| environment.ACTIVITI_ADMIN_REST_APP_PORT | string | `"80"` | activiti-app port |
| environment.ACTIVITI_ADMIN_REST_APP_USERNAME | string | `"admin@app.activiti.com"` | activiti-app username |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.internalPort | int | `8080` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-process-services-admin"` |  |
| image.tag | string | `"24.2.0"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| ingress.className | string | `"nginx"` | supported ingress class |
| ingress.enabled | bool | `true` | Toggle ingress for APS admin |
| ingress.hosts[0].paths[0].path | string | `"/activiti-admin"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.failureThreshold | int | `5` |  |
| livenessProbe.initialDelaySeconds | int | `25` |  |
| livenessProbe.path | string | `"/activiti-admin/"` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.runAsUser | int | `33007` |  |
| readinessProbe.failureThreshold | int | `5` |  |
| readinessProbe.initialDelaySeconds | int | `25` |  |
| readinessProbe.path | string | `"/activiti-admin/"` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| resources.limits.cpu | string | `"1000m"` |  |
| resources.limits.memory | string | `"2Gi"` |  |
| resources.requests.cpu | string | `"250m"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"activiti-admin"` |  |
| service.type | string | `"ClusterIP"` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |
| workaround.ACTIVITI-5113 | bool | `false` | Enable workaround for [ACTIVITI-5113](https://hyland.atlassian.net/browse/ACTIVITI-5113) required for versions before 24.2.0 |
