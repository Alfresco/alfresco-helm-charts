{{/*

Usage: include "alfresco-connector-cic.cm.env" $

*/}}
{{- define "alfresco-connector-cic.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.cic }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
- name: AUTH_PROVIDERS_HYLANDEXPERIENCE_TOKENURI
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.hxAuthTokenUrl }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.live-ingester.cm.env" $

*/}}
{{- define "alfresco-connector-cic.live-ingester.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.cic }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
{{- include "alfresco-connector-cic.cm.env" $ }}
- name: HYLANDEXPERIENCE_INSIGHT_INGESTION_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.hxInsightIngestionUrl }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.nucleus-sync.cm.env" $

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.cic }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
{{- include "alfresco-connector-cic.cm.env" $ }}
- name: HYLANDEXPERIENCE_INSIGHT_INGESTION_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.hxInsightIngestionUrl }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.secret.env" $

*/}}
{{- define "alfresco-connector-cic.secret.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.cic }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
- name: AUTH_PROVIDERS_HYLANDEXPERIENCE_CLIENTID
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.hxClientId }}
- name: AUTH_PROVIDERS_HYLANDEXPERIENCE_CLIENTSECRET
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.hxClientSecret }}
- name: AUTH_PROVIDERS_HYLANDEXPERIENCE_ENVIRONMENTKEY
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.hxEnvKey }}
- name: APPLICATION_SOURCEID
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.hxAppSourceId }}
{{- end -}}
{{- end -}}
