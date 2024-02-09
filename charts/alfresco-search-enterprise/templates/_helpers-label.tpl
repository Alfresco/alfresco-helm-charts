{{- define "alfresco-search-enterprise.content.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "content" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.content.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "content" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.metadata.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "metadata" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.metadata.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "metadata" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.path.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "path" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.path.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "path" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.mediation.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "mediation" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.labels" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.mediation.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "mediation" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.selectorLabels" $scope }}
{{- end }}
