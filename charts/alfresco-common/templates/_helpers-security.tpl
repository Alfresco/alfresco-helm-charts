{{/*
Provide default pod security context

Usage: include "alfresco-common.default-pod-security-context" ""

*/}}
{{- define "alfresco-common.default-pod-security-context" }}
    runAsNonRoot: true
    runAsUser: 33099
    fsGroup: 1000
    fsGroupChangePolicy: OnRootMismatch
{{- end }}

{{- define "default-pod-security-context" }}
{{- template "alfresco-common.default-pod-security-context" . }}
{{- end }}

{{/*
Provide default container security context

Usage: include "alfresco-common.default-security-context" ""

*/}}
{{- define "alfresco-common.default-security-context" }}
    runAsNonRoot: true
    allowPrivilegeEscalation: false
    capabilities:
      drop:
        - ALL
{{- end }}

{{- define "default-security-context" }}
{{- template "alfresco-common.default-security-context" . }}
{{- end }}

{{/*
Provide pod security context

Usage: include "alfresco-common.component-pod-security-context" .

Applies .podSecurityContext if defined. Set to null to disable defaults.

*/}}
{{- define "alfresco-common.component-pod-security-context" }}
  securityContext:
{{- if hasKey .Values "podSecurityContext" }}
  {{- if .Values.podSecurityContext }}
    {{- .Values.podSecurityContext | toYaml | nindent 4 }}
  {{- end }}
{{- else }}
{{- include "alfresco-common.default-pod-security-context" . }}
{{- end }}
{{- end }}

{{- define "component-pod-security-context" }}
{{- template "alfresco-common.component-pod-security-context" . }}
{{- end }}

{{/*
Provide container security context

Usage: include "alfresco-common.component-security-context" .

Applies .securityContext if defined. Set to null to disable defaults.

*/}}
{{- define "alfresco-common.component-security-context" }}
  securityContext:
{{- if hasKey .Values "securityContext" }}
  {{- if .Values.securityContext }}
    {{- .Values.securityContext | toYaml | nindent 4 }}
  {{- end }}
{{- else }}
{{- include "alfresco-common.default-security-context" . }}
{{- end }}
{{- end }}

{{- define "component-security-context" }}
{{- template "alfresco-common.component-security-context" . }}
{{- end }}
