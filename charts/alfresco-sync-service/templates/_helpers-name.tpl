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
