# Changelog

All notable changes to ContextRail are documented here.

## 1.4.0

- Added optional shared-repository coordination metadata using the existing required `Owner` field plus optional `Branch` and comma-separated path-prefix `Scope` fields.
- Added OS-native advisory coordination checkers for Linux/macOS and Windows without changing the existing project-memory or code-trace validator semantics.
- Detect active task scopes that overlap by equal or ancestor/descendant repository path prefixes.
- On GitHub Actions, compare a matching task branch's simple `@username` owner with `GITHUB_ACTOR` and report mismatches as advisory findings rather than permission failures.
- Keep CODEOWNERS, branch protection, repository permissions, required review, CI, and merge policy authoritative; ContextRail coordination metadata does not lock files or grant ownership.
- Added deterministic cross-platform fixtures that prove scope-overlap and GitHub actor-mismatch findings.

## 1.3.0

- Added a reuse-first engineering policy for non-trivial work: perform proportional ecosystem research before committing to substantial custom implementation when proven solutions are likely to exist.
- Prefer compatible standard/platform capabilities, official APIs/SDKs/protocols, maintained open-source components, and proven existing systems over rebuilding commodity infrastructure.
- Require adoption checks for functional fit, maintenance, security, license compatibility, portability, operational constraints, and replacement cost.
- Keep incompatible implementations as research inputs only: learn from documented behavior, interfaces, architecture, failure modes, and tradeoffs, then implement independently without copying or closely translating restricted code.
- Prefer small project-owned adapters, upstream use over unnecessary forks, and minimal documented deltas when patching or vendoring is justified.
- Added the principle: custom infrastructure requires justification; own only the project-specific gap when proven commodity capability already exists.

## 1.2.1

- Simplified version awareness to three outcomes: silent when current, `UPDATE` when the local version differs from the published stable version, and `NOTICE` when the check cannot be completed.
- Added a user-owned instruction block to `AGENTS.md` that must be preserved verbatim across explicitly requested ContextRail updates.
- Added a canonical instruction to inform the user about version-check findings and never update automatically or overwrite `AGENTS.md` blindly.

## 1.2.0

- Added best-effort update awareness to the OS-native validators.
- Validators compare the local `.contextrail-version` with the published template version when network access is readily available and print a non-blocking `UPDATE` notice when a newer stable release exists.
- Update checks never affect validation errors, warnings, `--strict` results, or offline operation; malformed or unavailable remote responses are ignored.
- Added `CONTEXTRAIL_NO_UPDATE_CHECK=1` as an opt-out for environments that do not want the remote version check.

## 1.1.0

- Added governed delegation guidance to the canonical agent contract.
- Allowed primary agents to delegate bounded, low-risk, objectively verifiable work to native workers while retaining architecture, domain, security, integration, review, and completion ownership.
- Required delegated workers to receive explicit scope, acceptance criteria, verification evidence, and stop conditions, with worker output treated as untrusted until primary-agent review.
- Kept ContextRail provider- and model-independent and prohibited implicit metered pay-as-you-go delegation or purchased external usage without explicit user authorization.
- Added an optional copy-paste delegation brief for material savings when no suitable native worker exists, without turning ContextRail into a multi-agent runtime or model router.

## 1.0.0

- Added a generic `handoffs/HANDOFF.md` adoption contract with `incoming/` and `processed/` staging directories.
- Defined how external specifications, assessments, plans, and exports are deduplicated and converted into local Notes records and independently verifiable Board tasks before implementation.
- Added a minimal language-native code trace contract using `ContextRail: TASK-####` plus a short current invariant.
- Defined trace placement for complete symbols, narrow blocks, statements, and principal regression tests without storing full code history in comments.
- Added validator checks for code markers that reference missing lifecycle or Notes records and for markers without a nearby non-empty invariant.
- Added deterministic normalized-title checks that reject duplicate record identities and inconsistent titles for the same stable ID.
- Added a valid implementation-and-test trace fixture and exact CI assertions for duplicate titles, orphan Notes details, and broken code pointers on Linux, macOS, and Windows.
- Declared the four bounded memory roles, generic handoff intake, task-linked code trace, OS-native validation, canonical verification integration, and synchronized distribution as the stable ContextRail 1.0 contract.

## 0.5.0

- Split the development repository from the clean user-project template distribution.
- Added `template/` as the canonical source for the published `contextrail-template` repository.
- Added root-cause-before-patch guidance to prevent accumulating input-specific guards and `if/else` exceptions.
- Added independent self-review and evidence-grounded completion rules.
- Added controlled handling for incidental bugs and risks without silent scope expansion.
- Added first-adoption discovery and canonical verification integration.
- Added required-field validation for Board, Notes, and History records.
- Added a minimal template CI workflow while keeping validator development fixtures and three-OS testing in the source repository.
- Added synchronized GitHub Releases with a clean ZIP, archive checksum, file manifest, published-template round-trip verification, and same-version drift detection.
- Hardened Windows validation for Windows PowerShell 5.1 compatibility.

## 0.4.0

- Removed the Python/runtime dependency from harness validation.
- Added OS-native validators for Linux, macOS, and Windows.
- Added Claude Code, Gemini CLI, GitHub Copilot, and Cursor adapters that redirect to `AGENTS.md`.
- Added valid/invalid fixture checks and a three-platform GitHub Actions workflow.
- Expanded the public documentation and ContextRail branding.

## 0.3.0

- Added a cross-platform Python check runner and project-native check configuration.
- Added Linux, Windows CMD, and PowerShell wrapper experiments.

## 0.2.0

- Added `SYSTEM.md` to separate implemented system truth from active work and design discussion.
- Expanded adoption and governance documentation.

## 0.1.0

- Added the initial `BOARD.md`, `NOTES.md`, and `HISTORY.md` lifecycle model.
- Added the canonical `AGENTS.md` operating guide, adapters, OS-native validators, fixture, and cross-platform CI.
