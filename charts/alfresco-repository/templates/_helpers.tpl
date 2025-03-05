{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-repository.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-repository.fullname" -}}
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
{{- define "alfresco-repository.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alfresco-repository.labels" -}}
helm.sh/chart: {{ include "alfresco-repository.chart" . }}
{{ include "alfresco-repository.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: {{ .Chart.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alfresco-repository.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alfresco-repository.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alfresco-repository.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alfresco-repository.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define required annotations for secure ACS/SHARE API access

Usage: include "alfresco-repository.nginx.secure.annotations" ""

*/}}
{{- define "alfresco-repository.nginx.secure.annotations" -}}
{{- if eq "nginx" .Values.ingress.className }}
nginx.ingress.kubernetes.io/server-snippet: |
{{- if eq "solr" .Values.configuration.search.flavor }}
  location ~ ^/.*/(wc)?s(ervice)?/api/solr/.*$ {return 403;}
  location ~ ^/.*/proxy/.*/api/solr/.*$ {return 403;}
{{- end }}
  location ~ ^/.*/-default-/proxy/.*/api/.*$ {return 403;}
  location ~ ^/.*/s/prometheus$ {return 403;}
{{- end }}
{{- end }}
