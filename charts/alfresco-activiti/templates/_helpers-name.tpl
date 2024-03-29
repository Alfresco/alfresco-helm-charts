{{- define "alfresco-activiti.database-config.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "database") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-activiti.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-activiti.database-secret.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "database-secret") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-activiti.fullname" $ctx }}
{{- end -}}
