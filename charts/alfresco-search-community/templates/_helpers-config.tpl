{{/*

Render the common plain and referenced env vars for the batch indexing container

Usage: include "alfresco-search-community.config.env" $

*/}}
{{- define "alfresco-search-community.config.env" -}}
{{- $repoCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "repository")) "Chart" .Chart "Release" .Release }}
{{- $repoCm := coalesce .Values.repository.existingConfigMap.name (include "alfresco-search-community.fullname" $repoCtx) }}
{{- $transformCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "transform")) "Chart" .Chart "Release" .Release }}
{{- $transformCm := coalesce .Values.transform.existingConfigMap.name (include "alfresco-search-community.fullname" $transformCtx) }}
{{- $secretCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "shared-secret")) "Chart" .Chart "Release" .Release }}
{{- $sharedSecret := coalesce .Values.transform.sharedSecret.existingSecret.name (include "alfresco-search-community.fullname" $secretCtx) }}
- name: ELASTICSEARCH_INDEXNAME
  value: {{ .Values.indexName | quote }}
- name: ALFRESCO_ACS_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $repoCm }}
      key: {{ .Values.repository.existingConfigMap.keys.url }}
- name: ALFRESCO_ACCEPTEDCONTENTMEDIATYPESCACHE_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ $transformCm }}
      key: {{ .Values.transform.existingConfigMap.keys.url }}
- name: ALFRESCO_CONTENT_TRANSFORM_SHAREDSECRET
  valueFrom:
    secretKeyRef:
      name: {{ $sharedSecret }}
      key: {{ .Values.transform.sharedSecret.existingSecret.keys.sharedSecret }}
{{- end -}}
