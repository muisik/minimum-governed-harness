# System

This file describes the current implemented ContextRail development and distribution system.

## Purpose and Scope

ContextRail provides a minimal governed system map, project-memory layer, external-handoff intake contract, task-linked implementation trace, memory lifecycle compaction, governed delegation guardrails, reuse-first engineering guidance, recoverability-before-destruction guidance, durable rationale for material agent decisions and technical debt, and lightweight shared-work coordination for coding-agent repositories.

This repository develops, tests, documents, versions, and publishes the reusable template. ContextRail does not generate specifications, manage projects, perform semantic retrieval, operate a multi-agent runtime, choose dependencies for a project, provide legal advice, enforce repository permissions, prove backup correctness, or replace project-native verification and operational safeguards.

## Components

- `template/` — canonical source for every file distributed to user repositories.
- `template/AGENTS.md` — canonical distributed operating contract, including memory lifecycle, durable decision rationale, recoverability before destructive change, reuse-first engineering, governed delegation, and shared-work coordination.
- `template/handoffs/HANDOFF.md` — generic procedure for adopting external packages into local Board and Notes records.
- `template/scripts/validate-linux.sh`, `validate-macos.sh`, and `validate-windows.ps1` — OS-native project-memory, lifecycle-compaction, and code-trace validators.
- `template/scripts/check-coordination.sh` and `check-coordination.ps1` — advisory shared-work checks for active task ownership, branch identity, and path-scope overlap.
- `project-memory/` — ContextRail's own system model, unfinished work, durable rationale, and completion evidence.
- `docs/` — public adoption and governance documentation, including `SAFETY-GUARDRAILS.md`.
- `tests/fixtures/valid-trace/` — valid implementation and principal-test task trace.
- `tests/fixtures/invalid/` — deliberately invalid memory, identity, and code-trace examples.
- `tests/fixtures/team-coordination/` — deterministic active-task overlap and GitHub actor-mismatch examples.
- `tests/fixtures/lifecycle-compaction/` — deterministic completed-task Notes-bloat and compact-stub examples.
- `.github/workflows/validate-memory.yml` — Linux, macOS, and Windows contract validation, exact failure/warning assertions, coordination-check assertions, and same-version published-template drift detection.
- `.github/workflows/release.yml` — release-marker or manual-triggered template synchronization, archive creation, round-trip verification, checksums, manifest generation, and GitHub Release publication.
- `muisik/contextrail-template` — clean published mirror used as the GitHub Template Repository; the historical `isikmuhamm` URL redirects to the same repository.
- GitHub Releases — immutable version announcements and clean downloadable template archives.

## Primary Flows

1. Reusable changes are made under `template/`.
2. External packages in a user repository are staged under `handoffs/incoming/`, deduplicated, and converted into local Notes records and independently verifiable Board tasks before implementation.
3. Unfinished tasks remain in `BOARD.md` with necessary implementation detail retrieved by exact ID from `NOTES.md`.
4. Material agent-made technical choices that are within delegated authority and constrain future work preserve durable rationale in the appropriate Notes record. Deliberate technical debt records what was deferred, why, its consequence or risk, and a repayment trigger or condition.
5. Before destructive, irreversible, or material data-loss-risk work, the agent establishes a concrete recovery path appropriate to the affected asset. If recoverability cannot be established, the operation stops unless permanent destruction of that exact target is itself explicitly user-authorized; collateral loss remains outside that authorization.
6. When a task is completed or cancelled, it leaves the Board; detailed implementation notes, acceptance proof, test evidence, outcome, and remaining boundary move to `HISTORY.md`, while Notes retains at most a short task stub when discoverability is useful. Durable `REQ`, `DEC`, and `RISK` records remain when they still explain current or future work.
7. `SYSTEM.md` changes on task completion only when current architecture, flow, interface, ownership, invariants, or known limits changed.
8. Durable implementation boundaries and principal regression tests may carry a local `TASK-####` pointer and short invariant.
9. In a shared repository, an active task may declare its working `Branch` and expected path-prefix `Scope`; the coordination checker exposes likely overlap with other active work and can compare a matching GitHub branch's simple `@username` owner with `GITHUB_ACTOR`.
10. Coordination findings are advisory. Agents narrow or coordinate materially overlapping work instead of treating ContextRail metadata as a file lock or permission grant.
11. For non-trivial capabilities likely to have proven existing solutions, the primary agent performs proportional ecosystem research before substantial custom implementation and prefers compatible reuse or integration when it materially satisfies the requirement.
12. External code or components are incorporated only when their license and terms are compatible with the project's intended use; incompatible implementations may inform behavior, architecture, interfaces, failure modes, and tradeoffs but are not copied or closely translated.
13. The primary agent may delegate bounded, low-risk, objectively verifiable execution work to native workers while retaining judgment, integration, review, and completion ownership.
14. Validators confirm memory lifecycle, identity, references, completed-task compaction, and task-linked code-pointer integrity on Linux, macOS, and Windows; the separate coordination checker reports parallel-work advisories.
15. Documentation, changelog, and `.contextrail-version` are updated with a released behavior change.
16. A `vX.Y.Z` release identity is supplied by workflow dispatch or a main commit carrying `[release:vX.Y.Z]`; the release workflow requires that identity, changelog heading, and `.contextrail-version` to agree.
17. The release workflow synchronizes `template/` to the published template repository when needed and verifies a fresh clone against the source payload.
18. A clean ZIP is built from `template/`, extracted, and compared back to source before the GitHub Release is created.
19. Users either create a new repository from the clean template or download the matching release archive.

