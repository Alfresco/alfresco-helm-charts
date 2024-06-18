{{- define "alfresco-search-enterprise.content.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "content" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.name" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.metadata.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "metadata" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.name" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.path.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "path" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.name" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.mediation.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "mediation" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.name" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.content.fullname" -}}
{{- $component := include "alfresco-search-enterprise.content.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.fullname" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.metadata.fullname" -}}
{{- $component := include "alfresco-search-enterprise.metadata.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.fullname" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.path.fullname" -}}
{{- $component := include "alfresco-search-enterprise.path.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.fullname" $scope }}
{{- end }}

{{- define "alfresco-search-enterprise.mediation.fullname" -}}
{{- $component := include "alfresco-search-enterprise.medaition.name" . }}
{{- $scope := (dict "Values" (dict "nameOverride" $component ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-search-enterprise.fullname" $scope }}
{{- end }}
