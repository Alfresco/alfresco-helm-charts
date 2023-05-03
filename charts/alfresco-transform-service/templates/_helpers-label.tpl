{{- define "alfresco-transform-service.filestore.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.filestore.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.imagemagick.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "imagemagick" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.imagemagick.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "imagemagick" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.libreoffice.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "libreoffice" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.libreoffice.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "libreoffice" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}
