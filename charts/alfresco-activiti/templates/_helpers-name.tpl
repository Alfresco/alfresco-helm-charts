{{- define "alfresco-activiti.deployment.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-activiti.fullname" $scope }}
{{- end }}

{{- define "alfresco-activiti.ingress.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "ingress-aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-activiti.fullname" $scope }}
{{- end }}

{{- define "alfresco-activiti.config.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "configmap-aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-activiti.fullname" $scope }}
{{- end }}

{{- define "alfresco-activiti.database-config.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "database-aps") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-activiti.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-activiti.database-secret.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "database-secret-aps") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-activiti.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-activiti.service.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "service-aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-activiti.fullname" $scope }}
{{- end }}
