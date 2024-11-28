---
title: alfresco-insight-zeppelin
parent: Charts Reference
---

# alfresco-insight-zeppelin

![Version: 3.0.4](https://img.shields.io/badge/Version-3.0.4-informational?style=flat-square) ![AppVersion: 2.0.13](https://img.shields.io/badge/AppVersion-2.0.13-informational?style=flat-square)

A Helm chart for deploying Alfresco Insight Zeppelin

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/alfresco-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | string | `""` | Pod affinity, passed thru tpl function |
| environment.ZEPPELIN_INTP_MEM | string | `"-Xms512m -Xmx1g"` |  |
| environment.ZEPPELIN_MEM | string | `"-Xms512m -Xmx1g"` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` | Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| global.strategy.rollingUpdate.maxSurge | int | `1` |  |
| global.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| image.internalPort | int | `9090` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/insight-zeppelin"` |  |
| image.tag | string | `"2.0.13"` |  |
| ingress.path | string | `"/zeppelin"` |  |
| livenessProbe.initialDelaySeconds | int | `130` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33007` |  |
| readinessProbe.initialDelaySeconds | int | `60` |  |
| readinessProbe.periodSeconds | int | `20` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `1` |  |
| repository.existingConfigMap.keys.host | string | `"REPO_HOST"` | Key within the configmap holding the repository hostname |
| repository.existingConfigMap.keys.port | string | `"REPO_PORT"` | Key within the configmap holding the repository port |
| repository.existingConfigMap.name | string | `nil` | Name of a pre-existing configmap containing Alfresco repository URL |
| repository.url | string | `"http://alfresco-search-service"` | Alfresco repository URL |
| resources.limits.cpu | string | `"1"` |  |
| resources.limits.memory | string | `"1024Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"zeppelin"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
