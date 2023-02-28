# alfresco-helm-charts

⚠️⚠️⚠️ This repo represent an ongoing effort to make the existing [Alfresco Helm Charts](https://github.com/Alfresco/acs-deployment/tree/master/helm/alfresco-content-services) more independent and reusable. Please continue to refer to the parent [acs-deployment](https://github.com/Alfresco/acs-deployment) repository for [docs](https://github.com/Alfresco/acs-deployment/tree/master/docs/helm) and [issues](https://github.com/Alfresco/acs-deployment/issues).

## Development

This repository follows the [helm/charts-repo-actions-demo](https://github.com/helm/charts-repo-actions-demo) template, that support the testing and the release of helm charts with the help of two tools:

* https://github.com/helm/chart-testing
* https://github.com/helm/chart-releaser

### PR workflow

Each time a PR is raised, `ct` automatically detect which charts has been changed and run for them:

* linter
* unittest
* integration tests on KinD

Once a PR that contains a chart version bump is merged, the main workflow will release each version that has not yet released. Each chart release will trigger the creation of git tag, a GitHub release with packages attached and the update of the charts registry index.

### Update dependencies

There is an initial support for bumping charts dependencies with updatecli via a manually triggered [GHA workflow](https://github.com/Alfresco/alfresco-helm-charts/actions/workflows/updatecli.yaml).
