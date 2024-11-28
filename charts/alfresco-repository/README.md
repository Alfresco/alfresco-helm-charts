---
title: alfresco-repository
parent: Charts Reference
---

# alfresco-repository

![Version: 0.8.0](https://img.shields.io/badge/Version-0.8.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.4.0](https://img.shields.io/badge/AppVersion-23.4.0-informational?style=flat-square)

Alfresco content repository Helm chart

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-repository.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer scheduling pods in different zones |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-repository.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer scheduling pods on different nodes |
| args | list | `[]` |  |
| autoscaling.behavior.scaleDown.policies | list | `[{"periodSeconds":60,"type":"Pods","value":1}]` | list of available policies for scaling down scale down either by one pod or by destroying 25% of the pods (whichever is smaller) |
| autoscaling.behavior.scaleUp.policies | list | `[{"periodSeconds":60,"type":"Percent","value":50},{"periodSeconds":60,"type":"Pods","value":2}]` | list of available policies for scaling up scale up either by one pod or by adding 50% more pods (whichever is bigger) |
| autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `30` |  |
| autoscaling.enabled | bool | `false` | Toggle repository autoscaling |
| autoscaling.maxReplicas | int | `3` | maximum number of replicas to spin up within the replicatset |
| autoscaling.metrics | list | `[{"resource":{"name":"cpu","target":{"averageUtilization":75,"type":"Utilization"}},"type":"Resource"}]` | a list of resource the HPA controller should monitor For more details check https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics |
| autoscaling.minReplicas | int | `1` | minimum number of replicas to spin up within the replicatset |
| command | list | `[]` |  |
| configuration.db.driver | string | `nil` | JDBC driver class of the driver if none is provided the it is guessed from the URL provided |
| configuration.db.existingConfigMap.keys.driver | string | `"DATABASE_DRIVER"` | configmap key where to find the JDBC driver class to use. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter. |
| configuration.db.existingConfigMap.keys.url | string | `"DATABASE_URL"` | configmap key where to find the URL of the database |
| configuration.db.existingConfigMap.name | string | `nil` |  |
| configuration.db.existingSecret | object | `{"keys":{"password":"DATABASE_PASSWORD","username":"DATABASE_USERNAME"},"name":null}` | Existing secret and their keys where to find the database username & password. |
| configuration.db.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password |
| configuration.db.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username |
| configuration.db.existingSecret.name | string | `nil` | Name of a pre-existing secret containing database credentials |
| configuration.db.password | string | `nil` | Password to authentication to the repository database |
| configuration.db.url | string | `nil` | JDBC url of the database This is a mandatory parameter |
| configuration.db.username | string | `nil` | Username to authentication to the repository database |
| configuration.hz.port | int | `5701` | Hazelcast listener port Only change it if you use a custom image where the port has been changed from default |
| configuration.imap | object | see below | Basic IMAP capabilities config (limited to enabling/disabling). In order to pass more IMAP properties and configure the subsystem more deeply, please use value `environment.CATALINA_OPTS` or `configuration.repository.existingConfiMap` and check the [available properties for this subsystem](https://docs.alfresco.com/content-services/latest/config/email/#imap-subsystem-properties) |
| configuration.imap.enabled | bool | `false` | Enable/Disable Alfresco repository IMAP capabilities |
| configuration.imap.port | int | `1143` | port to use to listen for IMAP clients |
| configuration.imap.protocol | string | `"imap"` | Protocol to use to talk to IMAP clients (imap or imaps) |
| configuration.imap.service.annotations | string | `nil` | Use annations to get custom behavior of the loadbalancer exposing the service |
| configuration.messageBroker.existingConfigMap.keys.url | string | `"BROKER_URL"` | Key within the configmap  holding the message broker URL. It MUST be a failover URL as per the spec below: https://activemq.apache.org/failover-transport-reference.html |
| configuration.messageBroker.existingConfigMap.name | string | `nil` | Name of a pre-existing configmap containing the message broker URL |
| configuration.messageBroker.existingSecret.keys.password | string | `"BROKER_PASSWORD"` | Key within the secret holding the message broker password |
| configuration.messageBroker.existingSecret.keys.username | string | `"BROKER_USERNAME"` | Key within the secret holding the message broker username |
| configuration.messageBroker.existingSecret.name | string | `nil` | Name of a pre-existing secret containing message broker credentials |
| configuration.messageBroker.password | string | `nil` | Password to authenticate to the message broker |
| configuration.messageBroker.url | string | `nil` | Message Broker URL |
| configuration.messageBroker.username | string | `nil` | Username to authenticate to the message broker |
| configuration.repository.existingConfigMap | string | `nil` | a configmap containing the "alfresco-global.properties" key populated with actual Alfresco repository properties see [details](./docs/repository-properties.md) |
| configuration.repository.existingSecrets | list | `[{"key":"license.lic","name":"repository-secrets","purpose":"acs-license"}]` | A list of secrets to make available to the repository as env vars. This list can contain special secrets marked with predefined `purpose`: `acs-license` to pass license as a secret or subsystems:*:* to configure an Alfresco subsystem. See [Configuring Alfresco Subsystem](./docs/subsystems.md) for more details. |
| configuration.search.existingConfigMap.keys.flavor | string | `"SEARCH_FLAVOR"` | configmap key where to find the search engine used |
| configuration.search.existingConfigMap.keys.host | string | `"SEARCH_HOST"` | configmap key where to find the hostname part of the search URL. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter. |
| configuration.search.existingConfigMap.keys.port | string | `"SEARCH_PORT"` | configmap key where to find the port part of the search URL. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter. |
| configuration.search.existingConfigMap.keys.securecomms | string | `"SEARCH_SECURECOMMS"` | configmap key where to find the search communication security type. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter. |
| configuration.search.existingConfigMap.keys.solr_base_url | string | `"SOLR_BASE_URL"` | configmap key where to find the root path to Solr. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter. Not applicable to Elasticsearch |
| configuration.search.existingConfigMap.keys.url | string | `"SEARCH_URL"` | Key within the configmap  holding the search service URL. |
| configuration.search.existingConfigMap.name | string | `nil` | Optional configmap containing the search service URL |
| configuration.search.existingSecret.keys.password | string | `"ELASTICSEARCH_PASSWORD"` | Key within the secret holding the search service password |
| configuration.search.existingSecret.keys.solr-secret | string | `"SOLR_SECRET"` | Key within the secret holding the index shared secret |
| configuration.search.existingSecret.keys.username | string | `"ELASTICSEARCH_USERNAME"` | Key within the secret holding the search service username |
| configuration.search.existingSecret.name | string | `nil` | Optional secret containing search service credentials |
| configuration.search.flavor | string | `"noindex"` | Can be either `solr`, `elasticsearch` or `noindex` |
| configuration.search.password | string | `nil` | Password to authenticate to the search service |
| configuration.search.solr-secret | string | `nil` | Solr inter process shared secret |
| configuration.search.url | string | `nil` | URL where the search service can be found |
| configuration.search.username | string | `nil` | Username to authenticate to the search service |
| configuration.smtp | object | see below | Basic SMTP capabilities config (limited to enabling/disabling). In order to pass more SMTP properties and configure the subsystem more deeply, please use value `environment.CATALINA_OPTS` or `configuration.repository.existingConfigMap` and check the [available properties for this subsystem](https://github.com/Alfresco/alfresco-community-repo/blob/master/repository/src/main/resources/alfresco/subsystems/email/InboundSMTP/inboundSMTP.properties) |
| configuration.smtp.enabled | bool | `false` | Enable/Disable Alfresco repository SMTP capabilities |
| configuration.smtp.port | int | `1025` | port to use to listen for SMTP clients |
| configuration.smtp.service.annotations | string | `nil` | Use annations to get custom behavior of the loadbalancer exposing the service |
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
| image.tag | string | `"23.4.0"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{"nginx.ingress.kubernetes.io/affinity":"cookie","nginx.ingress.kubernetes.io/proxy-body-size":"5g","nginx.ingress.kubernetes.io/session-cookie-hash":"sha1","nginx.ingress.kubernetes.io/session-cookie-name":"alfrescoRepo"}` | provide annotations for nginx ingress (no toher ingress is supported at that point) |
| ingress.className | string | `"nginx"` | supported ingress class |
| ingress.enabled | bool | `true` | Toggle ingress |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.hosts[0].paths[1].path | string | `"/api-explorer"` |  |
| ingress.hosts[0].paths[1].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| initContainers.waitDbReady.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.waitDbReady.image.repository | string | `"busybox"` |  |
| initContainers.waitDbReady.image.tag | string | `"1.37.0"` |  |
| initContainers.waitDbReady.resources.limits.cpu | string | `"250m"` |  |
| initContainers.waitDbReady.resources.limits.memory | string | `"20Mi"` |  |
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
| resources.requests.cpu | string | `"2"` |  |
| resources.requests.memory | string | `"2Gi"` |  |
| securityContext | object | `{}` |  |
| service.name | string | `"repository"` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"alfresco-repo-sa"` |  |
| startupProbe.failureThreshold | int | `9` |  |
| startupProbe.httpGet.path | string | `"/alfresco/api/-default-/public/alfresco/versions/1/probes/-live-"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| startupProbe.periodSeconds | int | `20` |  |
| startupProbe.timeoutSeconds | int | `3` |  |
| strategy.rollingUpdate.maxSurge | int | `1` |  |
| strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| strategy.type | string | `"RollingUpdate"` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| terminationGracePeriod | int | `60` | How long to wait for tomcat to complete shutdown before killing it |
| tolerations | list | `[]` |  |
