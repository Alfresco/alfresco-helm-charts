{{- define "activemq.env" -}}
- name: ACTIVEMQ_URL
  value: $(BROKER_URL)
- name: ACTIVEMQ_USER
  value: $(BROKER_USERNAME)
- name: ACTIVEMQ_PASSWORD
  value: $(BROKER_PASSWORD)
{{- end -}}

{{- define "spring.activemq.env" -}}
- name: SPRING_ACTIVEMQ_BROKERURL
  value: $(BROKER_URL)
- name: SPRING_ACTIVEMQ_USER
  value: $(BROKER_USERNAME)
- name: SPRING_ACTIVEMQ_PASSWORD
  value: $(BROKER_PASSWORD)
{{- end -}}
