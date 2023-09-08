# alfresco-repository

![Version: 0.1.0-alpha.8](https://img.shields.io/badge/Version-0.1.0--alpha.8-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.1.0-A21](https://img.shields.io/badge/AppVersion-23.1.0--A21-informational?style=flat-square)

Alfresco content repository Helm chart

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.1.0 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Configuring Alfresco subsystems

This chart offers a simple mechanism to configure Alfresco Subsystems.

The way it's done is pretty simple, one just need to provide a secret which
contains all the configuration files for the subsystems. The secret needs to be
added to the list of `.Values.configuration.repository.existingSecrets`:

```yaml
configuration:
  repository:
    existingSecrets:
      - name: ldap1
        purpose: subsystems:Authentication:ldap
```

For the above configuration to work there are some rules to follow:

* `name` must match both the secret name and the subsystem instance name (in
   case the subsystem name must be referenced somewhere else, e.g. in
  `authentication.chain`)
* `purpose` must be of the form: `subsystems:subsystemName:subsystemType`
* The secret must contain all necessary files to configure the subsystem.
  Usually a bean definition XML file and properties file. (see example below)

### Examples: ContentStore configuration

Creating the subsystem's secret:

Place all the configuration files in a folder on your local system. Sample
files can be extracted from the S3 AMP file. For more details on the content of
the files check out the [Alfresco S3 connector
doc](https://docs.alfresco.com/aws-s3/latest/config/#content-store-subsystems#).

```bash
mkdir s3-config
unzip -d s3-config ~/Downloads/alfresco-s3-connector-5.1.0.amp config/alfresco/subsystems/ContentStore/S3/
tree s3-config
s3-config/
 ├── s3-contentstore-context.xml
 └── s3-contentstore.properties
...
```

> By default subsystem Beans may include other XML files from upper level
> directories. This is not possible with as kubernetes secrets are projected
> down from a single directory (mount point). If your subsystem config does
> this kind of inclusion you'll need to amend the Bean to not use `import`
> statement or import from the current directory.

Create the secret using `kubectl`

```shell
kubectl create secret generic S3 --from-file=s3-config/
```

Pass the following `configuration.repository.existingSecrets` together with the
property to set the new contentstore subsystem as the default contentstore:

```yaml
configuration:
  repository:
    existingSecrets:
      - name: repository-secrets
        key: license.lic
        purpose: acs-license
      - name: S3
        purpose: subsystems:ContentStore:S3
environment:
  CATALINA_OPTS: >-
    -Dfilecontentstore.subsystem.name=S3
```

> As a list, `configuration.repository/existingSecrets` cannot be merged so you
> would need to re-define the license secret to have it deployed.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| args | list | `[]` |  |
| command | list | `[]` |  |
| configuration.db.driver | string | `nil` | JDBC driver class of the driver if none is provided the it is guessed from the URL provided |
| configuration.db.existingConfigMap.keys.driver | string | `"DATABASE_DRIVER"` | configmap key where to find the JDBC driver class to use. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter. |
| configuration.db.existingConfigMap.keys.host | string | `"DATABASE_HOST"` | configmap key where to find the hostname part of the database URL. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter. |
| configuration.db.existingConfigMap.keys.port | string | `"DATABASE_PORT"` | configmap key where to find the port part of the database URL. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter. |
| configuration.db.existingConfigMap.keys.url | string | `"DATABASE_URL"` | configmap key where to find the URL of the database |
| configuration.db.existingConfigMap.name | string | `nil` |  |
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
| configuration.repository.existingSecrets | list | `[{"key":"license.lic","name":"repository-secrets","purpose":"acs-license"}]` | A list of secrets to make available to the repository as env vars. This list can contain special secrets marked with predifined `purpose`: `acs-license` to pass license as a secret or subsystems:*:* to configure an Alfresco subsystem. See [Configuring Alfresco Subsystem](#configuring-alfresco-subsystems) for more details. |
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
| ingress.annotations | object | `{"nginx.ingress.kubernetes.io/affinity":"cookie","nginx.ingress.kubernetes.io/proxy-body-size":"5g","nginx.ingress.kubernetes.io/session-cookie-hash":"sha1","nginx.ingress.kubernetes.io/session-cookie-name":"alfrescoRepo"}` | provide annotations for nginx ingress (no toher ingress is supported at that point) |
| ingress.enabled | bool | `true` | Toggle ingress |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
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

