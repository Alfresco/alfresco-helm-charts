{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "alfresco-process-services.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "aps.fullname" -}}
{{- template "alfresco-process-services.fullname" . }}
{{- end -}}

{{/*
Compute database related resources name

Usage "alfresco-process-services.database" $

*/}}

{{- define "alfresco-process-services.database" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "alfresco-process-services-database") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}
