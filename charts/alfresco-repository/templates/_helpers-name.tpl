{{- define "alfresco-repository.repository.name" -}}
{{- print (.Values.repository.nameOverride | default "repository") }}
{{- end }}

{{- define "alfresco-repository.share.name" -}}
{{- print (.Values.share.nameOverride | default "share") }}
{{- end }}

{{- define "alfresco-repository.config-dev-log4j-properties.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) "-custom-log4j-properties-configmap") ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.config-repository.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) "-configmap" ) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.config-share.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.share.name" .) "-configmap" ) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.deployment-repository.fullname" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) ) "fullnameOverride" .Values.repository.fullnameOverride) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.deployment-share.fullname" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.share.name" .) ) "fullnameOverride" .Values.share.fullnameOverride ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- /* This should be removed and reuse a common named template for every chart */}}
{{- define "alfresco-repository.deployment-activemq.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "activemq-broker" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-mail-password.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) "-mail-password-secret" ) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-metadata-keystore.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) "-metadata-keystore-secret" ) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-repository-properties.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) "-properties-secret" ) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-repository.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) "-secret" ) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-s3.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (print (include "alfresco-repository.repository.name" .) "-secret-s3" ) ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}
