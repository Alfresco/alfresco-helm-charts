{{/*

Usage: include "alfresco-connector-cic.cm.env" $

*/}}
{{- define "alfresco-connector-cic.cm.env" -}}
{{- with .Values.cic }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $) }}
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
{{- with .Values.cic }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $) }}
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
{{- with .Values.cic }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $) }}
- name: HX_TOKEN_URI
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.hxAuthTokenUrl }}
- name: NUCLEUS_BASE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.nucleusBaseUrl }}
- name: NUCLEUS_IDP_BASE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.nucleusIdpBaseUrl }}
- name: NUCLEUS_SYSTEM_ID
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.nucleusSystemId }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.nucleus-sync.secret.env" $

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.secret.env" -}}
{{- with .Values.cic }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.fullname" $) }}
- name: HX_CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.hxClientId }}
- name: HX_CLIENT_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.hxClientSecret }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.secret.env" $

*/}}
{{- define "alfresco-connector-cic.secret.env" -}}
{{- with .Values.cic }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.fullname" $) }}
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
