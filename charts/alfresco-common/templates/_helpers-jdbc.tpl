{{/*
Compute a JDBC URL object
We're just manipulating the string URl to make it parseable by urlParse.
This template SHOULD NOT be used directly.

Usage: include "alfresco-common.jdbc.parser" "URL"

*/}}
{{- define "alfresco-common.jdbc.parser" -}}
{{- $jdbc_url := required "Alfresco repository needs a database to start. Please provide a valid URL in db.url value" . }}
{{- if hasPrefix "jdbc:" $jdbc_url }}
{{- $jdbc_url = trimPrefix "jdbc:" $jdbc_url }}
{{- end }}
{{- if hasPrefix "oracle:thin:@" $jdbc_url }}
  {{- $ora_url := trimPrefix "oracle:thin:" $jdbc_url }}
  {{- $ora_url = (mustRegexReplaceAllLiteral "^@(tcps?://)?" $ora_url "oracle://") }}
  {{- $jdbc_url = $ora_url }}
{{- end }}
{{- if hasPrefix "sqlserver://" $jdbc_url }}
  {{- $jdbc_url = trimPrefix "sqlserver://" $jdbc_url }}
  {{- $query := $jdbc_url | splitList ";" }}
  {{- $host := "" }}
  {{- if and (not (empty (index $query 0))) (not (contains "=" (index $query 0))) }}
    {{- $host = index $query 0 }}
    {{- $query = rest $query }}
  {{- end }}
  {{- $path := "" }}
  {{- range $query }}
    {{- if and (hasPrefix "serverName=" .) (empty $host) }}
      {{- $host = trimPrefix "serverName=" . }}
      {{- $_ := mustWithout $query . }}
    {{- end }}
    {{- if hasPrefix "databaseName=" . }}
      {{- $path = trimPrefix "databaseName=" . }}
      {{- $_ := mustWithout $query . }}
    {{- end }}
  {{- end }}
  {{- $ms_url := printf "sqlserver://%s/%s?%s" $host $path ($query | join "&") }}
  {{- $jdbc_url = $ms_url }}
{{- end }}
{{- $parsed_url := urlParse $jdbc_url }}
{{- if or (empty $parsed_url.host) (empty $parsed_url.hostname) (empty $parsed_url.scheme) (eq "/" $parsed_url.path) }}
  {{- fail "The provided JDBC URL cannot be parsed please check or raise a bug." }}
{{- end }}
{{- mustToJson (dict "jdbc" $parsed_url) }}
{{- end -}}

{{/*
Compute default ports based on URL

Usage: include "alfresco-common.db.default.port" "URL"

*/}}
{{- define "alfresco-common.db.default.port" -}}
{{- $pg_rdbms := dict "name" "postgresql" "port" 5432 }}
{{- $my_rdbms := dict "name" "mysql" "port" 3306 }}
{{- $maria_rdbms := dict "name" "mariadb" "port" 3306 }}
{{- $ora_rdbms := dict "name" "oracle" "port" 1521 }}
{{- $ms_rdbms := dict "name" "sqlserver" "port" 1434 }}
{{- range $rdbms := list $pg_rdbms $my_rdbms $maria_rdbms $ora_rdbms $ms_rdbms }}
{{- eq $rdbms.name $ | ternary $rdbms.port "" }}
{{- end }}
{{- end -}}

{{/*
Compute default driver based on URL

Usage: include "alfresco-common.db.default.driver" "URL"

*/}}
{{- define "alfresco-common.db.default.driver" -}}
{{- $pg_rdbms := dict "name" "postgresql" "driver" "org.postgresql.Driver" }}
{{- $my_rdbms := dict "name" "mysql" "driver" "com.mysql.jdbc.Driver" }}
{{- $maria_rdbms := dict "name" "mariadb" "driver" "org.mariadb.jdbc.Driver" }}
{{- $ora_rdbms := dict "name" "oracle" "driver" "oracle.jdbc.OracleDriver" }}
{{- $ms_rdbms := dict "name" "sqlserver" "driver" "com.microsoft.sqlserver.jdbc.SQLServerDriver" }}
{{- range $rdbms := list $pg_rdbms $my_rdbms $maria_rdbms $ora_rdbms $ms_rdbms }}
{{- eq $rdbms.name $ | ternary $rdbms.driver "" }}
{{- end }}
{{- end -}}

{{/*
Provide repository database engine from URL

Usage: include "alfresco-common.db.rdbms" "URL"

*/}}
{{- define "alfresco-common.db.rdbms" -}}
{{- index (include "alfresco-common.jdbc.parser" . | fromJson) "jdbc" "scheme" }}
{{- end -}}

{{/*
Provide repository database hostname

Usage: include "alfresco-common.db.hostname" "URL"

*/}}
{{- define "alfresco-common.db.hostname" -}}
{{- index (include "alfresco-common.jdbc.parser" . | fromJson) "jdbc" "hostname" }}
{{- end -}}

{{/*
Provide database port from JDBC URL

Usage: include "alfresco-common.db.port" "URL"

*/}}
{{- define "alfresco-common.db.port" -}}
{{- $socket := (index (include "alfresco-common.jdbc.parser" . | fromJson) "jdbc" "host") }}
{{- if gt ($socket | splitList ":" | len) 1 }}
  {{- $socket | splitList ":" | last }}
{{- else }}
  {{- template "alfresco-common.db.default.port" (index (include "alfresco-common.jdbc.parser" . | fromJson) "jdbc" "scheme") }}
{{- end }}
{{- end -}}

{{/*
Provide database driverClass based on  JDBC URL

Usage: include "alfresco-common.db.driver" (dict "url" "someurl" "driver" "driverclass")

*/}}
{{- define "alfresco-common.db.driver" -}}
{{- $scheme := index (include "alfresco-common.jdbc.parser" .url | fromJson) "jdbc" "scheme" }}
{{- coalesce .driver (include "alfresco-common.db.default.driver" $scheme) }}
{{- end -}}
