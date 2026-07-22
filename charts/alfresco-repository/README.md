---
title: alfresco-repository
parent: Charts Reference
---

# alfresco-repository

![Version: 1.8.0-alpha.1](https://img.shields.io/badge/Version-1.8.0--alpha.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 26.2.0](https://img.shields.io/badge/AppVersion-26.2.0-informational?style=flat-square)

Alfresco content repository Helm chart

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Service annotations

Use `service.annotations` to add annotations to the repository Kubernetes Service. For example, to enable Traefik sticky sessions:

```yaml
service:
  annotations:
    traefik.ingress.kubernetes.io/service.sticky.cookie: "true"
    traefik.ingress.kubernetes.io/service.sticky.cookie.name: alfrescoRepo
```

## OpenSearch index template creation

When `initContainers.createIndexTemplate.enabled` is `true`, an init container PUTs an index template to the search backend before the repository starts. It supports two authentication modes via `initContainers.createIndexTemplate.auth.mode`:

- `basic` (default): HTTP basic auth using the search credentials, run with `curlimages/curl`. Behaviour is unchanged from previous releases.
- `iam`: AWS SigV4-signed request for IAM-secured AWS OpenSearch Service domains, run with `ghcr.io/okigan/awscurl`. Credentials are resolved automatically from the pod's AWS identity (IRSA), including session tokens — no keys are configured in the chart. Set `initContainers.createIndexTemplate.auth.aws.region` to the domain's region. Annotate the ServiceAccount with the IAM role to assume:

```yaml
serviceAccount:
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::<account-id>:role/<role-name>
initContainers:
  createIndexTemplate:
    enabled: true
    auth:
      mode: iam
      aws:
        region: us-east-1
```

The init container image is selected automatically based on the auth mode; override `initContainers.createIndexTemplate.images.basic.*` or `initContainers.createIndexTemplate.images.iam.*` to pin a different image.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 5.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Additional labels to be added to all resources (deployments, statefulsets, services, pods, etc.) Example:   Product: k8s   Environment: DEV |
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
| configuration.debug | object | see below | Debug port configuration for remote debugging (JDWP) |
| configuration.debug.enabled | bool | `false` | Enable/Disable debug port exposure and JDWP agent |
| configuration.debug.port | int | `8888` | port to use for remote debugging |
| configuration.debug.suspend | string | `"n"` | suspend JVM on startup waiting for debugger (y/n) |
| configuration.hz.port | int | `5701` | Hazelcast listener port Only change it if you use a custom image where the port has been changed from default |
| configuration.imap | object | see below | Basic IMAP capabilities config (limited to enabling/disabling). In order to pass more IMAP properties and configure the subsystem more deeply, please use value `environment.CATALINA_OPTS` or `configuration.repository.existingConfigMap` and check the [available properties for this subsystem](https://docs.hyland.com/r/Alfresco/Alfresco-Content-Services/25.2/Alfresco-Content-Services/Configure/Email/Configure-Email-Client-with-IMAP/IMAP-Subsystem-Properties) |
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
| configuration.search.elasticsearchProperties | object | see below | A map of additional elasticsearch.* properties to be passed as -D arguments to the repository when search.flavor is set to elasticsearch. See more on the [docs](https://docs.hyland.com/r/Alfresco/Alfresco-Search-Enterprise/5.3/Alfresco-Search-Enterprise/Configure/Overview/Alfresco-Repository) |
| configuration.search.elasticsearchProperties."archive.indexName" | string | `"alfresco-archive"` | Name of the archive search index to use. |
| configuration.search.elasticsearchProperties."index.custom.analyzer.config.files" | string | `""` | Custom language analyzer configuration files. Multiple files can be specified as a comma-separated list (e.g. `file:/path/to/file.txt,file:/path/to/file2.txt`). |
| configuration.search.elasticsearchProperties."index.locale" | string | `"en"` | Locale used for the Elasticsearch language analyzer. |
| configuration.search.elasticsearchProperties."index.mapping.total_fields.limit" | int | `7500` | Maximum number of fields allowed in the search index mapping. |
| configuration.search.elasticsearchProperties."index.max_result_window" | int | `10000` | Maximum number of results that can be returned by a single query. |
| configuration.search.elasticsearchProperties."ssl.host.name.verification" | bool | `true` | When using TLS (`https` or `mtls`), whether to verify the server certificate hostname matches. |
| configuration.search.elasticsearchProperties.createIndexIfNotExists | bool | `true` | Automatically create the search index if it does not exist at repository startup. Enabled by default for convenience but it is recommended to disable it in production and create the index with the desired shards/replicas settings beforehand. See also the `initContainers.createIndexTemplate` feature in this chart. |
| configuration.search.elasticsearchProperties.indexName | string | `"alfresco"` | Name of the search index to use. |
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
| global.additionalLabels | object | `{}` | Global additional labels that can be set at parent/umbrella chart level These will be merged with chart-level additionalLabels, with chart-level taking precedence |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| global.ingressClassName | string | `"nginx"` | Global ingress class name override for all ingress resources in this chart |
| global.known_urls | string | `nil` | a fallback for .Values.known_urls that can be shared between charts |
| image.port | int | `8080` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-content-repository"` |  |
| image.tag | string | `"26.2.0"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` | File uploads are limited to 5g |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-read-timeout" | string | `"20m"` | File uploads will timeout after 20 minutes |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-hash" | string | `"sha1"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-name" | string | `"alfrescoRepo"` |  |
| ingress.className | string | `""` | supported ingress class |
| ingress.enabled | bool | `true` | Toggle ingress |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.hosts[0].paths[1].path | string | `"/api-explorer"` |  |
| ingress.hosts[0].paths[1].pathType | string | `"Prefix"` |  |
| ingress.hosts[0].paths[2] | object | `{"path":"/alfresco/s/prometheus","pathType":"Prefix","serviceName":"blocked-prometheus"}` | Block direct access to prometheus endpoint |
| ingress.tls | list | `[]` |  |
| initContainers.createIndexTemplate.auth.aws.region | string | `nil` | AWS region of the OpenSearch domain; required when mode is `iam` |
| initContainers.createIndexTemplate.auth.aws.service | string | `"es"` | AWS service name for SigV4 signing (defaults to `es` for managed OpenSearch/Elasticsearch) |
| initContainers.createIndexTemplate.auth.mode | string | `"basic"` | Authentication mode for the index-template request: `basic` (HTTP basic auth) or `iam` (AWS SigV4, signed with the pod's AWS identity via IRSA) |
| initContainers.createIndexTemplate.enabled | bool | `false` | Whether to create an Elasticsearch index template before starting the repository |
| initContainers.createIndexTemplate.images | object | `{"basic":{"pullPolicy":"IfNotPresent","repository":"curlimages/curl","tag":"8.11.0"},"iam":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/okigan/awscurl","tag":"v0.44"}}` | Init container image per auth mode; the entry matching `auth.mode` is used |
| initContainers.createIndexTemplate.indexName | string | `"alfresco"` | Index name to apply the template to |
| initContainers.createIndexTemplate.numberOfReplicas | int | `0` | Number of replicas for the index |
| initContainers.createIndexTemplate.numberOfShards | int | `1` | Number of shards for the index |
| initContainers.createIndexTemplate.resources.basic.limits.cpu | string | `"250m"` |  |
| initContainers.createIndexTemplate.resources.basic.limits.memory | string | `"20Mi"` |  |
| initContainers.createIndexTemplate.resources.iam.limits.cpu | string | `"250m"` |  |
| initContainers.createIndexTemplate.resources.iam.limits.memory | string | `"256Mi"` |  |
| initContainers.createIndexTemplate.templateName | string | `"alfresco-template"` | Template name for the index template |
| initContainers.waitDbReady.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.waitDbReady.image.repository | string | `"busybox"` |  |
| initContainers.waitDbReady.image.tag | string | `"1.37"` |  |
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
| service.annotations | object | `{}` | Annotations to add to the repository service. |
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
| terminationGracePeriod | int | `60` | How long to wait for tomcat to complete shutdown before killing it |
| tolerations | list | `[]` |  |
