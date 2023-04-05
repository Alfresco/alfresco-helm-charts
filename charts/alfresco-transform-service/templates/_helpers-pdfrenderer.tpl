{{- define "pdfrenderer.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-pdfrenderer
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "pdfrenderer.labels" -}}
chart: {{ include "alfresco-transform-service.chart" . }}
{{ include "pdfrenderer.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
