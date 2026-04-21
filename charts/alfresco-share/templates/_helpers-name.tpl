{{- define "alfresco-share.custom-application-context.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "share-custom-application-context" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}

{{- define "alfresco-share.service-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "share-hz" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-share.fullname" $scope }}
{{- end }}

{{- define "alfresco-share.cluster-role-hz.name" -}}
{{- printf "%s-%s-share-hazelcast-cluster-role" .Release.Name .Release.Namespace | trunc 253 | trimSuffix "-" }}
{{- end }}

{{- define "alfresco-share.cluster-role-binding-hz.name" -}}
{{- printf "%s-%s-share-hazelcast-cluster-role-binding" .Release.Name .Release.Namespace | trunc 253 | trimSuffix "-" }}
{{- end }}
