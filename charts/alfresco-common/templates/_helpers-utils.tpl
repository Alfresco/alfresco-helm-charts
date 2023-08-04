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
    {{- required "If you want to use a search service, either provide a url or a configmap containing that URL" (index . $key) }}
  {{- end }}
{{- end }}
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
