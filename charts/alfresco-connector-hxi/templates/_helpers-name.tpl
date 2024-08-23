{{- define "alfresco-connector-hxi.live-ingester.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "live-ingester" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.name" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.live-ingester.fullname" -}}
{{- $component := include "alfresco-connector-hxi.live-ingester.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.fullname" $scope }}
{{- end }}
