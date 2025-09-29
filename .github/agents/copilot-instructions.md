# Copilot Instructions for Alfresco Helm Charts

## Chart Version Bumping Requirements

**CRITICAL REQUIREMENT**: Always remember to bump the Chart.yaml version when making changes to any chart in the `charts/` directory, following semantic versioning principles.

### Semantic Versioning Rules

When making changes to any chart folder under `charts/`, you MUST bump the version in the corresponding `Chart.yaml` file according to these rules:

#### Major Version Bump (X.y.z → X+1.0.0)
**Required for non-backward-compatible changes:**
- Breaking changes to chart configuration structure
- Removal of existing values or configuration options
- Changes that require manual intervention during upgrade
- Incompatible dependency version updates
- Changes to default behavior that could break existing deployments

#### Minor Version Bump (x.Y.z → x.Y+1.z)
**Required for backward-compatible feature additions:**
- New configuration options or values
- New features that don't break existing functionality
- Addition of new templates or resources
- Backward-compatible dependency updates
- New optional functionality

#### Patch Version Bump (x.y.Z → x.y.Z+1)
**Required for backward-compatible bug fixes:**
- Bug fixes that don't change functionality
- Documentation updates within the chart
- Template fixes that don't change behavior
- Security patches that maintain compatibility
- Minor dependency patch updates

### Implementation Checklist

When working on changes to any chart (e.g., `charts/alfresco-repository/`, `charts/alfresco-common/`, etc.):

1. **Identify affected charts**: Determine which chart directories contain modified files
2. **Assess change impact**: Categorize the change (breaking, feature, bugfix)
3. **Update Chart.yaml version**: Increment the appropriate version number
4. **Verify version format**: Ensure version follows semantic versioning (e.g., "1.2.3")
5. **Check dependencies**: If modifying alfresco-common, update dependent charts' requirements

### Chart Structure Reference

Each chart is located in `charts/{chart-name}/` and contains:
- `Chart.yaml` - Contains the version field that must be updated
- `values.yaml` - Default configuration values
- `templates/` - Kubernetes resource templates

### Examples of Version Bumping

```yaml
# Before change (in Chart.yaml)
version: 1.5.2

# After adding a new feature (minor bump)
version: 1.6.0

# After fixing a bug (patch bump)  
version: 1.5.3

# After breaking change (major bump)
version: 2.0.0
```

### Special Considerations

- **alfresco-common chart**: Changes here often require updating dependent charts
- **Multiple charts affected**: Each chart needs its own version bump
- **Pre-release versions**: Use semantic versioning pre-release identifiers (e.g., "1.0.0-alpha.1")
- **Coordination with releases**: Version bumps trigger chart releases through CI/CD

### Chart Dependencies

Some charts depend on others (e.g., many charts depend on `alfresco-common`). When updating:
1. Update the dependency chart first
2. Update dependent charts to reference the new version
3. Test the dependency chain

### Quick Reference Commands

To check current chart versions:
```bash
find charts/ -name "Chart.yaml" -exec grep -H "version:" {} \;
```

To validate semantic versioning format:
```bash
# Version should match pattern: MAJOR.MINOR.PATCH (e.g., 1.2.3)
grep -E "version: [0-9]+\.[0-9]+\.[0-9]+" charts/*/Chart.yaml
```

### Chart-Specific Examples

Current chart versions (as reference):
- `alfresco-common`: 4.0.0 (library chart, many dependencies)
- `alfresco-repository`: 0.10.1 (application chart)
- `alfresco-connector-hxi`: 0.1.5 (newer chart)
- `elastic`: 0.1.2 (infrastructure chart)

**Remember: Every change to chart files requires a corresponding version bump in Chart.yaml!**

### Automation Note

The repository uses GitHub Actions to automatically release charts when versions are bumped. Make sure your version bump is intentional and follows the semantic versioning rules above.