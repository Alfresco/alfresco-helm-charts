{{- define "alfresco-connector-cic.live-ingester.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-cic.live-ingester.name" .) "additionalLabels" .Values.additionalLabels "global" .Values.global) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.labels" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.live-ingester.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-cic.live-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.bulk-ingester.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-cic.bulk-ingester.name" .) "additionalLabels" .Values.additionalLabels "global" .Values.global) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.labels" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.bulk-ingester.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-cic.bulk-ingester.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.nucleus-sync.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-cic.nucleus-sync.name" .) "additionalLabels" .Values.additionalLabels "global" .Values.global) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.labels" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.nucleus-sync.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-connector-cic.nucleus-sync.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.selectorLabels" $scope }}
{{- end }}
