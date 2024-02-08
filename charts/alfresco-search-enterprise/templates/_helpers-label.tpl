{{- define "alfresco-search-enterprise.mediation.labels" -}}
{{- include "alfresco-search-enterprise.labels" . }}
app.kubernetes.io/component: search-enterprise-mediation
{{- end }}

{{- define "alfresco-search-enterprise.default.labels" -}}
{{- include "alfresco-search-enterprise.labels" . }}
app.kubernetes.io/component: {{ include "alfresco-search-enterprise.name" . }}
{{- end }}
