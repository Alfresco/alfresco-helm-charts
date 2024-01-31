{{- define "alfresco-share.custom-application-context.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "custom-application-context" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}

{{- define "alfresco-share.service-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "hz" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}

{{- define "alfresco-share.cluster-role-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "hazelcast-cluster-role" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}

{{- define "alfresco-share.cluster-role-binding-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "hazelcast-cluster-role-binding" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}