## Boundaries and Sources of Truth

- Reusable distribution payload — `template/`.
- Current ContextRail system model — this file.
- Active ContextRail work and optional coordination metadata — `project-memory/BOARD.md`.
- Open/planned task detail plus durable requirements, decisions, risks, rationale, material agent-decision context, and technical-debt rationale — `project-memory/NOTES.md`.
- Completed/cancelled task detail and canonical completion evidence — `project-memory/HISTORY.md`.
- Shared agent workflow and guardrails — `template/AGENTS.md`.
- External-handoff intake procedure — `template/handoffs/HANDOFF.md`.
- Raw external packages in user repositories — non-canonical source evidence under `handoffs/`.
- Runtime behavior — source code and native tests.
- Repository permissions, branch protection, CODEOWNERS, review, and merge authority — repository-native hosting controls, not ContextRail Board metadata.
- Public behavior and adoption claims — `README.md` and `docs/`.
- Published user template — generated mirror at `muisik/contextrail-template`; it is not independently edited.
- Official versions and downloadable archives — GitHub Releases in `minimum-governed-harness`.

## Invariants

- `template/` is the only canonical source for distributed files.
- The published template contains only files intended to remain in a user's repository and excludes this development repository's README, license, changelog, contribution guide, fixtures, and development history.
- The four-file memory model remains the default: System for current truth, Board for unfinished tasks, Notes for open/planned detail and durable rationale, History for completion/cancellation evidence.
- A completed or cancelled task does not remain on the Board; detailed closed-task implementation evidence is canonical in History and is not duplicated in Notes.
- A closed task may keep a short Notes stub for exact-ID discoverability; durable `REQ`, `DEC`, and `RISK` records remain when still meaningful.
- External packages are adopted into local records before implementation and do not become another canonical memory store.
- Stable record identities do not reuse the same normalized title under different IDs.
- Task-linked code markers resolve to a local Board or History lifecycle record and matching Notes detail; comments point to the task that best explains the current invariant rather than accumulating full edit history.
- Agents do not silently broaden the selected task, and rationale never grants authority to exceed delegated scope, accepted requirements, security boundaries, public contracts, or other ownership boundaries.
- Material agent-made technical decisions that constrain future work preserve durable rationale in project memory when the agent is authorized to make them; trivial local implementation choices do not require durable records.
- Deliberate technical debt records the deferral, reason, consequence or risk, and a concrete repayment trigger or condition.
- Destructive, irreversible, or material data-loss-risk operations require a concrete recovery path appropriate to the affected asset before execution unless permanent destruction of that exact target is itself explicitly user-authorized.
- Recoverability is proven rather than presumed: tracked source requires a known recoverable Git state with existing user changes preserved, while persistent or external state requires an appropriate backup, snapshot, export, version, rollback, or equivalent mechanism whose scope and freshness are understood.
- Explicit authorization for intentional permanent destruction does not authorize collateral loss outside the stated target and scope.
- `Owner` remains the canonical responsibility field for unfinished tasks; `Branch` and `Scope` are optional coordination metadata rather than lifecycle authorities.
- Shared-work scope overlap and GitHub branch-owner mismatch are advisory findings; they do not grant ownership, lock files, or override CODEOWNERS, branch protection, permissions, or reviewer authority.
- Substantial custom infrastructure is a justified decision rather than the default starting point when proven compatible capability is readily available.
- External adoption considers functional fit, maintenance, security, license compatibility, portability, operational constraints, and replacement cost.
- Incompatible implementation code is not copied or closely translated; only independently reusable engineering knowledge informs a separate implementation.
- Replaceable third-party capability should remain behind a small project-owned boundary when practical; unnecessary forks are avoided and justified deltas stay minimal and documented.
- Delegation never transfers end-to-end task ownership, durable project judgment, final review, or completion authority away from the primary agent.
- Delegated output is not completion evidence until the primary agent inspects and verifies the actual result.
- ContextRail does not hard-code model providers or authorize metered paid delegation without explicit user approval.
- Linux, macOS, and Windows validators implement the same governance contract; Linux/macOS and Windows coordination checkers implement the same advisory semantics.
- The empty clean template and valid trace fixture pass strict validation; deliberately invalid fixtures emit and fail on the expected identity, orphan, and code-pointer findings.
- The lifecycle-compaction fixture emits the expected completed-task detail warning under strict validation while its compact closed-task stub does not emit that warning.
- The coordination fixture emits the expected active-scope overlap and branch-owner mismatch advisories on all supported operating-system jobs.
- If source and published repositories declare the same `.contextrail-version`, their payloads are byte-equivalent.
- A GitHub Release is created only after the source payload, fresh published-template clone, and extracted release ZIP compare equal.
- Release identity, changelog section, and `.contextrail-version` identify the same semantic version.
- Project-native tests remain authoritative for runtime behavior; ContextRail validation governs memory and pointer integrity.

