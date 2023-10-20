{{- define "alfresco-search-enterprise.searchIndexExistingSecretName" -}}
{{- coalesce .Values.searchIndex.existingSecretName (printf "%s-elasticsearch-secret" (include "alfresco-search-enterprise.fullname" .)) }}
{{- end -}}

{{- define "alfresco-search-enterprise.config.spring" -}}
{{- if not .Values.searchIndex.host }}
  {{- fail "Please provide elasticsearch connection details as .searchIndex values or using an .searchIndex.existingConfigMap." }}
{{- end -}}
SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.searchIndex.protocol }}://{{ .Values.searchIndex.host }}:{{ .Values.searchIndex.port }}"
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
