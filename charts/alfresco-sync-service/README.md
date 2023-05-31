# alfresco-sync-service

![Version: 4.1.0](https://img.shields.io/badge/Version-4.1.0-informational?style=flat-square) ![AppVersion: 3.9.0](https://img.shields.io/badge/AppVersion-3.9.0-informational?style=flat-square)

Alfresco Sync Service

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.1.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.0.0 |
| oci://registry-1.docker.io/bitnamicharts | common | 2.x.x |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.adminUser.password | string | `"admin"` | Password to use to set as the connection user for ActiveMQ |
| activemq.adminUser.user | string | `"admin"` | User to use to set as the connection user for ActiveMQ |
| activemq.enabled | bool | `false` | Toggle ActiveMQ chart dependency see [Alfresco ActiveMQ chart documentation](https://github.com/Alfresco/alfresco-helm-charts/tree/main/charts/activemq)) |
| activemq.nameOverride | string | `"activemq"` |  |
| activemq.services.broker.ports.external.openwire | int | `61616` |  |
| database.driver | string | `"org.postgresql.Driver"` | The JDBC Driver to connect to the DB. If different from the default make sure your container image ships it. |
| database.existingSecretName | string | `nil` | An existing kubernetes secret with DB info (prefered over using values) |
| database.password | string | `"admin"` | JDBC password to use to connect to the DB |
| database.url | string | `nil` | JDBC url to connect to the external DB |
| database.user | string | `"alfresco"` | JDBC username to use to connect to the DB |
| environment.EXTRA_JAVA_OPTS | string | `""` |  |
| environment.JAVA_OPTS | string | `"-Dsync.metrics.reporter.graphite.enabled=false -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| global | object | `{"alfrescoRegistryPullSecrets":"quay-registry-secret","messageBroker":{"password":null,"url":null,"user":null},"strategy":{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0}}}` | Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| global.messageBroker.password | string | `nil` | Credential to use to authenticate to the broker. |
| global.messageBroker.url | string | `nil` | A failover URI formatted string, see: https://activemq.apache.org/failover-transport-reference |
| global.messageBroker.user | string | `nil` | Username to authenticate as. |
| image.internalPort | int | `9090` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/service-sync"` |  |
| image.tag | string | `"3.9.0"` |  |
| ingress.extraAnnotations | string | `nil` | useful when running Sync service without SSL termination done by a load balancer, e.g. when ran on Minikube for testing purposes nginx.ingress.kubernetes.io/ssl-redirect: "false" |
| ingress.path | string | `"/syncservice"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| messageBroker.existingSecretName | string | `nil` | An existing k8s secret with broker details (prefered over using values) |
| messageBroker.nameOverride | string | `"activemq"` | A name that will be used as a base to get broker conenction details |
| messageBroker.password | string | `nil` | Credential to use to authenticate to the broker. |
| messageBroker.url | string | `nil` | A failover URI formatted string, see: https://activemq.apache.org/failover-transport-reference |
| messageBroker.user | string | `nil` | Username to authenticate as. |
| nodeSelector | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33020` |  |
| postgresql | object | `{"auth":{"database":"alfrescosync","enablePostgresUser":false,"password":"admin","username":"alfresco"},"enabled":false,"nameOverride":"postgresql-syncservice","primary":{"extendedConfiguration":"shared_buffers = 256MB\nmax_connections = 100\nwal_level = minimal\nmax_wal_senders = 0\nmax_replication_slots = 0\neffective_cache_size = 1024GB\nlog_min_messages = LOG\n"},"resources":{"limits":{"cpu":"2","memory":"2Gi"}}}` | Defines properties required by sync service for connecting to the database If you set database.external to true you will have to setup the JDBC driver, user, password and JdbcUrl as `driver`, `user`, `password` & `url` subelements of `database`. Also make sure that the container has the db driver |
| postgresql.enabled | bool | `false` | Toggle PostgreSQL chart dependency see [PostgreSQL Bitnami charts documentation](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)) |
| readinessProbe.failureThreshold | int | `12` |  |
| readinessProbe.initialDelaySeconds | int | `20` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `1` |  |
| repository.host | string | `"alfresco-cs-repository"` | ACS repository host |
| repository.nameOverride | string | `nil` | A nameOverride use to compute an ACS repository service name |
| repository.port | int | `80` | ACS repository port |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2000Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"800Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"syncservice"` |  |
| service.type | string | `"NodePort"` |  |

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.
