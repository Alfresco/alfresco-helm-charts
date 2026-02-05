# Copilot Instructions for Alfresco Helm Charts

## Repository Overview

This repository contains Helm charts for deploying Alfresco Content Services (ACS) and related components to Kubernetes. It includes 18 individual charts for various Alfresco services including repository, share, search, transform services, and integrations.

**Key Technologies:**
- Helm 3
- Kubernetes
- YAML templating
- GitHub Actions for CI/CD

## Building and Testing

### Prerequisites Setup

**On homebrew supported platforms:**
```bash
brew bundle install  # Installs all required tools from Brewfile
```

**Required Helm plugins (any platform):**
```bash
helm plugin install https://github.com/jtyr/kubeconform-helm --version v0.2.0
helm plugin install https://github.com/helm-unittest/helm-unittest --version v1.0.0
```

**Pre-commit hooks:**
```bash
pre-commit install  # Must be run after each commit
```

### Testing Commands

**1. Lint a specific chart:**
```bash
ct lint --config ct.yaml --charts charts/<chart-name>
```

**2. Run unit tests for a chart:**
```bash
helm unittest --color charts/<chart-name>
```

**3. Validate chart rendering:**
```bash
helm template charts/<chart-name> --output-dir charts/<chart-name>/render -f charts/<chart-name>/ci/default-values.yaml
yamllint -c .yamllint.yml charts/<chart-name>/render
```

**4. Check Kubernetes API compatibility (minimum version):**
```bash
helm kubeconform -kubernetes-version=1.28.15 -values-dir=ci -strict charts/<chart-name>
```

**5. Check chart version dependencies:**
```bash
./scripts/charts.sh  # Ensures no GA charts depend on pre-release versions
```

**6. Run all pre-commit checks:**
```bash
pre-commit run --all-files
```

**Important Notes:**
- **Always run tests in the order above** before committing changes
- The `alfresco-common` chart is a library chart and cannot be tested directly
- Tests require the chart to have a `ci/default-values.yaml` file
- Integration tests on KinD require Quay.io credentials (CI only)
- Pre-commit hooks will automatically run on commit
- **When making changes under a chart's `templates/` folder**, add new tests or
  improve existing ones to cover the template changes.
- **Re-evaluate and propose updates to this instruction file** whenever the
  supported Kubernetes version changes or any dependency versions referenced
  here change (e.g., kubeconform or helm-unittest).

### Common Pitfalls

1. **Forgetting to bump chart versions** - This is the #1 mistake. Always bump
   Chart.yaml version for any chart changes
2. **Missing helm plugins** - Both kubeconform-helm and helm-unittest are required
3. **Not running pre-commit** - Pre-commit catches many issues before CI
4. **Testing without ci/default-values.yaml** - Each chart needs valid test values
5. **Dependencies out of sync** - Run `helm dependency update` after Chart.yaml changes

## Project Layout

### Repository Structure

```
/
├── .github/
│   ├── copilot-instructions.md       # This file
│   ├── workflows/                    # CI/CD pipelines
│   │   ├── lint-test.yaml           # Main test workflow (runs on PRs)
│   │   ├── release.yaml             # Chart release automation
│   │   ├── pre-commit.yaml          # Pre-commit hook validation
│   │   ├── checkov.yml              # Security scanning (Checkov)
│   │   └── kics.yml                 # Security scanning (KICS)
│   └── dependabot.yml               # Dependency updates
├── charts/                          # All Helm charts (18 total)
│   ├── alfresco-common/            # Library chart - used by many others
│   ├── alfresco-repository/        # Main ACS repository service
│   ├── alfresco-share/             # Share UI
│   ├── alfresco-search-*/          # Search services
│   └── [other charts]/
├── docs/                           # Jekyll documentation site
├── scripts/                        # Utility scripts
│   └── charts.sh                   # Validates chart version consistency
├── .pre-commit-config.yaml         # Pre-commit hook configuration
├── ct.yaml                         # Chart Testing tool configuration
├── cr.yaml                         # Chart Releaser configuration
├── .yamllint.yml                   # YAML linting rules
├── README.md                       # Main documentation
└── UPGRADES.md                     # Breaking changes and deprecations
```

