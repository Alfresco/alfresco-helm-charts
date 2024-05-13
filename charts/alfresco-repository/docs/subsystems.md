---
title: Subsystems
parent: Repository
grand_parent: Guides
---

# Configuring Alfresco subsystems

This chart offers a rather simple mechanism to configure Alfresco Subsystems.
Although subsystems are well known to most Alfresco administrators, in a
kubernetes environment they should be used only when necessary (e.g. if in need
to instantiate several instances of the same subsystem)

Subsystem configuration relies on providing a secret which contains all the
configuration files for the subsystems. The secret needs to be added to the
list of `configuration.repository.existingSecrets`:

```yaml
configuration:
  repository:
    existingSecrets:
      - name: ldap1
        purpose: subsystems:Authentication:ldap
```

For the above configuration to work there are some rules to follow:

* `name` must match both the secret name and the subsystem instance name (in
   case the subsystem name must be referenced somewhere else, e.g. in
  `authentication.chain`)
* `purpose` must be of the form: `subsystems:subsystemName:subsystemType`
* The secret must contain all necessary files to configure the subsystem.
  Usually a bean definition XML file and properties file. (see example below)

> Kubernetes secrets can not be bigger than 1MB. That means that this method
> will not work in case a subsystem contain 1MB of data or more. This should
> not be the case for most subsystems but is important t know in case of
> customizations

## Examples: ContentStore configuration

Creating the subsystem's secret:

Place all the configuration files in a folder on your local system. Sample
files can be extracted from the S3 AMP file. For more details on the content of
the files check out the [Alfresco S3 connector docs](https://docs.alfresco.com/aws-s3/latest/config/#content-store-subsystems).

```bash
mkdir s3-config
unzip -d s3-config ~/Downloads/alfresco-s3-connector-5.1.0.amp config/alfresco/subsystems/ContentStore/S3/
tree s3-config
s3-config/
 ├── s3-contentstore-context.xml
 └── s3-contentstore.properties
...
```

> By default subsystem Beans may include other XML files from upper level
> directories. This is not possible with as kubernetes secrets are projected
> down from a single directory (mount point). If your subsystem config does
> this kind of inclusion you'll need to amend the Bean to not use `import`
> statement or import from the current directory.

Create the secret using `kubectl`

```shell
kubectl create secret generic S3 --from-file=s3-config/
```

Pass the following `configuration.repository.existingSecrets` together with the
property to set the new contentstore subsystem as the default contentstore:

```yaml
configuration:
  repository:
    existingSecrets:
      - name: repository-secrets
        key: license.lic
        purpose: acs-license
      - name: S3
        purpose: subsystems:ContentStore:S3
environment:
  CATALINA_OPTS: >-
    -Dfilecontentstore.subsystem.name=S3
```

> As a list, `configuration.repository/existingSecrets` cannot be merged so you
> would need to re-define the license secret to have it deployed.
