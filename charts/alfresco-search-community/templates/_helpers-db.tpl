{{/*

Usage: include "alfresco-search-community.db.env" $

*/}}
{{- define "alfresco-search-community.db.env" -}}
{{- $dbCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "database")) "Chart" .Chart "Release" .Release }}
{{- $dbFullName := include "alfresco-search-community.fullname" $dbCtx }}
{{- with .Values.db }}
- name: SPRING_DATASOURCE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ .existingConfigMap.name | default $dbFullName }}
      key: {{ .existingConfigMap.keys.url }}
- name: SPRING_DATASOURCE_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .existingSecret.name | default $dbFullName }}
      key: {{ .existingSecret.keys.username }}
- name: SPRING_DATASOURCE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .existingSecret.name | default $dbFullName }}
      key: {{ .existingSecret.keys.password }}
{{- end }}
{{- end -}}
