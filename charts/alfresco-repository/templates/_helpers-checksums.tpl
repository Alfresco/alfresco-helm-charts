{{/*
Compute Resource checksum given a path
*/}}
{{- define "alfresco-repository.secret-checksum" -}}
{{- $release := required "alfresco-repository.secret-checksum needs to be given the release name" .release }}
{{- with (index .context "Values" "configuration" .configKey) }}
checksum.config.alfresco.org/{{ $.configKey }}-values: {{ omit . "existingSecret" | toJson | sha256sum }}
checksum.config.alfresco.org/{{ $.configKey }}-existing:
  {{- $defaultLookup := (dict "existingSecret" (dict "keys" dict)) }}
  {{- $lookup := ((lookup "v1" "Secret" $release ( .existingSecret.name | default "")).data | default $defaultLookup) }}
  {{- pick $lookup .existingSecret.keys.username .existingSecret.keys.password | toJson | sha256sum | indent 1}}
{{- end }}
{{- end -}}
