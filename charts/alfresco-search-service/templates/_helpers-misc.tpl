{{/*
Get Alfresco Search container Port ("internal")
*/}}
{{- define "alfresco-search.containerPort" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- .Values.insightEngineImage.internalPort | default 8983 | int -}}
{{- else }}
{{- .Values.searchServicesImage.internalPort | default 8983 | int -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Service Port
*/}}
{{- define "alfresco-search.svcPort" -}}
{{- $defaultSvcPort := 80 }}
{{- if hasKey .Values "service" }}
  {{- coalesce .Values.service.externalPort $defaultSvcPort | int }}
{{- else }}
  {{- $defaultSvcPort | int }}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Pull Policy
*/}}
{{- define "alfresco-search.pullPolicy" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- print .Values.insightEngineImage.pullPolicy -}}
{{- else }}
{{- print .Values.searchServicesImage.pullPolicy -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Docker Image
*/}}
{{- define "alfresco-search.dockerImage" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
  {{- printf "%s:%s" .Values.insightEngineImage.repository .Values.insightEngineImage.tag }}
{{- else }}
  {{- printf "%s:%s" .Values.searchServicesImage.repository .Values.searchServicesImage.tag }}
{{- end }}
{{- end -}}
