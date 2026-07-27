---
title: How to Connect CIC to a Running Repository
parent: Knowledge Retrieval
grand_parent: Guides
---

# Connecting CIC Chart to a Running Repository Instance

This guide walks you through deploying the CIC (Content Ingestion & Connectivity)
Helm chart and connecting it to an existing Alfresco Content Services (ACS) instance.
The chart deploys up to three optional components:

- **live-ingester** — listens for ACS content events and ingests them into Hyland Experience Insight
- **nucleus-sync** — periodically synchronises Alfresco users and groups with the Nucleus identity system
- **bulk-ingester** — performs a one-time bulk ingestion from the ACS database (disabled by default)

> **Tip:** For production deployments, store credentials in Kubernetes Secrets and reference
> them via the `existingSecret` values to avoid inline credentials in your values file.

## Setup Steps

1. **Prepare your [values file](cic.yml)** with the required connection settings for
   the components you want to enable. At minimum you need Hyland Experience credentials
   and the Alfresco repository URL. For nucleus-sync you also need the Nucleus connection
   details (`nucleusBaseUrl`, `nucleusIdpBaseUrl`, `nucleusSystemId`).

2. **Apply the Helm chart** using your configured values file:

```bash
helm repo add alfresco-helm-charts https://alfresco.github.io/alfresco-helm-charts/
helm repo update
helm install cic alfresco-helm-charts/alfresco-connector-cic --values cic.yml
```

3. **Configure the Alfresco repository** with the properties shown in the Helm install
   notes. These properties use the `hxi.*` namespace because they are consumed by the
   Alfresco Repository's HXI extension. If you are using the `alfresco-content-services`
   Helm chart, add them under `config.repository.additionalGlobalProperties`:

```yaml
config:
  repository:
    additionalGlobalProperties:
      hxi.discovery.base-url: <hxi-discovery-url>
      hxi.auth.providers.hyland-experience.token-uri: <hx-auth-token-url>
      hxi.auth.providers.hyland-experience.environment-key: <hx-env-key>
      hxi.auth.providers.hyland-experience.client-id: <hx-client-id>
      hxi.auth.providers.hyland-experience.client-secret: <hx-client-secret>
      hxi.knowledge-retrieval.url: <hxi-knowledge-retrieval-url>
      hxi.connector.source-id: <hx-app-source-id>
```

4. **Restart the repository** to apply the configuration changes.

5. **Verify ingestion is working** by checking logs in the `live-ingester` pod.
   Look for successful connection messages and ingestion events.

This process ensures your CIC chart is properly connected to a running
repository instance and ready to support knowledge retrieval and analytics.
