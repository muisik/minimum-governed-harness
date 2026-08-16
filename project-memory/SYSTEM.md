# System

This file describes the current implemented ContextRail development and distribution system.

## Purpose and Scope

ContextRail provides a minimal governed system map, project-memory layer, external-handoff intake contract, task-linked implementation trace, governed delegation guardrails, reuse-first engineering guidance, and lightweight shared-work coordination for coding-agent repositories. This repository develops, tests, documents, versions, and publishes the reusable template. It does not generate specifications, manage projects, perform semantic retrieval, operate a multi-agent runtime, choose dependencies for a project, provide legal advice, enforce repository permissions, or replace project-native verification.

## Components

- `template/` — canonical source for every file distributed to user repositories.
- `template/AGENTS.md` — canonical distributed operating contract, including reuse-first engineering, governed delegation, and shared-work coordination boundaries.
- `template/handoffs/HANDOFF.md` — generic procedure for adopting external packages into local Board and Notes records.
- `template/scripts/validate-linux.sh`, `validate-macos.sh`, and `validate-windows.ps1` — OS-native project-memory and code-trace validators.
- `template/scripts/check-coordination.sh` and `check-coordination.ps1` — advisory shared-work checks for active task ownership, branch identity, and path-scope overlap.
- `project-memory/` — ContextRail's own system model, active work, rationale, and completion evidence.
- `docs/` — public adoption and governance documentation.
- `tests/fixtures/valid-trace/` — valid implementation and principal-test task trace.
- `tests/fixtures/invalid/` — deliberately invalid memory, identity, and code-trace examples.
- `tests/fixtures/team-coordination/` — deterministic active-task overlap and GitHub actor-mismatch examples.
- `.github/workflows/validate-memory.yml` — Linux, macOS, and Windows contract validation, exact failure assertions, coordination-check assertions, and same-version published-template drift detection.
- `.github/workflows/release.yml` — tag-gated synchronization, archive creation, round-trip verification, checksums, manifest generation, and GitHub Release publication.
- `isikmuhamm/contextrail-template` — clean published mirror used as the GitHub Template Repository.
- GitHub Releases — immutable version announcements and clean downloadable template archives.

## Primary Flows

1. Reusable changes are made under `template/`.
2. External packages in a user repository are staged under `handoffs/incoming/`, deduplicated, and converted into local Notes records and independently verifiable Board tasks before implementation.
3. Durable implementation boundaries and principal regression tests may carry a local `TASK-####` pointer and short invariant.
4. In a shared repository, an active task may declare its working `Branch` and expected path-prefix `Scope`; the coordination checker exposes likely overlap with other active work and can compare a matching GitHub branch's simple `@username` owner with `GITHUB_ACTOR`.
5. Coordination findings are advisory. Agents narrow or coordinate materially overlapping work instead of treating ContextRail metadata as a file lock or permission grant.
6. For non-trivial capabilities likely to have proven existing solutions, the primary agent performs proportional ecosystem research before committing to substantial custom implementation and prefers compatible reuse or integration when it materially satisfies the requirement.
7. External code or components are incorporated only when their license and terms are compatible with the project's intended use; incompatible implementations may inform behavior, architecture, interfaces, failure modes, and tradeoffs but are not copied or closely translated.
8. The primary agent may delegate bounded, low-risk, objectively verifiable execution work to native workers while retaining judgment, integration, review, and completion ownership.
9. Validators confirm memory lifecycle, identity, references, and task-linked code-pointer integrity on Linux, macOS, and Windows; the separate coordination checker reports parallel-work advisories without changing those validator semantics.
10. Documentation, changelog, and `.contextrail-version` are updated with a released behavior change.
11. A `vX.Y.Z` tag pointing to `main` starts the release workflow.
12. The workflow requires the tag, changelog heading, and `.contextrail-version` to agree.
13. The workflow synchronizes `template/` to `isikmuhamm/contextrail-template` when needed and verifies a fresh clone against the source payload.
14. A clean ZIP is built from `template/`, extracted, and compared back to the source before the GitHub Release is created.
15. Users either create a new repository from the clean template or download the matching release archive.

## Boundaries and Sources of Truth

- Reusable distribution payload — `template/`.
- Current ContextRail system model — this file.
- Active ContextRail work and optional coordination metadata — `project-memory/BOARD.md`.
- Task detail and rationale — `project-memory/NOTES.md`.
- Completed evidence — `project-memory/HISTORY.md`.
- Agent workflow, shared-work coordination guidance, reuse-first guidance, and delegation boundaries — `template/AGENTS.md`.
- External-handoff intake procedure — `template/handoffs/HANDOFF.md`.
- Raw external packages in user repositories — non-canonical source evidence under `handoffs/`.
- Runtime behavior — source code and native tests.
- Repository permissions, branch protection, CODEOWNERS, review, and merge authority — repository-native hosting controls, not ContextRail Board metadata.
- Public behavior and adoption claims — `README.md` and `docs/`.
- Published user template — generated mirror at `isikmuhamm/contextrail-template`; it is not independently edited.
- Official versions and downloadable archives — GitHub Releases in `minimum-governed-harness`.

