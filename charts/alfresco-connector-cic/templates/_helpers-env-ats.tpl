{{/*

Usage: include "alfresco-connector-cic.sfs.cm.env" $

*/}}
{{- define "alfresco-connector-cic.ats.cm.env" -}}
{{- with .Values.ats }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.ats.fullname" $) }}
- name: ALFRESCO_TRANSFORM_SHAREDFILESTORE_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.sfsUrl }}
{{- end -}}
{{- end -}}
