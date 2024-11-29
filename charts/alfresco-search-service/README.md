---
title: alfresco-search-service
parent: Charts Reference
---

# alfresco-search-service

![Version: 4.0.0](https://img.shields.io/badge/Version-4.0.0-informational?style=flat-square) ![AppVersion: 2.0.13](https://img.shields.io/badge/AppVersion-2.0.13-informational?style=flat-square)

A Helm chart for deploying Alfresco Search Service

Checkout [alfresco-content-services chart's doc](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for an example of how to leverage this chart from an umbrella chart.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/alfresco-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | alfresco-insight-zeppelin | 3.0.4 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.1.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | string | `""` | Pod affinity, passed thru tpl function |
| alfresco-insight-zeppelin.enabled | bool | `false` |  |
| environment.SOLR_CREATE_ALFRESCO_DEFAULTS | string | `"alfresco,archive"` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| ingress.annotations | object | `{"nginx.ingress.kubernetes.io/auth-realm":"Authentication Required - Alfresco Search Services","nginx.ingress.kubernetes.io/auth-type":"basic","nginx.ingress.kubernetes.io/whitelist-source-range":"0.0.0.0/0"}` | nginx ingress annotations (see https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations) |
| ingress.basicAuth | string | `nil` | Default solr basic auth user/password: admin / admin You can create your own with htpasswd utilility & encode it with base640. Example: `echo -n "$(htpasswd -nbm admin admin)" | base64 | tr -d '\n'` basicAuth: YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg== |
| ingress.className | string | `"nginx"` |  |
| ingress.enabled | bool | `false` | Expose the solr admin console behind basic auth |
| ingress.existingSecretName | string | `nil` | An existing secret that contains an `auth` key with a value in the same format of `ingress.basicAuth` |
| ingress.path | string | `"/solr"` |  |
| ingress.tls | list | `[]` |  |
| initContainer.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainer.image.repository | string | `"busybox"` |  |
| initContainer.image.tag | string | `"1.35.0"` |  |
| initContainer.resources.limits.memory | string | `"20Mi"` |  |
| initContainer.resources.requests.memory | string | `"5Mi"` |  |
| insightEngineImage.internalPort | string | `nil` | container's port search service is listening on change if your custom image use a different port. |
| insightEngineImage.pullPolicy | string | `"IfNotPresent"` |  |
| insightEngineImage.repository | string | `"quay.io/alfresco/insight-engine"` |  |
| insightEngineImage.tag | string | `"2.0.13"` |  |
| livenessProbe.failureThreshold | int | `1` |  |
| livenessProbe.initialDelaySeconds | int | `130` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.baseSize | string | `"10Gi"` | Capacity of the PVC for persistency |
| persistence.enabled | bool | `true` | When disabled, data is lost when pod is terminated/rescheduled |
| persistence.existingClaim | string | `nil` | Provide a pre-existing PVC for persistency |
| persistence.search.data.mountPath | string | `"/opt/alfresco-search-services/data"` |  |
| persistence.search.data.subPath | string | `"alfresco-content-services/solr-data"` |  |
| persistence.storageClass | string | `nil` | Bind PVC based on storageClass (e.g. dynamic provisioning) |
| podSecurityContext.fsGroup | int | `33007` |  |
| podSecurityContext.runAsGroup | int | `33007` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33007` |  |
| readinessProbe.initialDelaySeconds | int | `60` |  |
| readinessProbe.periodSeconds | int | `20` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| repository.existingConfigMap.keys.host | string | `"SOLR_ALFRESCO_HOST"` | Key within the configmap holding the repository hostname |
| repository.existingConfigMap.keys.port | string | `"SOLR_ALFRESCO_PORT"` | Key within the configmap holding the repository port |
| repository.existingConfigMap.keys.securecomms | string | `"SOLR_ALFRESCO_SECURE_COMMS"` | Key within the configmap holding the repository security level |
| repository.existingConfigMap.name | string | `nil` | Name of a pre-existing configmap containing Alfresco repository URL |
| repository.existingSecret.keys.sharedSecret | string | `"SOLR_ALFRESCO_SECURECOMMS_SECRET"` | Key within the secret holding the repository shared secret |
| repository.existingSecret.name | string | `nil` | Alternatively, provide a pre-existing secret containing the shared secret used with repository when `securecomms` is `secret` |
| repository.host | string | `nil` | Alfresco repository hostname |
| repository.port | string | `nil` | Alfresco repository port |
| repository.securecomms | string | `"secret"` | Alfresco repository security level to use when tracking the repo ('none' or 'secret') |
| repository.sharedSecret | string | `nil` | Shared secret used with repository when `securecomms` is `secret` |
| resources.limits.cpu | string | `"4"` |  |
| resources.limits.memory | string | `"2000Mi"` |  |
| resources.requests.cpu | string | `"0.50"` |  |
| resources.requests.memory | string | `"1200Mi"` |  |
| searchServicesImage.internalPort | string | `nil` | container's port search service is listening on change if your custom image use a different port. |
| searchServicesImage.pullPolicy | string | `"IfNotPresent"` |  |
| searchServicesImage.repository | string | `"quay.io/alfresco/search-services"` |  |
| searchServicesImage.tag | string | `"2.0.13"` |  |
| service.name | string | `"solr"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
| type | string | `"search-services"` | set alfresco-insight-zeppelin.enabled=true As the Docker Image for Insight Engine is not publicly available the alfrescoRegistryPullSecrets has to be set More information can be found on https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/registry-authentication.md |
