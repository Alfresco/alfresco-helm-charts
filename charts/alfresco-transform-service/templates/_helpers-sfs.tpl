{{/*
Set the Shared File Store URL for T-engines
*/}}
{{- define "alfresco-transform-service.sfs.url" -}}
{{- if eq .Values.repository.edition "Enterprise" }}
FILE_STORE_URL: http://{{ template "alfresco-transform-service.deployment-filestore.name" . }}/alfresco/api/-default-/private/sfs/versions/1/file
{{- end }}
{{- end -}}
