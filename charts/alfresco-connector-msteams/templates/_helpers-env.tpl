{{/*
Set environment variables necessary for secret
*/}}
{{- define "alfresco-connector-msteams.secret-msteams.env" -}}
{{- $msSecret := coalesce .Values.microsoft.app.existingSecret.name (include "alfresco-connector-msteams.secret.name" .) -}}
- name: MICROSOFT_APP_ID
  valueFrom:
    secretKeyRef:
        name: {{ $msSecret }}
        key: {{ .Values.microsoft.app.existingSecret.keys.id }}
- name: MICROSOFT_APP_PASSWORD
  valueFrom:
    secretKeyRef:
        name: {{ $msSecret }}
        key: {{ .Values.microsoft.app.existingSecret.keys.password }}
{{- end -}}

{{/*
Set environment variables necessary for configmap
*/}}
{{- define "alfresco-connector-msteams.repo-msteams.env" -}}
{{- $msteamsCm := coalesce .Values.repository.existingConfigMap.name (include "alfresco-connector-msteams.repo-configmap.name" .) -}}
- name: ALFRESCO_BASE_URL
  valueFrom:
    configMapKeyRef:
        name: {{ $msteamsCm }}
        key: {{ .Values.repository.existingConfigMap.keys.url }}
{{- end -}}
