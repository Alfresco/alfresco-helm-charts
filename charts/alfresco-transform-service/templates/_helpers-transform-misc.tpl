{{- define "transform-misc.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-transform-misc
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "transform-misc.labels" -}}
chart: {{ include "alfresco-transform-service.chart" . }}
{{ include "transform-misc.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
