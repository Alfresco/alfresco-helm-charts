{{- define "spring.elasticsearch.config" -}}
{{- if .Values.elasticsearch.enabled }}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.elasticsearch.protocol }}://{{ .Values.elasticsearch.host }}:{{ .Values.elasticsearch.port }}"
{{- else }}
  {{- if or (not .Values.global.elasticsearch.protocol) (or (not .Values.global.elasticsearch.host) (not .Values.global.elasticsearch.port)) }}
    {{ fail "Please provide external elasticsearch details under global.elasticsearch or enable the embedded elasticsearch via elasticsearch.enabled" }}
  {{- end }}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.global.elasticsearch.protocol  }}://{{ .Values.global.elasticsearch.host }}:{{ .Values.global.elasticsearch.port }}"
{{- end -}}
{{- end -}}

{{- define "spring.elasticsearch.env.credentials" -}}
- name: SPRING_ELASTICSEARCH_REST_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ default (printf "%s-elasticsearch-secret" (include "alfresco-elasticsearch-connector.fullName" $)) $.Values.global.elasticsearch.existingSecretName }}
      key: ELASTICSEARCH_USERNAME
- name: SPRING_ELASTICSEARCH_REST_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ default (printf "%s-elasticsearch-secret" (include "alfresco-elasticsearch-connector.fullName" $)) $.Values.global.elasticsearch.existingSecretName }}
      key: ELASTICSEARCH_PASSWORD
{{- end -}}
