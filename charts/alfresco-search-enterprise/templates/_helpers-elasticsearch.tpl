{{- define "alfresco-search-enterprise.config.spring" -}}
{{- if not .Values.searchIndex.host }}
  {{- fail "Please provide elasticsearch connection details as .searchIndex values or using an .searchIndex.existingConfigMap." }}
{{- end -}}
SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.searchIndex.protocol }}://{{ .Values.searchIndex.host }}:{{ .Values.searchIndex.port }}"
{{- end -}}

{{- define "alfresco-search-enterprise.config.spring.envCredentials" -}}
{{- $esCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "es")) "Chart" .Chart "Release" .Release }}
{{- with .Values.searchIndex }}
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
