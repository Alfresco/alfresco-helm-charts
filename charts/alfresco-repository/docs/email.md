---
title: Email features
parent: Repository
grand_parent: Guides
---

# Configuring email related features

Alfresco repository can interact with users through emails in different ways.
Below we describe how to enable and configure the 3 main email features Alfresco
offers:

* Sending emails
* Accepting incoming email
* IMAP interface to the repository

## Sending emails

To enable Alfresco to send emails, it needs to communicate with a mail relay
that administrators must configure. This mail relay is considered an integral
part of the required architecture, and administrators can configure it using
standard Alfresco properties.

There are 2 ways to pass properties to the repository:

* Using `configuration.repository.existingConfigMap`
* Using `environment.CATALINA_OPTS` env var.

### Using a configmap

Passing properties through a configmap is as simple as setting it in the
alfresco-global.properties file. Start by creating a file called
`alfresco-global.properties` as a regular properties file:

```properties
mail.host=mysmtp.infra.local
mail.port=587
mail.username=alfresco
mail.from.default=alfresco@domain.tld
mail.smtp.auth=true
mail.smtp.starttls.enable=true
```

> Note: Although possible, we do not set the authentication password is not set
> in the configmap. Instead we will create a secret for it.

We then create a configmap from the file with the mail properties (and possibly
other properties):

```bash
kubectl create configmap repo-config \
  --from-file=alfresco-global.properties
```

### Using a env vars

Passing properties through the CATALINA_OPTS environment variable can be done as
shown below:

```yaml
environment:
  CATALINA_OPTS: >-
    -Dmail.host=mysmtp.infra.local
    -Dmail.port=587
    -Dmail.username=alfresco
    -Dmail.from.default=alfresco@domain.tld
    -Dmail.smtp.auth=true
    -Dmail.smtp.starttls.enable=true
```

### Passing credentials

Regardless of whether you choose to pass properties using a configmap or
directly values, you should avoid passing credentials in the same way.
To securely pass credentials we will create a secret so the Alfresco repository
can authenticate to the mail relay:

```bash
kubectl create secret generic mail-secret \
  --from-literal "MAIL_PASSWORe=mysupersecret"
```

Now when installing the chart you can use the values below:

```yaml
configuration:
  repository:
    existingConfigMap: repo-config
    existingSecrets:
      - name: repository-secrets
        key: license.lic
        purpose: acs-license
      - name: mail-secret
        key: MAIL_PASSWORD
        purpose: property:mail.password
```

### Enabling TLS/SSL

If you need to negotiate TLS/SSL session with the mail relay and your mail
relay uses a certificate that's not from a known CA, you will need to import a
truststore containing either the server certificate itself or its issuing CA.

Checkout the [keystore doc for more details](keystores.md) import a
truststore or a keystore works the same way.

## Accepting incoming email

Enabling Alfresco Inbound SMTP capabilities allow content to be fed into
Alfresco repository using email and SMTP protocol. It is HIGHLY recommended to
not expose Alfresco SMTP server directly to the outside world and instead have
an SMTP proxy to implement required security measures.

```properties
configuration:
  smtp:
    enabled: true
    port: 1465
    service:
      annotations:
        service.beta.kubernetes.io/load-balancer-source-ranges: 10.0.0.0/24
        service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: instance
        service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
        service.beta.kubernetes.io/aws-load-balancer-subnets: subnet-xxxx, subnet-yyyy
        service.beta.kubernetes.io/aws-load-balancer-ssl-cert=arn:aws:acm:region:account:certificate/certificate_ID
environment:
  CATALINA_OPTS: >-
    -Demail.inbound.unknownUser=anonymous
    -Demail.server.domain=myecm.domain.tld
    -Demail.server.allowed.senders=ecm-ingestor@myecm.domain.tld
    -Demail.server.blocked.senders=.*
    -Demail.server.auth.enabled=true
```

Here we configure an SMTPs service to listen on port 1465 through an AWS
loadbalancer and accept emails from a single sender. This loadbalancer will be
responsible for doing the SSL off-load and further traffic will be cleartext.
This is suitable in most cases as - as said earlier - your SMTP server should
never be exposed directly on internet and have an SMTP proxy in front of it.

In case you really need to terminate the SSL session on the Alfresco repo see
the [keystore doc](keystores.md)

## Enabling IMAP

Similarly to SMTP inbound, it is possible to enable IMAP interface to the
repository  using the configuration below:

To get broader view on the available properties to configure IMAP please refer
to the [IMAP
documentation](https://docs.alfresco.com/content-services/latest/config/email/#configure-imap)

```properties
configuration:
  imap:
    enabled: true
    port: 1145
    service:
      annotations:
        service.beta.kubernetes.io/load-balancer-source-ranges: 10.0.0.0/24
        service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: instance
        service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
environment:
  CATALINA_OPTS: >-
    -Dimap.server.attachments.extraction.enabled=false
```

As usual, in order to configure IMAPs or IMAP/TLS refer to the
[keystore](keystores.md) documentation.
