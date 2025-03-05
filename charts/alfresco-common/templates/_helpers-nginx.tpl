{{/*
Define annotations as provided in values
Skip ANY server-snippet annotation (CVE-2021-25742)

Usage: include "alfresco-common.nginx.annotations" $

*/}}
{{- define "alfresco-common.nginx.annotations" }}
{{- range $annotation, $value := .ingress.annotations }}
  {{- if ne $annotation "nginx.ingress.kubernetes.io/server-snippet" }}
  {{- $annotation | nindent 4 }}: |-
    {{- $value | nindent 6 }}
  {{- end }}
{{- end }}
{{- end }}
