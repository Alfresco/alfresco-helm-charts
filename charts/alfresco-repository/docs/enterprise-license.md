---
title: Enterprise license
parent: Repository
grand_parent: Guides
---

# Deploy Alfresco repository with enterprise license

Alfresco content repository Docker images come with an embedded license which
last only 2 days. If you've built a custom image, it may have a one year
license but in order to change it you would need to build a new image.
You can also configure this chart so the license is instead read from a
kubernetes secret so that, when it's time to renew the license you only need to
update that secret.

This configuration relies on 2 steps:

* creating a secret to hold the license
* configuring the chart to use that secret

## Create a kubernetes secret to store the license

Make sure your license available is readable and you have appropriate
kubernetes access in order to create a secret in the ACS namespace where you
want to deploy the helm release.

```bash
ACS_NAMESPACE=acs
kubectl create secret generic mylicense \
  --namespace $ACS_NAMESPACE \
  --from-file ~/Downloads/Alfresco-ent72-foobar.lic
```

## Configure the chart to leverage that secret

In the chart value file add the following:

```yaml
alfresco-repository:
  configuration:
    repository:
      existingSecrets:
        - name: mylicense
          key: Alfresco-ent72-foobar.lic
          purpose: acs-license
```

> License files for your Alfresco enterprise subscription can be obtained from
> the [Hyland Community portal](https://community.hyland.com/)

## Applying a new license (in case this is not a fresh deployment)

Before your license expires you will want to apply a new one. It's actually
very easy do to so. All you need to do is overwrite the secret you created on
previous deployment. You can use the exact same command just replacing the
license file with the new one. Once that's done you can refresh the license from
the Alfresco admin console and use the "Apply a new license" feature (check the
[admin doc][license]

[license]: https://support.hyland.com/r/Alfresco/Alfresco-Content-Services/25.1/Alfresco-Content-Services/Administer/Licenses/Upload-new-license
