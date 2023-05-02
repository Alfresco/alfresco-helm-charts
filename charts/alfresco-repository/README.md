# alfresco-repository

![Version: 0.1.0-0](https://img.shields.io/badge/Version-0.1.0--0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 7.4.0-M3](https://img.shields.io/badge/AppVersion-7.4.0--M3-informational?style=flat-square)

A Helm chart for installing Alfresco Repository together with Share

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.0.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 1.0.0 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.enabled | bool | `false` | Enable embedded broker - useful when testing this chart in standalone |
| alfresco-sync-service.enabled | bool | `false` |  |
| apiexplorer.ingress.path | string | `"/api-explorer"` |  |
| database.driver | string | `nil` | Postgresql jdbc driver name ex: org.postgresql.Driver. It should be available in the container image. |
| database.existingSecretName | string | `nil` | An existing secret that contains DATABASE_USERNAME and DATABASE_PASSWORD keys. When using embedded postgres you need to also set `postgresql.existingSecret`. |
| database.external | bool | `false` | Enable using an external database for Alfresco Content Services. Must disable `postgresql.enabled` when true. |
| database.password | string | `nil` | External Postgresql database password |
| database.secretName | string | `"acs-alfresco-cs-dbsecret"` | Name of the secret managed by this chart |
| database.url | string | `nil` | External Postgresql jdbc url ex: `jdbc:postgresql://oldfashioned-mule-postgresql-acs:5432/alfresco` |
| database.user | string | `nil` | External Postgresql database user |
| email | object | `{"handler":{"folder":{"overwriteDuplicates":true}},"inbound":{"emailContributorsAuthority":"EMAIL_CONTRIBUTORS","enabled":false,"unknownUser":"anonymous"},"initContainers":{"pemToKeystore":{"image":{"pullPolicy":"IfNotPresent","repository":"registry.access.redhat.com/redhat-sso-7/sso71-openshift","tag":"1.1-16"}},"pemToTruststore":{"image":{"pullPolicy":"IfNotPresent","repository":"registry.access.redhat.com/redhat-sso-7/sso71-openshift","tag":"1.1-16"}},"setPerms":{"image":{"pullPolicy":"IfNotPresent","repository":"busybox","tag":"1.35.0"}}},"server":{"allowed":{"senders":".*"},"auth":{"enabled":true},"blocked":{"senders":null},"connections":{"max":3},"domain":null,"enableTLS":true,"enabled":false,"hideTLS":false,"port":1125,"requireTLS":false},"ssl":{"secretName":null}}` | For a full information of configuring the inbound email system, see https://docs.alfresco.com/content-services/latest/config/email/#manage-inbound-emails |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| global.elasticsearch | object | `{"existingSecretName":null,"host":null,"password":null,"port":null,"protocol":null,"user":null}` | Shared connections details for search subsystem based on Elasticsearch/Opensearch |
| global.elasticsearch.existingSecretName | string | `nil` | Alternatively, provide connection details via an existing secret that contains ELASTICSEARCH_USERNAME and ELASTICSEARCH_PASSWORD keys |
| global.elasticsearch.host | string | `nil` | The host where service is available |
| global.elasticsearch.password | string | `nil` | The password required to access the service, if any |
| global.elasticsearch.port | string | `nil` | The port where service is available |
| global.elasticsearch.protocol | string | `nil` | Valid values are http or https |
| global.elasticsearch.user | string | `nil` | The username required to access the service, if any |
| global.strategy.rollingUpdate.maxSurge | int | `1` |  |
| global.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| global.tracking.auth | string | `"secret"` | Select how solr and repo authenticate to each other none: work only prior to acs 7.2 (and was the default) secret: use a shared secret (to specify using `tracking.sharedsecret`) https: to use mTLS auth (require appropriate certificate configuration) |
| global.tracking.sharedsecret | string | `nil` | Shared secret to authenticate repo/solr traffic. Strong enough secret can be generated with `openssl rand 20 -base64` |
| imap | object | `{"mail":{"from":{"default":null},"to":{"default":null}},"server":{"enabled":false,"host":"0.0.0.0","imap":{"enabled":true},"imaps":{"enabled":true,"port":1144},"port":1143}}` | For a full information of configuring the imap subsystem, see https://docs.alfresco.com/content-services/latest/config/email/#enable-imap-protocol-using-alfresco-globalproperties |
| mail | object | `{"encoding":"UTF-8","existingSecretName":null,"from":{"default":null,"enabled":false},"host":null,"password":null,"port":25,"protocol":"smtps","smtp":{"auth":true,"debug":false,"starttls":{"enable":true},"timeout":30000},"smtps":{"auth":true,"starttls":{"enable":true}},"username":null}` | For a full information of configuring the outbound email system, see https://docs.alfresco.com/content-services/latest/config/email/#manage-outbound-emails |
| mail.existingSecretName | string | `nil` | An existing kubernetes secret that contains MAIL_PASSWORD as per `mail.password` value |
| mail.from.default | string | `nil` | Specifies the email address from which email notifications are sent |
| mail.host | string | `nil` | SMTP(S) host server to enable delivery of site invitations, activity notifications and workflow tasks by email |
| messageBroker | object | `{"existingSecretName":null,"password":null,"secretName":"acs-alfresco-cs-brokersecret","url":null,"user":null}` | external activemq connection settings when activemq.enabled=false |
| messageBroker.existingSecretName | string | `nil` | Alternatively, provide credentials via an existing secret that contains BROKER_URL, BROKER_USERNAME and BROKER_PASSWORD keys |
| messageBroker.secretName | string | `"acs-alfresco-cs-brokersecret"` | Name of the secret created by this chart when an existing is not provided |
| metadataKeystore.defaultKeyPassword | string | `"oKIWzVdEdA"` |  |
| metadataKeystore.defaultKeystorePassword | string | `"mp6yc0UD9e"` |  |
| postgresql.auth.database | string | `"alfresco"` |  |
| postgresql.auth.existingSecret | string | `nil` |  |
| postgresql.auth.password | string | `"alfresco"` |  |
| postgresql.auth.username | string | `"alfresco"` |  |
| postgresql.commonAnnotations.application | string | `"alfresco-content-services"` |  |
| postgresql.enabled | bool | `true` | Toggle embedded postgres for Alfresco Content Services repository Check [PostgreSQL Bitnami chart Documentation](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) |
| postgresql.image.pullPolicy | string | `"IfNotPresent"` |  |
| postgresql.image.tag | string | `"14.4.0"` |  |
| postgresql.nameOverride | string | `"postgresql-acs"` |  |
| postgresql.primary.extendedConfiguration | string | `"max_connections = 250\nshared_buffers = 512MB\neffective_cache_size = 2GB\nwal_level = minimal\nmax_wal_senders = 0\nmax_replication_slots = 0\nlog_min_messages = LOG\n"` |  |
| postgresql.primary.persistence.existingClaim | string | `nil` | provide an existing persistent volume claim name to persist SQL data Make sure the root folder has the appropriate permissions/ownhership set. |
| postgresql.primary.persistence.storageClass | string | `nil` | set the storageClass to use for dynamic provisioning. setting it to null means "default storageClass". |
| postgresql.primary.persistence.subPath | string | `"alfresco-content-services/database-data"` |  |
| postgresql.primary.resources.limits.cpu | string | `"8"` |  |
| postgresql.primary.resources.limits.memory | string | `"8192Mi"` |  |
| postgresql.primary.resources.requests.cpu | string | `"0.5"` |  |
| postgresql.primary.resources.requests.memory | string | `"1500Mi"` |  |
| repository.adminPassword | string | `"209c6174da490caeb422f3fa5a7ae634"` | Administrator password for ACS in NTLM hash format to set at bootstrap time |
| repository.command | list | `[]` |  |
| repository.edition | string | `"Enterprise"` |  |
| repository.environment.JAVA_OPTS | string | `"-Dtransform.service.enabled=true -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80 -Dencryption.keystore.type=JCEKS -Dencryption.cipherAlgorithm=DESede/CBC/PKCS5Padding -Dencryption.keyAlgorithm=DESede -Dencryption.keystore.location=/usr/local/tomcat/shared/classes/alfresco/extension/keystore/keystore -Dmetadata-keystore.aliases=metadata -Dmetadata-keystore.metadata.algorithm=DESede"` |  |
| repository.existingSecretName | string | `nil` | An existing secret that contains REPO_ADMIN_PASSWORD as an alternative for `repository.adminPassword` value |
| repository.extraInitContainers | list | `[]` |  |
| repository.extraLogStatements | object | `{}` | Provide additional log statements by adding classes and/or packages in a key:value maner org.alfresco.repo.content.transform.TransformerDebug: debug |
| repository.extraSideContainers | list | `[]` |  |
| repository.extraVolumeMounts | list | `[]` |  |
| repository.extraVolumes | list | `[]` |  |
| repository.image.hazelcastPort | int | `5701` |  |
| repository.image.internalPort | int | `8080` |  |
| repository.image.pullPolicy | string | `"IfNotPresent"` |  |
| repository.image.repository | string | `"quay.io/alfresco/alfresco-content-repository"` |  |
| repository.image.tag | string | `"7.4.0-M3"` |  |
| repository.index.subsystem | string | `"solr6"` | The search service to use, between none, solr6 or elasticsearch |
| repository.ingress.annotations | object | `{}` |  |
| repository.ingress.maxUploadSize | string | `"5g"` |  |
| repository.ingress.path | string | `"/"` |  |
| repository.ingress.tls | list | `[]` |  |
| repository.initContainers.db.image.pullPolicy | string | `"IfNotPresent"` |  |
| repository.initContainers.db.image.repository | string | `"busybox"` |  |
| repository.initContainers.db.image.tag | string | `"1.35.0"` |  |
| repository.initContainers.db.resources.limits.cpu | string | `"0.25"` |  |
| repository.initContainers.db.resources.limits.memory | string | `"10Mi"` |  |
| repository.initContainers.db.securityContext.runAsUser | int | `1000` |  |
| repository.licenseSecret | string | `nil` | The name of the secret holding the ACS repository license if any. it must be contained within a `data['*.lic']` property For details on how to manage license, see: https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/examples/alf_license.md |
| repository.livenessProbe.initialDelaySeconds | int | `130` |  |
| repository.livenessProbe.periodSeconds | int | `20` |  |
| repository.livenessProbe.timeoutSeconds | int | `10` |  |
| repository.nodeSelector | object | `{}` |  |
| repository.persistence.accessModes | list | `["ReadWriteMany"]` | Specify a storageClass for dynamic provisioning |
| repository.persistence.baseSize | string | `"20Gi"` |  |
| repository.persistence.data.mountPath | string | `"/usr/local/tomcat/alf_data"` |  |
| repository.persistence.data.subPath | string | `"alfresco-content-services/repository-data"` |  |
| repository.persistence.enabled | bool | `true` | Persist repository data |
| repository.persistence.existingClaim | string | `nil` | Use pre-provisioned pv through its claim (e.g. static provisioning) |
| repository.persistence.storageClass | string | `nil` | Bind PVC based on storageClass (e.g. dynamic provisioning) |
| repository.podSecurityContext.fsGroup | int | `1000` |  |
| repository.podSecurityContext.runAsGroup | int | `1000` |  |
| repository.podSecurityContext.runAsNonRoot | bool | `true` |  |
| repository.podSecurityContext.runAsUser | int | `33000` |  |
| repository.readinessProbe.failureThreshold | int | `6` |  |
| repository.readinessProbe.initialDelaySeconds | int | `60` |  |
| repository.readinessProbe.periodSeconds | int | `20` |  |
| repository.readinessProbe.timeoutSeconds | int | `10` |  |
| repository.replicaCount | int | `2` |  |
| repository.resources.limits.cpu | string | `"4"` |  |
| repository.resources.limits.memory | string | `"3000Mi"` |  |
| repository.resources.requests.cpu | string | `"1"` |  |
| repository.resources.requests.memory | string | `"1500Mi"` |  |
| repository.service.externalPort | int | `80` |  |
| repository.service.name | string | `"alfresco"` |  |
| repository.service.type | string | `"ClusterIP"` |  |
| repository.startupProbe | object | `{"failureThreshold":10,"periodSeconds":30}` | The startup probe to cover the worse case startup time for slow clusters |
| repository.strategy.type | string | `"Recreate"` |  |
| s3connector.config.bucketLocation | string | `nil` |  |
| s3connector.config.bucketName | string | `nil` |  |
| s3connector.enabled | bool | `false` | Enable the S3 Connector For a full list of properties on the S3 connector see: https://docs.alfresco.com/s3connector/references/s3-contentstore-ref-config-props.html |
| s3connector.existingSecretName | string | `nil` | An existing kubernetes secret that contains ACCESSKEY, SECRETKEY, ENCRYPTION, KMSKEYID keys |
| s3connector.secrets.accessKey | string | `nil` |  |
| s3connector.secrets.awsKmsKeyId | string | `nil` |  |
| s3connector.secrets.encryption | string | `nil` |  |
| s3connector.secrets.secretKey | string | `nil` |  |
| share | object | `{"command":[],"environment":{"CATALINA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"},"extraInitContainers":[],"extraSideContainers":[],"extraVolumeMounts":[],"extraVolumes":[],"image":{"internalPort":8080,"pullPolicy":"IfNotPresent","repository":"quay.io/alfresco/alfresco-share","tag":"7.4.0-M3"},"ingress":{"annotations":{},"path":"/share","tls":[]},"livenessProbe":{"initialDelaySeconds":200,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"podSecurityContext":{"runAsNonRoot":true},"readinessProbe":{"initialDelaySeconds":60,"periodSeconds":20,"timeoutSeconds":15},"replicaCount":1,"resources":{"limits":{"cpu":"4","memory":"2000Mi"},"requests":{"cpu":"1","memory":"512Mi"}},"securityContext":{"capabilities":{"drop":["NET_RAW","ALL"]},"runAsNonRoot":false},"service":{"externalPort":80,"name":"share","type":"ClusterIP"}}` | Define the alfresco-share properties to use in the k8s cluster This is the default presentation layer(UI) of Alfresco Content Services |
| solr6 | object | `{"context":"/solr","host":null,"port":null}` | Connections details for Search subsystem based on Solr6 |
| solr6.context | string | `"/solr"` | Context for the Solr6 instance |
| solr6.host | string | `nil` | Host dns/ip of Solr6 instance |
| solr6.port | string | `nil` | Port of the Solr6 instance |
| transformmisc.enabled | bool | `false` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
