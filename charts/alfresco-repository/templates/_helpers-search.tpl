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
  {{- $search_url := include "alfresco-common.read.cm.then.value" (dict "ns" $.Release.Namespace "key" "url" "context" .) }}
  {{- if eq "solr6" (include "alfresco-repository.search.flavor.valid" .flavor) }}
  -Dsolr.host={{ template "alfresco-common.url.host" $search_url }}
  -Dsolr.port={{ template "alfresco-common.url.port" $search_url }}
  -Dsolr.base.url={{ include "alfresco-common.url.path" $search_url | default "/solr" }}
  {{- $solr_comms := include "alfresco-repository.solr.security" . }}
  -Dsolr.secureComms={{ $solr_comms }}
  {{- if eq "secret" $solr_comms }}
  -Dsolr.sharedSecret=$SOLR_SECRET
  {{- end }}
  {{- else if eq "elasticsearch" (include "alfresco-repository.search.flavor.valid" .flavor) }}
  -Delasticsearch.host={{ template "alfresco-common.url.host" $search_url }}
  -Delasticsearch.port={{ template "alfresco-common.url.port" $search_url }}
  -Delasticsearch.secureComms={{ eq "https" (include "alfresco-common.url.scheme" $search_url) | ternary "https" "none"  }}
  -Delasticsearch.user=$ELASTICSEARCH_USERNAME
  -Delasticsearch.password=$ELASTICSEARCH_PASSWORD
  -Delasticsearch.createIndexIfNotExists=true
  {{- end }}
{{- end }}
{{- end -}}
