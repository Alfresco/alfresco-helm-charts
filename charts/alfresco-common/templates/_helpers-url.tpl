{{/*
Known URLs are the URL we can trust
*/}}
{{- define "alfresco-common.known.urls" -}}
{{- $known_urls := coalesce .Values.known_urls .Values.global.known_urls "http://localhost,https://localhost" }}
{{- if kindIs "string" $known_urls }}
  {{- $known_urls = splitList "," $known_urls }}
{{- end }}
{{- mustToJson (dict "known_urls" $known_urls) }}
{{- end -}}

{{/*
Build up CSRF referer
*/}}
{{- define "alfresco-common.csrf.referer" -}}
{{- $csrf_referers := list }}
{{- range index (include "alfresco-common.known.urls" . | fromJson) "known_urls" }}
  {{- $parsed_url := urlParse . }}
  {{- $known_url := urlJoin (dict "host" $parsed_url.host "path" $parsed_url.path "scheme" $parsed_url.scheme) }}
  {{- $csrf_referers = append $csrf_referers $known_url }}
{{- end }}
{{- $csrf_referers | join "/.*\\|" }}/.*
{{- end -}}

{{/*
Build up CSRF Origin
*/}}
{{- define "alfresco-common.csrf.origin" -}}
{{- $csrf_origins := list }}
{{- range index (include "alfresco-common.known.urls" . | fromJson) "known_urls" }}
  {{- $parsed_url := urlParse . }}
  {{- $known_url := urlJoin (dict "host" $parsed_url.host "scheme" $parsed_url.scheme) }}
  {{- $csrf_origins = append $csrf_origins $known_url }}
{{- end }}
{{- $csrf_origins | join "," }}
{{- end -}}

{{/*
Pick the main external URL
*/}}
{{- define "alfresco-common.external.url" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- urlJoin (dict "host" $parsed_url.host "scheme" $parsed_url.scheme) }}
{{- end -}}

{{/*
Pick the main external host
*/}}
{{- define "alfresco-common.external.host" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- $parsed_url.host }}
{{- end -}}

{{/*
Pick the main external port.
Returns empty if not specified, consuming template should handle defaults
*/}}
{{- define "alfresco-common.external.port" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- if gt ($parsed_url.host | splitList ":") 1 }}
  {{- $parsed_url.host | splitList ":" | last }}
{{- end }}
{{- end -}}

{{/*
Pick the main external scheme
*/}}
{{- define "alfresco-common.external.scheme" -}}
{{- $parsed_url := urlParse (index (include "alfresco-common.known.urls" . | fromJson) "known_urls" | first) }}
{{- $parsed_url.scheme }}
{{- end -}}
