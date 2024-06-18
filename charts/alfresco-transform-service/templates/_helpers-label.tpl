{{- define "alfresco-transform-service.filestore.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.filestore.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.filestore.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.filestore.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.imagemagick.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.imagemagick.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.imagemagick.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.imagemagick.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.libreoffice.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride"  (include "alfresco-transform-service.libreoffice.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.libreoffice.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.libreoffice.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.pdfrenderer.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.pdfrenderer.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.pdfrenderer.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.pdfrenderer.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.tika.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.tika.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.tika.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.tika.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.transform-misc.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.transform-misc.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.transform-misc.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.transform-misc.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.transform-router.labels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.transform-router.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.labels" $scope }}
{{- end }}

{{- define "alfresco-transform-service.transform-router.selectorLabels" -}}
{{- $scope := (dict "Values" (dict "nameOverride" (include "alfresco-transform-service.transform-router.name" .)) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-transform-service.selectorLabels" $scope }}
{{- end }}
