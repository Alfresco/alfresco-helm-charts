{{/*
Read pull secrets from .Values.imagePullSecrets or .Values.global.alfrescoRegistryPullSecrets.
Supports both a list of {name: ...} objects and plain string values.

Usage: include "alfresco-common.imagePullSecrets" .

*/}}
{{- define "alfresco-common.imagePullSecrets" }}
imagePullSecrets:
{{- with .Values }}
{{- range .imagePullSecrets }}
  {{- if kindIs "string" . }}
  - name: {{ . }}
  {{- else }}
  - {{ toYaml . }}
  {{- end }}
{{- end }}
{{- if and (hasKey . "global") .global.alfrescoRegistryPullSecrets }}
  - name: {{ .global.alfrescoRegistryPullSecrets }}
{{- end }}
{{- end }}
{{- end }}

{{- define "alfresco-content-services.imagePullSecrets" }}
{{- template "alfresco-common.imagePullSecrets" . }}
{{- end }}
