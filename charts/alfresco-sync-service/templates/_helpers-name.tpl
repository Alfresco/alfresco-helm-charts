{{/*
Compute database related resources name

Usage "alfresco-sync-service.database" $

*/}}

{{- define "alfresco-sync-service.database" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "alfresco-sync-database") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-sync-service.fullname" $ctx }}
{{- end -}}

{{/*
Compute message broker related resources name

Usage "alfresco-sync-service.message-broker" $

*/}}

{{- define "alfresco-sync-service.message-broker" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "alfresco-sync-mq") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-sync-service.fullname" $ctx }}
{{- end -}}

{{/*
Compute repository related resources name

Usage "alfresco-sync-service.repository" $

*/}}

{{- define "alfresco-sync-service.repository" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "alfresco-sync-repo") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-sync-service.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-sync-service.hazelcast-tcp.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "sync-hazelcast-tcp" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-sync-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-sync-service.service-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "sync-hazelcast" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-sync-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-sync-service.cluster-role-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "sync-hazelcast-cluster-role" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-sync-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-sync-service.cluster-role-binding-hz.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "sync-hazelcast-cluster-role-binding" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-sync-service.fullname" $scope }}
{{- end }}
