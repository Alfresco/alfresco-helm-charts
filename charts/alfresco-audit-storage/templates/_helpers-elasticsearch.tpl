{{/*

Usage: include "alfresco-audit-storage.config.audit.entryStorage.es.env" $

*/}}
{{- define "alfresco-audit-storage.config.audit.entryStorage.es.env" -}}
{{- $esCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "es")) "Chart" .Chart "Release" .Release }}
{{- with .Values.index }}
{{- $esCm := coalesce .existingConfigMap.name (include "alfresco-audit-storage.fullname" $esCtx) }}
- name: AUDIT_ENTRYSTORAGE_OPENSEARCH_CONNECTOR_URI
  valueFrom:
    configMapKeyRef:
      name: {{ $esCm }}
      key: {{ .existingConfigMap.keys.url }}
{{- end }}
{{- end -}}

{{/*

Usage: include "alfresco-audit-storage.config.audit.entryStorage.envCredentials" $

*/}}
{{- define "alfresco-audit-storage.config.audit.entryStorage.envCredentials" -}}
{{- $esCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "es")) "Chart" .Chart "Release" .Release }}
{{- with .Values.index }}
{{- $esSecret := coalesce .existingSecret.name (include "alfresco-audit-storage.fullname" $esCtx) }}
- name: AUDIT_ENTRYSTORAGE_OPENSEARCH_CONNECTOR_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $esSecret }}
      key: {{ .existingSecret.keys.username }}
- name: AUDIT_ENTRYSTORAGE_OPENSEARCH_CONNECTOR_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $esSecret }}
      key: {{ .existingSecret.keys.password }}
{{- end }}
{{- end -}}
