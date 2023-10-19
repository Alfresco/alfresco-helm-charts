{{/*

Usage: include "alfresco-search-enterprise.activemq.url" $

*/}}
{{- define "alfresco-search-enterprise.activemq.url" -}}
{{- with .Values.activemq }}
{{- if .enabled }}
{{- $mqCtx := dict "Values" (dict "nameOverride" (.nameOverride | default "")) "Chart" (dict "Name" "activemq") "Release" $.Release }}
{{- printf "failover:(nio://%s-broker:61616)?timeout=3000&jms.useCompression=true" (include "activemq.fullname" $mqCtx) }}
{{- else }}
{{- required "Disabling in-cluster ActiveMQ requires passing (at least) messageBroker.url" $.Values.messageBroker.url }}
{{- end }}
{{- end }}
{{- end -}}

{{/*

Usage: include "alfresco-search-enterprise.activemq.cm.env" $

*/}}
{{- define "alfresco-search-enterprise.activemq.cm.env" -}}
{{- $mqCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- $mqCm := coalesce $.Values.messageBroker.existingConfigMap.name (include "alfresco-search-enterprise.fullname" $mqCtx) }}
- name: BROKER_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $mqCm }}
      key: {{ .Values.messageBroker.existingConfigMap.keys.url }}
{{- end -}}

{{/*

Usage: include "alfresco-search-enterprise.activemq.secret.env" $

*/}}
{{- define "alfresco-search-enterprise.activemq.secret.env" -}}
{{- $mqCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "mq")) "Chart" .Chart "Release" .Release }}
{{- $mqSecret := coalesce .Values.messageBroker.existingSecret.name (include "alfresco-search-enterprise.fullname" $mqCtx) }}
- name: BROKER_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .Values.messageBroker.existingSecret.keys.username }}
- name: BROKER_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $mqSecret }}
      key: {{ .Values.messageBroker.existingSecret.keys.password }}
{{- end -}}
