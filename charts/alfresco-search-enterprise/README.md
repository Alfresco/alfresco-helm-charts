# alfresco-search-enterprise

![Version: 3.0.0-alpha.1](https://img.shields.io/badge/Version-3.0.0--alpha.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.3.1](https://img.shields.io/badge/AppVersion-3.3.1-informational?style=flat-square)

A Helm chart for deploying Alfresco Elasticsearch connector

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.3.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.0.0-alpha.1 |
| https://helm.elastic.co | elasticsearch | 7.17.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.enabled | bool | `false` | Enable embedded broker - useful when testing this chart in standalone |
| affinity | object | `{}` |  |
| ats.existingConfigMap.keys.sfs_url | string | `"SFS_URL"` | Key within the configmap holding the URL of the alfresco shared filestore |
| ats.existingConfigMap.keys.transform_url | string | `"ATS_URL"` | Key within the configmap holding the URL of the alfresco transform |
| ats.existingConfigMap.name | string | `nil` | Alternatively, provide ATS details via an existing configmap |
| ats.sfs_url | string | `nil` | URL of the alfresco shared filestore |
| ats.transform_url | string | `nil` | URL of the alfresco transform (trouter or tengine-aio) |
| contentMediaTypeCache.enabled | bool | `true` |  |
| contentMediaTypeCache.refreshTime | string | `"0 0 * * * *"` |  |
| elasticsearch.clusterHealthCheckParams | string | `"wait_for_status=yellow&timeout=1s"` |  |
| elasticsearch.enabled | bool | `false` | Enable embedded elasticsearch - useful when using this chart in standalone |
| elasticsearch.replicas | int | `1` |  |
| fullnameOverride | string | `""` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| global.elasticsearch | object | `{"existingSecretName":null,"host":null,"password":null,"port":null,"protocol":null,"user":null}` | Shared connections details for Elasticsearch/Opensearch cluster |
| global.elasticsearch.existingSecretName | string | `nil` | Alternatively, provide connection details via an existing secret that contains ELASTICSEARCH_USERNAME and ELASTICSEARCH_PASSWORD keys |
| global.elasticsearch.host | string | `nil` | The host where service is available |
| global.elasticsearch.password | string | `nil` | The password required to access the service, if any |
| global.elasticsearch.port | string | `nil` | The port where service is available |
| global.elasticsearch.protocol | string | `nil` | Valid values are http or https |
| global.elasticsearch.user | string | `nil` | The username required to access the service, if any |
| imagePullSecrets | list | `[]` |  |
| indexName | string | `"alfresco"` | Name of the existing search index, usually created by repo |
| liveIndexing.content.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.content.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-content"` |  |
| liveIndexing.content.image.tag | string | `"3.3.1"` |  |
| liveIndexing.content.replicaCount | int | `1` |  |
| liveIndexing.mediation.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.mediation.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-mediation"` |  |
| liveIndexing.mediation.image.tag | string | `"3.3.1"` |  |
| liveIndexing.metadata.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.metadata.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-metadata"` |  |
| liveIndexing.metadata.image.tag | string | `"3.3.1"` |  |
| liveIndexing.metadata.replicaCount | int | `1` |  |
| liveIndexing.path.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.path.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-path"` |  |
| liveIndexing.path.image.tag | string | `"3.3.1"` |  |
| liveIndexing.path.replicaCount | int | `1` |  |
| messageBroker.existingSecretName | string | `nil` | Provide connection details alternatively via an existing secret that contains BROKER_URL, BROKER_USERNAME and BROKER_PASSWORD keys |
| messageBroker.password | string | `nil` | Broker password |
| messageBroker.url | string | `nil` | Broker URL formatted as per: https://activemq.apache.org/failover-transport-reference |
| messageBroker.user | string | `nil` | Broker username |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| pathIndexingComponent.enabled | bool | `true` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| reindexing.db.existingConfigMap.keys.url | string | `"DATABASE_URL"` | Key within the configmap holding the full JDBC url to connect to database service |
| reindexing.db.existingConfigMap.name | string | `nil` | Alternatively, provide database connection details via an existing configmap |
| reindexing.db.existingSecret.keys.password | string | `"DATABASE_PASSWORD"` | Key within the secret holding the database password |
| reindexing.db.existingSecret.keys.username | string | `"DATABASE_USERNAME"` | Key within the secret holding the database username |
| reindexing.db.existingSecret.name | string | `nil` | Alternatively, provide database credentials via an existing secret |
| reindexing.db.password | string | `nil` | The password required to access the service |
| reindexing.db.url | string | `nil` | Provide the full JDBC url to connect to database service e.g.: `jdbc:postgresql://hostname:5432/database` |
| reindexing.db.username | string | `nil` | The username required to access the service |
| reindexing.enabled | bool | `true` | Create the one-shot job to trigger the reindexing of repo contents |
| reindexing.image.pullPolicy | string | `"IfNotPresent"` |  |
| reindexing.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-reindexing"` |  |
| reindexing.image.tag | string | `"3.3.1"` |  |
| reindexing.initcontainers.waitForRepository.resources.limits.cpu | string | `"0.25"` |  |
| reindexing.initcontainers.waitForRepository.resources.limits.memory | string | `"10Mi"` |  |
| reindexing.pathIndexingEnabled | bool | `true` |  |
| reindexing.resources.limits.cpu | string | `"2"` |  |
| reindexing.resources.limits.memory | string | `"512Mi"` |  |
| reindexing.resources.requests.cpu | string | `"0.5"` |  |
| reindexing.resources.requests.memory | string | `"128Mi"` |  |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"2048Mi"` |  |
| resources.requests.cpu | string | `"0.5"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| searchIndex | object | `{"existingSecretName":null,"host":null,"password":null,"port":null,"protocol":null,"user":null}` | Overrides .Values.global.elasticsearch |
| searchIndex.existingSecretName | string | `nil` | Alternatively, provide connection details via an an existing secret that contains ELASTICSEARCH_USERNAME and ELASTICSEARCH_PASSWORD keys |
| searchIndex.host | string | `nil` | The host where service is available |
| searchIndex.password | string | `nil` | The password required to access the service, if any |
| searchIndex.port | string | `nil` | The port where service is available |
| searchIndex.protocol | string | `nil` | Valid values are http or https |
| searchIndex.user | string | `nil` | The username required to access the service, if any |
| securityContext | object | `{}` |  |
| tolerations | list | `[]` |  |
