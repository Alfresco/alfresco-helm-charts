# Building your Content platform architecture with Alfresco charts

## The alfresco-common library chart

Alfresco charts depend on a common library chart called
[alfresco-common](../charts/alfresco-common). This chart provides a set of
[named templates](https://helm.sh/docs/chart_template_guide/named_templates)
one can use in order to build his own content platform chart.

Named templates are reusable functions that can only return strings and always
take a single argument, which eventually can be an object. For example the [URL
helper](../charts/alfresco-comon/templates/_helper-url.tpl) file provides
functions to extract various elements from a given URL. For example:

* `{{ template "alfresco-common.url.scheme" "https://hub.alfresco.com/" }}`
  will return "https"
* `{{ template "alfresco-common.url.port" "https://hub.alfresco.com/" }}` will
  return "443"

Check out the dedicated Chart documentation to get a more comprehensive list of
named templates the chart offers.

## Alfresco components charts

The individual Alfresco components' chart are meant to be configurable and
reusable. They do not provide a working system on their own and need to be
either used from an "umbrella chart" or be given additional details about
other components they interact with in order to actually deliver the service
they are meant to deliver.
For example the `alfresco-repository` chart needs to have a database to
initialize its content repository.

This document explains what are the options you can leverage to "pipe" an
Alfresco chart with another or with an external service.

### Understanding the Alfresco Content platform

Before you begin, make sure you do understand the Alfresco Content platform and
its components so you know exactly what you need or do not need.

⚠️TODO: create chart diagram showing dependencies and level of dependencies

### Creating your Alfresco platform

There are numerous ways to create your own Alfresco deployment and the
component charts hosted in this repository can be used as building blocks for
this purpose. Depending on preferences you may want to use
[Terraform](https://www.terraform.io/),
[Kustomize](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/helmcharts/)
or simply wrap the component charts into an "umbrella chart".

Here we'll focus on the later option but the same configuration principles
apply to other methods.

In the example below we'll go through the process of creating a custom chart in
order to deploy a simple content platform made of:

* Alfresco content repository
* A database that hosted outside of the kubernetes cluster
* Alfresco Enterprise search service
* An elasticsearch cluster hosted as a kubernetes workload

#### Declaring chart as dependency

[Helm provides a mechanism to declare
dependencies](https://helm.sh/docs/helm/helm_dependency/) and re-use existing
charts.

We'll start by initializing a chart and declare the dependency to the
[alfresco-repository](../charts/alfresco-repository) chart.

```sh
helm create myecmplatform && cd $_
```

Edit the `Chart.yaml` to give the chart a sensible description, a version and
optionally specify the version of your content platform. Then declare the
dependency as shown below:

```yaml
dependencies:
  - name: alfresco-repository
    version: 0.1.0
    repository: https://alfresco.github.io/alfresco-helm-charts/
    alias: repo
```

> In the example above we use `repo` as an alias so any value in our chart that
> lives under the `$.repo` YAML path will actually be passed to the
> `alfresco-repository` chart. In other words, values documented for the
> `alfresco-repository` chart such as `replicaCount` will be used from your
> chart as `repo.replicaCount`.

#### Configuring the chart

Now we need to let the repository where it can find its database.
When it comes to configuring a chart so it can reach another component of the
platform, the Alfresco component charts lets you do that in 2 different ways:

* Using regular values
* Using kubernetes config resources (configMap or secret)

#### Configuring database using values

First thing to do is to check the chart's [values
documentation](../charts/alfresco-repository/README.md). There, we can see the
database configuration can be done using the `configuration.db` element in our
`values.yaml` file as shown below:

```yaml
repo:
  configuration:
    db:
      url: jdbc:postgresql//db.ecm.infra.local/alfresco
      username: ecmdaouser
      password: ecmdaopass
```

#### Configuring database using kubernetes resources

When using kubernetes resources we will want to differentiate configuration
details which are sensitive and which are not. The former will be stored in
[configMap](https://kubernetes.io/docs/concepts/configuration/configmap/),
while the later would use
[secret](https://kubernetes.io/fr/docs/concepts/configuration/secret/).

That means here we'll use a configMap to set store the database URL while
credentials would live in a secret. That concretely translate into the
following kubernetes resources:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/instance: myEcmReleaseName
    app.kubernetes.io/name: Alfresco-content-platform
    app.kubernetes.io/version: 1.0.0
  name: ecm-database-location
  namespace: myecm
data:
  MY_ECM_DB_URL: jdbc:postgresql://db.ecm.infra.local/alfresco
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  labels:
    app.kubernetes.io/instance: myEcmReleaseName
    app.kubernetes.io/name: Alfresco-content-platform
    app.kubernetes.io/version: 1.0.0
  name: ecm-database-credentials
  namespace: myecm
data:
  MY_ECM_DB_USER: c2NvdHQ=
  MY_ECM_DB_PASS: dGlnZXI=
```

Now we need to let the `alfresco-repository` chart where to find this:

```yaml
repo:
  configuration:
    db:
      existingConfigMap:
        name: ecm-database-location
      keys:
        url: MY_ECM_DB_URL
      existingSecret:
        name: ecm-database-credentials
      keys:
        username: MY_ECM_DB_USER
        password: MY_ECM_DB_PASS
```
