{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-connector-msteams.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-connector-msteams.fullname" -}}
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
{{- define "alfresco-connector-msteams.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alfresco-connector-msteams.labels" -}}
helm.sh/chart: {{ include "alfresco-connector-msteams.chart" . }}
{{ include "alfresco-connector-msteams.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ .Chart.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alfresco-connector-msteams.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alfresco-connector-msteams.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alfresco-connector-msteams.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alfresco-connector-msteams.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "alfresco-connector-msteams.secret.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "msteams-se") "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-msteams.fullname" $scope }}
{{- end }}

{{/*
Create the name of the configmap to use
*/}}
{{- define "alfresco-connector-msteams.repo-configmap.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repo-teams") "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-connector-msteams.fullname" $scope }}
{{- end }}
