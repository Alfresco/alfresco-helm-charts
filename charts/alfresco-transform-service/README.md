---
title: alfresco-transform-service
parent: Charts Reference
---

# alfresco-transform-service

![Version: 2.1.2](https://img.shields.io/badge/Version-2.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.1.5](https://img.shields.io/badge/AppVersion-4.1.5-informational?style=flat-square)

A Helm chart for deploying Alfresco Transform Services

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.6.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| filestore.affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.filestore.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10},{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.filestore.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}]}}` | Pod affinity, passed thru tpl function |
| filestore.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.filestore.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule on different zones |
| filestore.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.filestore.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule on different nodes |
| filestore.enabled | bool | `true` |  |
| filestore.environment."scheduler.cleanup.interval" | string | `"86400000"` |  |
| filestore.environment."scheduler.content.age.millis" | string | `"86400000"` |  |
| filestore.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| filestore.image.internalPort | int | `8099` |  |
| filestore.image.pullPolicy | string | `"IfNotPresent"` |  |
| filestore.image.repository | string | `"quay.io/alfresco/alfresco-shared-file-store"` |  |
| filestore.image.tag | string | `"4.1.5"` |  |
| filestore.initContainer.image.pullPolicy | string | `"IfNotPresent"` |  |
| filestore.initContainer.image.repository | string | `"busybox"` |  |
| filestore.initContainer.image.tag | string | `"1.35.0"` |  |
| filestore.initContainer.resources.limits.cpu | string | `"0.50"` |  |
| filestore.initContainer.resources.limits.memory | string | `"20Mi"` |  |
| filestore.livenessProbe.initialDelaySeconds | int | `10` |  |
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
| filestore.podAnnotations | object | `{}` |  |
| filestore.podLabels | object | `{}` |  |
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
| filestore.strategy.type | string | `"RollingUpdate"` | Custom strategy for filestore deployment |
| filestore.tolerations | list | `[]` |  |
| filestore.volumeMounts | list | `[]` |  |
| filestore.volumes | list | `[]` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| global.strategy.rollingUpdate.maxSurge | int | `1` |  |
| global.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| imagemagick.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.imagemagick.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule on different zones |
| imagemagick.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.imagemagick.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule on different nodes |
| imagemagick.autoscaling.behavior.scaleDown.policies | list | `[{"periodSeconds":60,"type":"Pods","value":1}]` | list of available policies for scaling down scale down either by one pod or by destroying 25% of the pods (whichever is smaller) |
| imagemagick.autoscaling.behavior.scaleDown.stabilizationWindowSeconds | int | `60` |  |
| imagemagick.autoscaling.behavior.scaleUp.policies | list | `[{"periodSeconds":60,"type":"Percent","value":50},{"periodSeconds":60,"type":"Pods","value":2}]` | list of available policies for scaling up scale up either by one pod or by adding 50% more pods (whichever is bigger) |
| imagemagick.autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `30` |  |
| imagemagick.autoscaling.enabled | bool | `false` | Toggle imagemagick autoscaling |
| imagemagick.autoscaling.maxReplicas | int | `3` | maximum number of replicas to spin up within the replicaset |
| imagemagick.autoscaling.metrics | list | `[{"resource":{"name":"cpu","target":{"averageUtilization":75,"type":"Utilization"}},"type":"Resource"}]` | a list of resource the HPA controller should monitor For more details check https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics |
| imagemagick.autoscaling.minReplicas | int | `1` | minimum number of replicas to spin up within the replicaset |
| imagemagick.enabled | bool | `true` |  |
| imagemagick.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| imagemagick.image.internalPort | int | `8090` |  |
| imagemagick.image.pullPolicy | string | `"IfNotPresent"` |  |
| imagemagick.image.repository | string | `"quay.io/alfresco/alfresco-imagemagick"` |  |
| imagemagick.image.tag | string | `"5.1.5"` |  |
| imagemagick.livenessProbe.initialDelaySeconds | int | `10` |  |
| imagemagick.livenessProbe.livenessPercent | int | `150` |  |
| imagemagick.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| imagemagick.livenessProbe.maxTransformSeconds | int | `900` |  |
| imagemagick.livenessProbe.maxTransforms | int | `10000` |  |
| imagemagick.livenessProbe.path | string | `"/live"` |  |
| imagemagick.livenessProbe.periodSeconds | int | `20` |  |
| imagemagick.livenessProbe.timeoutSeconds | int | `10` |  |
| imagemagick.nodeSelector | object | `{}` |  |
| imagemagick.podAnnotations | object | `{}` |  |
| imagemagick.podLabels | object | `{}` |  |
| imagemagick.podSecurityContext.runAsNonRoot | bool | `true` |  |
| imagemagick.podSecurityContext.runAsUser | int | `33002` |  |
| imagemagick.readinessProbe.initialDelaySeconds | int | `20` |  |
| imagemagick.readinessProbe.path | string | `"/ready"` |  |
| imagemagick.readinessProbe.periodSeconds | int | `30` |  |
| imagemagick.readinessProbe.timeoutSeconds | int | `10` |  |
| imagemagick.replicaCount | int | `2` |  |
| imagemagick.resources.limits.cpu | string | `"4"` |  |
| imagemagick.resources.limits.memory | string | `"4Gi"` |  |
| imagemagick.resources.requests.cpu | string | `"250m"` |  |
| imagemagick.resources.requests.memory | string | `"250Mi"` |  |
| imagemagick.service.externalPort | int | `80` |  |
| imagemagick.service.name | string | `"imagemagick"` |  |
| imagemagick.service.type | string | `"ClusterIP"` |  |
| imagemagick.tolerations | list | `[]` |  |
| imagemagick.volumeMounts | list | `[]` |  |
| imagemagick.volumes | list | `[]` |  |
| libreoffice.affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.libreoffice.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10},{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.libreoffice.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}]}}` | Pod affinity, passed thru tpl function |
| libreoffice.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.libreoffice.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule on different zones |
| libreoffice.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.libreoffice.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule on different nodes |
| libreoffice.autoscaling.behavior.scaleDown.policies | list | `[{"periodSeconds":60,"type":"Pods","value":1}]` | list of available policies for scaling down scale down either by one pod or by destroying 25% of the pods (whichever is smaller) |
| libreoffice.autoscaling.behavior.scaleDown.stabilizationWindowSeconds | int | `60` |  |
| libreoffice.autoscaling.behavior.scaleUp.policies | list | `[{"periodSeconds":60,"type":"Percent","value":50},{"periodSeconds":60,"type":"Pods","value":2}]` | list of available policies for scaling up scale up either by one pod or by adding 50% more pods (whichever is bigger) |
| libreoffice.autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `30` |  |
| libreoffice.autoscaling.enabled | bool | `false` | Toggle libreoffice autoscaling |
| libreoffice.autoscaling.maxReplicas | int | `3` | maximum number of replicas to spin up within the replicaset |
| libreoffice.autoscaling.metrics | list | `[{"resource":{"name":"cpu","target":{"averageUtilization":75,"type":"Utilization"}},"type":"Resource"}]` | a list of resource the HPA controller should monitor For more details check https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics |
| libreoffice.autoscaling.minReplicas | int | `1` | minimum number of replicas to spin up within the replicaset |
| libreoffice.enabled | bool | `true` |  |
| libreoffice.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| libreoffice.image.internalPort | int | `8090` |  |
| libreoffice.image.pullPolicy | string | `"IfNotPresent"` |  |
| libreoffice.image.repository | string | `"quay.io/alfresco/alfresco-libreoffice"` |  |
| libreoffice.image.tag | string | `"5.1.5"` |  |
| libreoffice.livenessProbe.initialDelaySeconds | int | `10` |  |
| libreoffice.livenessProbe.livenessPercent | int | `250` |  |
| libreoffice.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| libreoffice.livenessProbe.maxTransformSeconds | int | `1800` |  |
| libreoffice.livenessProbe.maxTransforms | int | `99999` |  |
| libreoffice.livenessProbe.path | string | `"/live"` |  |
| libreoffice.livenessProbe.periodSeconds | int | `20` |  |
| libreoffice.livenessProbe.timeoutSeconds | int | `10` |  |
| libreoffice.nodeSelector | object | `{}` |  |
| libreoffice.podAnnotations | object | `{}` |  |
| libreoffice.podLabels | object | `{}` |  |
| libreoffice.podSecurityContext.runAsNonRoot | bool | `true` |  |
| libreoffice.podSecurityContext.runAsUser | int | `33003` |  |
| libreoffice.readinessProbe.initialDelaySeconds | int | `20` |  |
| libreoffice.readinessProbe.path | string | `"/ready"` |  |
| libreoffice.readinessProbe.periodSeconds | int | `30` |  |
| libreoffice.readinessProbe.timeoutSeconds | int | `10` |  |
| libreoffice.replicaCount | int | `2` |  |
| libreoffice.resources.limits.cpu | string | `"4"` |  |
| libreoffice.resources.limits.memory | string | `"4Gi"` |  |
| libreoffice.resources.requests.cpu | string | `"250m"` |  |
| libreoffice.resources.requests.memory | string | `"500Mi"` |  |
| libreoffice.service.externalPort | int | `80` |  |
| libreoffice.service.name | string | `"libreoffice"` |  |
| libreoffice.service.type | string | `"ClusterIP"` |  |
| libreoffice.tolerations | list | `[]` |  |
| libreoffice.volumeMounts | list | `[]` |  |
| libreoffice.volumes | list | `[]` |  |
| messageBroker.existingConfigMap.keys.url | string | `"BROKER_URL"` |  |
| messageBroker.existingConfigMap.name | string | `nil` | Alternatively, provide message broker URL via an existing ConfigMap |
| messageBroker.existingSecret.keys.password | string | `"BROKER_PASSWORD"` |  |
| messageBroker.existingSecret.keys.user | string | `"BROKER_USERNAME"` |  |
| messageBroker.existingSecret.name | string | `nil` | Alternatively, provide message broker credentials via an existing Secret |
| messageBroker.password | string | `nil` | Activemq password |
| messageBroker.url | string | `nil` | Activemq connection url (e.g. failover:(nio://my-broker:61616)?timeout=3000&jms.useCompression=true) |
| messageBroker.user | string | `nil` | Activemq username |
| pdfrenderer.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.pdfrenderer.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule on different zones |
| pdfrenderer.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.pdfrenderer.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule on different nodes |
| pdfrenderer.autoscaling.behavior.scaleDown.policies | list | `[{"periodSeconds":60,"type":"Pods","value":1}]` | list of available policies for scaling down scale down either by one pod or by destroying 25% of the pods (whichever is smaller) |
| pdfrenderer.autoscaling.behavior.scaleDown.stabilizationWindowSeconds | int | `60` |  |
| pdfrenderer.autoscaling.behavior.scaleUp.policies | list | `[{"periodSeconds":60,"type":"Percent","value":50},{"periodSeconds":60,"type":"Pods","value":2}]` | list of available policies for scaling up scale up either by one pod or by adding 50% more pods (whichever is bigger) |
| pdfrenderer.autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `30` |  |
| pdfrenderer.autoscaling.enabled | bool | `false` | Toggle pdfrenderer autoscaling |
| pdfrenderer.autoscaling.maxReplicas | int | `3` | maximum number of replicas to spin up within the replicaset |
| pdfrenderer.autoscaling.metrics | list | `[{"resource":{"name":"cpu","target":{"averageUtilization":75,"type":"Utilization"}},"type":"Resource"}]` | a list of resource the HPA controller should monitor For more details check https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics |
| pdfrenderer.autoscaling.minReplicas | int | `1` | minimum number of replicas to spin up within the replicaset |
| pdfrenderer.enabled | bool | `true` |  |
| pdfrenderer.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| pdfrenderer.image.internalPort | int | `8090` |  |
| pdfrenderer.image.pullPolicy | string | `"IfNotPresent"` |  |
| pdfrenderer.image.repository | string | `"quay.io/alfresco/alfresco-pdf-renderer"` |  |
| pdfrenderer.image.tag | string | `"5.1.5"` |  |
| pdfrenderer.livenessProbe.initialDelaySeconds | int | `10` |  |
| pdfrenderer.livenessProbe.livenessPercent | int | `150` |  |
| pdfrenderer.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| pdfrenderer.livenessProbe.maxTransformSeconds | int | `1200` |  |
| pdfrenderer.livenessProbe.maxTransforms | int | `10000` |  |
| pdfrenderer.livenessProbe.path | string | `"/live"` |  |
| pdfrenderer.livenessProbe.periodSeconds | int | `20` |  |
| pdfrenderer.livenessProbe.timeoutSeconds | int | `10` |  |
| pdfrenderer.nodeSelector | object | `{}` |  |
| pdfrenderer.podAnnotations | object | `{}` |  |
| pdfrenderer.podLabels | object | `{}` |  |
| pdfrenderer.podSecurityContext.runAsNonRoot | bool | `true` |  |
| pdfrenderer.podSecurityContext.runAsUser | int | `33001` |  |
| pdfrenderer.readinessProbe.initialDelaySeconds | int | `20` |  |
| pdfrenderer.readinessProbe.path | string | `"/ready"` |  |
| pdfrenderer.readinessProbe.periodSeconds | int | `30` |  |
| pdfrenderer.readinessProbe.timeoutSeconds | int | `10` |  |
| pdfrenderer.replicaCount | int | `2` |  |
| pdfrenderer.resources.limits.cpu | string | `"2"` |  |
| pdfrenderer.resources.limits.memory | string | `"2Gi"` |  |
| pdfrenderer.resources.requests.cpu | string | `"100m"` |  |
| pdfrenderer.resources.requests.memory | string | `"250Mi"` |  |
| pdfrenderer.service.externalPort | int | `80` |  |
| pdfrenderer.service.name | string | `"pdfrenderer"` |  |
| pdfrenderer.service.type | string | `"ClusterIP"` |  |
| pdfrenderer.tolerations | list | `[]` |  |
| pdfrenderer.volumeMounts | list | `[]` |  |
| pdfrenderer.volumes | list | `[]` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tags.ci | bool | `false` | Enable dependencies required for CI. Do not enable. |
| tika.affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.tika.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10},{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.tika.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}]}}` | Pod affinity, passed thru tpl function |
| tika.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.tika.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule on different zones |
| tika.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.tika.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule on different nodes |
| tika.autoscaling.behavior.scaleDown.policies | list | `[{"periodSeconds":60,"type":"Pods","value":1}]` | list of available policies for scaling down scale down either by one pod or by destroying 25% of the pods (whichever is smaller) |
| tika.autoscaling.behavior.scaleDown.stabilizationWindowSeconds | int | `60` |  |
| tika.autoscaling.behavior.scaleUp.policies | list | `[{"periodSeconds":60,"type":"Percent","value":50},{"periodSeconds":60,"type":"Pods","value":2}]` | list of available policies for scaling up scale up either by one pod or by adding 50% more pods (whichever is bigger) |
| tika.autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `30` |  |
| tika.autoscaling.enabled | bool | `false` | Toggle tika autoscaling |
| tika.autoscaling.maxReplicas | int | `3` | maximum number of replicas to spin up within the replicaset |
| tika.autoscaling.metrics | list | `[{"resource":{"name":"cpu","target":{"averageUtilization":75,"type":"Utilization"}},"type":"Resource"}]` | a list of resource the HPA controller should monitor For more details check https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics |
| tika.autoscaling.minReplicas | int | `1` | minimum number of replicas to spin up within the replicaset |
| tika.enabled | bool | `true` |  |
| tika.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| tika.image.internalPort | int | `8090` |  |
| tika.image.pullPolicy | string | `"IfNotPresent"` |  |
| tika.image.repository | string | `"quay.io/alfresco/alfresco-tika"` |  |
| tika.image.tag | string | `"5.1.5"` |  |
| tika.livenessProbe.initialDelaySeconds | int | `30` |  |
| tika.livenessProbe.livenessPercent | int | `400` |  |
| tika.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| tika.livenessProbe.maxTransformSeconds | int | `1800` |  |
| tika.livenessProbe.maxTransforms | int | `10000` |  |
| tika.livenessProbe.path | string | `"/live"` |  |
| tika.livenessProbe.periodSeconds | int | `20` |  |
| tika.livenessProbe.timeoutSeconds | int | `10` |  |
| tika.nodeSelector | object | `{}` |  |
| tika.podAnnotations | object | `{}` |  |
| tika.podLabels | object | `{}` |  |
| tika.podSecurityContext.runAsNonRoot | bool | `true` |  |
| tika.podSecurityContext.runAsUser | int | `33004` |  |
| tika.readinessProbe.initialDelaySeconds | int | `30` |  |
| tika.readinessProbe.path | string | `"/ready"` |  |
| tika.readinessProbe.periodSeconds | int | `30` |  |
| tika.readinessProbe.timeoutSeconds | int | `10` |  |
| tika.replicaCount | int | `2` |  |
| tika.resources.limits.cpu | string | `"4"` |  |
| tika.resources.limits.memory | string | `"4Gi"` |  |
| tika.resources.requests.cpu | string | `"250m"` |  |
| tika.resources.requests.memory | string | `"600Mi"` |  |
| tika.service.externalPort | int | `80` |  |
| tika.service.name | string | `"tika"` |  |
| tika.service.type | string | `"ClusterIP"` |  |
| tika.tolerations | list | `[]` |  |
| tika.volumeMounts | list | `[]` |  |
| tika.volumes | list | `[]` |  |
| transformmisc.affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.transform-misc.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10},{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.transform-misc.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}]}}` | Pod affinity, passed thru tpl function |
| transformmisc.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.transform-misc.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule on different zones |
| transformmisc.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.transform-misc.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule on different nodes |
| transformmisc.autoscaling.behavior.scaleDown.policies | list | `[{"periodSeconds":60,"type":"Pods","value":1}]` | list of available policies for scaling down scale down either by one pod or by destroying 25% of the pods (whichever is smaller) |
| transformmisc.autoscaling.behavior.scaleDown.stabilizationWindowSeconds | int | `60` |  |
| transformmisc.autoscaling.behavior.scaleUp.policies | list | `[{"periodSeconds":60,"type":"Percent","value":50},{"periodSeconds":60,"type":"Pods","value":2}]` | list of available policies for scaling up scale up either by one pod or by adding 50% more pods (whichever is bigger) |
| transformmisc.autoscaling.behavior.scaleUp.stabilizationWindowSeconds | int | `30` |  |
| transformmisc.autoscaling.enabled | bool | `false` | Toggle transformmisc autoscaling |
| transformmisc.autoscaling.maxReplicas | int | `3` | maximum number of replicas to spin up within the replicaset |
| transformmisc.autoscaling.metrics | list | `[{"resource":{"name":"cpu","target":{"averageUtilization":75,"type":"Utilization"}},"type":"Resource"}]` | a list of resource the HPA controller should monitor For more details check https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/#support-for-resource-metrics |
| transformmisc.autoscaling.minReplicas | int | `1` | minimum number of replicas to spin up within the replicaset |
| transformmisc.enabled | bool | `true` |  |
| transformmisc.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| transformmisc.image.internalPort | int | `8090` |  |
| transformmisc.image.pullPolicy | string | `"IfNotPresent"` |  |
| transformmisc.image.repository | string | `"quay.io/alfresco/alfresco-transform-misc"` |  |
| transformmisc.image.tag | string | `"5.1.5"` |  |
| transformmisc.livenessProbe.initialDelaySeconds | int | `10` |  |
| transformmisc.livenessProbe.livenessPercent | int | `400` |  |
| transformmisc.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| transformmisc.livenessProbe.maxTransformSeconds | int | `1800` |  |
| transformmisc.livenessProbe.maxTransforms | int | `10000` |  |
| transformmisc.livenessProbe.path | string | `"/live"` |  |
| transformmisc.livenessProbe.periodSeconds | int | `20` |  |
| transformmisc.livenessProbe.timeoutSeconds | int | `10` |  |
| transformmisc.nodeSelector | object | `{}` |  |
| transformmisc.podAnnotations | object | `{}` |  |
| transformmisc.podLabels | object | `{}` |  |
| transformmisc.podSecurityContext.runAsNonRoot | bool | `true` |  |
| transformmisc.podSecurityContext.runAsUser | int | `33006` |  |
| transformmisc.readinessProbe.initialDelaySeconds | int | `20` |  |
| transformmisc.readinessProbe.path | string | `"/ready"` |  |
| transformmisc.readinessProbe.periodSeconds | int | `30` |  |
| transformmisc.readinessProbe.timeoutSeconds | int | `10` |  |
| transformmisc.replicaCount | int | `2` |  |
| transformmisc.resources.limits.cpu | string | `"2"` |  |
| transformmisc.resources.limits.memory | string | `"2Gi"` |  |
| transformmisc.resources.requests.cpu | string | `"100m"` |  |
| transformmisc.resources.requests.memory | string | `"250Mi"` |  |
| transformmisc.service.externalPort | int | `80` |  |
| transformmisc.service.name | string | `"transformmisc"` |  |
| transformmisc.service.type | string | `"ClusterIP"` |  |
| transformmisc.tolerations | list | `[]` |  |
| transformmisc.volumeMounts | list | `[]` |  |
| transformmisc.volumes | list | `[]` |  |
| transformrouter.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.transform-router.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule on different zones |
| transformrouter.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-transform-service.transform-router.name\" . }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ .Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule on different nodes |
| transformrouter.enabled | bool | `true` |  |
| transformrouter.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| transformrouter.image.internalPort | int | `8095` |  |
| transformrouter.image.pullPolicy | string | `"IfNotPresent"` |  |
| transformrouter.image.repository | string | `"quay.io/alfresco/alfresco-transform-router"` |  |
| transformrouter.image.tag | string | `"4.1.5"` |  |
| transformrouter.livenessProbe.initialDelaySeconds | int | `20` |  |
| transformrouter.livenessProbe.path | string | `"/actuator/health"` |  |
| transformrouter.livenessProbe.periodSeconds | int | `30` |  |
| transformrouter.livenessProbe.timeoutSeconds | int | `10` |  |
| transformrouter.nodeSelector | object | `{}` |  |
| transformrouter.podAnnotations | object | `{}` |  |
| transformrouter.podLabels | object | `{}` |  |
| transformrouter.podSecurityContext.runAsNonRoot | bool | `true` |  |
| transformrouter.podSecurityContext.runAsUser | int | `33016` |  |
| transformrouter.readinessProbe.initialDelaySeconds | int | `20` |  |
| transformrouter.readinessProbe.path | string | `"/actuator/health"` |  |
| transformrouter.readinessProbe.periodSeconds | int | `60` |  |
| transformrouter.readinessProbe.timeoutSeconds | int | `10` |  |
| transformrouter.replicaCount | int | `1` |  |
| transformrouter.resources.limits.cpu | string | `"1"` |  |
| transformrouter.resources.limits.memory | string | `"1Gi"` |  |
| transformrouter.resources.requests.cpu | string | `"100m"` |  |
| transformrouter.resources.requests.memory | string | `"250Mi"` |  |
| transformrouter.service.externalPort | int | `80` |  |
| transformrouter.service.name | string | `"transform-router"` |  |
| transformrouter.service.type | string | `"ClusterIP"` |  |
| transformrouter.tolerations | list | `[]` |  |
| transformrouter.volumeMounts | list | `[]` |  |
| transformrouter.volumes | list | `[]` |  |
