# alfresco-sync-service

![Version: 4.0.0](https://img.shields.io/badge/Version-4.0.0-informational?style=flat-square) ![AppVersion: 4.0.0-M7](https://img.shields.io/badge/AppVersion-4.0.0--M7-informational?style=flat-square)

Alfresco Sync Service

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.0.0 |
| https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami/ | common | 1.x.x |
| oci://registry-1.docker.io/bitnamicharts/postgresql | postgresql | 12.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| database | object | `{"driver":"org.postgresql.Driver","enabled":false,"existingSecretName":null,"password":"admin","postgresql":{"auth":{"database":"alfrescosync","enablePostgresUser":false,"existingSecret":null,"password":"admin","username":"alfresco"},"nameOverride":"postgresql-syncservice","primary":{"extendedConfiguration":"shared_buffers = 256MB\nmax_connections = 50\neffective_cache_size = 1024GB\nlog_min_messages = LOG\n"},"resources":{"limits":{"cpu":"2","memory":"2Gi"}}},"url":null,"user":"alfresco"}` | Defines properties required by sync service for connecting to the database If you set database.external to true you will have to setup the JDBC driver, user, password and JdbcUrl as `driver`, `user`, `password` & `url` subelements of `database`. Also make sure that the container has the db driver |
| database.driver | string | `"org.postgresql.Driver"` | The JDBC Driver to connect to the DB. Note: if different from the default make sure your container image ships it. |
| database.enabled | bool | `false` | If set to `true` a dedicated postgres instance will be deployed in the cluster for sync-service to use it. When set to `false` the chart expects you provide DB configuration details. |
| database.existingSecretName | string | `nil` | An existing kubernetes secret with DB info (prefered over using values) |
| database.password | string | `"admin"` | JDBC password to use to connect to the DB |
| database.url | string | `nil` | JDBC url to connect to the external DB |
| database.user | string | `"alfresco"` | JDBC username to use to connect to the DB |
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
| messageBroker | object | `{"existingSecretName":null,"password":"admin","url":"failover:(nio://acs-activemq-broker:61616)?timeout=3000&jms.useCompression=true","user":"admin"}` | messageBroker object allow to pass ActiveMQ connection details. url: provides URI formatted string, see: https://activemq.apache.org/failover-transport-reference user: username to authenticate as. password: credential to use to authenticate to the broker. |
| nodeSelector | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33020` |  |
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
