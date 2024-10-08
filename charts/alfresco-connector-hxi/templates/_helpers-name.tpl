{{- define "alfresco-connector-hxi.live-ingester.name" -}}
{{- $component := printf "%s-%s" (include "alfresco-connector-hxi.name" .) "live-ingester" }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.name" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.live-ingester.fullname" -}}
{{- $component := include "alfresco-connector-hxi.live-ingester.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.bulk-ingester.name" -}}
{{- $component := printf "%s-%s" (include "alfresco-connector-hxi.name" .) "bulk-ingester" }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.name" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.bulk-ingester.fullname" -}}
{{- $component := include "alfresco-connector-hxi.bulk-ingester.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.prediction-applier.name" -}}
{{- $component := printf "%s-%s" (include "alfresco-connector-hxi.name" .) "prediction-applier" }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.name" $scope }}
{{- end }}

{{- define "alfresco-connector-hxi.prediction-applier.fullname" -}}
{{- $component := include "alfresco-connector-hxi.prediction-applier.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-hxi.fullname" $scope }}
{{- end }}
