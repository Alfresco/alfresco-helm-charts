{{/*
Validate search flavor by checking it is set to either "none", "solr6" or "elasticsearch"

Usage: include "alfresco-repository.search.flavor.valid" "FLAVOR"

*/}}
{{- define "alfresco-repository.search.flavor.valid" -}}
{{- if not (mustHas . (list "none" "solr6" "elasticsearch")) }}
  {{- fail "Search Service flavor MUST be one of 'none', 'solr6' or 'elasticsearch'" }}
{{- else -}}
  {{- . }}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Repository search URL from values or secret

Usage: include "alfresco-repository.search.url" (dict "ns" "" "search" (dict "url" "" "existingConfigMap" (dict "name" "" "keys" (dict "url" ""))))

*/}}
{{- define "alfresco-repository.search.url" -}}
{{ $ns := .ns }}
{{- with .Values.configuration.search }}
  {{- if .existingConfigMap.name }}
    {{- $defaultLookup := (dict "data" dict) }}
    {{- $lookup := ((lookup "v1" "ConfigMap" $ns (.existingConfgMap.name)).data | default $defaultLookup) }}
    {{- pick $lookup .existingConfigMap.keys.url }}
  {{- else -}}
    {{- required "If you want to use a search service, either provide a url or a configmap containing that URL" .url }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Check whether a Solr shared secret was provided

Usage: include "alfresco-repository.solr.security" (dict "ns" "" "search" (dict "existingConfigMap" (dict "name" "" "keys" (dict "solr-secret" ""))))

*/}}
{{- define "alfresco-repository.solr.security" -}}
{{ $ns := .ns }}
{{- with .search }}
  {{- if .existingSecret.name }}
    {{- $defaultLookup := (dict "data" dict) }}
    {{- $lookup := ((lookup "v1" "Secret" $ns (.existingSecret.name)).data | default $defaultLookup) }}
    {{- hasKey $lookup (index .existingSecret.keys "solr-secret") | ternary "secret" "none" }}
  {{- else -}}
    {{- not (empty (index . "solr-secret")) | ternary "secret" "none" }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Alfresco Repository search configuration

Usage: include "alfresco-repository.search.config" $

*/}}
{{- define "alfresco-repository.search.config" -}}
{{- $search_url := include "alfresco-repository.search.url" . }}
{{- with .Values.configuration.search }}
  {{- if eq "solr6" (include "alfresco-repository.search.flavor.valid" .flavor) }}
  -Dsolr.host={{ template "alfresco-common.url.host" $search_url }}
  -Dsolr.port={{ template "alfresco-common.url.port" $search_url }}
  -Dsolr.base.url={{ include "alfresco-common.url.path" $search_url | default "/solr" }}
  -Dsolr.secureComms={{ include "alfresco-repository.solr.security" (dict "ns" $.Release.Namespace "search" . )}}
  {{- end }}
{{- end }}
{{- end -}}
