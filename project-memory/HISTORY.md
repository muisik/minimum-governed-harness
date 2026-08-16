# History

The canonical record of completed or cancelled ContextRail tasks.

Allowed statuses: `completed`, `cancelled`.

## TASK-0000 — Bootstrap Minimum Governed Harness
- Status: completed
- Completed: 2026-06-28
- Related: DEC-0001
- Evidence: GitHub Actions validated Linux, macOS, and Windows and rejected the original invalid fixture.
- Outcome: Added the initial system map, Board, Notes, History, canonical agent guide, adapters, OS-native validators, fixture, and cross-platform CI.

## TASK-0001 — Publish ContextRail v0.5 clean template distribution
- Status: completed
- Completed: 2026-07-01
- Related: DEC-0002, DEC-0003
- Evidence: GitHub Actions run 28520073108 passed clean-template validation, source-repository memory validation, and invalid-fixture rejection on Linux, macOS, and Windows.
- Outcome: Established `template/` as the canonical distribution source, added the v0.5 agent contract and required-field validation, documented the two-repository model, and prepared automated publication to the clean template repository.

## TASK-0002 — Add synchronized template and release distribution
- Status: completed
- Completed: 2026-07-01
- Related: DEC-0004
- Evidence: Pull-request Actions run 28522311524 passed Linux, macOS, Windows, and published-template consistency jobs; the gated release workflow created tag `v0.5.0`, whose tagged tree declares version `0.5.0` and contains the synchronized release workflow.
- Outcome: Added official clean GitHub Release archives in parallel with the Template Repository, with tag/version/changelog agreement, fresh-clone and archive round-trip equality gates, ZIP checksum, per-file manifest, and same-version drift detection.

## TASK-0003 — Add handoff adoption and task-linked code trace
- Status: completed
- Completed: 2026-07-01
- Related: DEC-0005, DEC-0006
- Evidence: Pull-request Actions run 28544540035 passed clean-template validation, source-repository validation, the valid implementation/test trace fixture, exact invalid-fixture assertions, and the published-template version guard on Linux, macOS, and Windows.
- Outcome: Added generic external handoff adoption, minimal TASK-plus-invariant code trace for implementation and principal tests, normalized-title identity guards, code-pointer validation, cross-platform fixtures, stable 1.0 documentation, and synchronized 1.0.0 release preparation.

## TASK-0004 — Harden published version synchronization
- Status: completed
- Completed: 2026-07-01
- Related: DEC-0004
- Evidence: The first release attempt stopped before tag creation when fresh-clone equality detected the stale mirror version; pull-request Actions run 28545034563 then passed Linux, macOS, Windows, and the published-template version guard after workflow hardening.
- Outcome: The release workflow now explicitly copies and stages `.contextrail-version`, checks worktree and staged values against the requested release, and retains fresh-clone plus archive round-trip gates.

## TASK-0005 — Add governed agent delegation policy
- Status: completed
- Completed: 2026-08-14
- Related: DEC-0007
- Evidence: Main distribution validation run 31808775511 passed; release workflow run 31808775525 synchronized and round-trip verified the published template and created GitHub Release `v1.1.0` with ZIP, SHA-256 checksum, and per-file manifest; the published mirror declares `.contextrail-version` `1.1.0`.
- Outcome: Added provider-independent governed delegation to the canonical agent contract, allowing bounded verifiable worker use while keeping durable judgment, canonical-memory integration, review, completion authority, and paid-usage control with the primary agent.

## TASK-0006 — Add reuse-first engineering policy
- Status: completed
- Completed: 2026-08-16
- Related: DEC-0008
- Evidence: The ContextRail 1.3.0 change set updates the canonical template policy, governance documentation, changelog, and current system/decision records while leaving validator schemas and lifecycle formats unchanged; repository CI and release verification provide the publication gate.
- Outcome: Added proportional research-before-building guidance, license-aware reuse boundaries, independent implementation rules for incompatible source code, replaceable adapter boundaries, minimal-fork guidance, and the requirement that substantial custom infrastructure be justified instead of assumed.
