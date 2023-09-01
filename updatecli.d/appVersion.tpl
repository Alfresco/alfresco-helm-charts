name: Charts appVersion update

sources:
  {{- range $id, $opt := .charts }}
  {{- if and ($opt) (index $opt "noAppVersion") }}{{ continue }}{{ end }}
  {{ $id }}Tag:
    name: {{ $id }} tag
    kind: yaml
    spec:
      file: charts/{{ $id }}/values.yaml
      key: {{ if and ($opt) (index $opt "tagKey") }}{{ $opt.tagKey }}{{ else }}$.image.tag{{ end }}
  {{- end }}

targets:
  {{- range $id, $opt := .charts }}
  {{- if and ($opt) (index $opt "noAppVersion") }}{{ continue }}{{ end }}
  {{ $id }}AppVersion:
    name: {{ $id }} appVersion
    kind: yaml
    spec:
      file: charts/{{ $id }}/Chart.yaml
      key: $.appVersion
    sourceid: {{ $id }}Tag
  {{- end }}
