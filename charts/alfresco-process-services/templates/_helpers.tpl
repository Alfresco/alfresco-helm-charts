{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-process-services.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-process-services.fullname" -}}
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
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "aps.fullname" -}}
{{- template "alfresco-process-services.fullname" . }}
{{- end -}}

{{/*
Compute database related resources name

Usage "alfresco-process-services.database-aps" $

*/}}

{{- define "alfresco-process-services.database-aps" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "alfresco-process-services-database-aps") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}

{{/*
Compute database related resources name

Usage "alfresco-process-services.database-admin" $

*/}}

{{- define "alfresco-process-services.database-admin" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "alfresco-process-services-database-admin") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}

{{/*
Compute database related resources name

Usage "alfresco-process-services.database" $

*/}}

{{- define "alfresco-process-services.database" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "alfresco-process-services-database") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}
