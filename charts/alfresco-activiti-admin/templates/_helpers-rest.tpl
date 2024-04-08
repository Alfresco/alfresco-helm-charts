{{- define "alfresco-activiti-admin.rest.baseUrl" -}}
{{- $restScheme := include "alfresco-common.url.scheme" .Values.environment.ACTIVITI_ADMIN_REST_APP_HOST }}
{{- $restHost := include "alfresco-common.url.host" .Values.environment.ACTIVITI_ADMIN_REST_APP_HOST }}
{{- $urlRoot := index .Values "workaround" "ACTIVITI-5113" | ternary "\\/\\/" "//"}}
{{- printf "%s:%s%s" $restScheme $urlRoot $restHost }}
{{- end -}}
