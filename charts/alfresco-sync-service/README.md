# alfresco-sync-service

![Version: 4.5.1](https://img.shields.io/badge/Version-4.5.1-informational?style=flat-square) ![AppVersion: 4.0.1](https://img.shields.io/badge/AppVersion-4.0.1-informational?style=flat-square)

Alfresco Sync Service

Checkout [alfresco-content-services chart doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.3.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.0 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.services.broker.ports.external.openwire | int | `61616` |  |
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
| environment.EXTRA_JAVA_OPTS | string | `""` |  |
| environment.JAVA_OPTS | string | `"-Dsync.metrics.reporter.graphite.enabled=false -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| global | object | `{"alfrescoRegistryPullSecrets":"quay-registry-secret","strategy":{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0}}}` | Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| image.internalPort | int | `9090` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/service-sync"` |  |
| image.tag | string | `"4.0.1"` |  |
| ingress.extraAnnotations | object | `{}` | useful when running Sync service without SSL termination done by a load balancer, e.g. when ran on Minikube for testing purposes nginx.ingress.kubernetes.io/ssl-redirect: "false" |
| ingress.path | string | `"/syncservice"` |  |
| ingress.tls | list | `[]` |  |
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
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33020` |  |
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
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `"alfresco-sync"` |  |
