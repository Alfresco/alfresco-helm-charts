{{/*
Get ActiveMQ URL
*/}}
{{- define "alfresco-sync-service.brokerUrl" -}}
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
Get ActiveMQ secret
*/}}
{{- define "alfresco-sync-service.brokerSecret" -}}
{{- if .Values.activemq.enabled }}
{{- coalesce .Values.activemq.existingSecretName (printf "%s-messagebroker-secret" (include "alfresco-sync-service.fullname" . )) -}}
{{- else }}
{{- coalesce .Values.messageBroker.existingSecretName .Values.global.messageBroker.existingSecretName -}}
{{- end }}
{{- end -}}
