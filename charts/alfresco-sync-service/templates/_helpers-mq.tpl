{{/*
Get ActiveMQ URL
*/}}
{{- define "syncservice.brokerUrl" -}}
{{- $brokerOptions := "?timeout=3000&jms.useCompression=true" }}
{{- $brokerPort := .Values.activemq.services.broker.ports.external.openwire | int }}
{{- if .Values.activemq.enabled }}
{{- $brokerHostname := include "activemq.fullname" (dict "Values" .Values.activemq "Chart" .Chart "Release" .Release) }}
{{- printf "failover:(nio://%s-broker:%d)%s" $brokerHostname $brokerPort $brokerOptions }}
{{- else }}
{{- coalesce .Values.messageBroker.url (printf "failover:(nio://%s-%s-broker:%d)%s" .Release.Name .Values.messageBroker.nameOverride $brokerPort $brokerOptions) -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ Username
*/}}
{{- define "syncservice.brokerUser" -}}
{{- if .Values.activemq.enabled }}
{{- .Values.activemq.adminUser.user -}}
{{- else }}
{{- .Values.messageBroker.user -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ Password
*/}}
{{- define "syncservice.brokerPass" -}}
{{- if .Values.activemq.enabled }}
{{- .Values.activemq.adminUser.password -}}
{{- else }}
{{- .Values.messageBroker.password -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ secret
*/}}
{{- define "syncservice.brokerSecret" -}}
{{- if .Values.activemq.enabled }}
{{- coalesce .Values.activemq.existingSecretName (printf "%s-messagebroker-secret" (include "syncservice.fullname" . )) -}}
{{- else }}
{{- .Values.messageBroker.existingSecretName -}}
{{- end }}
{{- end -}}
