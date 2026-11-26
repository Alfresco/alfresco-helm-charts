{{/*
Unused helpers

The following helpers are not used by any chart in the Alfresco organization:
- alfresco-common.read.cm.then.value
- alfresco-common.reqRead.cm.then.value
- alfresco-common.haskey.secret
- alfresco-common.checksum.config
- alfresco-common.lazy.getValueFromKey
- alfresco-common.may.glob.value

They were removed in favor of simpler, more direct approaches.
If you are using these helpers outside this repository, please migrate
to alternative implementations before upgrading to the next major version.

Potential replacements:
- For ConfigMap/Secret reads: Use helm-secrets or direct value references
- For checksums: Use Helm's built-in checksum annotation helpers
- For value lookups: Use direct dot notation in templates

*/}}
