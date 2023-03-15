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
{{- coalesce .Values.messageBroker.url .Values.global.messageBroker.url (printf "failover:(nio://%s-%s-broker:%d)%s" .Release.Name .Values.messageBroker.nameOverride $brokerPort $brokerOptions) -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ Username
*/}}
{{- define "syncservice.brokerUser" -}}
{{- if .Values.activemq.enabled }}
{{- .Values.activemq.adminUser.user -}}
{{- else }}
{{- coalesce .Values.messageBroker.user .Values.global.messageBroker.user "alfresco" -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ Password
*/}}
{{- define "syncservice.brokerPass" -}}
{{- if .Values.activemq.enabled }}
{{- .Values.activemq.adminUser.password -}}
{{- else }}
{{- coalesce .Values.messageBroker.password .Values.global.messageBroker.password "admin" -}}
{{- end }}
{{- end -}}

{{/*
Get ActiveMQ secret
*/}}
{{- define "syncservice.brokerSecret" -}}
{{- if .Values.activemq.enabled }}
{{- coalesce .Values.activemq.existingSecretName (printf "%s-messagebroker-secret" (include "syncservice.fullname" . )) -}}
{{- else }}
{{- coalesce .Values.messageBroker.existingSecretName .Values.global.messageBroker.existingSecretName -}}
{{- end }}
{{- end -}}
