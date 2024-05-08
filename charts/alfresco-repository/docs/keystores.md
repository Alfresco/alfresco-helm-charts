---
title: Custom keystores
parent: Repository
grand_parent: Guides
---

# Using custom keystore

Alfresco uses a set of keystores for different purposes. Among others thing
keystores can be used for metadata encryption or traffic encryption.

The alfresco-content-repository image comes with a keystore which contains a
single security key. That key is primarily used for metadata encryption and it
required when the repository starts up. In production environment it is
recommended to use a custom keystore rather than the one present in the image.

One may also need to have additional keystores deployed, for instance to allow
using TLS encryption for a service the repository provides using an x509
certificate. We describe below how to do both.

## The metadata keystore

This keystore is used for property encryption and needs to remain identical
throughout the life of the repository. Losing this keystore or its passwords
will result in a repository that cannot startup so it is absolutely crucial to
to back them up in some safe place.

First create a local keystore. It is recommended to use p12 containers nowadays
and leverage AES algorithm:

```bash
keytool -genseckey \
  -keystore /path/to/keystore.p12
  -storetype PKCS12 \
  -storepass secret -keyalg AES \
  -keysize 256 \
  -alias metadata
```

Now we need to create a secret with from that keystore file and its password in
the namespace where Alfresco will be deployed:

```bash
kubectl create secret generic repository-keystores \
  --from-file=/path/to/keystore.p12 \
  --from-literal "ENC_METADATA_STOREPASS=secret" \
  --from-literal "ENC_METADATA_KEYPASS=secret"
```

> Note, unlike the older JCEKS format, PKCS12 do not allow having different
> passwords for the keystore and the key. so both variables need to be
> populated with the same value (the same one that was used whn generating the
> keystore using keytool (here "secret").

Once the secret is created in target namespace we need to let the chart know it
needs to mount it and provide necessary options for the repository to access
that keystore. To do so use the properties below:

```yaml
---
configuration:
  repository:
    existingSecrets:
      - name: repository-keystores
        key: ENC_METADATA_STOREPASS
      - name: repository-keystores
        key: ENC_METADATA_KEYPASS
environment:
  JAVA_OPTS: >-
    -Dencryption.keystore.type=PKCS12
    -Dencryption.cipherAlgorithm=AES/CBC/PKCS5Padding
    -Dencryption.keyAlgorithm=AES
    -Dencryption.keystore.location=/usr/local/tomcat/shared/classes/alfresco/extension/keystore/keystore.p12
    -Dmetadata-keystore.aliases=metadata
    -Dmetadata-keystore.metadata.algorithm=AES
extraVolumes:
  - name: keystore
    secret:
      secretName: repository-keystores
extraVolumeMounts:
  - name: keystore
    readOnly: true
    mountPath: /usr/local/tomcat/shared/classes/alfresco/extension/keystore
```

> Note credentials are not passed directly using `environment.JAVA_OPTS` but
> secrets.

## Other keystore

The same approach would work to deploy any keystore. Below example describes how
to deploy a custom keystore (here for imaps configuration) together with the
required option so the repository can use it.

First let's create a keysotre with a self-signed cert & store it in a p12 file.

```bash
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout server.key -out server.crt
openssl pkcs12 -export -in server.crt -inkey server.key -out server.p12 -name localhost
keytool -importkeystore \
        -deststorepass secret -destkeypass secret -destkeystore keystore.p12 -deststoretype PKCS12 \
        -srckeystore server.p12 -srcstoretype PKCS12 -srcstorepass secret \
        -alias localhost
```

> Java prefers working with PKCS12 containers generated using keytool so that's
> why we generate 2 p12 files

Then create a secret from this keystore file:

```bash
kubectl create secret generic repository-keystores \
  --from-file=keystore.p12 \
```

Now in order to make sure the repo can open the keystore we need to give the
necessary credentials. We will pass credentials values as kubernetes secret
keys' values and their related java properties as their keys. For example in
order to pass the property `javax.net.ssl.keyStorePassword=secret` we would
create the secret as follow:

```bash
kubectl create secret generic kesystore-secret \
  --from-literal MYKEYSTORE_PASS=secret
```

> credentials can be held in the same secret as the keystore itself.

Now we need to reference these secrets and pass the non sensitive properties
as `environment.JAVA_OPTS` when deploying the alfresco-repository chart:

```yaml
extraVolumes:
  - name: keystore
    secret:
      secretName: repository-keystores
extraVolumeMounts:
  - name: keystore
    readOnly: true
    mountPath: /usr/local/tomcat/shared/classes/alfresco/extension/keystore
configuration:
  repository:
    existingSecrets:
      - name: kesystore-secret
        key: javax.net.ssl.keyStorePassword
        purpose: property:javax.net.ssl.keyStorePassword
environment:
  JAVA_OPTS: >-
    -Djavax.net.ssl.keyStore=/usr/local/tomcat/shared/classes/alfresco/extension/keystore/keystore.p12
```

This very same procdure can apply to other service which require a
certification to enable traffic encryption.
