{{- define "alfresco-search-service.deployment.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "solr" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-search-service.pvc.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "solr-claim" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-service.fullname" $scope }}
{{- end }}
