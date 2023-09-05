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
  {{- if .existingSecret.name }}
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

Usage: include "alfresco-repository.solr.cm dict "url" "" flavor ""

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
