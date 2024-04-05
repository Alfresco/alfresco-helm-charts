{{/*
Render database configmap

Usage: include "alfresco-activiti-admin.db.cm" (dict "url" "" "driver" "")

*/}}
{{- define "alfresco-activiti-admin.db.cm" -}}
  {{- $reqmsg := "Either provide database url as values, or provide a cm that contains it." }}
  {{- $url := .url | required $reqmsg }}
  DATABASE_URL: {{ hasPrefix "jdbc:" $url | ternary $url (print "jdbc:" $url) }}
  DATABASE_DRIVER: {{ template "alfresco-common.db.driver" . }}
{{- end -}}
