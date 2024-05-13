---
title: Global properties
parent: Repository
grand_parent: Guides
---

# Configuring Alfresco repository

Alfresco repository can be configured using properties files. The most common
one is `alfresco-global.properties`.

Another option to pass configuration properties for the Alfresco repository is
to use the `CATALINA_OPTS`environment variable.  Using env vars to configure an
application is very common in containerized environments.

In some circumstances you might need/want to use subsystem configuration. This
is mostly useful in case you need to instantiate several times the same
subsystem, otherwise you should prefer properties or environment variables.

Neither environment variables nor configmaps are really suitable to pass
sensitive data. For that purpose secrets are recommended.

Below we provide details on how to use each of these option and how (the
subsystem approach is explained [here](./subsystems.md).

## Repository configuration using alfresco-global.properties

Although the `alfresco-repository` chart do not generate the
`alfresco-globa.properties` file, it can be passed as a pre-existing configmap
making it easy for you to port your existing configuration to kubernetes
environments. Such a pre-existing secret must be referenced using the value
`configuration.repository.existingConfigMap`.

```yaml
configuration:
  repository:
    existingConfigMap: my-global-properties-cm
```

This configmap should be the mere representation of the file, for example:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-global-properties-cm
data:
  alfresco-global.properties: |
    deployment.method=HELM_CHART
    alfresco.host=myecm.domain.tld
    alfresco.port=443
    alfresco.protocol=https
```

## Repository configuration using environment variables

Using environment variable is quite similar to using a properties file. All one
need to do in order to switch from one approach to the other is to prefix the
property with the `-D` java uses to set system properties. Such properties are
passed as shown below using the `environment.CATALINA_OPTS` value.

```yaml
environment:
  CATALINA_OPTS: >-
    -DalfrescoNtlm1:alfrescoNtlm,ldap1:ldap
    -Dsynchronization.externalUserControl=true
    -Dsynchronization.externalUserControlSubsystemName=ldap1
    -Dldap.synchronization.userAccountStatusProperty=pwdAccountLockedTime
    -Dldap.synchronization.disabledAccountPropertyValue=000001010000Z
```

## Sensitive data within the repository configuration

Sometimes the data required as a repository property is considered sensitive.
In such case we recommend using the approach below.

In the first place you will need a secret to hold the sensitive data you want
to pass to the Alfresco repository. One can be created as follow:

```bash
kubectl create secret generic repo-secret \
  --from-literal "REPO_ADMIN_PASSWORD=moreSecureThanAdmin"
```

Now we will reference that secret in the list of
`configuration.repository.existingSecrets` by specifying its name, the key
which holds the sensitive data we need and specify the name of the property we
want to assign that value to.
Here the name of the secret is `repo-scret`, the key holding the sensitive
value is `REPO_ADMIN_PASSWORD` and the property must be specified using
`purpose` attribute and following the syntax "property:doted.notation.property"

```yaml
configuration:
  repository:
    existingSecrets:
      - name: repo-secret
        key: REPO_ADMIN_PASSWORD
        purpose: property:alfresco_user_store.adminpassword
```