## External Interfaces

- GitHub repository `muisik/contextrail-template`.
- GitHub Releases API and `gh` CLI used by Actions.
- GitHub Actions runners for Linux, macOS, and Windows.
- GitHub Actions `GITHUB_ACTOR`, `GITHUB_HEAD_REF`, and `GITHUB_REF_NAME` values for best-effort coordination identity checks.
- Repository secret `CONTEXTRAIL_TEMPLATE_TOKEN` for cross-repository template publication.

## Known Limits

- Existing user repositories do not receive template updates automatically.
- Completion-compaction validation is structural and heuristic; it does not compare prose semantically or prove that every durable rationale item was preserved before compaction.
- Recoverability sufficiency, material decision significance, delegated decision authority, and technical-debt rationale quality are semantic judgments. ContextRail documents these operating invariants but does not pretend to prove them with filename or keyword heuristics.
- ContextRail does not verify that backups can actually restore successfully; project-native backup, restore, cloud, database, and operational controls remain authoritative.
- Shared-work coordination is advisory and repo-local; it does not reserve files, prevent concurrent edits, prove a GitHub account exists, or replace repository-native authorization and review controls.
- Scope overlap is based on declared repository-relative path prefixes; it does not perform semantic code ownership or symbol-level conflict prediction.
- ContextRail defines reuse-first decision guidance but does not perform dependency due diligence, guarantee license compatibility, or replace project-specific legal/security review.
- ContextRail defines delegation policy but does not provide or orchestrate a multi-agent runtime; execution capabilities come from the active coding environment.
- Validator and coordination-checker implementations are intentionally OS-native and require parity maintenance across shell and PowerShell.
- Code-trace validation proves pointer integrity and nearby invariant text, not semantic correctness or test adequacy.
- Commentless, generated, vendor, lock, and binary files rely on task Notes for implementation mapping while the task is open and on History/current governing tasks after closure as appropriate.

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
- `DEC-0010` — closed task detail compacts into History while Notes retains only short task stubs plus durable requirements, decisions, and risks.
- `DEC-0011` — destructive or material data-loss-risk work requires proven recoverability unless permanent destruction of the exact target is itself explicitly user-authorized.
- `DEC-0012` — material agent-made decisions and deliberate technical debt preserve durable rationale while trivial local choices remain unlogged and rationale never expands delegated authority.
