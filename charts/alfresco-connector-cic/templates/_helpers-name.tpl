{{- define "alfresco-connector-cic.live-ingester.name" -}}
{{- $component := printf "%s-%s" (include "alfresco-connector-cic.name" .) "live-ingester" }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.name" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.live-ingester.fullname" -}}
{{- $component := include "alfresco-connector-cic.live-ingester.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.bulk-ingester.name" -}}
{{- $component := printf "%s-%s" (include "alfresco-connector-cic.name" .) "bulk-ingester" }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.name" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.bulk-ingester.fullname" -}}
{{- $component := include "alfresco-connector-cic.bulk-ingester.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.nucleus-sync.name" -}}
{{- $component := printf "%s-%s" (include "alfresco-connector-cic.name" .) "nucleus-sync" }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.name" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.nucleus-sync.fullname" -}}
{{- $component := include "alfresco-connector-cic.nucleus-sync.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.mq.fullname" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (printf "%s-mq" (include "alfresco-connector-cic.name" .))) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.database.fullname" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (printf "%s-database" (include "alfresco-connector-cic.name" .))) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.repository.fullname" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (printf "%s-repository" (include "alfresco-connector-cic.name" .))) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.fullname" $scope }}
{{- end }}

{{- define "alfresco-connector-cic.ats.fullname" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (printf "%s-ats" (include "alfresco-connector-cic.name" .))) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-cic.fullname" $scope }}
{{- end }}
