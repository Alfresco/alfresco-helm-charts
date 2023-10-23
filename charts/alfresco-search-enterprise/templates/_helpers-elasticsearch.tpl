{{/*

Usage: include "alfresco-search-enterprise.config.spring.es.env" $

*/}}
{{- define "alfresco-search-enterprise.config.spring.es.env" -}}
{{- $esCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "es")) "Chart" .Chart "Release" .Release }}
{{- with .Values.search }}
{{- $esCm := coalesce .existingConfigMap.name (include "alfresco-search-enterprise.fullname" $esCtx) }}
- name: SPRING_ELASTICSEARCH_REST_URIS
  valueFrom:
    configMapKeyRef:
      name: {{ $esCm }}
      key: {{ .existingConfigMap.keys.url }}
{{- end }}
{{- end -}}

{{/*

Usage: include "alfresco-search-enterprise.config.spring.envCredentials" $

*/}}
{{- define "alfresco-search-enterprise.config.spring.envCredentials" -}}
{{- $esCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "es")) "Chart" .Chart "Release" .Release }}
{{- with .Values.search }}
{{- $esSecret := coalesce .existingSecret.name (include "alfresco-search-enterprise.fullname" $esCtx) }}
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
