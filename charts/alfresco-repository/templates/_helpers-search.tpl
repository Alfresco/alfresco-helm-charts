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
  -Dsolr.host="$SOLR_HOST"
  -Dsolr.port="$SOLR_PORT"
  -Dsolr.base.url="$SOLR_BASE_URL"
  {{- $solr_comms := include "alfresco-repository.solr.security" . }}
  -Dsolr.secureComms={{ $solr_comms }}
  {{- if eq "secret" $solr_comms }}
  -Dsolr.sharedSecret=$SOLR_SECRET
  {{- end }}
  {{- else if eq "elasticsearch" (include "alfresco-repository.search.flavor.valid" .flavor) }}
  -Delasticsearch.host=$ELASTICSEARCH_HOST
  -Delasticsearch.port=$ELASTICSEARCH_PORT
  -Delasticsearch.secureComms=$ELASTICSEARCH_SECURECOMMS
  -Delasticsearch.user=$ELASTICSEARCH_USERNAME
  -Delasticsearch.password=$ELASTICSEARCH_PASSWORD
  -Delasticsearch.createIndexIfNotExists=true
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Compute Alfresco Repository Solr env from search URL

Usage: include "alfresco-repository.solr.cm "URL"

*/}}
{{- define "alfresco-repository.solr.cm" -}}
SOLR_HOST: {{ template "alfresco-common.url.host" . }}
SOLR_PORT: {{ include "alfresco-common.url.port" . | quote }}
SOLR_BASE_URL: {{ include "alfresco-common.url.path" . | default "/solr" }}
{{- end -}}

{{/*
Compute Alfresco Repository Elasticsearch env from search URL

Usage: include "alfresco-repository.elasticsearch.cm "URL"

*/}}
{{- define "alfresco-repository.elasticsearch.cm" -}}
ELASTICSEARCH_HOST: {{ template "alfresco-common.url.host" . }}
ELASTICSEARCH_PORT: {{ include "alfresco-common.url.port" . | quote }}
ELASTICSEARCH_SECURECOMMS: {{ eq "https" (include "alfresco-common.url.scheme" .) | ternary "https" "none"  }}
{{- end -}}
