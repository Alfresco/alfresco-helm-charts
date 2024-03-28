# Alfresco Process Service database configuration

Alfresco Process Service uses a relational database to store data. An additional
database is required in order to deploy the APS admin application.

> It is not possible to use the same database for both applications. Though,
> both databases can be hosted on the same database server.

## Configuring the APS database

This charts uses generic configuration means reused in all our charts. You
should start reading the
[getting-started](../../docs/getting-started-with-alfresco-charts.md) guide.

### Using values

The most straightforward way to configure the APS database is to use the Helm
values file. The following example shows how to configure the APS database:

```yaml
processEngine:
  database:
    url: jdbc:postgresql://postgresql:5432/activiti
    username: alfresco
    password: alfresco
```

### Using a ConfigMap & Secret

Another and more production-ready way to configure the APS database is to use
configmaps and secrets from an umbrella chart. This chart depends on the
`alfresco-common` library chart, which provides a named template to ease
creation of the database configuration. Below is an example which assumes the
alfresco-process-services chart is set as a dependency in the umbrella chart
and values are configured as follows:

```yaml
# apsdb could be anything else, it is just a name
apsdb:
  url: jdbc:mysql://mysql:3306/activiti
alfresco-process-services:
  processEngine:
    database:
      existingConfigMap:
        name: my-database-config
```

Then create a ConfigMap template with the following content:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-database-config
data:
  {{ template "alfresco-process-services.db.cm" .Values.apsdb }}
```

If you chose to not use the "alfresco-process-services.db.cm" helper template,
you need to make sure you also provide the `DATABASE_DRIVER` key in the
configmap. The helper will try autodetect which class to use based on the URL
provided.

> If you want to use a custom driver class, you can provide it in the
> `apsdb.driver` value.

For the secret there is no helper and you need to provide one secret which
contains 2 data keys:

* DATABASE_USERNAME
* DATABASE_PASSWORD

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-database-secret
type: Opaque
data:
  DATABASE_USERNAME: {{ .Values.apsdb.username | b64enc | quote }}
  DATABASE_PASSWORD: {{ .Values.apsdb.password | b64enc | quote }}
```

You may want to reuse a secret which is already created in your cluster but has
different keys. In this case you would need to configure the
alfresco-process-services chart as follows:

```yaml
alfresco-process-services:
  processEngine:
    database:
      existingSecret:
        name: my-database-secret
        keys:
          username: MY_DATABASE_USERNAME
          password: MY_DATABASE_PASSWORD
```

The exact same approach can be used to configure the APS admin application, in
which case the `adminApp` key should be used instead of `processEngine`.
