{{- define "alfresco-transform-service.filestore.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.filestore.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}
