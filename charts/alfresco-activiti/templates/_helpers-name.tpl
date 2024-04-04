{{- define "alfresco-activiti.database.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" (printf "%s-database" .Chart.Name)) "Chart" .Chart "Release" .Release }}
{{- template "alfresco-activiti.fullname" $ctx }}
{{- end -}}
