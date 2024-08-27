{{/*

Render Alfresco Shared Filesotre related env vars

Usage: include "alfresco-connector-hxi.sfs.fullurl" "URL"

*/}}
{{- define "alfresco-connector-hxi.sfs.fullurl" -}}
  SFS_URL: {{ template "alfresco-common.sfs.fullurl" . }}
{{- end -}}


{{/*

Usage: include "alfresco-connector-hxi.sfs.cm.env" $

*/}}
{{- define "alfresco-connector-hxi.ats.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "ats")) "Chart" .Chart "Release" .Release }}
{{- with .Values.ats }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx) }}
- name: ALFRESCO_TRANSFORM_SHAREDFILESTORE_FILEENDPOINT
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.sfsUrl }}
{{- end -}}
{{- end -}}
