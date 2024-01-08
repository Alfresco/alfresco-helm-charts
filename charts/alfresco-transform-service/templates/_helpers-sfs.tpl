{{/*
Set the Shared File Store URL for T-engines
*/}}
{{- define "alfresco-transform-service.sfs.url" -}}
{{- if .Values.filestore.enabled }}
FILE_STORE_URL: http://{{ template "alfresco-transform-service.filestore.name" . }}/alfresco/api/-default-/private/sfs/versions/1/file
{{- end }}
{{- end -}}
