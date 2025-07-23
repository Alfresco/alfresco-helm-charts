# Deprecation

- Named template `alfresco-activiti.activiti-5113.elasticsearch` is now just
  returning the value of the `ACTIVITI_ES_REST_CLIENT_ADDRESS` entry of the
  `environment` map. It will be retired completely in the next major release.
- `.ingress.extraAnnotations` is deprecated in favor of `.ingress.annotations`
