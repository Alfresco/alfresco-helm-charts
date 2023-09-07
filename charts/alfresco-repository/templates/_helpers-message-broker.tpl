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

{{/*
Render message broker configmap

Usage: include "alfresco-repository.mq.cm" "URL"

*/}}
{{- define "alfresco-repository.mq.cm" -}}
  BROKER_URL: {{ template "alfresco-repository.mq.url.valid" . }}
{{- end -}}
