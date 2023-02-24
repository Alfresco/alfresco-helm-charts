{{- define "alfresco-search-enterprise.existingSecretName" -}}
{{ $.Values.searchIndex.existingSecretName | default $.Values.global.searchIndex.existingSecretName | default (printf "%s-elasticsearch-secret" (include "alfresco-search-enterprise.fullName" $)) }}
{{- end -}}

{{- define "alfresco-search-enterprise.config.spring" -}}
{{- if .Values.elasticsearch.enabled }}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.elasticsearch.protocol }}://{{ .Values.elasticsearch.clusterName }}-{{ .Values.elasticsearch.nodeGroup }}:{{ .Values.elasticsearch.httpPort }}"
{{- else }}
  {{- if and (not .Values.global.searchIndex.host) (not .Values.searchIndex.host) }}
    {{ fail "Please provide external elasticsearch connection details as values under .global.searchIndex or .searchIndex or enable the embedded elasticsearch via .elasticsearch.enabled" }}
  {{- end }}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.searchIndex.protocol | default .Values.global.searchIndex.protocol }}://{{ .Values.searchIndex.host | default .Values.global.searchIndex.host }}:{{ .Values.searchIndex.port | default .Values.global.searchIndex.port }}"
{{- end -}}
{{- end -}}

{{- define "alfresco-search-enterprise.config.spring.envCredentials" -}}
- name: SPRING_ELASTICSEARCH_REST_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ template "alfresco-search-enterprise.existingSecretName" $ }}
      key: ELASTICSEARCH_USERNAME
- name: SPRING_ELASTICSEARCH_REST_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ template "alfresco-search-enterprise.existingSecretName" $ }}
      key: ELASTICSEARCH_PASSWORD
{{- end -}}
