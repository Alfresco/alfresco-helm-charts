{{/*
Validate search flavor by checking it is set to either "noindex", "solr6" or "elasticsearch"

Usage: include "alfresco-repository.search.flavor.valid" "FLAVOR"

*/}}
{{- define "alfresco-repository.search.flavor.valid" -}}
{{- if not (mustHas . (list "noindex" "solr6" "elasticsearch")) }}
  {{- fail "Search Service flavor MUST be one of 'noindex', 'solr6' or 'elasticsearch'" }}
{{- else -}}
  {{- . }}
{{- end }}
{{- end -}}

{{/*
Check whether a Solr shared secret was provided

Usage: include "alfresco-repository.solr.security" (dict "search" (dict "existingConfigMap" (dict "name" "" "keys" (dict "solr-secret" ""))))

*/}}
{{- define "alfresco-repository.solr.security" -}}
{{- if .existingSecret.name }}
  {{- print "secret" }}
{{- else }}
  {{- not (empty (index . "solr-secret")) | ternary "secret" "none" }}
{{- end }}
{{- end -}}

{{/*
Alfresco Repository search configuration

Usage: include "alfresco-repository.search.config" $

*/}}
{{- define "alfresco-repository.search.config" -}}
{{- with .Values.configuration.search }}
  {{- if eq "solr6" (include "alfresco-repository.search.flavor.valid" .flavor) }}
  -Dsolr.host="$SEARCH_HOST"
  -Dsolr.port="$SEARCH_PORT"
  -Dsolr.base.url="$SOLR_BASE_URL"
  -Dsolr.secureComms="$SEARCH_SECURECOMMS"
  {{- if or .existingSecret.name (index . "solr-secret") }}
  -Dsolr.sharedSecret=$SOLR_SECRET
  {{- end }}
  {{- else if eq "elasticsearch" (include "alfresco-repository.search.flavor.valid" .flavor) }}
  -Delasticsearch.host=$SEARCH_HOST
  -Delasticsearch.port=$SEARCH_PORT
  -Delasticsearch.secureComms=$SEARCH_SECURECOMMS
  -Delasticsearch.user=$ELASTICSEARCH_USERNAME
  -Delasticsearch.password=$ELASTICSEARCH_PASSWORD
  -Delasticsearch.createIndexIfNotExists=true
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Compute Alfresco Repository Solr env from search configuration context

Usage: include "alfresco-repository.solr.cm dict "url" "" "solr-secret" "" "existingSecret" (dict "name" "")

*/}}
{{- define "alfresco-repository.solr.cm" -}}
SEARCH_HOST: {{ template "alfresco-common.url.host" .url }}
SEARCH_PORT: {{ include "alfresco-common.url.port" .url | quote }}
SEARCH_SECURECOMMS: {{ template "alfresco-repository.solr.security" . }}
SOLR_BASE_URL: {{ include "alfresco-common.url.path" .url | default "/solr" }}
{{- end -}}

{{/*
Compute Alfresco Repository Elasticsearch env from search URL

Usage: include "alfresco-repository.elasticsearch.cm "URL"

*/}}
{{- define "alfresco-repository.elasticsearch.cm" -}}
SEARCH_HOST: {{ template "alfresco-common.url.host" . }}
SEARCH_PORT: {{ include "alfresco-common.url.port" . | quote }}
SEARCH_SECURECOMMS: {{ eq "https" (include "alfresco-common.url.scheme" .) | ternary "https" "none"  }}
{{- end -}}

{{/*
Render search config as env vars in deployment
*/}}
{{- define "alfresco-repository.search.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" "alfresco-search") "Chart" .Chart "Release" .Release }}
{{- $flavor := include "alfresco-repository.search.flavor.valid" $.Values.configuration.search.flavor }}
{{- with .Values.configuration.search }}
{{- $cm := coalesce .existingConfigMap.name (include "alfresco-repository.fullname" $cmCtx) }}
- name: SEARCH_FLAVOR
  valueFrom:
    configMapKeyRef:
      name: {{ $cm }}
      key: {{ .existingConfigMap.keys.flavor }}
{{- if ne "noindex" $flavor }}
{{- range list "host" "port" "securecomms" }}
- name: {{ printf "SEARCH_%s" (upper .) }}
  valueFrom:
    configMapKeyRef:
      name: {{ $cm }}
      key: {{ index $.Values.configuration.search.existingConfigMap.keys . }}
{{- end }}
{{- end }}
{{- if eq "solr6" $flavor }}
- name: SOLR_BASE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $cm }}
      key: {{ .existingConfigMap.keys.solr_base_url }}
{{- end }}
{{- end }}
{{- end -}}
