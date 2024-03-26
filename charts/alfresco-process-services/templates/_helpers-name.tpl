{{- define "alfresco-process-services.deployment-aps.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}

{{- define "alfresco-process-services.deployment-admin.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "admin" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}

{{- define "alfresco-process-services.ingress-aps.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "ingress-aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}

{{- define "alfresco-process-services.ingress-admin.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "ingress-admin" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}

{{- define "alfresco-process-services.config-aps.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "configmap-aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}

{{- define "alfresco-process-services.config-admin.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "configmap-admin" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}

{{- define "alfresco-process-services.database-config-aps.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "database-aps") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-process-services.database-config-admin.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "database-admin") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-process-services.database-secret-aps.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "dabase-secret-aps") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-process-services.database-secret-admin.name" -}}
{{- $ctx := dict "Values" (dict "nameOverride" "database-secret-admin") "Chart" .Chart "Release" .Release }}
{{- template "alfresco-process-services.fullname" $ctx }}
{{- end -}}

{{- define "alfresco-process-services.service-aps.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "service-aps" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}

{{- define "alfresco-process-services.service-admin.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "service-admin" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-process-services.fullname" $scope }}
{{- end }}
