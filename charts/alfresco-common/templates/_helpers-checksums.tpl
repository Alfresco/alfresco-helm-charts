{{/*
Compute Secret checksum whether it's read from values or from secrets

Usage: include "alfresco-common.secret-checksum" (dict "ns" $.Release.Namespace "context" (dict "some-key" (dict "existingSecret" (dict "keys" (dict "username" "" "password" "")))) "configKey" "some-key")

*/}}
{{- define "alfresco-common.secret-checksum" -}}
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
