{{- define "tika.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-tika
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "tika.labels" -}}
chart: {{ include "alfresco-transform-service.chart" . }}
{{ include "tika.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
