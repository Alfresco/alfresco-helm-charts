---
title: alfresco-sync-service
parent: Charts Reference
---

# alfresco-sync-service

![Version: 6.1.0](https://img.shields.io/badge/Version-6.1.0-informational?style=flat-square) ![AppVersion: 5.1.0](https://img.shields.io/badge/AppVersion-5.1.0-informational?style=flat-square)

Alfresco Sync Service

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.6.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-sync-service.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule pods on nodes with different zones |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-sync-service.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule pods on nodes with different nodes |
| database.driver | string | `"org.postgresql.Driver"` | The JDBC Driver to connect to the DB. If different from the default make sure your container image ships it. |
| database.existingConfigMap.keys.driver | string | `"DATABASE_DRIVER"` | configmap key where to find the JDBC driver class to use. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter. |
| database.existingConfigMap.keys.url | string | `"DATABASE_URL"` | configmap key where to find the URL of the database |
| database.existingConfigMap.name | string | `nil` |  |
| database.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password |
| database.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username |
| database.existingSecret.name | string | `nil` | Name of a pre-existing secret containing database credentials |
| database.password | string | `nil` | JDBC password to use to connect to the DB |
| database.url | string | `nil` | JDBC url to connect to the external DB |
| database.username | string | `nil` | JDBC username to use to connect to the DB |
| environment.JAVA_OPTS | string | `"-Dsql.db.pool.initial=25 -Dsql.db.pool.max=75 -Dsync.metrics.reporter.graphite.enabled=false -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| global | object | `{"alfrescoRegistryPullSecrets":"quay-registry-secret","strategy":{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0}}}` | Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| hazelcast.service.port | int | `5701` |  |
| hazelcast.service.type | string | `"ClusterIP"` |  |
| image.internalPort | int | `9090` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/service-sync"` |  |
| image.tag | string | `"5.1.0"` |  |
| ingress.extraAnnotations | object | `{}` | useful when running Sync service without SSL termination done by a load balancer, e.g. when ran on Minikube for testing purposes nginx.ingress.kubernetes.io/ssl-redirect: "false" |
| ingress.path | string | `"/syncservice"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/alfresco/healthcheck"` |  |
| livenessProbe.httpGet.port | string | `"serviceport"` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| messageBroker.existingConfigMap.keys.url | string | `"BROKER_URL"` | configmap key where to find the URL of the message broker |
| messageBroker.existingConfigMap.name | string | `nil` | Name of a pre-existing configmap containing message broker details |
| messageBroker.existingSecret.keys.password | string | `"BROKER_PASSWORD"` | Key within the secret holding the message broker password |
| messageBroker.existingSecret.keys.username | string | `"BROKER_USERNAME"` | Key within the secret holding the message broker username |
| messageBroker.existingSecret.name | string | `nil` | Name of a pre-existing secret containing message broker credentials |
| messageBroker.nameOverride | string | `"activemq"` | A name that will be used as a base to get broker connection details |
| messageBroker.password | string | `nil` | Credential to use to authenticate to the broker. |
| messageBroker.url | string | `nil` | A failover URI formatted string, see: https://activemq.apache.org/failover-transport-reference |
| messageBroker.username | string | `nil` | Username to authenticate as. |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33020` |  |
| readinessProbe.failureThreshold | int | `12` |  |
| readinessProbe.httpGet.path | string | `"/alfresco/healthcheck"` |  |
| readinessProbe.httpGet.port | string | `"serviceport"` |  |
| readinessProbe.initialDelaySeconds | int | `20` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `1` |  |
| repository.existingConfigMap.keys.host | string | `"REPO_HOST"` | configmap key where to find the URL of the message broker |
| repository.existingConfigMap.keys.port | string | `"REPO_PORT"` |  |
| repository.existingConfigMap.keys.scheme | string | `"REPO_SCHEME"` |  |
| repository.existingConfigMap.name | string | `nil` | Name of a pre-existing configmap containing message broker details |
| repository.host | string | `nil` | ACS repository host |
| repository.port | string | `nil` | ACS repository port |
| repository.scheme | string | `nil` | ACS repository port |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2000Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"800Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"syncservice"` |  |
| service.type | string | `"NodePort"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `"alfresco-sync"` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| terminationGracePeriodSeconds | int | `60` |  |
| tolerations | list | `[]` |  |
