# elastic

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 8.17.3](https://img.shields.io/badge/AppVersion-8.17.3-informational?style=flat-square)

WARNING: This chart is meant to ease initial deployment for TESTING purposes.
DO NOT use this chart in any staging, or production environment. It has very
limited options. It is not meant to be configurable and we do not aim at
making it particularly secure or add features to it. Its SOLE goal is to allow
for quickly spinning up an Alfresco platform on kubernetes, any issue that
does not affect this is likely to not be fixed. For any other purpose, make
sure to deploy your own enterprise grade Elasticsearch instance and configure
Alfresco charts to point to it.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 4.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| elasticsearch.credentials.enabled | bool | `false` |  |
| elasticsearch.credentials.existingSecret.name | string | `""` |  |
| elasticsearch.credentials.existingSecret.passwordKey | string | `"password"` |  |
| elasticsearch.credentials.existingSecret.usernameKey | string | `"username"` |  |
| elasticsearch.credentials.password | string | `""` |  |
| elasticsearch.credentials.username | string | `"elastic"` |  |
| elasticsearch.image.pullPolicy | string | `"IfNotPresent"` |  |
| elasticsearch.image.repository | string | `"elasticsearch"` |  |
| elasticsearch.image.tag | string | `"8.17.3"` |  |
| elasticsearch.ingress.annotations | object | `{}` |  |
| elasticsearch.ingress.className | string | `"nginx"` |  |
| elasticsearch.ingress.enabled | bool | `false` |  |
| elasticsearch.ingress.hosts[0].paths[0].path | string | `"/elasticsearch"` |  |
| elasticsearch.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| elasticsearch.ingress.tls | list | `[]` |  |
| elasticsearch.livenessProbe.exec.command[0] | string | `"sh"` |  |
| elasticsearch.livenessProbe.exec.command[1] | string | `"-c"` |  |
| elasticsearch.livenessProbe.exec.command[2] | string | `"curl -s -X GET http://localhost:9200/_cluster/health?pretty | grep status | grep -q '\\(green\\|yellow\\)'"` |  |
| elasticsearch.livenessProbe.initialDelaySeconds | int | `30` |  |
| elasticsearch.livenessProbe.periodSeconds | int | `20` |  |
| elasticsearch.livenessProbe.timeoutSeconds | int | `5` |  |
| elasticsearch.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| elasticsearch.persistence.baseSize | string | `"8Gi"` |  |
| elasticsearch.persistence.data.mountPath | string | `"/usr/share/elasticsearch/data"` |  |
| elasticsearch.persistence.data.subPath | string | `"alfresco-content-services/elasticsearch-data"` |  |
| elasticsearch.persistence.enabled | bool | `false` |  |
| elasticsearch.persistence.existingClaim | string | `nil` |  |
| elasticsearch.persistence.storageClass | string | `nil` |  |
| elasticsearch.readinessProbe.exec.command[0] | string | `"sh"` |  |
| elasticsearch.readinessProbe.exec.command[1] | string | `"-c"` |  |
| elasticsearch.readinessProbe.exec.command[2] | string | `"curl -s -X GET http://localhost:9200/_cluster/health?pretty | grep status | grep -q '\\(green\\|yellow\\)'"` |  |
| elasticsearch.readinessProbe.initialDelaySeconds | int | `30` |  |
| elasticsearch.readinessProbe.periodSeconds | int | `20` |  |
| elasticsearch.readinessProbe.timeoutSeconds | int | `5` |  |
| elasticsearch.resources.limits.cpu | int | `1` |  |
| elasticsearch.resources.limits.memory | string | `"2Gi"` |  |
| elasticsearch.resources.requests.cpu | string | `"500m"` |  |
| elasticsearch.resources.requests.memory | string | `"2Gi"` |  |
| elasticsearch.service.name | string | `"elasticsearch"` | used for naming pvc |
| fullnameOverride | string | `""` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| kibana.enabled | bool | `false` |  |
| kibana.image.pullPolicy | string | `"IfNotPresent"` |  |
| kibana.image.repository | string | `"kibana"` |  |
| kibana.image.tag | string | `"8.17.0"` |  |
| kibana.ingress.annotations | object | `{}` |  |
| kibana.ingress.className | string | `"nginx"` |  |
| kibana.ingress.enabled | bool | `false` |  |
| kibana.ingress.hosts[0].paths[0].path | string | `"/kibana"` |  |
| kibana.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| kibana.ingress.tls | list | `[]` |  |
| kibana.livenessProbe.initialDelaySeconds | int | `60` |  |
| kibana.livenessProbe.periodSeconds | int | `10` |  |
| kibana.livenessProbe.timeoutSeconds | int | `5` |  |
| kibana.readinessProbe.initialDelaySeconds | int | `60` |  |
| kibana.readinessProbe.periodSeconds | int | `10` |  |
| kibana.readinessProbe.timeoutSeconds | int | `5` |  |
| kibana.resources.limits.cpu | int | `1` |  |
| kibana.resources.limits.memory | string | `"1Gi"` |  |
| kibana.resources.requests.cpu | string | `"500m"` |  |
| kibana.resources.requests.memory | string | `"1Gi"` |  |
| kibana.serverBasePath | string | `"/kibana"` |  |
| nameOverride | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
