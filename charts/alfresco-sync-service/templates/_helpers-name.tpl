{{/*
Compute database related resources name

Usage "alfresco-sync-service.database" $

*/}}

{{- define "alfresco-sync-service.database" -}}
{{- $dbCtx := dict "Values" (dict "nameOverride" "alfresco-sync-database") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-sync-service.fullname" $dbCtx }}
{{- end -}}
