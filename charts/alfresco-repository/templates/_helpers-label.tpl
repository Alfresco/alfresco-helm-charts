{{- define "alfresco-repository.repository.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-repository.repository.name" .) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.labels" $scope }}
{{- end }}

{{- define "alfresco-repository.repository.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-repository.repository.name" .) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-repository.share.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-repository.share.name" .) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.labels" $scope }}
{{- end }}

{{- define "alfresco-repository.share.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-repository.share.name" .) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.selectorLabels" $scope }}
{{- end }}
