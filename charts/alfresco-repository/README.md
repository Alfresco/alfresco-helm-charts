# alfresco-repository

![Version: 0.1.0-alpha.4](https://img.shields.io/badge/Version-0.1.0--alpha.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.1.0-A21](https://img.shields.io/badge/AppVersion-23.1.0--A21-informational?style=flat-square)

Alfresco content repository Helm chart

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.1.0-alpha.3 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| args | list | `[]` |  |
| command | list | `[]` |  |
| configuration.db.driver | string | `nil` | JDBC driver class of the driver if none is provided the it is guessed from the URL provided |
| configuration.db.existingSecret | object | `{"keys":{"password":"DATABASE_PASSWORD","username":"DATABASE_USERNAME"},"name":null}` | Existing secret and their keys where to find the database username & password. |
| configuration.db.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password |
| configuration.db.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username |
| configuration.db.existingSecret.name | string | `nil` | Name of a pre-existing secret containing database credentials |
| configuration.db.password | string | `nil` | Password to authentication to the repository database |
| configuration.db.url | string | `nil` | JDBC url of the database WITHOUT the "jdbc:" prefix This is a mandatory parameter |
| configuration.db.username | string | `nil` | Username to authentication to the repository database |
| configuration.hz.port | int | `5701` | Hazelcast listener port Only change it if you use a custom image where the port has been changed from default |
| configuration.messageBroker.existingConfigMap.keys.url | string | `"BROKER_URL"` | Key within the configmap  holding the message broker URL. It MUST be a failover URL as per the spec below: https://activemq.apache.org/failover-transport-reference.html |
| configuration.messageBroker.existingConfigMap.name | string | `nil` | Name of a pre-existing configmap containing the meesage broker URL |
| configuration.messageBroker.existingSecret.keys.password | string | `"BROKER_PASSWORD"` | Key within the secret holding the message broker password |
| configuration.messageBroker.existingSecret.keys.username | string | `"BROKER_USERNAME"` | Key within the secret holding the message broker username |
| configuration.messageBroker.existingSecret.name | string | `nil` | Name of a pre-existing secret containing message broker credentials |
| configuration.messageBroker.password | string | `nil` | Password to authenticate to the message broker |
| configuration.messageBroker.url | string | `nil` | Message Broker URL |
| configuration.messageBroker.username | string | `nil` | Username to authenticate to the message broker |
| configuration.repository.existingConfigMap | string | `nil` | a configmap containing the "alfresco-global.properties" key populated with actual Alfresco repository properties |
| configuration.repository.existingSecrets | list | `[{"key":"license.lic","name":"repository-secrets","purpose":"acs-license"}]` | A list of secrets to make available to the repo as env vars. It's also used to pass the Alfresco license which will be mounted as a file when the secret as the `purpose` value set to `acs-license`. Other secrets will be used as env variables. |
| configuration.search.existingConfigMap.keys.url | string | `"SEARCH_URL"` | Key within the configmap  holding the search service URL. |
| configuration.search.existingConfigMap.name | string | `nil` | Optional configmap containing the search service URL |
| configuration.search.existingSecret.keys.password | string | `"ELASTICSEARCH_PASSWORD"` | Key within the secret holding the search service password |
| configuration.search.existingSecret.keys.solr-secret | string | `"SOLR_SECRET"` | Key within the secret holding the index shared secret |
| configuration.search.existingSecret.keys.username | string | `"ELASTICSEARCH_USERNAME"` | Key within the secret holding the search service username |
| configuration.search.existingSecret.name | string | `nil` | Optional secret containing search service credentials |
| configuration.search.flavor | string | `"none"` | Can be either `solr`, `elasticsearch` or `none` |
| configuration.search.password | string | `nil` | Password to authenticate to the search service |
| configuration.search.solr-secret | string | `nil` | Solr inter process shared secret |
| configuration.search.url | string | `nil` | URL where the search service can be found |
| configuration.search.username | string | `nil` | Username to authenticate to the search service |
| environment.CATALINA_OPTS | string | `nil` | Java or Tomcat system properties. These properties must be provided as a single string following the pattern "-Dproperty=value -Dmoreprop=morevalue". They override the content of the global properties file but you should prefer providing configuration.repository.existingConfigMap. |
| environment.JAVA_OPTS | string | `"-XX:MaxRAMPercentage=80"` | Set JVM options |
| extraInitContainers | list | `[]` |  |
| extraSideContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` | If a private image registry a secret can be defined and passed to kubernetes, see: https://github.com/Alfresco/acs-deployment/blob/a924ad6670911f64f1bba680682d266dd4ea27fb/docs/helm/eks-deployment.md#docker-registry-secret |
| global.known_urls | string | `nil` | a fallback for .Values.known_urls that can be shared between charts |
| image.port | int | `8080` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-content-repository"` |  |
| image.tag | string | `"23.1.0-A21"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-hash" | string | `"sha1"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-name" | string | `"alfrescoRepo"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/alfresco/api/-default-/public/alfresco/versions/1/probes/-live-"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `3` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes | list | `["ReadWriteMany"]` | Specify a storageClass for dynamic provisioning |
| persistence.baseSize | string | `"20Gi"` |  |
| persistence.data.mountPath | string | `"/usr/local/tomcat/alf_data"` |  |
| persistence.data.subPath | string | `"alfresco-content-services/repository-data"` |  |
| persistence.enabled | bool | `false` | Persist Contentsotre data |
| persistence.existingClaim | string | `nil` | Use pre-provisioned pv through its claim (e.g. static provisioning) |
| persistence.storageClass | string | `nil` | Bind PVC based on storageClass (e.g. dynamic provisioning) |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33000` |  |
| readinessProbe.httpGet.path | string | `"/alfresco/api/-default-/public/alfresco/versions/1/probes/-ready-"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.periodSeconds | int | `20` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"4"` |  |
| resources.limits.memory | string | `"8Gi"` |  |
| resources.requests.cpu | string | `"250m"` |  |
| resources.requests.memory | string | `"2Gi"` |  |
| securityContext | object | `{}` |  |
| service.name | string | `"repository"` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"alfresco-repo-sa"` |  |
| startupProbe.failureThreshold | int | `5` |  |
| startupProbe.httpGet.path | string | `"/alfresco/api/-default-/public/alfresco/versions/1/probes/-live-"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.periodSeconds | int | `30` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| strategy.rollingUpdate.maxSurge | int | `1` |  |
| strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| strategy.type | string | `"RollingUpdate"` |  |
| terminationGracePeriod | int | `60` | How long to wait for tomcat to complete shutdown before killing it |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
