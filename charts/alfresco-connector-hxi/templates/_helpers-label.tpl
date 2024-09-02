{{- define "alfresco-connector-hxi.live-ingester.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.live-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.labels" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.live-ingester.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.live-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.bulk-ingester.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.bulk-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.labels" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.bulk-ingester.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.bulk-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.prediction-applier.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.prediction-applier.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.labels" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.prediction-applier.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-hxi.prediction-applier.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.selectorLabels" $scope }}
{{- end }}
