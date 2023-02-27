{{- define "alfresco-search-enterprise.searchIndexExistingSecretName" -}}
{{ $.Values.searchIndex.existingSecretName | default $.Values.global.elasticsearch.existingSecretName | default (printf "%s-elasticsearch-secret" (include "alfresco-search-enterprise.fullName" $)) }}
{{- end -}}

{{- define "alfresco-search-enterprise.config.spring" -}}
{{- if .Values.elasticsearch.enabled }}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.elasticsearch.protocol }}://{{ .Values.elasticsearch.clusterName }}-{{ .Values.elasticsearch.nodeGroup }}:{{ .Values.elasticsearch.httpPort }}"
{{- else }}
  {{- if and (not .Values.global.elasticsearch.host) (not .Values.searchIndex.host) }}
    {{ fail "Please provide external elasticsearch connection details as values under .global.elasticsearch or .searchIndex or enable the embedded elasticsearch via .elasticsearch.enabled" }}
  {{- end }}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.searchIndex.protocol | default .Values.global.elasticsearch.protocol }}://{{ .Values.searchIndex.host | default .Values.global.elasticsearch.host }}:{{ .Values.searchIndex.port | default .Values.global.elasticsearch.port }}"
{{- end -}}
{{- end -}}

{{- define "alfresco-search-enterprise.config.spring.envCredentials" -}}
- name: SPRING_ELASTICSEARCH_REST_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ template "alfresco-search-enterprise.searchIndexExistingSecretName" $ }}
      key: ELASTICSEARCH_USERNAME
- name: SPRING_ELASTICSEARCH_REST_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ template "alfresco-search-enterprise.searchIndexExistingSecretName" $ }}
      key: ELASTICSEARCH_PASSWORD
{{- end -}}
