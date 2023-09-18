{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-search-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-search-service.fullname" -}}
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
Alfresco Search Service Host
*/}}
{{- define "alfresco-search.host" -}}
  {{ printf "%s-solr" (include "alfresco-search-service.fullname" .) }}
{{- end -}}

{{/*
Get Alfresco Search container Port ("internal")
*/}}
{{- define "alfresco-search.containerPort" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- .Values.insightEngineImage.internalPort | default 8983 | int -}}
{{- else }}
{{- .Values.searchServicesImage.internalPort | default 8983 | int -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Service Port
*/}}
{{- define "alfresco-search.svcPort" -}}
{{- $defaultSvcPort := 80 }}
{{- if hasKey .Values "service" }}
  {{- coalesce .Values.service.externalPort $defaultSvcPort | int }}
{{- else }}
  {{- $defaultSvcPort | int }}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Pull Policy
*/}}
{{- define "alfresco-search.pullPolicy" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- print .Values.insightEngineImage.pullPolicy -}}
{{- else }}
{{- print .Values.searchServicesImage.pullPolicy -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Docker Image
*/}}
{{- define "alfresco-search.dockerImage" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
  {{- printf "%s:%s" .Values.insightEngineImage.repository .Values.insightEngineImage.tag }}
{{- else }}
  {{- printf "%s:%s" .Values.searchServicesImage.repository .Values.searchServicesImage.tag }}
{{- end }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alfresco-search-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alfresco-search-service.labels" -}}
helm.sh/chart: {{ include "alfresco-search-service.chart" . }}
{{ include "alfresco-search-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alfresco-search-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alfresco-search-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alfresco-search-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alfresco-search-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
