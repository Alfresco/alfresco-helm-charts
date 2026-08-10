{{/*

Usage: include "alfresco-connector-cic.repository.cm.env" $

*/}}
{{- define "alfresco-connector-cic.repository.cm.env" -}}
{{- with .Values.repository }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.repository.fullname" $) }}
- name: ALFRESCO_REPOSITORY_BASEURL
  valueFrom:
    configMapKeyRef:
        name: {{ $cmName }}
        key: {{ .existingConfigMap.keys.url }}
{{- if .existingConfigMap.keys.authType }}
- name: AUTH_PROVIDERS_ALFRESCO_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authType }}
{{- end }}
{{- if .existingConfigMap.keys.authGrantType }}
- name: AUTH_PROVIDERS_ALFRESCO_GRANTTYPE
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authGrantType }}
{{- end }}
{{- if .existingConfigMap.keys.authTokenUrl }}
- name: AUTH_PROVIDERS_ALFRESCO_TOKENURI
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authTokenUrl }}
{{- end }}
{{- if .existingConfigMap.keys.versionOverride }}
- name: ALFRESCO_REPOSITORY_VERSIONOVERRIDE
  valueFrom:
    configMapKeyRef:
        name: {{ $cmName }}
        key: {{ .existingConfigMap.keys.versionOverride }}
{{- end }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.nucleus-sync.repository.cm.env" $

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.repository.cm.env" -}}
{{- with .Values.repository }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.repository.fullname" $) }}
- name: ALFRESCO_BASE_URL
  valueFrom:
    configMapKeyRef:
        name: {{ $cmName }}
        key: {{ .existingConfigMap.keys.apiUrl }}
{{- if .existingConfigMap.keys.authType }}
- name: AUTH_ALFRESCO_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authType }}
{{- end }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.nucleus-sync.repository.secret.env" $

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.repository.secret.env" -}}
{{- with .Values.repository }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.repository.fullname" $) }}
- name: ALFRESCO_USER_NAME
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.username }}
- name: ALFRESCO_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.password }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.repository.secret.env" $

*/}}
{{- define "alfresco-connector-cic.repository.secret.env" -}}
{{- with .Values.repository }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.repository.fullname" $) }}
- name: AUTH_PROVIDERS_ALFRESCO_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.username }}
- name: AUTH_PROVIDERS_ALFRESCO_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.password }}
- name: AUTH_PROVIDERS_ALFRESCO_CLIENTID
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.clientId }}
- name: AUTH_PROVIDERS_ALFRESCO_CLIENTSECRET
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ .existingSecret.keys.clientSecret }}
{{- end -}}
{{- end -}}
