# alfresco-sync-service

![Version: 3.2.0-SNAPSHOT](https://img.shields.io/badge/Version-3.2.0--SNAPSHOT-informational?style=flat-square) ![AppVersion: 4.0.0-M6](https://img.shields.io/badge/AppVersion-4.0.0--M6-informational?style=flat-square)

Alfresco Sync Service

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.0.0 |
| https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami/ | common | 1.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| database | object | `{"external":false}` | Defines properties required by sync service for connecting to the database If you set database.external to true you will have to setup the JDBC driver, user, password and JdbcUrl as `driver`, `user`, `password` & `url` subelements of `database`. Also make sure that the container has the db driver |
| environment.EXTRA_JAVA_OPTS | string | `""` |  |
| environment.JAVA_OPTS | string | `"-Dsync.metrics.reporter.graphite.enabled=false -Dsync.metrics.reporter.graphite.address=127.0.0.1 -Dsync.metrics.reporter.graphite.port=2003 -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| global | object | `{"alfrescoRegistryPullSecrets":"quay-registry-secret","strategy":{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0}}}` | Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| image.internalPort | int | `9090` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/service-sync"` |  |
| image.tag | string | `"4.0.0-M6"` |  |
| ingress.extraAnnotations | string | `nil` | useful when running Sync service without SSL termination done by a load balancer, e.g. when ran on Minikube for testing purposes nginx.ingress.kubernetes.io/ssl-redirect: "false" |
| ingress.path | string | `"/syncservice"` |  |
| ingress.tls | list | `[]` |  |
| initContainers.activemq.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.activemq.image.repository | string | `"bash"` |  |
| initContainers.activemq.image.tag | string | `"5.1.16"` |  |
| initContainers.activemq.resources.limits.cpu | string | `"0.25"` |  |
| initContainers.activemq.resources.limits.memory | string | `"10Mi"` |  |
| initContainers.postgres.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.postgres.image.repository | string | `"busybox"` |  |
| initContainers.postgres.image.tag | string | `"1.35.0"` |  |
| initContainers.postgres.resources.limits.cpu | string | `"0.25"` |  |
| initContainers.postgres.resources.limits.memory | string | `"10Mi"` |  |
| livenessProbe.initialDelaySeconds | int | `150` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| messageBroker | object | `{"existingSecretName":null,"url":null}` | messageBroker object allow to pass ActiveMQ connection details. url: provides URI formatted string, see: https://activemq.apache.org/failover-transport-reference user: username to authenticate as. password: credential to use to authenticate to the broker. |
| nodeSelector | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33020` |  |
| postgresql-syncservice.enabled | bool | `true` | If true, install the postgresql chart alongside Alfresco Sync service. Note: Set this to false if you use an external database. |
| postgresql-syncservice.image.pullPolicy | string | `"IfNotPresent"` |  |
| postgresql-syncservice.image.tag | string | `"11.7.0"` |  |
| postgresql-syncservice.name | string | `"postgresql-syncservice"` |  |
| postgresql-syncservice.nameOverride | string | `"postgresql-syncservice"` |  |
| postgresql-syncservice.postgresConfig.log_min_messages | string | `"LOG"` |  |
| postgresql-syncservice.postgresConfig.max_connections | int | `450` |  |
| postgresql-syncservice.postgresqlDatabase | string | `"syncservice-postgresql"` |  |
| postgresql-syncservice.postgresqlPassword | string | `"admin"` |  |
| postgresql-syncservice.postgresqlUsername | string | `"alfresco"` |  |
| postgresql-syncservice.replicaCount | int | `1` |  |
| postgresql-syncservice.resources.limits.cpu | string | `"2"` |  |
| postgresql-syncservice.resources.limits.memory | string | `"1500Mi"` |  |
| postgresql-syncservice.resources.requests.cpu | string | `"0.5"` |  |
| postgresql-syncservice.resources.requests.memory | string | `"600Mi"` |  |
| postgresql-syncservice.service.port | int | `5432` |  |
| readinessProbe.failureThreshold | int | `12` |  |
| readinessProbe.initialDelaySeconds | int | `20` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `1` |  |
| repository.host | string | `"alfresco-cs-repository"` |  |
| repository.port | int | `80` |  |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2000Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"800Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"syncservice"` |  |
| service.type | string | `"NodePort"` |  |

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.
