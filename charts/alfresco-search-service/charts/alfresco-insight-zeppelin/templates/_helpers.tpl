{{/*
Get Alfresco Insight Zeppelin Full Name
*/}}
{{- define "alfresco-insight-zeppelin.fullName" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get Alfresco Zeppelin Host
*/}}
{{- define "alfresco-insight-zeppelin.host" -}}
{{- printf "%s-%s" .Release.Name "alfresco-insight-zeppelin" -}}
{{- end -}}

{{/*
Get Alfresco Repo Host
*/}}
{{- define "alfresco-repo-host" -}}
{{- .Values.repository.host | default (printf "%s-repository" (include "content-services.shortname" $)) }}
{{- end -}}

{{/*
Get Alfresco Repo Port
*/}}
{{- define "alfresco-repo-port" -}}
{{- .Values.repository.port | default 80 }}
{{- end -}}
