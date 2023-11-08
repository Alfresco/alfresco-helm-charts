# alfresco-helm-charts

This repository aims at delivering independent and lightweight
[Helm](https://helm.sh) charts for Alfresco Content Services platform that can
be used as building blocks by devops teams to build the Content Services
platform that match the organization needs.

⚠️ The existing [Alfresco Helm
Charts](https://github.com/Alfresco/acs-deployment/tree/master/helm/alfresco-content-services)
remains available and has been updated to leverage charts hosted in this
repository.

If you want to understand what are the principles to leverage in order to build
on top of Alfresco components' chart please refer to the
[getting-started-with-alfresco-charts](./getting-started-with-alfresco-charts.md)

Each individual chart has its own documentation page that's available in the
chart directory in [charts/](../charts). There are the values available for
each of them.

## Development

This repository follows the
[helm/charts-repo-actions-demo](https://github.com/helm/charts-repo-actions-demo)
template, that support the testing and the release of helm charts with the help
of two tools:

* [Helm chart testing](https://github.com/helm/chart-testing)
* [Helm chart releaser](https://github.com/helm/chart-releaser)

In order to install all the tools required for development on MacOS via
[Homebrew](https://brew.sh), run: `brew bundle install`

To setup [pre-commit](https://github.com/pre-commit/pre-commit), run:

```shell
pre-commit install
```

To install required helm plugins:

```shell
helm plugin install https://github.com/jtyr/kubeconform-helm --version v0.1.12
helm plugin install https://github.com/helm-unittest/helm-unittest --version v0.3.4
```

### PR workflow

Each time a PR is raised, `ct` automatically detects which charts has been
changed and run for them:

* linter
* unittest
* integration tests on KinD

Once a PR that contains a chart version bump is merged, the main workflow will
release each version that has not yet released. Each chart release will trigger
the creation of git tag, a GitHub release with packages attached and the update
of the charts registry index.

### Update dependencies

There is an initial support for bumping charts dependencies with
[Updatecli](https://www.updatecli.io/) via a manually triggered
[GHA
workflow](https://github.com/Alfresco/alfresco-helm-charts/actions/workflows/updatecli.yaml).

## Release

* Ensure alfresco-common [version](../charts/alfresco-common/Chart.yaml) is not a
  pre-release, otherwise release it.
* Ensure
  [supported-matrix](https://github.com/Alfresco/alfresco-updatecli/blob/master/deployments/values/supported-matrix.yaml)
  has been manually updated for the latest acs version released and the
  compatibility matrix is up to date.
* Trigger the creation of an update branch by executing [Bump
  version](../.github/workflows/updatecli.yaml) with `values` option. Optionally
  you can test not yet merged changes from alfresco-updatecli by specifying a
  branch other than master.
* Check that `updatecli-bump-acs` branch has been created. Review changes made
  by updatecli according to the supported matrix, eventually revert manually
  unwanted changes and push again.
* Ensure that all the charts are getting a GA release (non-alpha) at this point.
* Once the PR has been merged and all charts released, you can head to
  [acs-deployment](https://github.com/Alfresco/acs-deployment) to update the ACS umbrella chart.
