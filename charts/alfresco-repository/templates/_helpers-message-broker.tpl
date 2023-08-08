{{/*
Validate ActiveMQ is a failover transport URL

Usage: include "alfresco-repository.mq.url.valid" "URL"

*/}}
{{- define "alfresco-repository.mq.url.valid" -}}
{{- if hasPrefix "failover:(" . }}
  {{- . }}
{{- else -}}
  {{- printf "failover:(%s)" . }}
{{- end }}
{{- end -}}
