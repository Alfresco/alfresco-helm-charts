{{/*
Get Alfresco Solr context
*/}}
{{- define "alfresco-search.baseurl" -}}
{{- if index $.Values "alfresco-search" "enabled" -}}
  /solr
{{- else -}}
  {{ index $.Values "alfresco-search" "external" "context" | default "/solr" -}}
{{- end -}}
{{- end -}}

{{/*
Required Solr secret
*/}}
{{- define "tracking-shared-secret" -}}
  {{- required "You need to provide a shared secret for Solr/repo authentication , see https://github.com/Alfresco/acs-deployment/tree/master/docs/helm" .Values.global.tracking.sharedsecret -}}
{{- end }}
