{{/*

Render Alfresco Transform Service Router URL

Usage: include "alfresco-common.transform.fullurl" "URL"

*/}}
{{- define "alfresco-common.ats.fullurl" -}}
{{- $scheme := include "alfresco-common.url.scheme" . }}
{{- $host := include "alfresco-common.url.host" . }}
{{- printf "%s://%s/transform/config" $scheme $host }}
{{- end -}}

{{/*

Render Alfresco Transform ServiceShared Filestore URL

Usage: include "alfresco-common.sfs.fullurl" "URL"

*/}}
{{- define "alfresco-common.sfs.fullurl" -}}
{{- $scheme := include "alfresco-common.url.scheme" . }}
{{- $host := include "alfresco-common.url.host" . }}
{{- printf "%s://%s/alfresco/api/-default-/private/sfs/versions/1/file" $scheme $host }}
{{- end -}}
