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
