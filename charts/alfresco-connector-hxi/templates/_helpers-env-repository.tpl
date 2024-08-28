{{/*

Usage: include "alfresco-connector-hxi.repository.cm.env" $

*/}}
{{- define "alfresco-connector-hxi.repository.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "repository")) "Chart" .Chart "Release" .Release }}
{{- with .Values.repository }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-hxi.fullname" $cmCtx) }}
- name: ALFRESCO_REPOSITORY_BASEURL
  valueFrom:
    configMapKeyRef:
        name: {{ $cmName }}
        key: {{ .existingConfigMap.keys.url }}
- name: AUTH_PROVIDERS_ALFRESCO_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authType }}
- name: AUTH_PROVIDERS_ALFRESCO_GRANTTYPE
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authGrantType }}
- name: AUTH_PROVIDERS_ALFRESCO_TOKENURI
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authTokenUrl }}
- name: ALFRESCO_REPOSITORY_VERSIONOVERRIDE
  valueFrom:
    configMapKeyRef:
        name: {{ $cmName }}
        key: {{ .existingConfigMap.keys.versionOverride }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-hxi.repository.secret.env" $

*/}}
{{- define "alfresco-connector-hxi.repository.secret.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "repository")) "Chart" .Chart "Release" .Release }}
{{- with .Values.repository }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-hxi.fullname" $cmCtx ) }}
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
