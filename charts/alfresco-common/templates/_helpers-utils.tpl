{{/*
Read from either a Configmap entry or a value (in this order)

Usage: include "alfresco-common.read.cm.then.value" (dict "ns" "" "key" "" "context" (dict "existingConfigMap" (dict "name" "" "keys" dict ...)))

*/}}
{{- define "alfresco-common.read.cm.then.value" -}}
{{- $ns := .ns }}
{{- $key := .key }}
{{- with .context }}
  {{- if .existingConfigMap.name }}
    {{- $defaultLookup := (dict "data" dict) }}
    {{- $lookup := lookup "v1" "ConfigMap" $ns .existingConfigMap.name | default $defaultLookup }}
    {{- get $lookup.data (index .existingConfigMap.keys $key) }}
  {{- else -}}
    {{- index . $key }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Read from either a Configmap entry or a value (in this order) and fail if returns empty

Usage: include "alfresco-common.reqRead.cm.then.value" (dict "ns" "" "key" "" "context" (dict "existingConfigMap" (dict "name" "" "keys" dict ...)))

*/}}
{{- define "alfresco-common.reqRead.cm.then.value" -}}
{{- $ns := .ns }}
{{- $key := .key }}
{{- $result := include "alfresco-common.read.cm.then.value" . }}
{{- required (printf "key %s not found in provided context neither in ConfigMap %s/%s" $key $ns .context.existingConfigMap.name) $result }}
{{- end -}}

{{/*
Check whether a secret has a specific entry (don't read it). Return "true" if entry is present in secret or value, otherwise "false"

Usage: include "alfresco-common.haskey.secret" (dict "ns" "" "key" "" "context" (dict "existingSecret" (dict "name" "" "keys" (dict ...))))

*/}}
{{- define "alfresco-common.haskey.secret" -}}
{{- $ns := .ns }}
{{- $key := .key }}
{{- with .context }}
  {{- if .existingSecret.name }}
    {{- $defaultLookup := (dict "data" dict) }}
    {{- $lookup := lookup "v1" "Secret" $ns .existingSecret.name | default $defaultLookup }}
    {{- hasKey $lookup.data (index .existingSecret.keys $key) }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Compute Secret checksum whether it's read from values or from secrets

Usage: include "alfresco-common.secret-checksum" (dict "ns" $.Release.Namespace "context" (dict "some-key" (dict "existingSecret" (dict "keys" (dict "username" "" "password" "")))) "configKey" "some-key")

*/}}
{{- define "alfresco-common.checksum.config" -}}
{{- $ns := required "template needs to be given the release namepace" .ns }}
{{- with (index .context .configKey) }}
{{- if .existingSecret.name }}
checksum.config.alfresco.org/{{ $.configKey }}-existing:
  {{- $defaultLookup := dict "data" dict }}
  {{- $lookup := lookup "v1" "Secret" $ns (.existingSecret.name) | default $defaultLookup }}
  {{- pick $lookup.data .existingSecret.keys.username .existingSecret.keys.password | toJson | sha256sum | indent 1}}
{{- else }}
checksum.config.alfresco.org/{{ $.configKey }}-values: {{ omit . "existingSecret" | toJson | sha256sum }}
{{- end }}
{{- end }}
{{- end -}}
