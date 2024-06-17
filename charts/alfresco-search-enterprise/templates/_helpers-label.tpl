{{- define "alfresco-search-enterprise.content.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.content.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.content.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.content.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.metadata.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.metadata.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.metadata.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.metadata.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.path.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.path.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.path.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.path.name" .) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.mediation.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.mediation.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.mediation.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-search-enterprise.mediation.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}
