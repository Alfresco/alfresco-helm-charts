{{/*

Usage: include "alfresco-connector-hxi.activemq.url" $

*/}}
{{- define "alfresco-connector-hxi.activemq.url" -}}
{{- required "You need to provide an ActiveMQ URL using messageBroker.url or using an existingConfigMap check chart README file" $.Values.messageBroker.url }}
{{- end -}}

{{/*

Usage: include "alfresco-connector-hxi.activemq.cm.env" $

*/}}
{{- define "alfresco-connector-hxi.activemq.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- with .Values.messageBroker }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx) }}
- name: SPRING_ACTIVEMQ_BROKERURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.url }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-hxi.activemq.secret.env" $

*/}}
{{- define "alfresco-connector-hxi.activemq.secret.env" -}}
{{- $secretCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- with .Values.messageBroker }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-hxi.fullname" $secretCtx) }}
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
