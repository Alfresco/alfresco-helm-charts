{{/*
Define annotations as provided in values
*/}}
{{- define "alfresco-common.nginx.annotations" }}
{{- range $annotation, $value := .ingress.annotations }}
  {{- if ne $annotation "nginx.ingress.kubernetes.io/server-snippet" }}
  {{- $annotation | nindent 4 }}: |-
    {{- $value | nindent 6 }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Define required annotations for secure nginx ingress
We're overridong here ANY server snippet annotation and applying only ours trusted ones
*/}}
{{- define "alfresco-common.nginx.secure.annotations" }}
{{- template "alfresco-common.nginx.annotations" . }}
    nginx.ingress.kubernetes.io/server-snippet: |
      location ~ ^/.*/(wc)?s(ervice)?/api/solr/.*$ {return 403;}
      location ~ ^/.*/proxy/.*/api/solr/.*$ {return 403;}
      location ~ ^/.*/-default-/proxy/.*/api/.*$ {return 403;}
      location ~ ^/.*/s/prometheus$ {return 403;}
{{- end }}
