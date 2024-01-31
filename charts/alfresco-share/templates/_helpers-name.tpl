{{- define "alfresco-share.custom-application-context.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "custom-application-context" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}

{{- define "alfresco-share.service-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "hz" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}
