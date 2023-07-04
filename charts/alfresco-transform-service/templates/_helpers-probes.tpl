{{/*
Generate Alfresco Tengines probes
*/}}
{{- define "alfresco-transform-service.probes" -}}
readinessProbe:
  httpGet:
    path: {{ .readinessProbe.path }}
    port: {{ .image.internalPort }}
  initialDelaySeconds: {{ .readinessProbe.initialDelaySeconds }}
  periodSeconds: {{ .readinessProbe.periodSeconds }}
  timeoutSeconds: {{ .readinessProbe.timeoutSeconds }}
livenessProbe:
  httpGet:
    path: {{ .livenessProbe.path }}
    port: {{ .image.internalPort }}
  initialDelaySeconds: {{ .livenessProbe.initialDelaySeconds }}
  periodSeconds: {{ .livenessProbe.periodSeconds }}
  failureThreshold: 3
  timeoutSeconds: {{ .livenessProbe.timeoutSeconds }}
{{- end }}
