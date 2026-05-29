{{/*
Validate ActiveMQ has a failover transport URL

Usage: include "alfresco-common.activemq.url.withFailover" "URL"

*/}}
{{- define "alfresco-common.activemq.url.withFailover" -}}
{{- if hasPrefix "failover:(" . }}
  {{- . }}
{{- else -}}
  {{- printf "failover:(%s)" . }}
{{- end }}
{{- end -}}

{{/*
Render ActiveMQ broker configmap

Usage: include "alfresco-common.activemq.cm" "URL"

*/}}
{{- define "alfresco-common.activemq.cm" -}}
  BROKER_URL: {{ template "alfresco-common.activemq.url.withFailover" . }}
{{- end -}}

{{/*
Provide generic ActiveMQ env vars

Usage: include "alfresco-common.activemq.env" ""

*/}}
{{- define "alfresco-common.activemq.env" -}}
- name: ACTIVEMQ_URL
  value: $(BROKER_URL)
- name: ACTIVEMQ_USER
  value: $(BROKER_USERNAME)
- name: ACTIVEMQ_PASSWORD
  value: $(BROKER_PASSWORD)
{{- end -}}

{{- define "activemq.env" -}}
{{- template "alfresco-common.activemq.env" . }}
{{- end -}}

{{/*
Provide Spring ActiveMQ env vars

Usage: include "alfresco-common.spring.activemq.env" ""

*/}}
{{- define "alfresco-common.spring.activemq.env" -}}
- name: SPRING_ACTIVEMQ_BROKERURL
  value: $(BROKER_URL)
- name: SPRING_ACTIVEMQ_USER
  value: $(BROKER_USERNAME)
- name: SPRING_ACTIVEMQ_PASSWORD
  value: $(BROKER_PASSWORD)
{{- end -}}

{{- define "spring.activemq.env" -}}
{{- template "alfresco-common.spring.activemq.env" . }}
{{- end -}}
