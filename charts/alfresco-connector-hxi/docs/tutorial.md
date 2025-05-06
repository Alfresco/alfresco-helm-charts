---
title: How to Connect HXI to a Running Repository
parent: Knowledge Retrieval
grand_parent: Guides
---

# Connecting HXI Chart to a Running Repository Instance

This guide walks you through connecting an HXI chart to a running repository
instance, with a focus on configuring the live ingester. It includes setting up
the HXI Helm chart and ensuring the repository instance is correctly configured
for the HXI extension.

## Prerequisites

Before you begin, make sure you have:

1. A running ACS (Alfresco Content Services) stack.
2. The HXI (Hyland Experience Insight) extension installed and enabled on the repository.
3. From your ACS stack:
   - ActiveMQ URL
   - ActiveMQ username
   - ActiveMQ password
   - SFS (Shared File Store) URL
4. From Hyland Experience Insight (HXI) / Knowledge Retrieval:
   - HXI Client ID
   - HXI Client Secret
   - HXI Environment Key
   - HXI App Source ID
   - HXI Authentication Token URL
   - HXI Insight Ingestion URL
   - HXI Discovery Base URL
   - HXI Knowledge Retrieval URL

> Tip: For better security, store credentials such as secrets and passwords in
> Kubernetes secrets. This guide demonstrates inline configuration for
> simplicity. For secure handling, refer to the `existingSecret` option in the
> ACS deployment documentation.

## Setup Steps

1. **Prepare your [file](hxi.yml)**  with all required connection settings for
   HXI, ActiveMQ, and the repository. This file is passed into the Helm chart
   and should include the HXI client details, environment key, URLs, and the
   version of the connector.

2. **Apply the Helm chart** using your configured values file:

```bash
helm install hxi . --values docs/hxi.yml
```

3. **Review the output** from the Helm chart installation. You will see a list
   of generated properties that need to be passed to the repository instance:

```txt
hxi.discovery.base-url=https://discovery.staging.experience.hyland.com
hxi.auth.providers.hyland-experience.token-uri=https://auth.iam.staging.experience.hyland.com/idp/connect/token
hxi.auth.providers.hyland-experience.environment-key=alfresco-kd-ci-xxxx
hxi.auth.providers.hyland-experience.client-id=sc-xxxx
hxi.auth.providers.hyland-experience.client-secret=your-client-secret
hxi.knowledge-retrieval.url=https://alfresco-kd-ci-xxxx.insight.staging.ncp.hyland.com/discovery/agents
hxi.connector.source-id=984b2de8-xxxx
```

4. **Update the repository instance** to include these properties. If you're
   using the `alfresco-content-services` Helm chart, add them under
   `config.repository.additionalGlobalProperties`.

Example:

```yaml
config:
  repository:
    additionalGlobalProperties:
      hxi.discovery.base-url: https://discovery.staging.experience.hyland.com
      hxi.auth.providers.hyland-experience.token-uri: https://auth.iam.staging.experience.hyland.com/idp/connect/token
      hxi.auth.providers.hyland-experience.environment-key: alfresco-kd-ci-xxxx
      hxi.auth.providers.hyland-experience.client-id: sc-xxxx
      hxi.auth.providers.hyland-experience.client-secret: your-client-secret
      hxi.knowledge-retrieval.url: https://alfresco-kd-ci-xxxx.insight.staging.ncp.hyland.com/discovery/agents
      hxi.connector.source-id: 984b2de8-xxxx
```

5. **Restart the repository** to ensure the configuration changes take effect.

6. **Verify ingestion is working** by checking logs in the `live-ingester` pod.
   Look for successful connection messages and ingestion events.

This process ensures your HXI chart is properly connected to a running
repository instance and ready to support knowledge retrieval and analytics.