### Chart Structure

Each chart under `charts/` follows this structure:
```
charts/<chart-name>/
├── Chart.yaml              # Chart metadata and version (MUST bump on changes)
├── Chart.lock              # Dependency lock file
├── values.yaml             # Default configuration values
├── templates/              # Kubernetes resource templates
├── tests/                  # Helm unit tests
├── ci/
│   ├── default-values.yaml # Values for CI testing
│   └── kustomize/          # Optional mocks for testing
├── docs/                   # Chart-specific documentation
└── README.md               # Auto-generated from README.md.gotmpl
```

### Key Files to Know

- **Chart.yaml**: Contains version field that MUST be updated for every change
- **values.yaml**: Default configuration - changes here usually need minor version bump
- **templates/*.yaml**: Kubernetes resources - test changes thoroughly
- **tests/*.yaml**: Unit tests using helm-unittest
- **ci/default-values.yaml**: Minimal values for testing - keep this working

### CI/CD Workflows

**On Pull Request (charts modified):**
1. `list-changed` job detects which charts changed
2. `lint` job runs for each changed chart:
   - `ct lint` - Helm linting
   - `helm unittest` - Unit tests
   - `helm template` + `yamllint` - Template validation
3. `install` job (non-fork PRs only):
   - Creates KinD cluster
   - Installs chart with test values
   - Validates deployment

**On Merge to main:**
1. `release` workflow triggers
2. For each chart with a version bump:
   - Creates Git tag
   - Publishes chart package
   - Creates GitHub release
   - Updates charts index

**Security Scanning:**
- Checkov and KICS run on PRs with chart changes
- Scans for misconfigurations and security issues

## Chart Version Bumping Requirements

**CRITICAL REQUIREMENT**: Always remember to bump the Chart.yaml version when
making changes to any chart in the `charts/` directory, following semantic
versioning principles.

### Semantic Versioning Rules

When making changes to any chart folder under `charts/`, you MUST bump the
version in the corresponding `Chart.yaml` file according to these rules:

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

### Automation Note

The repository uses GitHub Actions to automatically release charts when versions are bumped. Make sure your version bump is intentional and follows the semantic versioning rules above.

## Dependencies and External Charts

### Chart Dependencies

Many charts depend on `alfresco-common` (currently v4.0.0), which is a library chart providing shared templates and helpers. When updating alfresco-common:

1. Bump alfresco-common version first
2. Update dependent charts' Chart.yaml dependencies section
3. Run `helm dependency update charts/<chart-name>` for each dependent chart
4. Test each dependent chart individually

### External Dependencies

Charts also depend on external charts:
- **bitnami charts**: Used for PostgreSQL, ActiveMQ, etc.
- Repository: `https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami/`
- Self-reference: `https://alfresco.github.io/alfresco-helm-charts/`

These are configured in `ct.yaml` and must be added to local helm repos for testing:
```bash
helm repo add bitnami https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami/
helm repo add self https://alfresco.github.io/alfresco-helm-charts/
helm repo update
```

## Best Practices for Making Changes

### Before Making Changes
1. **Understand the chart scope**: Read the chart's README.md
2. **Check existing tests**: Review tests/ directory for coverage
3. **Run tests before changes**: Establish baseline that tests pass
4. **Check for dependencies**: See if other charts depend on the one you're modifying

### Making Changes
1. **Keep changes minimal**: Only modify what's necessary
2. **Preserve existing behavior**: Unless explicitly fixing a bug
3. **Update tests**: Add/modify tests for your changes
4. **Document in UPGRADES.md**: If introducing breaking changes
5. **Update README.md.gotmpl**: Charts auto-generate README from this template

### After Making Changes
1. **Bump Chart.yaml version** (critical - see versioning rules above)
2. **Update Chart.lock if needed**: Run `helm dependency update` if dependencies changed
3. **Run full test suite**: lint, unittest, template validation
4. **Check pre-commit**: Run `pre-commit run --all-files`
5. **Test rendering**: Verify templates render correctly with test values

### Validation Checklist
- [ ] Chart.yaml version bumped appropriately
- [ ] Chart.lock updated if dependencies changed
- [ ] README.md regenerated (pre-commit does this)
- [ ] Tests pass: `helm unittest charts/<chart-name>`
- [ ] Linting passes: `ct lint --config ct.yaml --charts charts/<chart-name>`
- [ ] Templates render: `helm template charts/<chart-name> -f charts/<chart-name>/ci/default-values.yaml`
- [ ] Pre-commit hooks pass: `pre-commit run --all-files`
- [ ] UPGRADES.md updated if breaking change
- [ ] No GA chart depends on pre-release versions: `./scripts/charts.sh`

## Common Development Tasks

### Creating a New Chart
```bash
# Use helm create as starting point
helm create charts/new-chart-name

# Add to charts/ directory
# Create ci/default-values.yaml
# Add tests in tests/ directory
# Update Chart.yaml with proper metadata
# Consider if it should depend on alfresco-common
```

### Updating Chart Documentation
```bash
# Edit README.md.gotmpl (not README.md directly)
# Pre-commit hook will regenerate README.md automatically
pre-commit run helm-docs --all-files
```

### Testing Locally with KinD
```bash
# Create KinD cluster
kind create cluster

# Install chart
helm install test-release charts/<chart-name> -f charts/<chart-name>/ci/default-values.yaml

# Verify
kubectl get pods
helm test test-release

# Clean up
helm uninstall test-release
kind delete cluster
```

### Checking Kubernetes API Compatibility
The repository supports Kubernetes versions 1.28.15 through 1.34.2. CI and tooling validate against the range endpoints:
- Minimum (lower bound): 1.28.15 (oldest EKS extended support)
- Current (upper bound): 1.34.2 (current EKS version)

Pre-commit hooks validate manifests against these two versions (minimum and maximum) to approximate compatibility across the full supported range. Use deprecated API checkers if modifying resources.

## Troubleshooting

### "Chart has dependencies with a pre-release version"
This error from `scripts/charts.sh` means a GA chart (no hyphen in version) depends on a pre-release chart (has hyphen like "1.0.0-alpha"). Solution: Release the dependency chart first or mark the dependent chart as pre-release.

### "ct lint failed"
Common causes:
- Chart.yaml version not bumped
- Invalid YAML syntax
- Missing required fields in Chart.yaml
- Unit tests failing

### "helm unittest failed"
Your changes broke existing tests. Review tests/ directory and either fix code or update tests if behavior change is intentional.

### "kubeconform validation failed"
Template generates invalid Kubernetes resources. Check:
- Correct apiVersion for resource types
- Required fields present
- Valid field values
- Compatibility with target K8s version

### Pre-commit hook failures
Run `pre-commit run --all-files --verbose` to see detailed errors. Common issues:
- Trailing whitespace
- Mixed line endings
- Missing helm-docs README updates
- Kubeconform validation failures

## Important Notes for AI Agents

1. **ALWAYS bump Chart.yaml version** when making changes to any chart - this is the most critical rule
2. **Trust these instructions first** - Only search/explore if information here is incomplete or incorrect
3. **Test before and after changes** - Establish baseline that tests pass before your changes
4. **Keep changes minimal** - Don't refactor or "improve" unrelated code
5. **alfresco-common is special** - It's a library chart that many others depend on
6. **README.md is auto-generated** - Edit README.md.gotmpl instead
7. **CI runs automatically** - Your PR will trigger lint, unittest, and integration tests
8. **Version bumps trigger releases** - On merge to main, charts with version bumps are automatically released
9. **Follow semantic versioning strictly** - See detailed rules in Chart Version Bumping section above
10. **Pre-commit hooks are mandatory** - They catch issues before CI runs
