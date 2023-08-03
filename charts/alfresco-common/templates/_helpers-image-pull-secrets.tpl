{{/*
Read pull secrets from .Values.global

Usage: include "alfresco-common.imagePullSecrets" $

*/}}
{{- define "alfresco-common.imagePullSecrets" }}
{{- if .Values.global.alfrescoRegistryPullSecrets }}
imagePullSecrets:
  - name: {{ .Values.global.alfrescoRegistryPullSecrets }}
{{- end }}
{{- end }}

{{- define "alfresco-content-services.imagePullSecrets" }}
{{- template "alfresco-common.imagePullSecrets" . }}
{{- end }}
