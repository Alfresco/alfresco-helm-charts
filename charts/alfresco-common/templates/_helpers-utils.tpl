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

Usage: include "alfresco-common.secret-checksum" (dict "ns" "" "configKey" "somekey" "context" (dict "somekey" (dict "existingConfigMap" (dict "keys" dict))(dict "existingSecret" (dict "keys" dict))...) "configKey" "some-key")

*/}}
{{- define "alfresco-common.checksum.config" -}}
{{- $ns := required "template needs to be given the release namepace" .ns }}
{{- $configCtx := index .context .configKey }}
{{- $lookedup_secret := "" }}
{{- $lookedup_cm := "" }}
{{- $defaultLookup := dict "data" dict -}}
{{/* If configmap is given, checksum & concat its keys otherwise checksum & concat values */}}
{{- with $configCtx }}
{{- if .existingConfigMap.name }}
  {{- $lookup := lookup "v1" "ConfigMap" $ns .existingConfigMap.name | default $defaultLookup }}
  {{- range $k := (keys .existingConfigMap.keys | sortAlpha) }}
    {{- $lookedup_cm = cat $lookedup_cm (pick $lookup.data (index $configCtx "existingConfigMap" "keys" $k) | toJson | sha256sum) }}
  {{- end }}
{{- else }}
  {{- range $k := (keys .existingConfigMap.keys | sortAlpha) }}
    {{- $lookedup_cm = cat $lookedup_cm (index $configCtx $k | toJson | sha256sum) }}
  {{- end }}
{{- end -}}
{{/* If secret is given, checksum & concat its keys otherwise checksum & concat values */}}
{{- if .existingSecret.name }}
  {{- $lookup := lookup "v1" "Secret" $ns .existingSecret.name | default $defaultLookup }}
  {{- range $k := (keys .existingSecret.keys | sortAlpha) }}
    {{- $lookedup_secret = cat $lookedup_secret (pick $lookup.data (index $configCtx "existingSecret" "keys" $k) | toJson | sha256sum) }}
  {{- end }}
{{- else }}
  {{- range $k := (keys .existingSecret.keys | sortAlpha) }}
    {{- $lookedup_secret = cat $lookedup_secret (index $configCtx (index $configCtx "existingSecret" "keys" $k) | toJson | sha256sum) }}
  {{- end }}
{{- end }}
{{- end -}}
{{/*  Finaly checksums both concatenated hashes */}}
checksum.config.alfresco.org/{{ $.configKey }}: {{- cat $lookedup_cm $lookedup_secret | trim | sha256sum | indent 1 }}
{{- end -}}

{{/*
Gets a value from its path, return empty if not found
Shamelessly inspired from bitnami "common.utils.getValueFromKey"

Usage: include "alfresco-common.lazy.getValueFromKey" (dict "key" "path.to.key" "context" $)

*/}}
{{- define "alfresco-common.lazy.getValueFromKey" -}}
{{- $splitKey := splitList "." .key -}}
{{- $value := "" -}}
{{- $latestObj := $.context.Values -}}
{{- range $splitKey -}}
  {{- if not $latestObj -}}
    {{- break }}
  {{- end -}}
  {{- $value = ( index $latestObj . ) -}}
  {{- $latestObj = $value -}}
{{- end -}}
{{- printf "%v" ( default "" $value) -}}
{{- end -}}

{{/*
Evaluate a value within the chart's context given a path, otherwise fallback to the global context

Usage: include "alfresco-common.may.glob.value" dict "rootCtx" $ "path" "path.to.key")

*/}}
{{- define "alfresco-common.may.glob.value" -}}
{{- $chartValues := "" }}
{{- $globalValues := "" }}
{{- $chartValues = include "alfresco-common.utils.getValueFromKey" (dict "key" .path "context" .rootCtx) }}
{{- $globalValues := include "alfresco-common.utils.getValueFromKey" (dict "key" (printf "global.%s" .path) "context" .rootCtx) }}
{{- coalesce $chartValues $globalValues }}
{{- end -}}
