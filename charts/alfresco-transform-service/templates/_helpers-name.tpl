{{- define "alfresco-transform-service.config-filestore.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.config-imagemagick.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "imagemagick-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.config-libreoffice.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "libreoffice-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.config-pdfrenderer.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "pdfrenderer-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.config-tika.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "tika-configmap" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.deployment-filestore.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.deployment-imagemagick.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "imagemagick" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.deployment-libreoffice.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "libreoffice" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.deployment-pdfrenderer.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "pdfrenderer" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}

{{- define "alfresco-transform-service.deployment-tika.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "tika" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.fullname" $scope }}
{{- end }}
