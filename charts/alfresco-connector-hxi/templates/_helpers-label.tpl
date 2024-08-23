{{- define "alfresco-connector-hxi.live-ingester.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.live-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.labels" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.live-ingester.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.live-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.selectorLabels" $scope }}
{{- end }}
