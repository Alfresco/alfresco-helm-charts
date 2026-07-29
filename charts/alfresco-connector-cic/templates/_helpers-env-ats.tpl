{{/*

Usage: include "alfresco-connector-cic.sfs.cm.env" $

*/}}
{{- define "alfresco-connector-cic.ats.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "ats")) "Chart" .Chart "Release" .Release }}
{{- with .Values.ats }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $cmCtx) }}
- name: ALFRESCO_TRANSFORM_SHAREDFILESTORE_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.sfsUrl }}
{{- end -}}
{{- end -}}
