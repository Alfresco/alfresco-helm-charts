{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-transform-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-transform-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alfresco-transform-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alfresco-transform-service.labels" -}}
helm.sh/chart: {{ include "alfresco-transform-service.chart" . }}
{{ include "alfresco-transform-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ .Chart.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alfresco-transform-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alfresco-transform-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alfresco-transform-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alfresco-transform-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create checksum annotations to trigger pods recreation on config changes
*/}}
{{- define "alfresco-transform-service.configsums" -}}
{{- $context := .Context -}}
{{- $component_config := printf "config-%s" .Component -}}
{{- range list "secret-messagebroker" $component_config }}
checksum.alfresco.org/{{ . }}: {{ include (print $context.Template.BasePath "/" . ".yaml") $context | sha256sum }}
{{- end }}
{{- end -}}
