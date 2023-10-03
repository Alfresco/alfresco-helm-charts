# alfresco-repository

![Version: 0.1.0-alpha.14](https://img.shields.io/badge/Version-0.1.0--alpha.14-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.1.0-A21](https://img.shields.io/badge/AppVersion-23.1.0--A21-informational?style=flat-square)

Alfresco content repository Helm chart

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.0.0-alpha.2 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Values

<table>
	<thead>
		<th>Key</th>
		<th>Type</th>
		<th>Default</th>
		<th>Description</th>
	</thead>
	<tbody>
		<tr>
			<td>affinity</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>args</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>command</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>configuration.db.driver</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>JDBC driver class of the driver if none is provided the it is guessed from the URL provided</td>
		</tr>
		<tr>
			<td>configuration.db.existingConfigMap.keys.driver</td>
			<td>string</td>
			<td><pre lang="json">
"DATABASE_DRIVER"
</pre>
</td>
			<td>configmap key where to find the JDBC driver class to use. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter.</td>
		</tr>
		<tr>
			<td>configuration.db.existingConfigMap.keys.host</td>
			<td>string</td>
			<td><pre lang="json">
"DATABASE_HOST"
</pre>
</td>
			<td>configmap key where to find the hostname part of the database URL. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter.</td>
		</tr>
		<tr>
			<td>configuration.db.existingConfigMap.keys.port</td>
			<td>string</td>
			<td><pre lang="json">
"DATABASE_PORT"
</pre>
</td>
			<td>configmap key where to find the port part of the database URL. The configmap may leverage the alfresco-repository.db.cm named template to auto-generate it from the sole url parameter.</td>
		</tr>
		<tr>
			<td>configuration.db.existingConfigMap.keys.url</td>
			<td>string</td>
			<td><pre lang="json">
"DATABASE_URL"
</pre>
</td>
			<td>configmap key where to find the URL of the database</td>
		</tr>
		<tr>
			<td>configuration.db.existingConfigMap.name</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>configuration.db.existingSecret</td>
			<td>object</td>
			<td><pre lang="json">
{
  "keys": {
    "password": "DATABASE_PASSWORD",
    "username": "DATABASE_USERNAME"
  },
  "name": null
}
</pre>
</td>
			<td>Existing secret and their keys where to find the database username & password.</td>
		</tr>
		<tr>
			<td>configuration.db.existingSecret.keys.password</td>
			<td>string</td>
			<td><pre lang="json">
"DATABASE_PASSWORD"
</pre>
</td>
			<td>Key within the secret holding the database password</td>
		</tr>
		<tr>
			<td>configuration.db.existingSecret.keys.username</td>
			<td>string</td>
			<td><pre lang="json">
"DATABASE_USERNAME"
</pre>
</td>
			<td>Key within the secret holding the database username</td>
		</tr>
		<tr>
			<td>configuration.db.existingSecret.name</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Name of a pre-existing secret containing database credentials</td>
		</tr>
		<tr>
			<td>configuration.db.password</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Password to authentication to the repository database</td>
		</tr>
		<tr>
			<td>configuration.db.url</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>JDBC url of the database This is a mandatory parameter</td>
		</tr>
		<tr>
			<td>configuration.db.username</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Username to authentication to the repository database</td>
		</tr>
		<tr>
			<td>configuration.hz.port</td>
			<td>int</td>
			<td><pre lang="json">
5701
</pre>
</td>
			<td>Hazelcast listener port Only change it if you use a custom image where the port has been changed from default</td>
		</tr>
		<tr>
			<td>configuration.imap</td>
			<td>object</td>
			<td><pre lang="">
see below
</pre>
</td>
			<td>Basic IMAP capabilities config (limited to enabling/disabling). In order to pass more IMAP properties and configure the subsystem more deeply, please use value `environment.CATALINA_OPTS` or `configuration.repository.existingConfiMap` and check the [available properties for this subsystem](https://docs.alfresco.com/content-services/latest/config/email/#imap-subsystem-properties)</td>
		</tr>
		<tr>
			<td>configuration.imap.enabled</td>
			<td>bool</td>
			<td><pre lang="json">
false
</pre>
</td>
			<td>Enable/Disable Alfresco repository IMAP capabilities</td>
		</tr>
		<tr>
			<td>configuration.imap.port</td>
			<td>int</td>
			<td><pre lang="json">
1143
</pre>
</td>
			<td>port to use to listen for IMAP clients</td>
		</tr>
		<tr>
			<td>configuration.imap.protocol</td>
			<td>string</td>
			<td><pre lang="json">
"imap"
</pre>
</td>
			<td>Protocol to use to talk to IMAP clients (imap or imaps)</td>
		</tr>
		<tr>
			<td>configuration.imap.service.annotations</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Use annations to get custom behavior of the loadbalancer exposing the service</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.existingConfigMap.keys.url</td>
			<td>string</td>
			<td><pre lang="json">
"BROKER_URL"
</pre>
</td>
			<td>Key within the configmap  holding the message broker URL. It MUST be a failover URL as per the spec below: https://activemq.apache.org/failover-transport-reference.html</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.existingConfigMap.name</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Name of a pre-existing configmap containing the meesage broker URL</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.existingSecret.keys.password</td>
			<td>string</td>
			<td><pre lang="json">
"BROKER_PASSWORD"
</pre>
</td>
			<td>Key within the secret holding the message broker password</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.existingSecret.keys.username</td>
			<td>string</td>
			<td><pre lang="json">
"BROKER_USERNAME"
</pre>
</td>
			<td>Key within the secret holding the message broker username</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.existingSecret.name</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Name of a pre-existing secret containing message broker credentials</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.password</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Password to authenticate to the message broker</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.url</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Message Broker URL</td>
		</tr>
		<tr>
			<td>configuration.messageBroker.username</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Username to authenticate to the message broker</td>
		</tr>
		<tr>
			<td>configuration.repository.existingConfigMap</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>a configmap containing the "alfresco-global.properties" key populated with actual Alfresco repository properties see [details](./doc/repositoryproperties.md#repository-configuration-using-alfresco-global.properties)</td>
		</tr>
		<tr>
			<td>configuration.repository.existingSecrets</td>
			<td>list</td>
			<td><pre lang="json">
[
  {
    "key": "license.lic",
    "name": "repository-secrets",
    "purpose": "acs-license"
  }
]
</pre>
</td>
			<td>A list of secrets to make available to the repository as env vars. This list can contain special secrets marked with predifined `purpose`: `acs-license` to pass license as a secret or subsystems:*:* to configure an Alfresco subsystem. See [Configuring Alfresco Subsystem](./docs/subsystems.md) for more details.</td>
		</tr>
		<tr>
			<td>configuration.search.existingConfigMap.keys.flavor</td>
			<td>string</td>
			<td><pre lang="json">
"SEARCH_FLAVOR"
</pre>
</td>
			<td>configmap key where to find the search engine used</td>
		</tr>
		<tr>
			<td>configuration.search.existingConfigMap.keys.host</td>
			<td>string</td>
			<td><pre lang="json">
"SEARCH_HOST"
</pre>
</td>
			<td>configmap key where to find the hostname part of the search URL. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter.</td>
		</tr>
		<tr>
			<td>configuration.search.existingConfigMap.keys.port</td>
			<td>string</td>
			<td><pre lang="json">
"SEARCH_PORT"
</pre>
</td>
			<td>configmap key where to find the port part of the search URL. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter.</td>
		</tr>
		<tr>
			<td>configuration.search.existingConfigMap.keys.securecomms</td>
			<td>string</td>
			<td><pre lang="json">
"SEARCH_SECURECOMMS"
</pre>
</td>
			<td>configmap key where to find the search communication security type. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter.</td>
		</tr>
		<tr>
			<td>configuration.search.existingConfigMap.keys.solr_base_url</td>
			<td>string</td>
			<td><pre lang="json">
"SOLR_BASE_URL"
</pre>
</td>
			<td>configmap key where to find the root path to Solr. The configmap may leverage the alfresco-repository.solr.cm named template to auto-generate it from the sole url parameter. Not applicable to Elasticsearch</td>
		</tr>
		<tr>
			<td>configuration.search.existingConfigMap.keys.url</td>
			<td>string</td>
			<td><pre lang="json">
"SEARCH_URL"
</pre>
</td>
			<td>Key within the configmap  holding the search service URL.</td>
		</tr>
		<tr>
			<td>configuration.search.existingConfigMap.name</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Optional configmap containing the search service URL</td>
		</tr>
		<tr>
			<td>configuration.search.existingSecret.keys.password</td>
			<td>string</td>
			<td><pre lang="json">
"ELASTICSEARCH_PASSWORD"
</pre>
</td>
			<td>Key within the secret holding the search service password</td>
		</tr>
		<tr>
			<td>configuration.search.existingSecret.keys.solr-secret</td>
			<td>string</td>
			<td><pre lang="json">
"SOLR_SECRET"
</pre>
</td>
			<td>Key within the secret holding the index shared secret</td>
		</tr>
		<tr>
			<td>configuration.search.existingSecret.keys.username</td>
			<td>string</td>
			<td><pre lang="json">
"ELASTICSEARCH_USERNAME"
</pre>
</td>
			<td>Key within the secret holding the search service username</td>
		</tr>
		<tr>
			<td>configuration.search.existingSecret.name</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Optional secret containing search service credentials</td>
		</tr>
		<tr>
			<td>configuration.search.flavor</td>
			<td>string</td>
			<td><pre lang="json">
"noindex"
</pre>
</td>
			<td>Can be either `solr`, `elasticsearch` or `noindex`</td>
		</tr>
		<tr>
			<td>configuration.search.password</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Password to authenticate to the search service</td>
		</tr>
		<tr>
			<td>configuration.search.solr-secret</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Solr inter process shared secret</td>
		</tr>
		<tr>
			<td>configuration.search.url</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>URL where the search service can be found</td>
		</tr>
		<tr>
			<td>configuration.search.username</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Username to authenticate to the search service</td>
		</tr>
		<tr>
			<td>configuration.smtp</td>
			<td>object</td>
			<td><pre lang="">
see below
</pre>
</td>
			<td>Basic SMTP capabilities config (limited to enabling/disabling). In order to pass more SMTP properties and configure the subsystem more deeply, please use value `environment.CATALINA_OPTS` or `configuration.repository.existingConfiMap` and check the [available properties for this subsystem](https://github.com/Alfresco/alfresco-community-repo/blob/master/repository/src/main/resources/alfresco/subsystems/email/InboundSMTP/inboundSMTP.properties)</td>
		</tr>
		<tr>
			<td>configuration.smtp.enabled</td>
			<td>bool</td>
			<td><pre lang="json">
false
</pre>
</td>
			<td>Enable/Disable Alfresco repository SMTP capabilities</td>
		</tr>
		<tr>
			<td>configuration.smtp.port</td>
			<td>int</td>
			<td><pre lang="json">
1025
</pre>
</td>
			<td>port to use to listen for SMTP clients</td>
		</tr>
		<tr>
			<td>configuration.smtp.service.annotations</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Use annations to get custom behavior of the loadbalancer exposing the service</td>
		</tr>
		<tr>
			<td>environment.CATALINA_OPTS</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Java or Tomcat system properties. These properties must be provided as a single string following the pattern "-Dproperty=value -Dmoreprop=morevalue". They override the content of the global properties file but you should prefer providing configuration.repository.existingConfigMap.</td>
		</tr>
		<tr>
			<td>environment.JAVA_OPTS</td>
			<td>string</td>
			<td><pre lang="json">
"-XX:MaxRAMPercentage=80"
</pre>
</td>
			<td>Set JVM options</td>
		</tr>
		<tr>
			<td>extraInitContainers</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>extraSideContainers</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>extraVolumeMounts</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>extraVolumes</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>fullnameOverride</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>global.alfrescoRegistryPullSecrets</td>
			<td>string</td>
			<td><pre lang="json">
"quay-registry-secret"
</pre>
</td>
			<td>If a private image registry a secret can be defined and passed to kubernetes, see: https://github.com/Alfresco/acs-deployment/blob/a924ad6670911f64f1bba680682d266dd4ea27fb/docs/helm/eks-deployment.md#docker-registry-secret</td>
		</tr>
		<tr>
			<td>global.known_urls</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>a fallback for .Values.known_urls that can be shared between charts</td>
		</tr>
		<tr>
			<td>image.port</td>
			<td>int</td>
			<td><pre lang="json">
8080
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>image.pullPolicy</td>
			<td>string</td>
			<td><pre lang="json">
"IfNotPresent"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>image.repository</td>
			<td>string</td>
			<td><pre lang="json">
"quay.io/alfresco/alfresco-content-repository"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>image.tag</td>
			<td>string</td>
			<td><pre lang="json">
"23.1.0-A21"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>imagePullSecrets</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>ingress.annotations</td>
			<td>object</td>
			<td><pre lang="json">
{
  "nginx.ingress.kubernetes.io/affinity": "cookie",
  "nginx.ingress.kubernetes.io/proxy-body-size": "5g",
  "nginx.ingress.kubernetes.io/session-cookie-hash": "sha1",
  "nginx.ingress.kubernetes.io/session-cookie-name": "alfrescoRepo"
}
</pre>
</td>
			<td>provide annotations for nginx ingress (no toher ingress is supported at that point)</td>
		</tr>
		<tr>
			<td>ingress.enabled</td>
			<td>bool</td>
			<td><pre lang="json">
true
</pre>
</td>
			<td>Toggle ingress</td>
		</tr>
		<tr>
			<td>ingress.hosts[0].paths[0].path</td>
			<td>string</td>
			<td><pre lang="json">
"/"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>ingress.hosts[0].paths[0].pathType</td>
			<td>string</td>
			<td><pre lang="json">
"Prefix"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>ingress.tls</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>livenessProbe.httpGet.path</td>
			<td>string</td>
			<td><pre lang="json">
"/alfresco/api/-default-/public/alfresco/versions/1/probes/-live-"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>livenessProbe.httpGet.port</td>
			<td>string</td>
			<td><pre lang="json">
"http"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>livenessProbe.periodSeconds</td>
			<td>int</td>
			<td><pre lang="json">
20
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>livenessProbe.timeoutSeconds</td>
			<td>int</td>
			<td><pre lang="json">
3
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>nameOverride</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>nodeSelector</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>persistence.accessModes</td>
			<td>list</td>
			<td><pre lang="json">
[
  "ReadWriteMany"
]
</pre>
</td>
			<td>Specify a storageClass for dynamic provisioning</td>
		</tr>
		<tr>
			<td>persistence.baseSize</td>
			<td>string</td>
			<td><pre lang="json">
"20Gi"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>persistence.data.mountPath</td>
			<td>string</td>
			<td><pre lang="json">
"/usr/local/tomcat/alf_data"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>persistence.data.subPath</td>
			<td>string</td>
			<td><pre lang="json">
"alfresco-content-services/repository-data"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>persistence.enabled</td>
			<td>bool</td>
			<td><pre lang="json">
false
</pre>
</td>
			<td>Persist Contentsotre data</td>
		</tr>
		<tr>
			<td>persistence.existingClaim</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Use pre-provisioned pv through its claim (e.g. static provisioning)</td>
		</tr>
		<tr>
			<td>persistence.storageClass</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Bind PVC based on storageClass (e.g. dynamic provisioning)</td>
		</tr>
		<tr>
			<td>podAnnotations</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>podSecurityContext.fsGroup</td>
			<td>int</td>
			<td><pre lang="json">
1000
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>podSecurityContext.runAsGroup</td>
			<td>int</td>
			<td><pre lang="json">
1000
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>podSecurityContext.runAsNonRoot</td>
			<td>bool</td>
			<td><pre lang="json">
true
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>podSecurityContext.runAsUser</td>
			<td>int</td>
			<td><pre lang="json">
33000
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>readinessProbe.httpGet.path</td>
			<td>string</td>
			<td><pre lang="json">
"/alfresco/api/-default-/public/alfresco/versions/1/probes/-ready-"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>readinessProbe.httpGet.port</td>
			<td>string</td>
			<td><pre lang="json">
"http"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>readinessProbe.periodSeconds</td>
			<td>int</td>
			<td><pre lang="json">
20
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>readinessProbe.timeoutSeconds</td>
			<td>int</td>
			<td><pre lang="json">
3
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>replicaCount</td>
			<td>int</td>
			<td><pre lang="json">
1
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>resources.limits.cpu</td>
			<td>string</td>
			<td><pre lang="json">
"4"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>resources.limits.memory</td>
			<td>string</td>
			<td><pre lang="json">
"8Gi"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>resources.requests.cpu</td>
			<td>string</td>
			<td><pre lang="json">
"250m"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>resources.requests.memory</td>
			<td>string</td>
			<td><pre lang="json">
"2Gi"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>securityContext</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>service.name</td>
			<td>string</td>
			<td><pre lang="json">
"repository"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>service.port</td>
			<td>int</td>
			<td><pre lang="json">
80
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>service.type</td>
			<td>string</td>
			<td><pre lang="json">
"ClusterIP"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>serviceAccount.annotations</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>serviceAccount.create</td>
			<td>bool</td>
			<td><pre lang="json">
true
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>serviceAccount.name</td>
			<td>string</td>
			<td><pre lang="json">
"alfresco-repo-sa"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>startupProbe.failureThreshold</td>
			<td>int</td>
			<td><pre lang="json">
5
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>startupProbe.httpGet.path</td>
			<td>string</td>
			<td><pre lang="json">
"/alfresco/api/-default-/public/alfresco/versions/1/probes/-live-"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>startupProbe.httpGet.port</td>
			<td>string</td>
			<td><pre lang="json">
"http"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>startupProbe.periodSeconds</td>
			<td>int</td>
			<td><pre lang="json">
30
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>startupProbe.timeoutSeconds</td>
			<td>int</td>
			<td><pre lang="json">
3
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>strategy.rollingUpdate.maxSurge</td>
			<td>int</td>
			<td><pre lang="json">
1
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>strategy.rollingUpdate.maxUnavailable</td>
			<td>int</td>
			<td><pre lang="json">
0
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>strategy.type</td>
			<td>string</td>
			<td><pre lang="json">
"RollingUpdate"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>tags.ci</td>
			<td>bool</td>
			<td><pre lang="json">
false
</pre>
</td>
			<td>A chart tag used for Hyland's CI purpose. Do not set it to true.</td>
		</tr>
		<tr>
			<td>terminationGracePeriod</td>
			<td>int</td>
			<td><pre lang="json">
60
</pre>
</td>
			<td>How long to wait for tomcat to complete shutdown before killing it</td>
		</tr>
		<tr>
			<td>tolerations</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
	</tbody>
</table>

