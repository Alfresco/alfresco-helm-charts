{{/*

Render Alfresco Trasnform Service related env vars

Usage: include "alfresco-search-enterprise.transform.fullurl" "URL"

*/}}
{{- define "alfresco-search-enterprise.ats.fullurl" -}}
  ALFRESCO_ACCEPTEDCONTENTMEDIATYPESCACHE_BASEURL: {{ printf "%s/transform/config" . }}
{{- end -}}

{{/*

Render Alfresco Shared Filesotre related env vars

Usage: include "alfresco-search-enterprise.sfs.fullurl" "URL"

*/}}
{{- define "alfresco-search-enterprise.sfs.fullurl" -}}
  ALFRESCO_SHAREDFILESTORE_BASEURL: {{ printf "%s/alfresco/api/-default-/private/sfs/versions/1/file/" . }}
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
