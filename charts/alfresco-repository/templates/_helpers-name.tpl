{{- define "alfresco-repository.config-dev-log4j-properties.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repository-custom-log4j-properties-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.config-repository.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repository-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.config-share.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "share-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.deployment-repository.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repository" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.deployment-share.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "share" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- /* This should be removed and reuse a common named template for every chart */}}
{{- define "alfresco-repository.deployment-activemq.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "activemq-broker" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-mail-password.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repository-mail-password-secret" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-metadata-keystore.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repository-metadata-keystore-secret" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-repository-properties.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repository-properties-secret" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}

{{- define "alfresco-repository.secret-repository.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "repository-secret" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-repository.fullname" $scope }}
{{- end }}
