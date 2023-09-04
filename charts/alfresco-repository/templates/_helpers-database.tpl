{{/*
Compute JDBC URL opbject
We're just manipulating the string URl to make it parseable by urlParse.
It MUST NOT be used directly.
*/}}
{{- define "alfresco-repository.jdbc.parser" -}}
{{- $jdbc_url := required "Alfresco repository needs a database to start. Please provide a valid URL in configuration.db.url value" . }}
{{- if hasPrefix "jdbc:" $jdbc_url }}
{{- fail "database URL MUST be provided WITHOUT the 'jdbc' prefix." }}
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
Compute default ports by RDBMS
*/}}
{{- define "alfresco-repository.db.default.port" -}}
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
Compute default driver by RDBMS
*/}}
{{- define "alfresco-repository.db.default.driver" -}}
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
Provide repository database engine
*/}}
{{- define "alfresco-repository.db.rdbms" -}}
{{- index (include "alfresco-repository.jdbc.parser" .url | fromJson) "jdbc" "scheme" }}
{{- end -}}

{{/*
Provide repository database hostname
*/}}
{{- define "alfresco-repository.db.hostname" -}}
{{- index (include "alfresco-repository.jdbc.parser" .url | fromJson) "jdbc" "hostname" }}
{{- end -}}

{{/*
Provide repository database port
*/}}
{{- define "alfresco-repository.db.port" -}}
{{- $socket := (index (include "alfresco-repository.jdbc.parser" .url | fromJson) "jdbc" "host") }}
{{- if gt ($socket | splitList ":" | len) 1 }}
  {{- $socket | splitList ":" | last }}
{{- else }}
  {{- template "alfresco-repository.db.default.port" (index (include "alfresco-repository.jdbc.parser" .url | fromJson) "jdbc" "scheme") }}
{{- end }}
{{- end -}}

{{/*
Provide repository database driverClass
*/}}
{{- define "alfresco-repository.db.driver" -}}
{{- $scheme := index (include "alfresco-repository.jdbc.parser" .url | fromJson) "jdbc" "scheme" }}
{{- coalesce .driver (include "alfresco-repository.db.default.driver" $scheme) }}
{{- end -}}

{{/*
Render database config as env vars
*/}}
{{- define "alfresco-repository.db.env" -}}
{{- $dbcmCtx := dict "Values" (dict "nameOverride" "alfresco-database") "Chart" .Chart "Release" .Release }}
{{- with .Values.configuration.db }}
{{- $dbcm := coalesce .existingConfigMap.name (include "alfresco-repository.fullname" $dbcmCtx) }}
- name: DATABASE_URL
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.url }}
- name: DATABASE_HOST
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.host }}
- name: DATABASE_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.port }}
- name: DATABASE_DRIVER
  valueFrom:
    configMapKeyRef:
      name: {{ $dbcm }}
      key: {{ .existingConfigMap.keys.driver }}
{{- end }}
{{- end -}}
