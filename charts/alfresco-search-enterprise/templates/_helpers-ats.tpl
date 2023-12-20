{{/*

Render Alfresco Trasnform Service related env vars

Usage: include "alfresco-search-enterprise.transform.fullurl" "URL"

*/}}
{{- define "alfresco-search-enterprise.ats.fullurl" -}}
  ATS_URL: {{ template "alfresco-common.ats.fullurl" . }}
{{- end -}}

{{/*

Render Alfresco Shared Filesotre related env vars

Usage: include "alfresco-search-enterprise.sfs.fullurl" "URL"

*/}}
{{- define "alfresco-search-enterprise.sfs.fullurl" -}}
  SFS_URL: {{ template "alfresco-common.sfs.fullurl" . }}
{{- end -}}

{{/*

Render common env vars

Usage: include "alfresco-search-enterprise.env" $

*/}}
{{- define "alfresco-search-enterprise.env" -}}
- name: ELASTICSEARCH_INDEXNAME
  value: {{ .Values.indexName }}
- name: ALFRESCO_ACCEPTEDCONTENTMEDIATYPESCACHE_REFRESHTIME
  value: {{ .Values.contentMediaTypeCache.refreshTime }}
- name: ALFRESCO_ACCEPTEDCONTENTMEDIATYPESCACHE_ENABLED
  value: {{ .Values.contentMediaTypeCache.enabled | quote }}
- name: ALFRESCO_PATHINDEXINGCOMPONENT_ENABLED
  value: {{ .Values.pathIndexingComponent.enabled | quote }}
{{- end -}}
