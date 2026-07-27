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

Injects CIC config into the nucleus-sync container using the shortened env var
names expected by nucleus-sync (HX_TOKEN_URI, NUCLEUS_BASE_URL, etc.) rather
than the AUTH_PROVIDERS_HYLANDEXPERIENCE_* style used by live-ingester.

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.cic }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
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

Injects HX credentials using the shortened names (HX_CLIENT_ID, HX_CLIENT_SECRET)
expected by nucleus-sync, rather than the AUTH_PROVIDERS_HYLANDEXPERIENCE_* style
used by live-ingester.

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.secret.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "")) "Chart" .Chart "Release" .Release }}
{{- with .Values.cic }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
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
