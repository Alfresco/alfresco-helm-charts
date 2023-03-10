{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "syncservice.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "syncservice.selectorLabels" -}}
app: {{ template "syncservice.fullname" . }}
release: {{ .Release.Name }}
component: syncservice
{{- end }}

{{- define "syncservice.labels" -}}
chart: {{ .Chart.Name }}
{{ include "syncservice.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}

{{- define "syncservice.brokerSecret" -}}
{{- .Values.messageBroker.existingSecretName | default (printf "%s-messagebroker-secret" (include "syncservice.fullname" . )) -}}
{{- end }}
