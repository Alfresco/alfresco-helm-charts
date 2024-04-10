{{/*

Workaround broken sed replacement in docker image entrypoint scripts - ACTIVITI-5113

Usage: include "alfresco-activiti.activiti-5113.elasticsearch" $

*/}}
{{- define "alfresco-activiti.activiti-5113.elasticsearch" -}}
{{- $esScheme := include "alfresco-common.url.scheme" .Values.environment.ACTIVITI_ES_REST_CLIENT_ADDRESS }}
{{- $esHost := include "alfresco-common.url.host" .Values.environment.ACTIVITI_ES_REST_CLIENT_ADDRESS }}
{{- $urlRoot := index .Values "workaround" "ACTIVITI-5113" | ternary "\\/\\/" "//"}}
{{- printf "%s:%s%s" $esScheme $urlRoot $esHost }}
{{- end -}}
