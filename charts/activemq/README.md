---
title: activemq
parent: Charts Reference
---

# activemq

![Version: 3.5.3](https://img.shields.io/badge/Version-3.5.3-informational?style=flat-square) ![AppVersion: 5.18.4](https://img.shields.io/badge/AppVersion-5.18.4-informational?style=flat-square)

A Helm chart providing a basic Apache ActiveMQ deployment required to evaluate ACS (not meant to be used in production).

## Source Code

* <https://github.com/Alfresco/alfresco-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| adminUser.existingSecretName | string | `nil` | An existing kubernetes secret that contains BROKER_USERNAME and BROKER_PASSWORD keys to override the default user credentials |
| adminUser.password | string | `"admin"` | Password for the default user with administrative privileges |
| adminUser.user | string | `"admin"` | Username for the default user with administrative privileges |
| enabled | bool | `true` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` | Authenticate to image registry before pulling by providing an existing secret of type kubernetes.io/dockerconfigjson |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"alfresco/alfresco-activemq"` |  |
| image.tag | string | `"5.18.4-jre17-rockylinux8"` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.timeoutSeconds | int | `1` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes | list | `["ReadWriteOnce"]` | defines type of access required by the persistent volume [Access_Modes] (https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.baseSize | string | `"20Gi"` |  |
| persistence.data.mountPath | string | `"/opt/activemq/data"` |  |
| persistence.data.subPath | string | `"alfresco-infrastructure/activemq-data"` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
| persistence.storageClass | string | `nil` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsUser | int | `33031` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `1` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2048Mi"` |  |
| resources.requests.cpu | string | `"0.25"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| service.name | string | `"activemq"` |  |
| services.broker.ports.external.amqp | int | `5672` |  |
| services.broker.ports.external.openwire | int | `61616` |  |
| services.broker.ports.external.stomp | int | `61613` |  |
| services.broker.ports.internal.amqp | int | `5672` |  |
| services.broker.ports.internal.openwire | int | `61616` |  |
| services.broker.ports.internal.stomp | int | `61613` |  |
| services.broker.type | string | `"ClusterIP"` |  |
| services.webConsole.ports.external.webConsole | int | `8161` |  |
| services.webConsole.ports.internal.webConsole | int | `8161` |  |
| services.webConsole.type | string | `"NodePort"` |  |
