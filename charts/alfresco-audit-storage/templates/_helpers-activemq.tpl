{{/*

Usage: include "alfresco-audit-storage.activemq.url" $

*/}}
{{- define "alfresco-audit-storage.activemq.url" -}}
{{- required "You need to provide an ActiveMQ URL using messageBroker.url or using an existingConfigMap check chart README file" $.Values.messageBroker.url }}
{{- end -}}

{{/*

Usage: include "alfresco-audit-storage.activemq.cm.env" $

*/}}
{{- define "alfresco-audit-storage.activemq.cm.env" -}}
{{- $mqCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- with .Values.messageBroker }}
{{- $mqCm := coalesce .existingConfigMap.name (include "alfresco-audit-storage.fullname" $mqCtx) }}
- name: SPRING_ACTIVEMQ_BROKERURL
  valueFrom:
    configMapKeyRef:
      name: {{ $mqCm }}
      key: {{ .existingConfigMap.keys.url }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-audit-storage.activemq.secret.env" $

*/}}
{{- define "alfresco-audit-storage.activemq.secret.env" -}}
{{- $mqCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- with .Values.messageBroker }}
{{- $mqSecret := coalesce .existingSecret.name (include "alfresco-audit-storage.fullname" $mqCtx) }}
- name: SPRING_ACTIVEMQ_USER
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .existingSecret.keys.username }}
- name: SPRING_ACTIVEMQ_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .existingSecret.keys.password }}
{{- end -}}
{{- end -}}
