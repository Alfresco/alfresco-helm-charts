# Deprecation

We sometimes have to introduce breaking changes. As we have to do that we try to
be conservative and introduce backward compatible behavior for a period of time
until the next major version of a chart allows us to really withdraw the
compatibility layer.
Below is a list of deprecations in our charts which will be removed in the next major release.

| Description                                                                  | Deprecation in | Removal in |
|------------------------------------------------------------------------------|----------------|------------|
| `alfresco-activiti.activiti-5113.elasticsearch` is now just returning the value of the `ACTIVITI_ES_REST_CLIENT_ADDRESS` entry of the `environment` map.| alfresco-activiti-0.5.1 | alfresco-activiti-1.0.0 |
| `.ingress.extraAnnotations` is deprecated in favor of `.ingress.annotations` | alfresco-search-service-5.1.0, alfresco-connector-msteams-2.1.0, alfresco-connector-ms365-3.1.0 | alfresco-search-service-6.0.0, alfresco-connector-msteams-3.0.0, alfresco-connector-ms365-4.0.0 |
