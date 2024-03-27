# Alfresco Process Services search index configuration

Alfresco Process Services can use an Elasticsearch index. This document provides
information on how to configure the search index in Alfresco Process Services.

## Elasticsearch configuration

It is quite common to tie Alfresco Process Services to an Elasticsearch index
which lives outside of the Kubernetes cluster. For example Your index might be
provided by a managed Elasticsearch service such as AWS OpenSearch.

> APS for now only support ElasticSearch 7.x
.
In order to connect to an external Elasticsearch index, you need to configure
the following properties in the `values.yaml` file:

```yaml
processEngine:
  environment:
    ACTIVITI_ES_REST_CLIENT_ADDRESS: vpc-id.region.es.amazonaws.com
    ACTIVITI_ES_REST_CLIENT_PORT: 443
    ACTIVITI_ES_REST_CLIENT_SCHEMA: https
    ACTIVITI_ES_REST_CLIENT_AUTH_ENABLED: true
    ACTIVITI_ES_REST_CLIENT_USERNAME: admin
    ACTIVITI_ES_REST_CLIENT_PASSWORD: esadmin
```

If you're using an internal PKI, you will need to provide a keystore containing
the certificate chain for the Elasticsearch server as a Kubernetes secret which
must contain the data key `truststore.p12`.

```yaml
processEngine:
  environment:
    ...
    ACTIVITI_ES_REST_CLIENT_KEYSTORE: /path/to/keystore/truststore.p12
    ACTIVITI_ES_REST_CLIENT_KEYSTORE_TYPE: PKCS12
    ACTIVITI_ES_REST_CLIENT_KEYSTORE_PASSWORD: somesecretpass
  volumes:
    - name: truststore
      secret:
        secretName: internal-truststore
  volumeMounts:
    - name: truststore
      readOnly: true
      mountPath: /path/to/keystore
```
