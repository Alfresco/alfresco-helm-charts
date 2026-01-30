{{/*
Expand the name of the chart.
*/}}
{{- define "elastic.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "elastic.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "elastic.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "elastic.labels" -}}
helm.sh/chart: {{ include "elastic.chart" . }}
{{ include "elastic.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with mustMerge .Values.additionalLabels .Values.global.additionalLabels }}
{{- toYaml . | nindent 0 }}
{{- end }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "elastic.selectorLabels" -}}
app.kubernetes.io/name: {{ include "elastic.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Get the name of the secret containing Elasticsearch credentials.
*/}}
{{- define "elastic.es-secret-name" -}}
{{- if .Values.elasticsearch.credentials.existingSecret.name }}
{{- .Values.elasticsearch.credentials.existingSecret.name }}
{{- else }}
{{- printf "%s-es-credentials" (include "elastic.fullname" .) }}
{{- end }}
{{- end -}}

{{- define "elastic.es-servicename" -}}
{{ include "elastic.fullname" . }}
{{- end -}}

{{- define "elastic.kibana-servicename" -}}
{{ include "elastic.fullname" . }}-kibana
{{- end -}}
