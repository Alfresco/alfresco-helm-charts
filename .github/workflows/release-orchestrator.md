---
emoji: 🚀
description: Orchestrate the Alfresco Helm chart release — merges updatecli bumps, determines per-chart semver bumps from the diff, creates a draft release PR, and keeps a GitHub issue as resumable state machine.
on:
  workflow_dispatch:
    inputs:
      release-name:
        description: 'Release codename (e.g. "nitrogen")'
        type: string
        required: true
permissions:
  contents: read
  issues: read
  pull-requests: read
checkout:
  fetch-depth: 0
  fetch:
    - "updatecli-bump-acs"
    - "updatecli-bump-helm"
tools:
  github:
    mode: gh-proxy
    toolsets: [default]
steps:
  - name: Install helm-docs
    uses: Alfresco/alfresco-build-tools/.github/actions/setup-helm-docs@v18.1.0
safe-outputs:
  create-issue:
    labels: [release, automation]
    max: 1
  update-issue:
    body: true
    target: "*"
    max: 1
  add-comment:
    max: 3
    hide-older-comments: true
  create-pull-request:
    draft: true
    preserve-branch-name: true
    max: 3
    allowed-files:
      - "charts/**/Chart.yaml"
      - "charts/**/Chart.lock"
      - "charts/**/values.yaml"
      - "charts/**/README.md"
      - "test-deps.yaml"
    protected-files:
      policy: request_review
      exclude: ["README.md"]
    allowed-base-branches:
      - "main"
    max-patch-size: 5120
---

# Release Orchestrator

## Context

- **Release codename**: `${{ inputs.release-name }}`
- **Triggered by**: `@${{ github.actor }}`

## Design

This workflow is re-runnable. A GitHub issue titled **`🚀 Release: ${{ inputs.release-name }}`** is the persistent state machine. Each run reads HTML comment markers (`<!-- phase:X:done -->`) to know which phases are already complete, executes only the next pending phase, then updates the issue and stops.

**Ordered phases — each can block the next:**

1. **alfresco-common GA** — if pre-release on `main`, create a PR to bump it to GA first
2. **activemq GA** — if `updatecli-bump-acs` contains activemq changes AND activemq is not GA on `main`, create a separate activemq-only PR first
3. **Main release** — only when alfresco-common is GA, activemq is GA, and activemq is no longer a diff between `updatecli-bump-acs` and `main`

Always end every run by updating the tracking issue and posting a summary comment.

---

## Step 0 — Find or create the tracking issue

Search for an existing open issue:

```bash
gh search issues \
  --repo Alfresco/alfresco-helm-charts \
  --state open \
  --limit 5 \
  --json number,title,body,url \
  -- "in:title \"🚀 Release: ${{ inputs.release-name }}\""
```

- **Found**: read the body carefully. Extract all `<!-- phase:X:done -->` markers. Store the issue number — you will call `update-issue` at the end of this run.
- **Not found**: you will call `create-issue` at the end of this run.

Phase markers:
- `<!-- phase:alfresco-common-ga:done -->` — alfresco-common is GA on main
- `<!-- phase:activemq-ga:done -->` — activemq is GA on main (or not in updatecli-bump-acs)
- `<!-- phase:main-release:done -->` — main release PR created

---

## Step 1 — Snapshot all chart versions on `main`

**Always run.** Read every `Chart.yaml` on `main` HEAD:

```bash
gh api "repos/Alfresco/alfresco-helm-charts/git/trees/HEAD?recursive=1" \
  --jq '[.tree[] | select(.path | endswith("Chart.yaml")) | .path][]'
```

For each path:

```bash
gh api "repos/Alfresco/alfresco-helm-charts/contents/<path>" \
  --jq '.content' | base64 --decode | grep -E '^(name|version):'
```

Build a map of `chart-name → version`. A version is pre-release if it contains `-`.

Also read supporting context:

