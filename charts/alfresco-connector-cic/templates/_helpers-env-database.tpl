{{/*

Usage: include "alfresco-connector-cic.database.cm.env" $

*/}}
{{- define "alfresco-connector-cic.database.cm.env" -}}
{{- with .Values.db }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.database.fullname" $) }}
- name: SPRING_DATASOURCE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.url }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.database.secret.env" $

*/}}
{{- define "alfresco-connector-cic.database.secret.env" -}}
{{- with .Values.db }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.database.fullname" $) }}
- name: SPRING_DATASOURCE_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.username }}
- name: SPRING_DATASOURCE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.password }}
{{- end -}}
{{- end -}}
