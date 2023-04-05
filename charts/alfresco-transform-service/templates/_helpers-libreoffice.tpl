{{- define "libreoffice.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-libreoffice
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "libreoffice.labels" -}}
chart: {{ include "alfresco-transform-service.chart" . }}
{{ include "libreoffice.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
