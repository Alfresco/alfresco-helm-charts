{{/*
Get Database Username
*/}}
{{- define "syncservice.dbUser" -}}
{{- $defaultUser := "alfresco" }}
{{- if .Values.database.enabled }}
{{- coalesce .Values.database.auth.username $defaultUser }}
{{- else }}
{{- coalesce .Values.database.external.user $defaultUser }}
{{- end }}
{{- end -}}

{{/*
Get Database Password
*/}}
{{- define "syncservice.dbPass" -}}
{{- $defaultPass := "admin" }}
{{- if .Values.database.enabled }}
{{- coalesce .Values.database.auth.password $defaultPass }}
{{- else }}
{{- coalesce .Values.database.external.password $defaultPass }}
{{- end }}
{{- end -}}

{{/*
Get Database Driver
*/}}
{{- define "syncservice.dbDriver" -}}
{{- $defaultDriver := "org.postgresql.Driver" }}
{{- if .Values.database.enabled }}
{{- $defaultDriver }}
{{- else }}
{{- coalesce .Values.database.external.driver $defaultDriver }}
{{- end }}
{{- end -}}

{{/*
Get Database URL
*/}}
{{- define "syncservice.dbUrl" -}}
{{- if .Values.database.enabled }}
{{- $pgsvcname := printf "%s-%s" .Release.Name .Values.database.nameOverride }}
{{- $pgsvcport := "" }}
{{- if hasKey .Values.database.primary "service" }}
{{- $pgsvcport := printf ":%s" (.Values.database.primary.service.port | default 5432) }}
{{- end }}
{{- printf "jdbc:postgresql://%s%s/%s" $pgsvcname $pgsvcport .Values.database.auth.database }}
{{- else }}
{{- required "To enable SyncService external database please provide .database.external.url" .Values.database.external.url }}
{{- end }}
{{- end -}}
