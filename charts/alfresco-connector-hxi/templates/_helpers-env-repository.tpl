{{/*
Set environment variables necessary for configmap
*/}}
{{- define "alfresco-connector-hxi.repository.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "repo")) "Chart" .Chart "Release" .Release }}
{{- with .Values.repository }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx) }}
- name: ALFRESCO_REPOSITORY_BASEURL
  valueFrom:
    configMapKeyRef:
        name: {{ $cmName }}
        key: {{ .existingConfigMap.keys.url }}
{{- end -}}
{{- end -}}