```bash
# Supported ACS matrix
gh api "repos/Alfresco/alfresco-updatecli/contents/deployments/values/supported-matrix.yaml" \
  --jq '.content' | base64 --decode | head -50

# Pending deprecations / planned removals
gh api "repos/Alfresco/alfresco-helm-charts/contents/UPGRADES.md" \
  --jq '.content' | base64 --decode | head -80

# docs.hyland.com version links
gh api "repos/Alfresco/alfresco-helm-charts/contents/charts/alfresco-repository/values.yaml" \
  --jq '.content' | base64 --decode | grep -i 'docs.hyland.com' | head -10
```

---

## Step 2 — Check updatecli branches (prerequisite for all phases)

The DevOps must have already run the `BumpVersions` workflow. Verify both branches exist:

```bash
gh api "repos/Alfresco/alfresco-helm-charts/branches/updatecli-bump-acs" \
  --jq '{sha: .commit.sha, date: .commit.commit.committer.date}' 2>/dev/null \
  || echo "MISSING"

gh api "repos/Alfresco/alfresco-helm-charts/branches/updatecli-bump-helm" \
  --jq '{sha: .commit.sha, date: .commit.commit.committer.date}' 2>/dev/null \
  || echo "MISSING"
```

If either is missing: update the issue with instructions to run [BumpVersions](https://github.com/Alfresco/alfresco-helm-charts/actions/workflows/updatecli.yaml) first, then re-run this workflow. **Stop here.**

Now compute what `updatecli-bump-acs` changes relative to `main` (used in Phase B and C):

```bash
git fetch origin updatecli-bump-acs updatecli-bump-helm
git diff origin/main...origin/updatecli-bump-acs --name-only
```

Store whether `charts/activemq/` appears in that diff as `ACTIVEMQ_IN_ACS_BRANCH=true/false`.

---

## Phase A — alfresco-common GA

**Skip if** `<!-- phase:alfresco-common-ga:done -->` is present in the issue.

Read `alfresco-common` version from the snapshot (Step 1).

### Case 1: already GA (no `-` in version)

Mark `<!-- phase:alfresco-common-ga:done -->` and proceed to Phase B.

### Case 2: pre-release

Check whether an open alfresco-common GA PR already exists:

```bash
gh pr list \
  --repo Alfresco/alfresco-helm-charts \
  --head "release/alfresco-common-ga" \
  --state open \
  --json number,title,url
```

**If PR exists and is open**: record its URL in the issue, post a comment asking the DevOps to merge it and re-run. **Stop.**

**If no PR exists**: create one.

Compute the GA version by stripping the pre-release suffix:
- `4.0.0-alpha.1` → `4.0.0`
- `3.2.0-M1` → `3.2.0`

Set up git and create the PR branch:

```bash
git config user.email "release-orchestrator[bot]@users.noreply.github.com"
git config user.name "Release Orchestrator"
git checkout -b release/alfresco-common-ga origin/main
```

Use the `edit` tool to update `version:` in `charts/alfresco-common/Chart.yaml` to the GA version.

Then regenerate the lock file:

```bash
helm dependency update charts/alfresco-common 2>/dev/null || true
```

Regenerate chart documentation and commit any changes:

```bash
helm-docs --chart-search-root charts/alfresco-common
git add charts/alfresco-common/README.md
git diff --cached --quiet || git commit -m "docs: regenerate helm-docs for alfresco-common"
```

Create the PR using `create-pull-request`:
- **title**: `chore: release alfresco-common <ga-version> GA`
- **base**: `main`
- **branch**: `release/alfresco-common-ga`
- **body**: explain this is a prerequisite for the `${{ inputs.release-name }}` release

Record the PR URL in the tracking issue. Post a comment asking the DevOps to **merge this PR first**, then re-run. **Stop.**

---

## Phase B — activemq GA

**Skip if** `<!-- phase:activemq-ga:done -->` is present in the issue.

**Skip if** `ACTIVEMQ_IN_ACS_BRANCH=false` (activemq not touched by `updatecli-bump-acs`) — mark done and proceed.

Read `activemq` version from the snapshot (Step 1).

### Case 1: activemq already GA on `main` AND no longer diffed in `updatecli-bump-acs` relative to `main`

This means the activemq GA PR was already merged. Mark `<!-- phase:activemq-ga:done -->` and proceed to Phase C.

### Case 2: activemq needs a GA PR

Check for an existing activemq GA PR:

```bash
gh pr list \
  --repo Alfresco/alfresco-helm-charts \
  --head "release/activemq-ga" \
  --state open \
  --json number,title,url
```

**If PR exists and is open**: record its URL, post a comment asking the DevOps to merge it and re-run. **Stop.**

**If no PR exists**: create one using **only the activemq-specific changes from `updatecli-bump-acs`**, plus a GA version bump.

```bash
git checkout -b release/activemq-ga origin/main

# Cherry-pick only the activemq-related changes from updatecli-bump-acs
git checkout origin/updatecli-bump-acs -- charts/activemq/
```

Determine the correct GA version for activemq:
- Read current `activemq` version on `main` (from snapshot)
- If it is pre-release (e.g. `3.1.0-alpha.1`): strip the suffix → `3.1.0`
- If it is already GA: apply an appropriate semver bump based on what changed in `charts/activemq/` between `origin/main` and `origin/updatecli-bump-acs` (use the semver rules from Phase C)

Use the `edit` tool to write the computed version into `charts/activemq/Chart.yaml`.

```bash
helm dependency update charts/activemq 2>/dev/null || true
```

Regenerate chart documentation and commit any changes:

```bash
helm-docs --chart-search-root charts/activemq
git add charts/activemq/README.md
git diff --cached --quiet || git commit -m "docs: regenerate helm-docs for activemq"
```

Create the PR using `create-pull-request`:
- **title**: `chore: release activemq <version> GA`
- **base**: `main`
- **branch**: `release/activemq-ga`
- **body**: explain this is a prerequisite for the `${{ inputs.release-name }}` release; list the changes included from `updatecli-bump-acs`

Record PR URL in the issue. Post a comment asking the DevOps to **merge this PR first**, then re-run. **Stop.**

---

## Phase C — Main release PR

**Skip if** `<!-- phase:main-release:done -->` is present in the issue.

**Prerequisites** — verify all of these before continuing:
1. `alfresco-common` is GA on `main` (phase A marker present)
2. `activemq` is GA on `main` (phase B marker present)
3. `updatecli-bump-acs` diff relative to `main` does **not** contain `charts/activemq/` (the activemq GA PR has been merged and the branch no longer diverges on activemq)

If any prerequisite fails: update the issue with the blocking reason and stop.

### C1. Check for an existing release PR

```bash
RELEASE_BRANCH="release/$(echo '${{ inputs.release-name }}' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | tr -s '-')"

gh pr list \
  --repo Alfresco/alfresco-helm-charts \
  --head "$RELEASE_BRANCH" \
  --state open \
  --json number,title,url,isDraft
```

If an open PR already exists: record its URL, mark `<!-- phase:main-release:done -->`, update issue and stop.

### C2. Build the release branch

```bash
git checkout -b "$RELEASE_BRANCH" origin/main

# Merge chart dependency bumps first, then ACS value bumps
git merge --no-edit origin/updatecli-bump-helm \
  -m "chore: merge updatecli chart dependency bumps"

git merge --no-edit origin/updatecli-bump-acs \
  -m "chore: merge updatecli ACS version bumps"
```

If merge conflicts: list the conflicting files in the issue, instruct the DevOps to resolve them manually, stop.

### C3. Determine per-chart semver bump and apply

Find all charts changed vs `main`:

```bash
git diff origin/main...HEAD --name-only | grep 'Chart\.yaml' | sort
```

For each changed chart, inspect the full diff:

```bash
git diff origin/main...HEAD -- charts/<chart-name>/
```

Apply these semver rules:

| Change type | Bump |
|-------------|------|
| Removed/renamed value, incompatible default, planned removal in UPGRADES.md | **major** `X+1.0.0` |
| New optional value, new template, new conditional resource, compat dependency bump | **minor** `x.Y+1.0` |
| Image tag bump only, bug fix, doc update, patch dependency bump | **patch** `x.y.Z+1` |

Apply bumps in dependency order:
1. `alfresco-common` (if still changed after Phase A)
2. `activemq` (if still changed after Phase B)
3. All remaining charts alphabetically

Use the `edit` tool to write the new `version:` into each `Chart.yaml`. After bumping `alfresco-common`, update `dependencies[].version` for it in all dependent charts.

```bash
helm dependency update charts/<chart-name> 2>/dev/null || true
```

### C4. Create the release PR

Regenerate documentation for all changed charts and commit any updates:

```bash
helm-docs --chart-search-root charts
git add charts/**/README.md
git diff --cached --quiet || git commit -m "docs: regenerate helm-docs for release ${{ inputs.release-name }}"
```

Use `create-pull-request`:
- **title**: `🚀 Release: ${{ inputs.release-name }}`
- **base**: `main`
- **branch**: `$RELEASE_BRANCH`
- **body**: version-change table (chart | old | new | bump | reason), plus the remaining manual checklist

---

## Step 3 — Update the tracking issue

**Always run last.** Compose the full issue body with current status (✅ done, ❌ blocked, ⏳ waiting, ❓ unknown):

```markdown
## Release: ${{ inputs.release-name }}

| Field | Value |
|-------|-------|
| Codename | `${{ inputs.release-name }}` |
| Triggered by | @${{ github.actor }} |
| Last updated | <current ISO datetime> |

---

## Phase A — alfresco-common GA

| Chart | Version on main | Status |
|-------|----------------|--------|
| `alfresco-common` | `<version>` | ✅ GA / ❌ Pre-release |

- [x/ ] alfresco-common GA PR — **<PR link or "not needed" or "pending merge">**

---

## Phase B — activemq GA (if in updatecli-bump-acs)

- [x/ ] activemq present in `updatecli-bump-acs` diff — **yes / no**
- [x/ ] activemq GA PR — **<PR link or "not needed" or "pending merge">**

---

## Phase C — Main release

**Prerequisites:**
- [x/ ] `alfresco-common` GA on `main` — **<✅/❌>**
- [x/ ] `activemq` GA on `main` — **<✅/❌>**
- [x/ ] `updatecli-bump-acs` no longer touches `activemq` vs `main` — **<✅/❌>**
- [x/ ] `updatecli-bump-acs` branch present — **<commit date or "missing">**
- [x/ ] `updatecli-bump-helm` branch present — **<commit date or "missing">**
- [ ] Both updatecli branches reviewed (unwanted bumps reverted) — **⚠️ manual**

**Release:**
- [x/ ] Release branch `<branch>` created — **<✅/pending>**
- [x/ ] Chart versions bumped (per-chart semver) — **<table: chart|old→new|bump, or "pending">**
- [x/ ] Draft PR created — **<PR link or "pending">**

---

## Phase D — Manual sign-off

- [ ] PR reviewed and approved
- [ ] PR merged into `main`
- [ ] All chart GitHub Releases auto-published on merge
- [ ] [acs-deployment](https://github.com/Alfresco/acs-deployment) umbrella chart updated

---

<details>
<summary>📋 All chart versions snapshot (main HEAD)</summary>

| Chart | Version | Pre-release? |
|-------|---------|--------------|
<all chart rows>

</details>

<!-- phase:alfresco-common-ga:done -->
<!-- phase:activemq-ga:done -->
<!-- phase:main-release:done -->
```

Include only the markers for phases that actually completed.

- Existing issue → `update-issue` with that issue number
- New issue → `create-issue`

Post an `add-comment` (with `hide-older-comments: true`) summarising what this run executed and what the DevOps must do next.

## Noop condition

Call `noop` only if the main release PR already exists open, all prerequisites are met, and this run took no new actions.
