{{/*
Get ActiveMQ URL
*/}}
{{- define "syncservice.brokerUrl" -}}
{{- if .Values.messageBroker.enabled }}
{{- $brokerOptions := "?timeout=3000&jms.useCompression=true" }}
{{- $brokerPort := .Values.messageBroker.services.broker.ports.external.openwire | int }}
{{- $brokerHostname := include "activemq.fullname" (dict "Values" .Values.messageBroker "Chart" .Chart "Release" .Release) }}
{{- coalesce .Values.messageBroker.url (printf "failover:(nio://%s-broker:%d)%s" $brokerHostname $brokerPort $brokerOptions) }}
{{- else }}
{{- required "Please provide a failover URL when using external message broker" .Values.messageBroker.external.url -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ Username
*/}}
{{- define "syncservice.brokerUser" -}}
{{- if .Values.messageBroker.enabled }}
{{- .Values.messageBroker.adminUser.user | default "admin" -}}
{{- else }}
{{- .Values.messageBroker.external.user -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ Password
*/}}
{{- define "syncservice.brokerPass" -}}
{{- if .Values.messageBroker.enabled }}
{{- .Values.messageBroker.adminUser.pass | default "admin" -}}
{{- else }}
{{- .Values.messageBroker.external.password -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ secret
*/}}
{{- define "syncservice.brokerSecret" -}}
{{- if .Values.messageBroker.enabled }}
{{- coalesce .Values.messageBroker.existingSecretName (printf "%s-messagebroker-secret" (include "syncservice.fullname" . )) -}}
{{- else }}
{{- .Values.messageBroker.external.existingSecretName -}}
{{- end }}
{{- end -}}
