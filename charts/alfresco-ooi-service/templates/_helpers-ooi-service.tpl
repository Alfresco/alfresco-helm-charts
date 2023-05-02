{{- define "alfresco-ooi-service..selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-ooi-service
release: {{ .Release.Name }}
component: ooiservice
{{- end }}

{{- define "alfresco-ooi-service.labels" -}}
chart: {{ include "alfresco-ooi-service.chart" . }}
{{ include "alfresco-ooi-service..selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
