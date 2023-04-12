module.exports = {
    "branchPrefix": "renovatebot/",
    "dryRun": null,
    "username": "alfresco-build",
    "gitAuthor": "Renovate Bot <alfresco-build@hyland.com>",
    "onboarding": false,
    "requireConfig": "optional",
    "platform": "github",
    "repositories": [
        {
            repository: "Alfresco/alfresco-helm-charts",
            enabledManagers: ["helmv3"],
            extends: ["config:base"],
        }
    ],
    "packageRules": []
};
