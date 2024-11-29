---
title: alfresco-share
parent: Charts Reference
---

# alfresco-share

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.4.0](https://img.shields.io/badge/AppVersion-23.4.0-informational?style=flat-square)

Alfresco Share Helm chart for Kubernetes

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts | alfresco-common | 3.1.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-share.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"topology.kubernetes.io/zone"},"weight":10}` | Prefer to schedule pods in different zones |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[1] | object | `{"podAffinityTerm":{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/name","operator":"In","values":["{{ template \"alfresco-share.name\" $ }}"]},{"key":"app.kubernetes.io/instance","operator":"In","values":["{{ $.Release.Name }}"]},{"key":"app.kubernetes.io/component","operator":"In","values":["{{ $.Chart.Name }}"]}]},"topologyKey":"kubernetes.io/hostname"},"weight":5}` | Prefer to schedule pods on different nodes |
| args | list | `[]` |  |
| command | list | `[]` |  |
| environment.CATALINA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| extraInitContainers | list | `[]` |  |
| extraSideContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` | Define a fully static name |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` | If a private image registry a secret can be defined and passed to kubernetes, see: https://github.com/Alfresco/acs-deployment/blob/a924ad6670911f64f1bba680682d266dd4ea27fb/docs/helm/eks-deployment.md#docker-registry-secret |
| global.known_urls | string | `nil` | a fallback for .Values.known_urls that can be shared between charts |
| hazelcast.port | int | `5701` | Port used to expose the Hazelcast service when replicaCount > 1 |
| image.port | int | `8080` | Internal port where the pod is listening. Should only be changed is you use a custom image which uses a different port. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/alfresco-share"` |  |
| image.tag | string | `"23.4.0"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-expires" | string | `"604800"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-max-age" | string | `"604800"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-name" | string | `"alfrescoShare"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-path" | string | `"/share"` |  |
| ingress.className | string | `"nginx"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].paths[0].path | string | `"/share"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| known_urls | string | `nil` | Provide the list of URL considered allowed to access Share resources (used for CSRF protection). The value be either a list of strings or a single string separated by spaces. |
| livenessProbe.httpGet.path | string | `"/share"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `15` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| managedApplicationContext.enabled | bool | `true` | Automatically inject a custom application context file which for now only enables hazelcast clustering when more than one replica is configured. Should be disabled when providing a custom application context file. |
| nameOverride | string | `""` | Define a partially static name |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| readinessProbe.httpGet.path | string | `"/share"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `15` |  |
| readinessProbe.periodSeconds | int | `30` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` | Define the number of replicas to run. Multiple replicas are only supported on Share 23.1.1 and later |
| repository.existingConfigMap.keys.host | string | `"REPO_HOST"` | name of the key in the configMap where to find the repository service host |
| repository.existingConfigMap.keys.port | string | `"REPO_PORT"` | name of the key in the configMap where to find the repository service port |
| repository.existingConfigMap.name | string | `nil` | a pre-existing configmap which provides expected configuration for Share |
| repository.host | string | `"localhost"` | repository hostname/servicename |
| repository.port | int | `8080` | repository port where service is exposed |
| resources.limits.cpu | string | `"4"` |  |
| resources.limits.memory | string | `"2000Mi"` |  |
| resources.requests.cpu | string | `"250m"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| securityContext.capabilities.drop[0] | string | `"NET_RAW"` |  |
| securityContext.capabilities.drop[1] | string | `"ALL"` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.name | string | `"share"` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `"share-sa"` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| strategy.rollingUpdate.maxSurge | int | `1` |  |
| strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| strategy.type | string | `"RollingUpdate"` |  |
| tolerations | list | `[]` |  |
