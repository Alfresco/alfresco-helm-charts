{{/*

Usage: include "alfresco-connector-cic.repository.cm.env" $

*/}}
{{- define "alfresco-connector-cic.repository.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "repository")) "Chart" .Chart "Release" .Release }}
{{- with .Values.repository }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $cmCtx) }}
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

Usage: include "alfresco-connector-cic.nucleus-sync.repository.cm.env" $

Like repository.cm.env but maps the repository URL to ALFRESCO_BASEURL
(alfresco.base-url) as expected by nucleus-sync, rather than
ALFRESCO_REPOSITORY_BASEURL (alfresco.repository.base-url) used by
live-ingester.

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.repository.cm.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "repository")) "Chart" .Chart "Release" .Release }}
{{- with .Values.repository }}
{{- $cmName := coalesce .existingConfigMap.name (include "alfresco-connector-cic.fullname" $cmCtx) }}
- name: ALFRESCO_BASE_URL
  valueFrom:
    configMapKeyRef:
        name: {{ $cmName }}
        key: {{ .existingConfigMap.keys.url }}
- name: AUTH_ALFRESCO_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ $cmName }}
      key: {{ .existingConfigMap.keys.authType }}
{{- end -}}
{{- end -}}

{{/*

Usage: include "alfresco-connector-cic.nucleus-sync.repository.secret.env" $

Injects Alfresco credentials using the shortened env var names
(ALFRESCO_USER_NAME, ALFRESCO_PASSWORD) expected by nucleus-sync,
rather than the AUTH_PROVIDERS_ALFRESCO_* names used by live-ingester.

*/}}
{{- define "alfresco-connector-cic.nucleus-sync.repository.secret.env" -}}
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "repository")) "Chart" .Chart "Release" .Release }}
{{- with .Values.repository }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
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
{{- $cmCtx := dict "Values" (dict "nameOverride" (printf "%s-%s" (.Values.nameOverride | default $.Chart.Name) "repository")) "Chart" .Chart "Release" .Release }}
{{- with .Values.repository }}
{{- $secretName := coalesce .existingSecret.name (include "alfresco-connector-cic.fullname" $cmCtx ) }}
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
