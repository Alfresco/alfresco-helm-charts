{{/*

Render Alfresco Trasnform Service related anv vars

Usage: include "alfresco-search-enterprise.transform.fullurl" "URL"

*/}}
{{- define "alfresco-search-enterprise.ats.fullurl" -}}
  ALFRESCO_ACCEPTEDCONTENTMEDIATYPESCACHE_BASEURL: {{ printf "%s/transform/config" . }}
{{- end -}}

{{/*

Render Alfresco Shared Filesotre related anv vars

Usage: include "alfresco-search-enterprise.sfs.fullurl" "URL"

*/}}
{{- define "alfresco-search-enterprise.sfs.fullurl" -}}
  ALFRESCO_SHAREDFILESTORE_BASEURL: {{ printf "%s/alfresco/api/-default-/private/sfs/versions/1/file/" . }}
{{- end -}}
