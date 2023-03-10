{{/*
Get ActiveMQ secret
*/}}
{{- define "syncservice.brokerSecret" -}}
{{- .Values.messageBroker.existingSecretName | default (printf "%s-messagebroker-secret" (include "syncservice.fullname" . )) -}}
{{- end }}
