{{/*
Set environment variables necessary for message broker configuration
*/}}
{{- define "alfresco-transform-service.messageBroker.env" -}}
{{- $mqConfigMap := coalesce .Values.messageBroker.existingConfigMap.name (include "alfresco-transform-service.messagebroker.name" .) -}}
{{- $mqSecret := coalesce .Values.messageBroker.existingSecret.name (include "alfresco-transform-service.secret-messagebroker.name" .) -}}
- name: ACTIVEMQ_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $mqConfigMap }}
      key: {{ .Values.messageBroker.existingConfigMap.keys.url }}
- name: ACTIVEMQ_USER
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .Values.messageBroker.existingSecret.keys.user }}
- name: ACTIVEMQ_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .Values.messageBroker.existingSecret.keys.password }}
{{- end -}}
