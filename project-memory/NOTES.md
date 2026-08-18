# Notes

Open task detail plus durable rationale, decisions, requirements, and risks for ContextRail itself. Search by exact ID; completed task detail is compacted into `HISTORY.md`.

## TASK-0001 — Publish ContextRail v0.5 clean template distribution
- Status: completed
- Related: DEC-0002, DEC-0003
- Last updated: 2026-07-01
- History: project-memory/HISTORY.md#task-0001--publish-contextrail-v05-clean-template-distribution

## TASK-0002 — Add synchronized template and release distribution
- Status: completed
- Related: DEC-0004
- Last updated: 2026-07-01
- History: project-memory/HISTORY.md#task-0002--add-synchronized-template-and-release-distribution

## TASK-0003 — Add handoff adoption and task-linked code trace
- Status: completed
- Related: DEC-0005, DEC-0006
- Last updated: 2026-07-01
- History: project-memory/HISTORY.md#task-0003--add-handoff-adoption-and-task-linked-code-trace

## TASK-0004 — Harden published version synchronization
- Status: completed
- Related: DEC-0004
- Last updated: 2026-07-01
- History: project-memory/HISTORY.md#task-0004--harden-published-version-synchronization

## TASK-0005 — Add governed agent delegation policy
- Status: completed
- Related: DEC-0007
- Last updated: 2026-08-14
- History: project-memory/HISTORY.md#task-0005--add-governed-agent-delegation-policy

## TASK-0006 — Add reuse-first engineering policy
- Status: completed
- Related: DEC-0008
- Last updated: 2026-08-16
- History: project-memory/HISTORY.md#task-0006--add-reuse-first-engineering-policy

## TASK-0007 — Refresh public README through ContextRail 1.3
- Status: completed
- Related: DEC-0007, DEC-0008
- Last updated: 2026-08-16
- History: project-memory/HISTORY.md#task-0007--refresh-public-readme-through-contextrail-13

## TASK-0008 — Add lightweight shared-work coordination
- Status: completed
- Related: DEC-0009
- Last updated: 2026-08-16
- History: project-memory/HISTORY.md#task-0008--add-lightweight-shared-work-coordination

## TASK-0009 — Add task lifecycle completion compaction
- Status: completed
- Related: DEC-0010
- Last updated: 2026-08-18
- History: project-memory/HISTORY.md#task-0009--add-task-lifecycle-completion-compaction

## DEC-0001 — Separate current truth, work, rationale, and evidence
- Status: accepted
- Related: TASK-0000
- Last updated: 2026-07-01
- Reflected in: project-memory/SYSTEM.md — Boundaries and Sources of Truth

### Decision

Use `SYSTEM.md`, `BOARD.md`, `NOTES.md`, and `HISTORY.md` as four bounded information roles.

## DEC-0002 — Maintain one canonical template payload
- Status: accepted
- Related: TASK-0001
- Last updated: 2026-07-01
- Reflected in: project-memory/SYSTEM.md — Components, Primary Flows, and Invariants

### Decision

Maintain reusable files only under `template/`. Treat `isikmuhamm/contextrail-template` as a published mirror rather than a separate development source.

## DEC-0003 — Integrate memory validation into canonical project verification
- Status: accepted
- Related: TASK-0001
- Last updated: 2026-07-01
- Reflected in: project-memory/SYSTEM.md — Invariants

### Decision

On first substantive use, discover the repository's existing native verification entrypoint and add ContextRail validation to the same canonical command. Use the standalone template workflow only as an initial safety net or when no established CI exists.

## DEC-0004 — Derive template and releases from one verified payload
- Status: accepted
- Related: TASK-0002, TASK-0004
- Last updated: 2026-07-01
- Reflected in: project-memory/SYSTEM.md — Primary Flows and Invariants

### Decision

Keep the GitHub Template Repository as the new-project channel and publish versioned clean ZIP archives from the same `template/` payload. Block release creation unless source, published mirror, and extracted archive are identical.

## DEC-0005 — Adopt external handoffs through local records
- Status: accepted
- Related: TASK-0003
- Last updated: 2026-07-01
- Reflected in: project-memory/SYSTEM.md — Components, Primary Flows, Boundaries and Sources of Truth, and Invariants

### Decision

Treat external handoff packages as non-canonical staging inputs. Before implementation, deduplicate them against current project memory and convert durable meaning into local Notes records and independently verifiable local Board tasks.

## DEC-0006 — Trace durable code boundaries to one governing task
- Status: accepted
- Related: TASK-0003
- Last updated: 2026-07-01
- Reflected in: project-memory/SYSTEM.md — Primary Flows, Invariants, and Known Limits

### Decision

Use a minimal language-native comment containing a local `TASK-####` pointer and short current invariant. The pointer identifies the task that best explains the present behavior, not every task that historically touched the code.

## DEC-0007 — Delegate bounded work without transferring ownership
- Status: accepted
- Related: TASK-0005
- Last updated: 2026-08-14
- Reflected in: project-memory/SYSTEM.md — Purpose and Scope, Components, Primary Flows, Boundaries and Sources of Truth, Invariants, and Known Limits

### Decision

Allow the primary coding agent to use native workers for bounded, low-risk, objectively verifiable work while retaining durable project judgment, canonical-memory integration, independent review, completion authority, and control over any paid external usage. ContextRail specifies the boundary but does not choose providers, models, or implement a multi-agent runtime.

## DEC-0008 — Prefer proven integration before custom implementation
- Status: accepted
- Related: TASK-0006
- Last updated: 2026-08-16
- Reflected in: project-memory/SYSTEM.md — Purpose and Scope, Primary Flows, Invariants, and Known Limits

### Decision

For non-trivial capabilities likely to have proven existing solutions, require proportional research before bespoke implementation. Prefer compatible reuse or integration, incorporate code only under compatible terms, use incompatible sources only as engineering knowledge for an independent implementation, keep replaceable dependencies behind small project-owned boundaries, and treat substantial custom infrastructure as a decision that requires justification rather than the default starting point.

## DEC-0009 — Keep team coordination advisory and repository-native
- Status: accepted
- Related: TASK-0008
- Last updated: 2026-08-16
- Reflected in: project-memory/SYSTEM.md — Components, Primary Flows, Invariants, and Known Limits; template/AGENTS.md — Canonical instruction file, Project-maintained instructions, Shared repository coordination

### Decision

Use existing Board ownership plus optional branch and path-scope metadata to make parallel work visible. Detect active scope overlap and GitHub branch-owner mismatch as advisory findings, while leaving permissions, ownership enforcement, review, locking, and merge authority to repository-native systems such as CODEOWNERS and branch protection. Keep `AGENTS.md` as the repository-shared project contract, keep contributors' personal preferences local, preserve the protected project-instruction block across updates, and retain tool-specific repository files only as thin adapters into the canonical contract.

## DEC-0010 — Compact closed task detail into History
- Status: accepted
- Related: TASK-0009
- Last updated: 2026-08-18
- Reflected in: project-memory/SYSTEM.md — Primary Flows, Boundaries and Sources of Truth, Invariants, and Known Limits; template/AGENTS.md — Source roles, Task lifecycle and completion compaction, Completing work

### Decision

Keep the four-file memory model but make closure asymmetric: Board contains unfinished tasks, Notes contains open/planned task detail plus durable `REQ`/`DEC`/`RISK` rationale, and History owns detailed completion/cancellation evidence. Closed tasks may retain only a short Notes index stub. Cross-platform validators warn when a closed Notes task remains long or duplicates completion-detail sections already represented in History; strict validation treats those warnings as failures so stale memory is repaired instead of silently accumulating.
