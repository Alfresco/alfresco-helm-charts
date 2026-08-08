{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-connector-cic.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-connector-cic.fullname" -}}
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

{{- define "alfresco-connector-cic.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alfresco-connector-cic.labels" -}}
helm.sh/chart: {{ include "alfresco-connector-cic.chart" . }}
{{ include "alfresco-connector-cic.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ .Chart.Name }}
{{- with mustMerge .Values.additionalLabels .Values.global.additionalLabels }}
{{- toYaml . | nindent 0 }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alfresco-connector-cic.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alfresco-connector-cic.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alfresco-connector-cic.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alfresco-connector-cic.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Render a probe spec, injecting port from image.internalPort so values.yaml
does not duplicate it alongside internalPort.
Usage: include "alfresco-connector-cic.probe" (list <probeValues> <port>)
*/}}
{{- define "alfresco-connector-cic.probe" -}}
{{- $probe := deepCopy (index . 0) -}}
{{- $port := index . 1 -}}
{{- range list "httpGet" "tcpSocket" -}}
{{- with index $probe . -}}{{- $_ := set . "port" $port -}}{{- end -}}
{{- end -}}
{{- toYaml $probe -}}
{{- end -}}
