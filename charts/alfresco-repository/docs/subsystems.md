## Configuring Alfresco subsystems

This chart offers a simple mechanism to configure Alfresco Subsytems.

The way it's done is pretty simple, one just need to provide a secret which
contains all the configuration files for the subsystems. The secret needs to be
added to the list of `.Values.configuration.repository.existingSecrets`:

```yaml
configuration:
  repository:
    existignSecrets:
      - name: ldap1
        purpose: subsystems:Authentication:ldap
```

For the above configuration to work there are some rules to follow:

* `name` must match both the secret name and the subsystem instance name (in
   case the subsystem name must be referenced somewhere else, e.g. in
  `authentication.chain`)
* `purpose` must be of the form: subsystems:subsystemName:subsystemType
* The secret must contain all necessary files to configure the subsystem.
  Usually a bean definition XML file and properties file. (see example below)

### Examples: ContentStore configuration

Creating the subsystem's secret:

Place all the configuration files in a folder on uyour local system. Sample
files can be extracted from the S3 AMP file. For more details on the content of
the files check out the [Alfresco S3 connector
doc](https://docs.alfresco.com/aws-s3/latest/config/#content-store-subsystems#).

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
> down from a single directory (mountpoint). If your subsystem config does
> this kind of inclusion you'll need to amend the Bean to not use `import`
> statement or import from the current directory.

Create the secret using `kubectl`

```shell
kubectl create secret generic S3--from-file=s3-config/
```

Pass the following `configuration.repository.existingSecrets` together with the
property to set the new contentstore subsystem as the default contentstore:

```yaml
configuration:
  repository:
    existignSecrets:
      - name: repository-secrets
        key: license.lic
        purpose: acs-license
      - name: S3
        purpose: subsystems:ContentStore:S3
environment:
  CATALINA_OPTS: >-
    -Dfilecontentstore.subsystem.name=S3
```

> As a list `configuration.repository/existignSecrets` cannot be merged so you
> would need to defined the license secret i order to have it deployed.
