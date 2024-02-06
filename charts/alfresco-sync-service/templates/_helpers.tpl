{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-sync-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-sync-service.fullname" -}}
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
{{- define "alfresco-sync-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alfresco-sync-service.labels" -}}
helm.sh/chart: {{ include "alfresco-sync-service.chart" . }}
{{ include "alfresco-sync-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ template "alfresco-sync-service.name" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alfresco-sync-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alfresco-sync-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alfresco-sync-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alfresco-sync-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "alfresco-sync-service.repository" -}}
{{- if .Values.repository.nameOverride }}
{{- printf "%s-%s" .Release.Name .Values.repository.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Values.repository.host }}
{{- end }}
{{- end -}}
