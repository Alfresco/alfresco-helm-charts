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
