{{/*
Build up CSRF referer
*/}}
{{- define "alfresco-share.csrf.referer" -}}
{{- $known_urls := . }}
{{- $csrf_referers := list }}
{{- if kindIs "string" . }}
  {{- $known_urls = splitList "," . }}
{{- end }}
{{- range $known_urls }}
  {{- $parsed_url := urlParse . }}
  {{- $known_url := urlJoin (dict "host" $parsed_url.host "path" $parsed_url.path "scheme" $parsed_url.scheme) }}
  {{- $csrf_referers = append $csrf_referers $known_url }}
{{- end }}
{{- $csrf_referers | join "/*\\|" }}/*
{{- end -}}

{{/*
Build up CSRF Origin
*/}}
{{- define "alfresco-share.csrf.origin" -}}
{{- $known_urls := . }}
{{- $csrf_origins := list }}
{{- if kindIs "string" . }}
  {{- $known_urls = splitList "," . }}
{{- end }}
{{- range $known_urls }}
  {{- $parsed_url := urlParse . }}
  {{- $known_url := urlJoin (dict "host" $parsed_url.host "path" $parsed_url.path "scheme" $parsed_url.scheme) }}
  {{- $csrf_origins = append $csrf_origins $known_url }}
{{- end }}
{{- $csrf_origins | join "," }}
{{- end -}}

{{/*
Pick the main external host
*/}}
{{- define "alfresco-share.external.url" -}}
{{- $known_urls := .}}
{{- if kindIs "string" . }}
  {{- $known_urls = splitList "," . }}
{{- end }}
{{- $parsed_url := urlParse (first $known_urls) }}
{{- urlJoin (dict "host" $parsed_url.host "scheme" $parsed_url.scheme) }}
{{- end -}}
