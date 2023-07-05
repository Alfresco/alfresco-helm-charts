# alfresco-transform-service

![Version: 0.1.0-alpha.0](https://img.shields.io/badge/Version-0.1.0--alpha.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.0.0](https://img.shields.io/badge/AppVersion-3.0.0-informational?style=flat-square)

A Helm chart for deploying Alfresco Transform Services

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.1.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | ai(alfresco-ai-transformer) | 0.1.0-alpha.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.adminUser.password | string | `"admin"` | Default password for the embedded broker admin user |
| activemq.adminUser.user | string | `"admin"` | Default username for the embedded broker admin user |
| activemq.enabled | bool | `false` |  |
| activemq.nameOverride | string | `"activemq"` |  |
| activemq.nodeSelector | object | `{}` | Possibility to choose Node for pod, with a key-value pair label e.g {"kubernetes.io/hostname": multinode-demo-m02} |
| ai.enabled | bool | `false` |  |
| ai.nameOverride | string | `"alfresco-ai"` |  |
| filestore.enabled | bool | `true` |  |
| filestore.environment."scheduler.cleanup.interval" | string | `"86400000"` |  |
| filestore.environment."scheduler.content.age.millis" | string | `"86400000"` |  |
| filestore.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| filestore.image.internalPort | int | `8099` |  |
| filestore.image.pullPolicy | string | `"IfNotPresent"` |  |
| filestore.image.repository | string | `"quay.io/alfresco/alfresco-shared-file-store"` |  |
| filestore.image.tag | string | `"3.0.0"` |  |
| filestore.initContainer.image.pullPolicy | string | `"IfNotPresent"` |  |
| filestore.initContainer.image.repository | string | `"busybox"` |  |
| filestore.initContainer.image.tag | string | `"1.35.0"` |  |
| filestore.initContainer.resources.limits.cpu | string | `"0.50"` |  |
| filestore.initContainer.resources.limits.memory | string | `"10Mi"` |  |
| filestore.livenessProbe.initialDelaySeconds | int | `10` |  |
| filestore.livenessProbe.livenessPercent | int | `150` |  |
| filestore.livenessProbe.livenessSavePeriodSeconds | int | `600` |  |
| filestore.livenessProbe.path | string | `"/live"` |  |
| filestore.livenessProbe.periodSeconds | int | `20` |  |
| filestore.livenessProbe.timeoutSeconds | int | `10` |  |
| filestore.nodeSelector | object | `{}` |  |
| filestore.persistence.accessModes | list | `["ReadWriteOnce"]` | Specify a storageClass for dynamic provisioning |
| filestore.persistence.data.mountPath | string | `"/tmp/Alfresco"` |  |
| filestore.persistence.data.subPath | string | `"alfresco-content-services/filestore-data"` |  |
| filestore.persistence.enabled | bool | `false` | Persist filestore data |
| filestore.persistence.existingClaim | string | `nil` | Use pre-provisioned pv through its claim (e.g. static provisionning) |
| filestore.persistence.storageClass | string | `nil` | Bind PVC based on storageClass (e.g. dynamic provisionning) |
| filestore.podSecurityContext.fsGroup | int | `1000` |  |
| filestore.podSecurityContext.runAsGroup | int | `1000` |  |
| filestore.podSecurityContext.runAsUser | int | `33030` |  |
| filestore.readinessProbe.initialDelaySeconds | int | `20` |  |
| filestore.readinessProbe.path | string | `"/ready"` |  |
| filestore.readinessProbe.periodSeconds | int | `60` |  |
| filestore.readinessProbe.timeoutSeconds | int | `10` |  |
| filestore.replicaCount | int | `1` |  |
| filestore.resources.limits.cpu | string | `"2"` |  |
| filestore.resources.limits.memory | string | `"1Gi"` |  |
| filestore.resources.requests.cpu | string | `"100m"` |  |
| filestore.resources.requests.memory | string | `"250Mi"` |  |
| filestore.service.externalPort | int | `80` |  |
| filestore.service.name | string | `"filestore"` |  |
| filestore.service.type | string | `"ClusterIP"` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| global.strategy.rollingUpdate.maxSurge | int | `1` |  |
| global.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| imagemagick.enabled | bool | `true` |  |
| imagemagick.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| imagemagick.image.internalPort | int | `8090` |  |
| imagemagick.image.pullPolicy | string | `"IfNotPresent"` |  |
| imagemagick.image.repository | string | `"quay.io/alfresco/alfresco-imagemagick"` |  |
| imagemagick.image.tag | string | `"4.0.0"` |  |
| imagemagick.livenessProbe.initialDelaySeconds | int | `10` |  |
| imagemagick.livenessProbe.livenessPercent | int | `150` |  |
| imagemagick.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| imagemagick.livenessProbe.maxTransformSeconds | int | `900` |  |
| imagemagick.livenessProbe.maxTransforms | int | `10000` |  |
| imagemagick.livenessProbe.path | string | `"/live"` |  |
| imagemagick.livenessProbe.periodSeconds | int | `20` |  |
| imagemagick.livenessProbe.timeoutSeconds | int | `10` |  |
| imagemagick.nodeSelector | object | `{}` |  |
| imagemagick.podSecurityContext.runAsNonRoot | bool | `true` |  |
| imagemagick.podSecurityContext.runAsUser | int | `33002` |  |
| imagemagick.readinessProbe.initialDelaySeconds | int | `20` |  |
| imagemagick.readinessProbe.path | string | `"/ready"` |  |
| imagemagick.readinessProbe.periodSeconds | int | `60` |  |
| imagemagick.readinessProbe.timeoutSeconds | int | `10` |  |
| imagemagick.replicaCount | int | `2` |  |
| imagemagick.resources.limits.cpu | string | `"4"` |  |
| imagemagick.resources.limits.memory | string | `"4Gi"` |  |
| imagemagick.resources.requests.cpu | string | `"250m"` |  |
| imagemagick.resources.requests.memory | string | `"250Mi"` |  |
| imagemagick.service.externalPort | int | `80` |  |
| imagemagick.service.name | string | `"imagemagick"` |  |
| imagemagick.service.type | string | `"ClusterIP"` |  |
| libreoffice.enabled | bool | `true` |  |
| libreoffice.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| libreoffice.image.internalPort | int | `8090` |  |
| libreoffice.image.pullPolicy | string | `"IfNotPresent"` |  |
| libreoffice.image.repository | string | `"quay.io/alfresco/alfresco-libreoffice"` |  |
| libreoffice.image.tag | string | `"4.0.0"` |  |
| libreoffice.livenessProbe.initialDelaySeconds | int | `10` |  |
| libreoffice.livenessProbe.livenessPercent | int | `250` |  |
| libreoffice.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| libreoffice.livenessProbe.maxTransformSeconds | int | `1800` |  |
| libreoffice.livenessProbe.maxTransforms | int | `99999` |  |
| libreoffice.livenessProbe.path | string | `"/live"` |  |
| libreoffice.livenessProbe.periodSeconds | int | `20` |  |
| libreoffice.livenessProbe.timeoutSeconds | int | `10` |  |
| libreoffice.nodeSelector | object | `{}` |  |
| libreoffice.podSecurityContext.runAsNonRoot | bool | `true` |  |
| libreoffice.podSecurityContext.runAsUser | int | `33003` |  |
| libreoffice.readinessProbe.initialDelaySeconds | int | `20` |  |
| libreoffice.readinessProbe.path | string | `"/ready"` |  |
| libreoffice.readinessProbe.periodSeconds | int | `60` |  |
| libreoffice.readinessProbe.timeoutSeconds | int | `10` |  |
| libreoffice.replicaCount | int | `2` |  |
| libreoffice.resources.limits.cpu | string | `"4"` |  |
| libreoffice.resources.limits.memory | string | `"4Gi"` |  |
| libreoffice.resources.requests.cpu | string | `"250m"` |  |
| libreoffice.resources.requests.memory | string | `"500Mi"` |  |
| libreoffice.service.externalPort | int | `80` |  |
| libreoffice.service.name | string | `"libreoffice"` |  |
| libreoffice.service.type | string | `"ClusterIP"` |  |
| messageBroker | object | `{"existingSecretName":null,"password":null,"secretName":"acs-alfresco-cs-brokersecret","url":null,"user":null}` | external activemq connection setting when activemq.enabled=false |
| messageBroker.existingSecretName | string | `nil` | Alternatively, provide credentials via an existing secret that contains BROKER_URL, BROKER_USERNAME and BROKER_PASSWORD keys |
| messageBroker.secretName | string | `"acs-alfresco-cs-brokersecret"` | Name of the secret managed by this chart |
| pdfrenderer.enabled | bool | `true` |  |
| pdfrenderer.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| pdfrenderer.image.internalPort | int | `8090` |  |
| pdfrenderer.image.pullPolicy | string | `"IfNotPresent"` |  |
| pdfrenderer.image.repository | string | `"quay.io/alfresco/alfresco-pdf-renderer"` |  |
| pdfrenderer.image.tag | string | `"4.0.0"` |  |
| pdfrenderer.livenessProbe.initialDelaySeconds | int | `10` |  |
| pdfrenderer.livenessProbe.livenessPercent | int | `150` |  |
| pdfrenderer.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| pdfrenderer.livenessProbe.maxTransformSeconds | int | `1200` |  |
| pdfrenderer.livenessProbe.maxTransforms | int | `10000` |  |
| pdfrenderer.livenessProbe.path | string | `"/live"` |  |
| pdfrenderer.livenessProbe.periodSeconds | int | `20` |  |
| pdfrenderer.livenessProbe.timeoutSeconds | int | `10` |  |
| pdfrenderer.nodeSelector | object | `{}` |  |
| pdfrenderer.podSecurityContext.runAsNonRoot | bool | `true` |  |
| pdfrenderer.podSecurityContext.runAsUser | int | `33001` |  |
| pdfrenderer.readinessProbe.initialDelaySeconds | int | `20` |  |
| pdfrenderer.readinessProbe.path | string | `"/ready"` |  |
| pdfrenderer.readinessProbe.periodSeconds | int | `60` |  |
| pdfrenderer.readinessProbe.timeoutSeconds | int | `10` |  |
| pdfrenderer.replicaCount | int | `2` |  |
| pdfrenderer.resources.limits.cpu | string | `"2"` |  |
| pdfrenderer.resources.limits.memory | string | `"2Gi"` |  |
| pdfrenderer.resources.requests.cpu | string | `"100m"` |  |
| pdfrenderer.resources.requests.memory | string | `"250Mi"` |  |
| pdfrenderer.service.externalPort | int | `80` |  |
| pdfrenderer.service.name | string | `"pdfrenderer"` |  |
| pdfrenderer.service.type | string | `"ClusterIP"` |  |
| tika.enabled | bool | `true` |  |
| tika.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| tika.image.internalPort | int | `8090` |  |
| tika.image.pullPolicy | string | `"IfNotPresent"` |  |
| tika.image.repository | string | `"quay.io/alfresco/alfresco-tika"` |  |
| tika.image.tag | string | `"4.0.0"` |  |
| tika.livenessProbe.initialDelaySeconds | int | `30` |  |
| tika.livenessProbe.livenessPercent | int | `400` |  |
| tika.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| tika.livenessProbe.maxTransformSeconds | int | `1800` |  |
| tika.livenessProbe.maxTransforms | int | `10000` |  |
| tika.livenessProbe.path | string | `"/live"` |  |
| tika.livenessProbe.periodSeconds | int | `20` |  |
| tika.livenessProbe.timeoutSeconds | int | `10` |  |
| tika.nodeSelector | object | `{}` |  |
| tika.podSecurityContext.runAsNonRoot | bool | `true` |  |
| tika.podSecurityContext.runAsUser | int | `33004` |  |
| tika.readinessProbe.initialDelaySeconds | int | `30` |  |
| tika.readinessProbe.path | string | `"/ready"` |  |
| tika.readinessProbe.periodSeconds | int | `60` |  |
| tika.readinessProbe.timeoutSeconds | int | `10` |  |
| tika.replicaCount | int | `2` |  |
| tika.resources.limits.cpu | string | `"4"` |  |
| tika.resources.limits.memory | string | `"4Gi"` |  |
| tika.resources.requests.cpu | string | `"250m"` |  |
| tika.resources.requests.memory | string | `"600Mi"` |  |
| tika.service.externalPort | int | `80` |  |
| tika.service.name | string | `"tika"` |  |
| tika.service.type | string | `"ClusterIP"` |  |
| transformmisc.enabled | bool | `true` |  |
| transformmisc.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| transformmisc.image.internalPort | int | `8090` |  |
| transformmisc.image.pullPolicy | string | `"IfNotPresent"` |  |
| transformmisc.image.repository | string | `"quay.io/alfresco/alfresco-transform-misc"` |  |
| transformmisc.image.tag | string | `"4.0.0"` |  |
| transformmisc.livenessProbe.initialDelaySeconds | int | `10` |  |
| transformmisc.livenessProbe.livenessPercent | int | `400` |  |
| transformmisc.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| transformmisc.livenessProbe.maxTransformSeconds | int | `1800` |  |
| transformmisc.livenessProbe.maxTransforms | int | `10000` |  |
| transformmisc.livenessProbe.path | string | `"/live"` |  |
| transformmisc.livenessProbe.periodSeconds | int | `20` |  |
| transformmisc.livenessProbe.timeoutSeconds | int | `10` |  |
| transformmisc.nodeSelector | object | `{}` |  |
| transformmisc.podSecurityContext.runAsNonRoot | bool | `true` |  |
| transformmisc.podSecurityContext.runAsUser | int | `33006` |  |
| transformmisc.readinessProbe.initialDelaySeconds | int | `20` |  |
| transformmisc.readinessProbe.path | string | `"/ready"` |  |
| transformmisc.readinessProbe.periodSeconds | int | `60` |  |
| transformmisc.readinessProbe.timeoutSeconds | int | `10` |  |
| transformmisc.replicaCount | int | `2` |  |
| transformmisc.resources.limits.cpu | string | `"2"` |  |
| transformmisc.resources.limits.memory | string | `"2Gi"` |  |
| transformmisc.resources.requests.cpu | string | `"100m"` |  |
| transformmisc.resources.requests.memory | string | `"250Mi"` |  |
| transformmisc.service.externalPort | int | `80` |  |
| transformmisc.service.name | string | `"transformmisc"` |  |
| transformmisc.service.type | string | `"ClusterIP"` |  |
| transformrouter.enabled | bool | `true` |  |
| transformrouter.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| transformrouter.image.internalPort | int | `8095` |  |
| transformrouter.image.pullPolicy | string | `"IfNotPresent"` |  |
| transformrouter.image.repository | string | `"quay.io/alfresco/alfresco-transform-router"` |  |
| transformrouter.image.tag | string | `"3.0.0"` |  |
| transformrouter.livenessProbe.initialDelaySeconds | int | `20` |  |
| transformrouter.livenessProbe.path | string | `"/actuator/health"` |  |
| transformrouter.livenessProbe.periodSeconds | int | `30` |  |
| transformrouter.livenessProbe.timeoutSeconds | int | `10` |  |
| transformrouter.nodeSelector | object | `{}` |  |
| transformrouter.podSecurityContext.runAsNonRoot | bool | `true` |  |
| transformrouter.podSecurityContext.runAsUser | int | `33016` |  |
| transformrouter.readinessProbe.initialDelaySeconds | int | `20` |  |
| transformrouter.readinessProbe.path | string | `"/actuator/health"` |  |
| transformrouter.readinessProbe.periodSeconds | int | `60` |  |
| transformrouter.readinessProbe.timeoutSeconds | int | `10` |  |
| transformrouter.replicaCount | int | `2` |  |
| transformrouter.resources.limits.cpu | string | `"1"` |  |
| transformrouter.resources.limits.memory | string | `"1Gi"` |  |
| transformrouter.resources.requests.cpu | string | `"100m"` |  |
| transformrouter.resources.requests.memory | string | `"250Mi"` |  |
| transformrouter.service.externalPort | int | `80` |  |
| transformrouter.service.name | string | `"transform-router"` |  |
| transformrouter.service.type | string | `"ClusterIP"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
