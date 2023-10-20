{{/*

Usage: include "alfresco-search-enterprise.activemq.url" $

*/}}
{{- define "alfresco-search-enterprise.activemq.url" -}}
{{- required "You need to provide an ActiveMQ URL using messageBroker.url or using an existingConfigMap check chart README file" $.Values.messageBroker.url }}
{{- end -}}

{{/*

Usage: include "alfresco-search-enterprise.activemq.cm.env" $

*/}}
{{- define "alfresco-search-enterprise.activemq.cm.env" -}}
{{- $mqCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- with .Values.messageBroker }}
{{- $mqCm := coalesce .existingConfigMap.name (include "alfresco-search-enterprise.fullname" $mqCtx) }}
- name: BROKER_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $mqCm }}
      key: {{ .existingConfigMap.keys.url }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-search-enterprise.activemq.secret.env" $

*/}}
{{- define "alfresco-search-enterprise.activemq.secret.env" -}}
{{- $mqCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- with .Values.messageBroker }}
{{- $mqSecret := coalesce .existingSecret.name (include "alfresco-search-enterprise.fullname" $mqCtx) }}
- name: BROKER_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .existingSecret.keys.username }}
- name: BROKER_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .existingSecret.keys.password }}
{{- end -}}
{{- end -}}
