{{- define "alfresco-transform-service.messagebroker.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "messagebroker" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.filestore.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.imagemagick.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "imagemagick" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.libreoffice.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "libreoffice" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.pdfrenderer.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "pdfrenderer" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.tika.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "tika" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.transform-misc.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "transform-misc" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.transform-router.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "transform-router" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.secret-messagebroker.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "messagebroker-creds" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}
