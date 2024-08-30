{{/*

Usage: include "alfresco-connector-hxi.cm.env" $

*/}}
{{- define "alfresco-connector-hxi.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.hxi }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx ) }}
- name: AUTH_PROVIDERS_HYLANDEXPERIENCE_TOKENURI
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.hxAuthTokenUrl }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-hxi.live-ingester.cm.env" $

*/}}
{{- define "alfresco-connector-hxi.live-ingester.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.hxi }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx ) }}
{{- include "alfresco-connector-hxi.cm.env" $ }}
- name: HYLANDEXPERIENCE_INSIGHT_INGESTION_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.hxInsightIngestionUrl }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-hxi.prediction-applier.cm.env" $

*/}}
{{- define "alfresco-connector-hxi.prediction-applier.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.hxi }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx ) }}
{{- include "alfresco-connector-hxi.cm.env" $ }}
- name: HYLANDEXPERIENCE_INSIGHT_PREDICTIONS_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.hxInsightPredictionsUrl }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-hxi.secret.env" $

*/}}
{{- define "alfresco-connector-hxi.secret.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.hxi }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-hxi.fullname" $cmCtx ) }}
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
