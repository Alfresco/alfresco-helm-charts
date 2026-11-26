{{/*
Known URLs are the URLs we can trust.
Splits on commas and/or whitespace, handles both "url1, url2" and "url1 url2" formats.

Usage: include "alfresco-common.known.urls" .

*/}}
{{- define "alfresco-common.known.urls" -}}
{{- $known_urls := coalesce .Values.known_urls (and (hasKey .Values "global") .Values.global.known_urls) "http://localhost,https://localhost" }}
{{- if kindIs "string" $known_urls }}
  {{- /* Replace common separators with comma, then split */ -}}
  {{- $known_urls = regexReplaceAll "\\s+|,\\s*" $known_urls "," }}
  {{- $known_urls = splitList "," $known_urls }}
  {{- /* Filter empty items */ -}}
  {{- $known_urls = compact $known_urls }}
{{- end }}
{{- if empty $known_urls }}
  {{- fail "No valid URLs found in known_urls after parsing" }}
{{- end }}
{{- $normalized := list }}
{{- range $known_urls }}
  {{- $trimmed := trim . }}
  {{- if not (or (hasPrefix "http://" $trimmed) (hasPrefix "https://" $trimmed)) }}
    {{- fail (printf "known_urls entry '%s' MUST start with a scheme (http:// or https://)" $trimmed) }}
  {{- end }}
  {{- $normalized = append $normalized $trimmed }}
{{- end }}
{{- mustToJson (dict "known_urls" $normalized) }}
{{- end -}}

{{/*
Build up CSRF referer with pipe-separated regex patterns.
Note: Share image's substituter.sh uses sed with | as delimiter,
so the pipe separator is escaped as \| in template output.

Usage: include "alfresco-common.csrf.referer" .

*/}}
{{- define "alfresco-common.csrf.referer" -}}
{{- $csrf_referers := list }}
{{- range index (include "alfresco-common.known.urls" . | fromJson) "known_urls" }}
  {{- $url := trimSuffix "/" . }}
  {{- $parsed_url := urlParse $url }}
  {{- $known_url := urlJoin (dict "host" $parsed_url.host "path" $parsed_url.path "scheme" $parsed_url.scheme) }}
  {{- $csrf_referers = append $csrf_referers $known_url }}
{{- end }}
{{- $csrf_referers | join "/.*\\|" }}/.*
{{- end -}}

{{/*
Build up CSRF Origin with pipe-separated values.
Note: Share image's substituter.sh uses sed with | as delimiter,
so the pipe separator is escaped as \| in template output.

Usage: include "alfresco-common.csrf.origin" .

*/}}
{{- define "alfresco-common.csrf.origin" -}}
{{- $csrf_origins := list }}
{{- range index (include "alfresco-common.known.urls" . | fromJson) "known_urls" }}
  {{- $url := trimSuffix "/" . }}
  {{- $parsed_url := urlParse $url }}
  {{- $known_url := urlJoin (dict "host" $parsed_url.host "scheme" $parsed_url.scheme) }}
  {{- $csrf_origins = append $csrf_origins $known_url }}
{{- end }}
{{- $csrf_origins | join "\\|" }}
{{- end -}}

{{/*
Pick the main external URL

Usage: include "alfresco-common.external.url" $

*/}}
{{- define "alfresco-common.external.url" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- urlJoin (dict "host" $parsed_url.host "scheme" $parsed_url.scheme) }}
{{- end -}}

{{/*
Pick the main external host

Usage: include "alfresco-common.external.host" $

*/}}
{{- define "alfresco-common.external.host" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- $parsed_url.host | splitList ":" | first }}
{{- end -}}

{{/*
Pick the main external port.

Usage: include "alfresco-common.external.port" $

*/}}
{{- define "alfresco-common.external.port" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- if gt ($parsed_url.host | splitList ":" | len) 1 }}
  {{- $parsed_url.host | splitList ":" | last }}
{{- else }}
  {{- eq (include "alfresco-common.external.scheme" .) "https" | ternary 443 80 }}
{{- end }}
{{- end -}}

{{/*
Pick the main external scheme

Usage: include "alfresco-common.external.scheme" $

*/}}
{{- define "alfresco-common.external.scheme" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- $parsed_url.scheme }}
{{- end -}}

{{/*
Pick the URL scheme

Usage: include "alfresco-common.url.scheme" "URL"

*/}}
{{- define "alfresco-common.url.scheme" -}}
{{- $parsed_url := urlParse . }}
{{- $parsed_url.scheme | default "http" }}
{{- end -}}

{{/*
Pick the URL hostname (without port, see url.port)

Usage: include "alfresco-common.url.host" "URL"

*/}}
{{- define "alfresco-common.url.host" -}}
{{- $parsed_url := urlParse . }}
{{- $parsed_url.hostname }}
{{- end -}}

{{/*
Pick the URL port

Usage: include "alfresco-common.url.port" "URL"

*/}}
{{- define "alfresco-common.url.port" -}}
{{- $parsed_url := urlParse . }}
{{- if gt ($parsed_url.host | splitList ":" | len) 1 }}
  {{- $parsed_url.host | splitList ":" | last }}
{{- else }}
  {{- eq (include "alfresco-common.url.scheme" .) "https" | ternary 443 80 }}
{{- end }}
{{- end -}}

{{/*
Pick the URL path

Usage: include "alfresco-common.url.path" "URL"

*/}}
{{- define "alfresco-common.url.path" -}}
{{- $parsed_url := urlParse . }}
{{- $parsed_url.path }}
{{- end -}}

{{/*
Pick the URL query params

Usage: include "alfresco-common.url.query" "URL"

*/}}
{{- define "alfresco-common.url.query" -}}
{{- $parsed_url := urlParse . }}
{{- $parsed_url.query }}
{{- end -}}
