---
title: Truststore
parent: Alfresco Search Enterprise
grand_parent: Guides
---

# Setting custom java truststore

There are multiple use cases where you may want to set a custom keystore or
truststore. It can be because you need to interact with a third party service
which uses a self-signed certificate or a prvite CA that is not shipped with
the container. Or maybe the service you are trying to connect to uses a
self-signed certificate and you want to trust it. In this case, you can
create a custom truststore and set it in the container.

## Create a custom truststore

You can create a custom truststore on your local machine using the
`keytool` command. The `keytool` command is part of the Java Development Kit (JDK)
and is used to manage keystores and truststores. You can use the following
command to create a new truststore and import a certificate into it:

```bash
keytool -importcert -file <path-to-certificate-file> -alias <alias-name> -keystore <path-to-truststore-file>
```

Where `<path-to-certificate-file>` is the path to the CA certificate or the
self-signed certificate you want to trust, `<alias-name>` is a name you want
to give to the certificate in the truststore, and `<path-to-truststore-file>`
is the path to the truststore file you want to create.
You will be prompted to enter a password for the truststore. You can use
the default password `changeit` or leave it empty (Truststore usually contain
public informations so it should not be a problem to not use a password).
Also note that <path-to-truststore-file> can point to an already existing
truststore file. We recommand using the default  `cacerts` truststore that
comes with the JDK. This way, you can add your custom certificates to the
default truststore and use it in your application.

## Create a Kubernetes secret

Once you have created the truststore, you can create a Kubernetes secret
to store the truststore file. You can use the following command to create a
Kubernetes secret:

```bash
kubectl create secret generic -n <namespace> <secret-name> \
  --from-file=<path-to-truststore-file> \
  --dry-run=client -o yaml
```

Where `<secret-name>` is the name you want to give to the secret and
`<path-to-truststore-file>` is the path to the truststore file you created
or updated in the previous step and `<namespace>` is the namespace where you
want to create the secret (needs to be the same namespace where your pods are
running).

This will produce a YAML output you can then apply to your Kubernetes
cluster or save to a file for applying later with the command below:

```bash
kubectl apply -f <path-to-secret-file>
```

## Mount the secret in the pod

You can mount the secret in the pod by adding the following values to the
Helm values file:

```yaml
extraVolumes:
  - name: custom-truststore
    secret:
      secretName: <secret-name>
extraVolumeMounts:
  - name: custom-truststore
    mountPath: /etc/ssl/certs/custom-truststore
    subPath: <path-to-truststore-file>
```

Now you need to set the `JAVA_OPTS` environment variable to use the custom
truststore. You can do this by adding the following values to the Helm
values file:

```yaml
liveIndexing:
  environment:
    JAVA_OPTS: "-Djavax.net.ssl.trustStore=/etc/ssl/certs/custom-truststore"
reindexing:
  environment:
    JAVA_OPTS: "-Djavax.net.ssl.trustStore=/etc/ssl/certs/custom-truststore"
```
