# alfresco-search-service

![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-informational?style=flat-square) ![AppVersion: 2.0.7](https://img.shields.io/badge/AppVersion-2.0.7-informational?style=flat-square)

A Helm chart for deploying Alfresco Search Service

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/alfresco-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | alfresco-insight-zeppelin | 2.0.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| PvNodeAffinity | string | `nil` | Define PVNodeAffinity for scheduling SOLR |
| affinity | string | `nil` | Define Affinity for scheduling SOLR |
| alfresco-insight-zeppelin.enabled | bool | `false` |  |
| environment.SOLR_CREATE_ALFRESCO_DEFAULTS | string | `"alfresco,archive"` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| global.tracking.auth | string | `"secret"` | Select how solr and repo authenticate to each other none: work only prior to acs 7.2 (and was the default) secret: use a shared secret (to specify using `tracking.sharedsecret`) https: to use mTLS auth (require appropriate certificate configuration) |
| global.tracking.sharedsecret | string | `nil` | Shared secret to authenticate repo/solr traffic |
| ingress.basicAuth | string | `nil` | Default solr basic auth user/password: admin / admin You can create your own with htpasswd utilility & encode it with base640. Example: `echo -n "$(htpasswd -nbm admin admin)" | base64 | tr -d '\n'` basicAuth: YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg== |
| ingress.enabled | bool | `false` | Expose the solr admin console behind basic auth |
| ingress.existingSecretName | string | `nil` | An existing secret that contains an `auth` key with a value in the same format of `ingress.basicAuth` |
| ingress.path | string | `"/solr"` |  |
| ingress.tls | list | `[]` |  |
| ingress.whitelist_ips | string | `"0.0.0.0/0"` | Comma separated list of CIDR to restrict search endpoint access. |
| initContainer.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainer.image.repository | string | `"busybox"` |  |
| initContainer.image.tag | string | `"1.35.0"` |  |
| initContainer.resources.limits.memory | string | `"10Mi"` |  |
| initContainer.resources.requests.memory | string | `"5Mi"` |  |
| insightEngineImage.internalPort | string | `nil` | container's port search service is listening on change if your custom image use a different port. |
| insightEngineImage.pullPolicy | string | `"IfNotPresent"` |  |
| insightEngineImage.repository | string | `"quay.io/alfresco/insight-engine"` |  |
| insightEngineImage.tag | string | `"2.0.7"` |  |
| livenessProbe.initialDelaySeconds | int | `130` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| nodeSelector | object | `{}` | Define the alfresco-search properties to use in the k8s cluster This is the search provider used by alfresco-content-repository |
| persistence | object | `{"EbsPvConfiguration":{"fsType":"ext4"},"VolumeSizeRequest":"10Gi","enabled":true,"search":{"data":{"mountPath":"/opt/alfresco-search-services/data","subPath":"alfresco-content-services/solr-data"}}}` | Defines the persistence |
| persistence.VolumeSizeRequest | string | `"10Gi"` | Only define if you have a specific claim already created existingClaim: "search-master-claim" |
| persistence.enabled | bool | `true` | If set to false data will be lost with pods |
| podSecurityContext.fsGroup | int | `33007` |  |
| podSecurityContext.runAsGroup | int | `33007` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33007` |  |
| readinessProbe.initialDelaySeconds | int | `60` |  |
| readinessProbe.periodSeconds | int | `20` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| repository.host | string | `nil` | ACS repository hostname |
| repository.port | string | `nil` | ACS repository port |
| resources.limits.cpu | string | `"4"` |  |
| resources.limits.memory | string | `"2000Mi"` |  |
| resources.requests.cpu | string | `"0.50"` |  |
| resources.requests.memory | string | `"1200Mi"` |  |
| searchServicesImage.internalPort | string | `nil` | container's port search service is listening on change if your custom image use a different port. |
| searchServicesImage.pullPolicy | string | `"IfNotPresent"` |  |
| searchServicesImage.repository | string | `"quay.io/alfresco/search-services"` |  |
| searchServicesImage.tag | string | `"2.0.7"` |  |
| service.name | string | `"solr"` |  |
| service.type | string | `"ClusterIP"` |  |
| tolerations | string | `nil` | Define Tolerations for scheduling SOLR |
| type | string | `"search-services"` | set alfresco-insight-zeppelin.enabled=true As the Docker Image for Insight Engine is not publicly available the alfrescoRegistryPullSecrets has to be set More information can be found on https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/registry-authentication.md |
