{{/*
Get Database Username
*/}}
{{- define "syncservice.dbUser" -}}
{{- $defaultUser := "alfresco" }}
{{- if .Values.database.enabled }}
{{- coalesce .Values.database.postgresql.auth.username $defaultUser }}
{{- else }}
{{- coalesce .Values.database.user $defaultUser }}
{{- end }}
{{- end -}}

{{/*
Get Database Password
*/}}
{{- define "syncservice.dbPass" -}}
{{- $defaultPass := "admin" }}
{{- if .Values.database.enabled }}
{{- coalesce .Values.database.postgresql.auth.password $defaultPass }}
{{- else }}
{{- coalesce .Values.database.password $defaultPass }}
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
{{- coalesce .Values.database.driver $defaultDriver }}
{{- end }}
{{- end -}}

{{/*
Get Database URL
*/}}
{{- define "syncservice.dbUrl" -}}
{{- if .Values.database.enabled }}
{{- $pgsvcname := printf "%s-%s" .Release.Name (index .Values "database" "postgresql" "nameOverride") }}
{{- $pgsvcport := "" }}
{{- if hasKey .Values.database.postgresql "service" }}
{{- $pgsvcport := printf ":%s" (.Values.database.postgresql.service.port | default 5432) }}
{{- end }}
{{- printf "jdbc:postgresql://%s%s/%s" $pgsvcname $pgsvcport .Values.database.postgresql.auth.database }}
{{- else }}
{{- required "To enable SyncService external database please provide .database.url" .Values.database.url }}
{{- end }}
{{- end -}}
