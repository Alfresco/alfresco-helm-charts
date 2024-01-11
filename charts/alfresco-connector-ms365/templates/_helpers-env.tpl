{{/*
Set environment variables necessary for configmap
*/}}
{{- define "alfresco-connector-ms365.env" -}}
{{- $repo_details_cm := coalesce .Values.repository.existingConfigMap.name (include "alfresco-connector-ms365.fullname" .) -}}
{{- $repo_url := printf "-Dalfresco.base-url=http://%s:%s" "$(REPO_HOST)" "$(REPO_PORT)" }}
- name: REPO_HOST
  valueFrom:
    configMapKeyRef:
        name: {{ $repo_details_cm }}
        key: {{ .Values.repository.existingConfigMap.keys.host }}
- name: REPO_PORT
  valueFrom:
    configMapKeyRef:
        name: {{ $repo_details_cm }}
        key: {{ .Values.repository.existingConfigMap.keys.port }}
{{- range $key, $value := (omit .Values.environment "JAVA_OPTS") }}
- name: {{ $key }}
  value: {{ $value | quote }}
{{- end }}
- name: JAVA_OPTS
  value: >-
    {{ (printf "%s %s" (.Values.environment.JAVA_OPTS | default "") ($repo_url)) }}
{{- end -}}
