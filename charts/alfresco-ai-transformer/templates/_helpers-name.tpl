{{- define "alfresco-ai-transformer.config-ai-aws.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "aws-comprehend" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-ai-transformer.fullname" $scope }}
{{- end }}

{{- define "alfresco-ai-transformer.config-ai-mq.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "ai-mq" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-ai-transformer.fullname" $scope }}
{{- end }}

{{- define "alfresco-ai-transformer.config-ai-sfs.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "ai-sfs" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-ai-transformer.fullname" $scope }}
{{- end }}

{{- define "alfresco-ai-transformer.secret-ai-aws.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "aws-comprehend" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-ai-transformer.fullname" $scope }}
{{- end }}

{{- define "alfresco-ai-transformer.secret-ai-mq.name" -}}
{{- $scope := (dict "Values" (dict "nameOverride" "ai-mq" ) "Chart" .Chart "Release" .Release) }}
{{- include "alfresco-ai-transformer.fullname" $scope }}
{{- end }}
