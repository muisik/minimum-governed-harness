# ContextRail — Minimum Governed Harness

[![Validate ContextRail distribution](https://github.com/muisik/minimum-governed-harness/actions/workflows/validate-memory.yml/badge.svg)](https://github.com/muisik/minimum-governed-harness/actions/workflows/validate-memory.yml)

**ContextRail** is a small, repo-local context and governance layer for coding agents.

It gives an agent a bounded current system map, unfinished work queue, durable rationale, completion evidence, external-handoff intake, task-linked implementation trace, and operating rules for safe delegation, verification, reuse, and shared-repository coordination — without replacing the agent's native planner or turning the repository into a project-management platform.

Current stable release: **v1.4.0**.

## At a glance

```text
AGENTS.md                -> Canonical shared operating guide for this repository
CLAUDE.md / GEMINI.md    -> Thin tool-specific entry points into AGENTS.md
project-memory/SYSTEM.md -> What is true about the implemented system now?
project-memory/BOARD.md  -> What unfinished work exists now, and who owns it?
project-memory/NOTES.md  -> What does the work mean, and why are decisions being made?
project-memory/HISTORY.md-> What was completed or cancelled, and what proves it?
handoffs/                -> How external work packages enter the governed model
scripts/                 -> OS-native validation and shared-work coordination checks
```

The core idea is simple: keep current truth, active work, rationale, and evidence separate enough that an agent can retrieve only what it needs, while preserving stable identities and explicit boundaries.

## What ContextRail adds

ContextRail is intentionally small, but the operating contract covers more than memory files:

- **bounded context retrieval** instead of loading the whole project history;
- **external handoff adoption** before implementation;
- **task-linked code trace** for durable behavior boundaries and principal regression tests;
- **root-cause-before-patch** guidance for defects;
- **independent review and evidence-backed completion**;
- **controlled incidental findings** without silent scope expansion;
- **governed delegation** to bounded workers while the primary agent retains judgment and completion ownership;
- **reuse-first engineering** so substantial custom infrastructure is justified rather than assumed;
- **lightweight shared-work coordination** using existing task ownership plus optional branch and path scope metadata;
- **non-blocking version awareness** and preservation of repository-shared project instructions across explicit updates;
- **thin tool adapters** so different contributors can use different coding agents without duplicating repository policy;
- **one canonical project verification path**, with ContextRail validation joining native tests rather than replacing them.

Normative detail lives in [`docs/GOVERNANCE.md`](docs/GOVERNANCE.md). This README is the entry point, not a second operating contract.

## Installation channels

### New project: GitHub Template Repository

Create a new repository from the clean distribution mirror:

**[`muisik/contextrail-template`](https://github.com/muisik/contextrail-template)**

The template contains only files intended to remain in the resulting project.

### Existing project or pinned version: GitHub Release

Use the official [Releases](https://github.com/muisik/minimum-governed-harness/releases) page and download:

```text
contextrail-template-vX.Y.Z.zip
```

Each release also includes:

```text
contextrail-template-vX.Y.Z.zip.sha256
contextrail-template-vX.Y.Z.manifest.sha256
```

The ZIP is built from the same canonical `template/` payload used to publish the Template Repository.

This repository is the ContextRail development, documentation, validation, and release source. It is **not** itself the clean user-project template.

See [`docs/ADOPTION.md`](docs/ADOPTION.md) for the installation and first-use flow.

## Core memory model

```text
SYSTEM  -> implemented system truth
BOARD   -> unfinished work and current responsibility
NOTES   -> task detail, rationale, decisions, requirements, and risks
HISTORY -> completed/cancelled work and evidence
```

`AGENTS.md` tells coding agents how to retrieve and maintain those four bounded sources.

External packages under `handoffs/` and task-linked code comments point into this model; they do not create another source of truth.

## Typical agent flow

```text
Read AGENTS
  -> read bounded SYSTEM map
  -> inspect working tree
  -> adopt any requested external handoff
  -> select one active or explicitly requested TASK
  -> retrieve only matching task detail and related records from NOTES
  -> inspect active ownership / branch / scope when parallel work may exist
  -> inspect only relevant code, tests, logs, and configuration
  -> research proven existing solutions first when substantial custom work may be avoidable
  -> implement with the agent's native planner
  -> delegate only bounded, objectively verifiable work when useful
  -> link durable behavior boundaries and principal tests back to the TASK
  -> run the project's canonical verification
  -> independently review the actual diff and evidence
  -> record completion in HISTORY
  -> update SYSTEM if current truth changed
```

`HISTORY.md` is searched by exact task or related ID only when prior implementation evidence is needed; it is not loaded by default.

## Operating contract

### External handoff adoption

Raw specifications, assessments, plans, exports, and other work packages are staged under `handoffs/incoming/`.

Before implementation, the agent follows `handoffs/HANDOFF.md` to:

1. search current local records and relevant code;
2. detect overlap and conflicts;
3. preserve external identifiers as provenance;
4. convert durable requirements, decisions, risks, rationale, and acceptance criteria into local Notes;
5. create short local tasks only for independently verifiable unfinished outcomes;
6. validate the resulting local model.

The raw package remains source evidence. Local Board and Notes records become the governed working context.

### Task-linked code trace

Durable behavior boundaries use a short language-native pointer:

```text
ContextRail: TASK-0042
Invariant: Persistent mutation requires explicit authorization.
```

The task carries the full rationale and relationships. The code comment identifies the task that best explains the **current** behavior; it is not a full edit history.

When the behavior is testable, the same task marker belongs on the principal regression test that proves the invariant.

Generated files, vendor code, binaries, lock files, and formats that cannot safely carry comments are not modified for traceability; their implementation boundary stays in task Notes.

### Root cause before patch

For defects, agents identify the violated invariant, domain rule, state transition, parser contract, policy, or ownership boundary before adding an input-specific guard.

Regression tests should cover the failure class rather than only the reported phrase or example.

### Independent review

The implementing agent is also the first review and QA layer.

Before claiming completion it must inspect the actual diff or artifacts, verify each acceptance criterion against evidence, state what tests do and do not prove, check relevant failure paths and system invariants, and keep project memory aligned with runtime behavior.

A worker's confidence statement or passing-test claim is not completion evidence by itself.

### Governed delegation

ContextRail allows native workers or subagents for **bounded, low-blast-radius, objectively verifiable** execution work when delegation is useful.

The primary agent keeps responsibility for ambiguous requirements, architecture and domain boundaries, security and permissions, destructive or data-risk operations, public contracts, final integration, independent review, canonical-memory updates, and completion decisions.

A delegated worker receives explicit scope, acceptance criteria, verification evidence, and stop conditions. Its output remains untrusted until the primary agent reviews the actual result.

ContextRail does not hard-code model or provider names and does not authorize metered pay-as-you-go models, purchased credits, or external paid APIs merely to enable delegation without explicit user authorization.

### Research before building

For non-trivial work, **custom implementation is not the default** when a proven compatible solution is reasonably likely to exist.

The agent should perform a proportional ecosystem check and prefer, when they materially satisfy the requirement:

1. established standard-library or platform capabilities;
2. official APIs, SDKs, and protocols;
3. maintained open-source components;
4. compatible existing systems or services.

Before incorporating an external implementation, evaluate functional fit, maintenance, security, license compatibility, portability, operational constraints, and replacement cost.

If an implementation cannot be incorporated because its license or terms are incompatible, it may still inform publicly documented behavior, interfaces, architecture, failure modes, and engineering tradeoffs. The required behavior must then be implemented independently rather than copied or closely translated.

Keep replaceable third-party capability behind a small project-owned boundary where practical. Prefer upstream use over unnecessary forks; when a fork or vendored patch is justified, keep the project-specific delta small and documented.

> Treat custom infrastructure as a decision that requires justification, not as the default starting point. Own only the project-specific gap when proven commodity capability already exists.

Research remains proportional: small or settled work should not become an ecosystem survey.

### Controlled incidental findings

Unrelated bugs, risks, smells, or surprising behavior are reported with evidence but do not silently expand the current task.

Immediate scope expansion is reserved for security vulnerabilities, data-loss risks, verification blockers, or findings that invalidate the current result.

## Shared repository coordination

ContextRail does not become a task tracker, file-locking service, or permission system when several people or coding agents share a repository. It adds only the coordination state that is useful next to implementation.

`Owner` remains the required responsibility field. When a GitHub identity is known, prefer the repository-visible form:

```markdown
## TASK-0142 — Payment retry
- Status: active
- Priority: P1
- Owner: @alice
- Branch: feature/task-0142-payment-retry
- Scope: src/payments, tests/payments
- Related: none
- Summary: Implement bounded payment retry behavior.
- Acceptance: Retry behavior is covered by project-native verification.
```

`Branch` and `Scope` are optional. `Scope` is a comma-separated set of repository-relative path prefixes and is a visibility hint, not an exclusive lock.

The advisory coordination checker can surface:

- an active task whose owner remains `unassigned`;
- a branch declaration without enough scope information to assess overlap;
- equal or ancestor/descendant path scopes across active tasks;
- a GitHub Actions branch whose simple `@username` owner differs from `GITHUB_ACTOR`.

Run it directly when useful:

### Linux / macOS

```sh
sh scripts/check-coordination.sh
```

### Windows

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\check-coordination.ps1
```

These are advisory signals. CODEOWNERS, branch protection or rulesets, repository permissions, required reviewers, CI, and Git merge behavior remain authoritative.

## Version awareness and project-maintained instructions

Every distributed project carries `.contextrail-version`.

The OS-native validators perform a best-effort comparison against the published stable template when network access and a suitable fetch utility are available:

- **current version:** silent;
- **different version:** prints a non-blocking `UPDATE` message;
- **version check unavailable or invalid:** prints a non-blocking `NOTICE`.

Version awareness never changes validator errors, warnings, `--strict` results, or offline operation.

The validator only reports. It does **not** automatically download, merge, or apply ContextRail updates.

`AGENTS.md` contains a dedicated repository-shared project instruction block:

```text
<!-- CONTEXTRAIL:USER-INSTRUCTIONS:START -->

<!-- CONTEXTRAIL:USER-INSTRUCTIONS:END -->
```

The marker names are retained for update compatibility, but the content is **project-owned**, not one contributor's personal agent preferences. It is shared by all contributors and coding agents and must be preserved verbatim across explicitly requested ContextRail updates. Personal preferences belong in each contributor's local or tool-specific configuration outside the shared repository contract.

ContextRail keeps tool-specific repository files such as `CLAUDE.md`, `GEMINI.md`, Copilot instructions, and Cursor rules as thin entry points into canonical `AGENTS.md`. Different contributors may therefore use different coding agents without maintaining conflicting copies of repository policy.

## Canonical verification integration

On first substantive use, the agent discovers the project's existing build, test, lint, static-analysis, smoke, and CI entrypoints.

ContextRail validation is added to **one canonical project verification command** rather than creating a competing test system.

The standalone template workflow is an initial safety net and can be removed when it duplicates an established project CI job.

Direct validator commands:

### Linux

```sh
sh scripts/validate-linux.sh --strict
```

### macOS

```sh
sh scripts/validate-macos.sh --strict
```

### Windows

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\validate-windows.ps1 -Strict
```

The validators use OS-provided tooling and require no Python, Node.js, Go, Rust, Java, .NET, or project-language runtime.

## Validation scope

ContextRail validators check governance and trace integrity, including:

- required files and required `SYSTEM.md` sections;
- lifecycle records incorrectly placed in System;
- duplicate IDs;
- normalized record titles reused under different identities;
- inconsistent titles for the same stable identity;
- invalid statuses;
- required fields for Board, Notes, and History records;
- missing completion/cancellation dates, evidence, or outcome;
- Board/History overlap;
- orphan task details;
- broken `Related`, `Supersedes`, and `Replacement` references;
- accepted decisions not reflected in current system truth;
- task-linked code comments pointing to missing lifecycle or Notes records;
- task-linked comments without a nearby non-empty invariant;
- an oversized `SYSTEM.md` that may no longer be a bounded map.

The validator does **not** prove semantic correctness, license compatibility, architecture quality, test adequacy, task ownership, or conflict freedom. Project-native tests remain authoritative for runtime behavior; the separate coordination checker only exposes likely parallel-work collisions.

## Clean template contents

The published template and release ZIP contain only files intended to remain in a user project:

```text
AGENTS.md
CLAUDE.md
GEMINI.md
.contextrail-version

.github/
  copilot-instructions.md
  workflows/contextrail.yml

.cursor/
  rules/00-agents.mdc

handoffs/
  HANDOFF.md
  incoming/.gitkeep
  processed/.gitkeep

project-memory/
  SYSTEM.md
  BOARD.md
  NOTES.md
  HISTORY.md

scripts/
  validate-linux.sh
  validate-macos.sh
  validate-windows.ps1
  check-coordination.sh
  check-coordination.ps1
```

They deliberately exclude ContextRail's own README, license, changelog, contribution guide, documentation, test fixtures, and development history.

## Synchronized distribution guarantee

Template creation and release downloads are parallel distribution channels derived from one canonical payload:

```text
minimum-governed-harness/template/
        canonical payload
              |
              +--> muisik/contextrail-template
              |
              +--> contextrail-template-vX.Y.Z.zip
```

A versioned release is created only after automation verifies that:

1. the release commit is contained in `main`;
2. `vX.Y.Z`, `template/.contextrail-version`, and the changelog heading agree;
3. the published Template Repository matches the canonical payload after synchronization when required;
4. a fresh clone of the published repository matches `template/`;
5. the generated ZIP extracts back to the same payload;
6. ZIP and per-file checksums are produced;
7. all expected release assets are present.

Normal CI adds another guard: if source and published repositories declare the same ContextRail version, any payload difference fails the consistency job.

## Required record shapes

### Board task

```markdown
## TASK-0001 — Add user authentication
- Status: active
- Priority: P1
- Owner: @github-user
- Branch: feature/task-0001-auth
- Scope: src/auth, tests/auth
- Related: DEC-0001
- Summary: Add session-based authentication.
- Acceptance: Login, logout, and protected routes are behavior-tested.
```

`Branch` and `Scope` are optional; the other fields shown above are the normal task contract.

### Notes record

```markdown
## TASK-0001 — Add user authentication
- Status: active
- Related: DEC-0001
- Last updated: 2026-08-16
```

Accepted decisions should also identify where current truth is reflected:

```markdown
- Reflected in: project-memory/SYSTEM.md — Authentication boundary
```

### History record

```markdown
## TASK-0001 — Add user authentication
- Status: completed
- Completed: 2026-08-16
- Related: DEC-0001
- Evidence: `pytest tests/auth -q`
- Outcome: Login, logout, and protected routes implemented.
```

Cancelled tasks use `Cancelled: YYYY-MM-DD` instead of `Completed`.

## Documentation

- [Governance contract](docs/GOVERNANCE.md)
- [Adoption guide](docs/ADOPTION.md)
- [Release history](CHANGELOG.md)
- [Latest release](https://github.com/muisik/minimum-governed-harness/releases/latest)

## What ContextRail is not

ContextRail is not a project-management replacement, specification generator, planning compiler, semantic database, dependency manager, legal-license checker, multi-agent runtime, model router, file-locking system, or substitute for source code and native tests.

It governs how agents retrieve project context and move work through a small set of repo-local boundaries while leaving execution, access control, and merge authority to the coding environment, repository host, and native toolchain.

## Stability and evolution

The **1.0 contract** established the stable structural core: four bounded memory roles, external handoff adoption, task-linked implementation trace, OS-native validation, canonical verification integration, and synchronized distribution.

Subsequent 1.x releases extend the operating policy without turning ContextRail into a runtime:

- **1.1:** governed delegation;
- **1.2 / 1.2.1:** non-blocking version awareness and preserved project instructions;
- **1.3:** reuse-first engineering and license-aware integration boundaries;
- **1.4:** lightweight shared-repository coordination and explicit separation of repository-shared instructions from personal agent preferences.

New mechanisms should continue to earn their place through repeated real-world need rather than expanding the harness by default.

## License

MIT
