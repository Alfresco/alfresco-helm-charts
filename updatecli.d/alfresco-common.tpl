name: "Helm autodiscovery using git scm"
scms:
  ourRepo:
    kind: github
    spec:
      user: {{ requiredEnv "GIT_AUTHOR_USERNAME" }}
      email: {{ requiredEnv "GIT_AUTHOR_EMAIL" }}
      owner: Alfresco
      repository: alfresco-helm-charts
      branch: main
      username: alfresco-build
      token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
    
sources:
  alfrescoCommonSource:
    kind: helmchart
    spec:
      url: https://alfresco.github.io/alfresco-helm-charts/
      name: alfresco-common

targets:
  activemqTarget:
    name: Bump alfresco-common upstream chart version
    kind: helmchart
    scmid: ourRepo
    spec:
      name: "charts/activemq"
      file: "Chart.yaml"
      key: "dependencies[0].version"
      versionincrement: patch

actions:
  default:
    kind: github/pullrequest
    scmid: ourRepo
    spec:
      draft: true
      labels:
        - updatecli
