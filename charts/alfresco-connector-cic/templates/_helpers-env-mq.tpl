{{/*

Usage: include "alfresco-connector-cic.activemq.url" $

*/}}
{{- define "alfresco-connector-cic.activemq.url" -}}
{{- required "You need to provide an ActiveMQ URL using messageBroker.url or using an existingConfigMap check chart README file" $.Values.messageBroker.url }}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.activemq.cm.env" $

*/}}
{{- define "alfresco-connector-cic.activemq.cm.env" -}}
{{- with .Values.messageBroker }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.mq.fullname" $) }}
- name: SPRING_ACTIVEMQ_BROKERURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.url }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.activemq.secret.env" $

*/}}
{{- define "alfresco-connector-cic.activemq.secret.env" -}}
{{- with .Values.messageBroker }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.mq.fullname" $) }}
- name: SPRING_ACTIVEMQ_USER
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.username }}
- name: SPRING_ACTIVEMQ_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.password }}
{{- end -}}
{{- end -}}
