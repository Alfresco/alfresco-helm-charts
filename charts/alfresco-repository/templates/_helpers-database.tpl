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
- name: DATABASE_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.host }}
- name: DATABASE_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.port }}
- name: DATABASE_DRIVER
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.driver }}
{{- end }}
{{- end -}}
