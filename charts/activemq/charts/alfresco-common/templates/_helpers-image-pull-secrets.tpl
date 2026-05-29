{{/*
Read pull secrets from .Values.global

Usage: include "alfresco-common.imagePullSecrets" $

*/}}
{{- define "alfresco-common.imagePullSecrets" }}
imagePullSecrets:
{{- with .Values }}
{{- range .imagePullSecrets }}
  - {{ toYaml . }}
{{- end }}
{{- if .global.alfrescoRegistryPullSecrets }}
  - name: {{ .global.alfrescoRegistryPullSecrets }}
{{- end }}
{{- end }}
{{- end }}

{{- define "alfresco-content-services.imagePullSecrets" }}
{{- template "alfresco-common.imagePullSecrets" . }}
{{- end }}
