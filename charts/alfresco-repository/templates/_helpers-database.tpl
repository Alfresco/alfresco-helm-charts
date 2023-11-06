{{/*
Render database config as env vars

Usage: include "alfresco-repository.db.env" $

*/}}
{{- define "alfresco-repository.db.env" -}}
{{- $dbcmCtx := dict "Values" (dict "nameOverride" "alfresco-database") "Chart" .Chart "Release" .Release }}
{{- with .Values.configuration.db }}
{{- $dbcm := coalesce .existingConfigMap.name (include "alfresco-repository.fullname" $dbcmCtx) }}
- name: DATABASE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.url }}
- name: DATABASE_DRIVER
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.driver }}
{{- end }}
{{- end -}}

{{/*
Render database configmap

Usage: include "alfresco-repository.db.cm" (dict "url" "" "driver" "")

*/}}
{{- define "alfresco-repository.db.cm" -}}
  DATABASE_URL: {{ hasPrefix "jdbc:" .url | ternary .url (print "jdbc:" .url) }}
  DATABASE_DRIVER: {{ template "alfresco-common.db.driver" . }}
{{- end -}}
