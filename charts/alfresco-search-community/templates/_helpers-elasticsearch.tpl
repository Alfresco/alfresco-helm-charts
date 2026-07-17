{{/*

Usage: include "alfresco-search-community.es.env" $

*/}}
{{- define "alfresco-search-community.es.env" -}}
{{- $esCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "es")) "Chart" .Chart "Release" .Release }}
{{- with .Values.index }}
{{- $esCm := coalesce .existingConfigMap.name (include "alfresco-search-community.fullname" $esCtx) }}
- name: SPRING_ELASTICSEARCH_REST_URIS
  valueFrom:
    configMapKeyRef:
      name: {{ $esCm }}
      key: {{ .existingConfigMap.keys.url }}
{{- end }}
{{- end -}}

{{/*

Usage: include "alfresco-search-community.es.envCredentials" $

*/}}
{{- define "alfresco-search-community.es.envCredentials" -}}
{{- $esCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "es")) "Chart" .Chart "Release" .Release }}
{{- with .Values.index }}
{{- $esSecret := coalesce .existingSecret.name (include "alfresco-search-community.fullname" $esCtx) }}
- name: SPRING_ELASTICSEARCH_REST_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $esSecret }}
      key: {{ .existingSecret.keys.username }}
- name: SPRING_ELASTICSEARCH_REST_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $esSecret }}
      key: {{ .existingSecret.keys.password }}
{{- end }}
{{- end -}}