## Invariants

- `template/` is the only canonical source for distributed files.
- The published template contains only files intended to remain in a user's repository.
- The published template excludes this repository's README, license, changelog, contribution guide, fixtures, and development history.
- External packages are adopted into local records before implementation and do not become another canonical memory store.
- Stable record identities do not reuse the same normalized title under different IDs.
- Task-linked code markers resolve to a local Board or History lifecycle record and matching Notes detail.
- Code comments point to the task that best explains the current invariant rather than accumulating full edit history.
- `Owner` remains the canonical responsibility field for unfinished tasks; `Branch` and `Scope` are optional coordination metadata rather than new lifecycle authorities.
- Shared-work scope overlap and GitHub branch-owner mismatch are advisory findings. They do not grant ownership, lock files, or override CODEOWNERS, branch protection, or reviewer authority.
- GitHub actor comparison is best-effort and only applies when the current branch matches an active task's `Branch` and `Owner` is a simple `@username`; no network lookup is required.
- Substantial custom infrastructure is a justified decision rather than the default starting point when proven compatible capability is readily available.
- External adoption considers functional fit, maintenance, security, license compatibility, portability, operational constraints, and replacement cost.
- Incompatible implementation code is not copied or closely translated into the project; only independently reusable engineering knowledge such as documented behavior, interfaces, architecture, failure modes, and tradeoffs informs a separate implementation.
- Replaceable third-party capability should remain behind a small project-owned boundary when practical; unnecessary forks are avoided and justified deltas stay minimal and documented.
- Delegation never transfers end-to-end task ownership, durable project judgment, final review, or completion authority away from the primary agent.
- Delegated output is not completion evidence until the primary agent inspects and verifies the actual result.
- ContextRail does not hard-code model providers or authorize metered paid delegation without explicit user approval.
- Linux, macOS, and Windows validators implement the same governance contract.
- Linux/macOS and Windows coordination checkers implement the same advisory overlap and GitHub actor semantics.
- The empty clean template and valid trace fixture pass strict validation.
- Deliberately invalid fixtures emit and fail on the expected identity, orphan, and code-pointer findings.
- The coordination fixture emits the expected active-scope overlap and branch-owner mismatch advisories on all supported operating-system jobs.
- If source and published repositories declare the same `.contextrail-version`, their payloads are byte-equivalent.
- A GitHub Release is created only after the source payload, fresh published-template clone, and extracted release ZIP compare equal.
- Release tag, changelog section, and `.contextrail-version` identify the same semantic version.
- A completed task does not remain on the Board.
- Project-native tests remain authoritative for runtime behavior; ContextRail validation governs memory and pointer integrity.

## External Interfaces

- GitHub repository `isikmuhamm/contextrail-template`.
- GitHub Releases API and `gh` CLI.
- GitHub Actions runners for Linux, macOS, and Windows.
- GitHub Actions `GITHUB_ACTOR`, `GITHUB_HEAD_REF`, and `GITHUB_REF_NAME` environment values for best-effort coordination identity checks.
- Repository secret `CONTEXTRAIL_TEMPLATE_TOKEN` for cross-repository template publication.

## Known Limits

- Existing user repositories do not receive template updates automatically.
- Shared-work coordination is advisory and repo-local; it does not reserve files, prevent concurrent edits, prove a GitHub account exists, or replace repository-native authorization and review controls.
- Scope overlap is based on declared repository-relative path prefixes; it does not perform semantic code ownership or symbol-level conflict prediction.
- ContextRail defines reuse-first decision guidance but does not perform dependency due diligence, guarantee license compatibility, or replace project-specific legal/security review.
- ContextRail defines delegation policy but does not provide or orchestrate a multi-agent runtime; execution capabilities come from the active coding environment.
- Validator and coordination-checker implementations are intentionally OS-native and therefore require parity maintenance across shell and PowerShell.
- Code-trace validation proves pointer integrity and nearby invariant text, not semantic correctness or test adequacy.
- Commentless, generated, vendor, lock, and binary files rely on task Notes for implementation mapping.

## Decision References

- `DEC-0001` — four bounded memory files separate current truth, work, rationale, and evidence.
- `DEC-0002` — `template/` is the canonical distribution source; the separate template repository is a generated mirror.
- `DEC-0003` — ContextRail validation joins one project-native canonical verification pipeline instead of creating a parallel test system.
- `DEC-0004` — template creation and versioned release archives are parallel distribution channels derived from one verified payload.
- `DEC-0005` — external packages are non-canonical staging inputs adopted into local Board and Notes records.
- `DEC-0006` — durable implementation boundaries use one governing task pointer and short current invariant.
- `DEC-0007` — native delegation is allowed only for bounded verifiable work while the primary agent retains judgment, review, completion authority, and paid-usage control.
- `DEC-0008` — non-trivial work uses reuse-first ecosystem research, license-aware incorporation, independent implementation for incompatible sources, and justified custom infrastructure.
- `DEC-0009` — shared-work coordination uses Board ownership plus optional branch and path-scope metadata for advisory collision visibility while repository-native controls remain authoritative.
