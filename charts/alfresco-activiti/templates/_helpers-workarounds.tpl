{{/*

Kept here for backward compatibility but was actually broken. If you were using
it remove it from your charts.

To be removed in next major bump (OPSEXP-3376).

Usage: include "alfresco-activiti.activiti-5113.elasticsearch" $

*/}}
{{- define "alfresco-activiti.activiti-5113.elasticsearch" -}}
{{- .Values.environment.ACTIVITI_ES_REST_CLIENT_ADDRESS }}
{{- end -}}
