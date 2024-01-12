{{- define "alfresco-search-service.deployment.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "solr" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-search-service.pvc.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "solr-claim" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-search-service.repository-config.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "solr-repository-config" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-search-service.ingress-secret.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "solr-ingress-credentials" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-service.fullname" $scope }}
{{- end }}
