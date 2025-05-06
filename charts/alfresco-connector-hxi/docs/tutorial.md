---
title: How to connect to running repository
parent: Knowledge Retrieval
grand_parent: Guides
---

# Connecting HXI Chart to a Running Repository Instance

This guide will walk you through the process of connecting an HXI chart to a
running repository instance, with a specific focus on configuring the live
ingester. This includes setting up the HXI Helm chart and ensuring the
repository instance is correctly configured for the HXI extension.

## Prerequisites

Before you begin, ensure you have the following:

1.  A running ACS stack.
2.  A running HXI (Hyland Experience Insight) extension installed/enabled on the
    repository side.
3.  From your ACS stack:
    * ActiveMQ URL
    * ActiveMQ Username
    * ActiveMQ Password
    * SFS (Shared File Store) URL
4.  From Hyland Experience Insight (HXI) / Knowledge Retrieval:
    * HXI Client ID
    * HXI Client Secret
    * HXI Environment Key
    * HXI App Source ID
    * HXI Authentication Token URL (e.g.,
      `https://auth.iam.staging.experience.hyland.com/idp/connect/token`)
    * HXI Insight Ingestion URL (for the live ingester, e.g.,
      `https://ingestion-api.insight.staging.ncp.hyland.com/v1`)
    * HXI Discovery Base URL (e.g.,
      `https://discovery.staging.experience.hyland.com`)
    * HXI Knowledge Retrieval URL (e.g.,
      `https://alfresco-kd-ci-8931ff99-97d8-4c36-a235-ba9269286322.insight.staging.ncp.hyland.com/discovery/agents`)

We recommend storing sensitive credentials like passwords and secrets in
Kubernetes secrets for better security but in this example we will show how to
pass them directly from the values. Using this method will produce a list a
properties needed to be add inside repository instance. To see how to leverage
`existingSecret` option visit acs-deployment docs.
