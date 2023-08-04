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

{{/*
Define required annotations for secure ACS/SHARE API access

Usage: include "alfresco-common.nginx.secure.annotations" ""

*/}}
{{- define "alfresco-common.nginx.secure.annotations" }}
    nginx.ingress.kubernetes.io/server-snippet: |
      location ~ ^/.*/(wc)?s(ervice)?/api/solr/.*$ {return 403;}
      location ~ ^/.*/proxy/.*/api/solr/.*$ {return 403;}
      location ~ ^/.*/-default-/proxy/.*/api/.*$ {return 403;}
      location ~ ^/.*/s/prometheus$ {return 403;}
{{- end }}
