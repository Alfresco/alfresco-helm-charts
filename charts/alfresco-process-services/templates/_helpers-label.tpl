{{- define "alfresco-process-services.aps.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.labels" $scope }}
{{- end }}

{{- define "alfresco-process-services.aps.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-process-services.admin.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "admin" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.labels" $scope }}
{{- end }}

{{- define "alfresco-process-services.admin.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "admin" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.selectorLabels" $scope }}
{{- end }}
