---
title: alfresco-ai-transformer
parent: Charts Reference
---

# alfresco-ai-transformer

![Version: 3.0.0](https://img.shields.io/badge/Version-3.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.1.7](https://img.shields.io/badge/AppVersion-3.1.7-informational?style=flat-square)

A Helm chart for deploying Alfresco ai transformer service

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.6.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-ai-transformer.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule pods in different zones |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-ai-transformer.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule pods in different nodes |
| args | list | `[]` |  |
| aws.accessKeyId | string | `nil` | AWS credentials are required as documented at https://docs.alfresco.com/intelligence-services/latest/config/#default-configuration |
| aws.comprehendRoleARN | string | `nil` |  |
| aws.existingConfigMap.keys.comprehendRoleARN | string | `"AWS_COMPREHEND_ROLE_ARN"` |  |
| aws.existingConfigMap.keys.region | string | `"AWS_REGION"` |  |
| aws.existingConfigMap.keys.s3Bucket | string | `"AWS_S3_BUCKET"` |  |
| aws.existingConfigMap.name | string | `nil` |  |
| aws.existingSecret.keys.accessKeyId | string | `"AWS_ACCESS_KEY_ID"` |  |
| aws.existingSecret.keys.secretAccessKey | string | `"AWS_SECRET_ACCESS_KEY"` |  |
| aws.existingSecret.name | string | `nil` |  |
| aws.region | string | `nil` |  |
| aws.s3Bucket | string | `nil` |  |
| aws.secretAccessKey | string | `nil` |  |
| command | list | `[]` |  |
| environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| extraInitContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| image.internalPort | int | `8090` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-ai-docker-engine"` |  |
| image.tag | string | `"3.1.7"` |  |
| livenessProbe.failureThreshold | int | `1` |  |
| livenessProbe.httpGet.path | string | `"/live"` |  |
| livenessProbe.httpGet.port | string | `"service-port"` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| messageBroker.existingConfigMap | object | `{"keys":{"url":"BROKER_URL"},"name":null}` | Alternatively, provide credentials via an existing secret and set the keys as they are given |
| messageBroker.existingSecret.keys.password | string | `"BROKER_PASSWORD"` |  |
| messageBroker.existingSecret.keys.username | string | `"BROKER_USERNAME"` |  |
| messageBroker.existingSecret.name | string | `nil` |  |
| messageBroker.password | string | `nil` |  |
| messageBroker.url | string | `nil` |  |
| messageBroker.user | string | `nil` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext.runAsUser | int | `33015` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/ready"` |  |
| readinessProbe.httpGet.port | string | `"service-port"` |  |
| readinessProbe.initialDelaySeconds | int | `20` |  |
| readinessProbe.periodSeconds | int | `60` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `2` |  |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.memory | string | `"1000Mi"` |  |
| resources.requests.cpu | string | `"0.25"` |  |
| resources.requests.memory | string | `"1000Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"ai-transformer"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `"ai-transformer-sa"` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| sfs.existingConfigMap.keys.url | string | `"FILE_STORE_URL"` |  |
| sfs.existingConfigMap.name | string | `nil` |  |
| sfs.url | string | `nil` | Alfresco Transformation filestore (e.g. http://acs-alfresco-transform-service) |
| strategy.rollingUpdate.maxSurge | int | `1` |  |
| strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| tags.ci | bool | `false` | A chart tag used for Hyland's CI purpose. Do not set it to true. |
| tolerations | list | `[]` |  |
| transformerLiveness.livenessPercent | int | `400` |  |
| transformerLiveness.livenessTransformPeriodSeconds | int | `600` |  |
| transformerLiveness.maxTransformSeconds | int | `1800` |  |
| transformerLiveness.maxTransforms | int | `10000` |  |
| trouter.pipelines | list | See | List of transformer pipelines the ATS router can advertise when using AI To get more details abous pipeline configuration check https://docs.alfresco.com/transform-service/latest/config/#transform-pipelines https://github.com/Alfresco/alfresco-ai-renditions/blob/master/ai-renditions/docker-compose/ai-pipeline-routes.json |
