{{/*

Usage: include "alfresco-connector-hxi.database.cm.env" $

*/}}
{{- define "alfresco-connector-hxi.database.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "database")) "Chart" .Chart "Release" .Release }}
{{- with .Values.db }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx) }}
- name: SPRING_DATASOURCE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.url }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-hxi.database.secret.env" $

*/}}
{{- define "alfresco-connector-hxi.database.secret.env" -}}
{{- $secretCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default .Chart.Name) "database")) "Chart" .Chart "Release" .Release }}
{{- with .Values.db }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-hxi.fullname" $secretCtx) }}
- name: SPRING_DATASOURCE_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.username }}
- name: SPRING_DATASOURCE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.password }}
{{- end -}}
{{- end -}}
