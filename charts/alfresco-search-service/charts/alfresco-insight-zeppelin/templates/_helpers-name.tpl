{{- define "alfresco-insight-zeppelin.deployment.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "insight-zeppelin" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-insight-zeppelin.fullname" $scope }}
{{- end }}
