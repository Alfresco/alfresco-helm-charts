{{/*
Get Database Driver
*/}}
{{- define "alfresco-sync-service.dbDriver" -}}
{{- $defaultDriver := "org.postgresql.Driver" }}
{{- if .Values.postgresql.enabled }}
{{- $defaultDriver }}
{{- else }}
{{- coalesce .Values.database.driver $defaultDriver }}
{{- end }}
{{- end -}}

{{/*
Get Database URL
*/}}
{{- define "alfresco-sync-service.dbUrl" -}}
{{- if .Values.postgresql.enabled }}
{{- $pgsvcname := printf "%s-%s" .Release.Name .Values.postgresql.nameOverride }}
{{- $pgsvcport := "" }}
{{- if hasKey .Values.postgresql.primary "service" }}
{{- $pgsvcport := printf ":%s" (.Values.postgresql.primary.service.port | default 5432) }}
{{- end }}
{{- printf "jdbc:postgresql://%s%s/%s" $pgsvcname $pgsvcport .Values.postgresql.auth.database }}
{{- else }}
{{- required "To enable SyncService external database please provide .database.url" .Values.database.url }}
{{- end }}
{{- end -}}
