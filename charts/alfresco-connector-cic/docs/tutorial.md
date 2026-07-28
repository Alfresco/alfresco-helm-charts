---
title: How to Connect CIC to a Running Repository
parent: Knowledge Retrieval
grand_parent: Guides
---

# Connecting CIC Chart to a Running Repository Instance

This guide walks you through connecting the `alfresco-connector-cic` chart to a
previously deployed repository instance. It covers configuring the live
ingester, the nucleus-sync service, and ensuring the repository instance is
correctly configured with the CIC extension.

## Prerequisites

Before you begin, make sure you have:

1. A working Alfresco Content Services deployment
2. The CIC (Content Intelligence Connector) extension installed and enabled on
   the repository.
3. From your ACS stack:
   - ActiveMQ URL
   - ActiveMQ username
   - ActiveMQ password
   - SFS (Shared File Store) URL
   - Repository URL
4. From Hyland Experience (HX) / Content Intelligence:
   - HX Client ID
   - HX Client Secret
   - HX Environment Key
   - HX App Source ID
   - HX Authentication Token URL
   - HX Insight Ingestion URL
   - HX Environment name (e.g. `staging` or `production`)
5. From Nucleus (required if deploying the nucleus-sync component):
   - Nucleus Base URL
   - Nucleus IDP Base URL
   - Nucleus System ID

> Tip: For better security, store credentials such as secrets and passwords in
> Kubernetes secrets. This guide demonstrates inline configuration for
> simplicity. For secure handling, use the `existingSecret` and
> `existingConfigMap` options documented in the chart's `values.yaml`.

## Setup Steps

1. **Prepare your [file](cic.yml)** with all required connection settings for
   CIC, ActiveMQ, ATS/SFS, and the repository. This file is passed into the
   Helm chart and should include the HX client details, Nucleus connection
   settings, and the version of the connector matching your deployed repository
   extension.

2. **Apply the Helm chart** using your configured values file:

   ```bash
   helm repo add alfresco-helm-charts https://alfresco.github.io/alfresco-helm-charts/
   helm repo update
   helm install cic alfresco-helm-charts/alfresco-connector-cic \
     --values charts/alfresco-connector-cic/docs/cic.yml
   ```

3. **Verify that the required pods are running.** Depending on which components
   are enabled in your values file, you should see:

   - `cic-live-ingester` — processes repository events and sends content to HX
     Insight ingestion.
   - `cic-bulk-ingester` (Job, enabled by default) — performs an initial full
     content crawl via ActiveMQ.
   - `cic-nucleus-sync` (enabled by default) — synchronises repository metadata
     with Nucleus.

   ```bash
   kubectl get pods -l app.kubernetes.io/instance=cic
   ```

4. **Configure the repository** with the CIC extension properties. If you are
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
         hxi.connector.source-id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx
   ```

   > Note: These repository-side properties are provided by Hyland along with
   > your CIC credentials and identify the HX environment the repository should
   > connect to for knowledge retrieval queries.

5. **Restart the repository** to ensure the configuration changes take effect.

6. **Verify ingestion is working** by checking the logs in the `live-ingester`
   pod. Look for successful connection messages and ingestion events:

   ```bash
   kubectl logs -l app.kubernetes.io/component=alfresco-connector-cic \
     -c cic-live-ingester --tail=100
   ```

   For nucleus-sync, verify that the Nucleus connection is established:

   ```bash
   kubectl logs -l app.kubernetes.io/component=alfresco-connector-cic \
     -c cic-nucleus-sync --tail=100
   ```

This process ensures your CIC chart is properly connected to a running
repository instance and ready to support content intelligence and knowledge
retrieval features.
