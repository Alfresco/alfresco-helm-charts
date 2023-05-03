{{- define "alfresco-transform-service.config-filestore.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.deployment-filestore.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}
