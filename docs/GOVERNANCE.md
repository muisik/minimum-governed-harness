# Governance Contract

ContextRail separates current system truth, unfinished work, reasoning, completion evidence, external intake, and runtime behavior without creating parallel sources of truth.

## System

`project-memory/SYSTEM.md` answers: **What is the implemented system now?**

It contains a concise map of purpose, components, flows, boundaries, invariants, external interfaces, and current limits. It excludes open tasks, chronological logs, unresolved debates, and speculative future architecture.

## Board

`project-memory/BOARD.md` answers: **What unfinished work exists now?**

It contains only `TASK-####` records with `proposed`, `active`, or `blocked` status. Each task requires `Status`, `Priority`, `Owner`, `Related`, `Summary`, and `Acceptance`.

For shared repositories, `Owner` remains the canonical responsibility field. Prefer `Owner: @github-login` when the responsible GitHub identity is known. `Branch` and `Scope` are optional coordination metadata: `Branch` names the task's working branch, while `Scope` is a comma-separated set of repository-relative file or directory prefixes that the task reasonably expects to change.

## Shared repository coordination

ContextRail makes parallel work visible; it does not reserve files or enforce permissions.

The optional OS-native coordination checker reads active Board tasks and reports advisory findings when:

- an active task remains `Owner: unassigned`;
- a task declares a branch without enough scope information to assess likely overlap;
- two active task scopes are equal or one declared path prefix contains the other at a repository path boundary;
- on GitHub Actions, a task's recorded branch matches the current branch while a simple `@username` owner differs from `GITHUB_ACTOR`.

Scope findings are intentionally coarse. They surface likely collisions early without attempting semantic code ownership, symbol analysis, locking, or merge prediction. Actor mismatches are also advisory because pair work, bots, delegated commits, and maintainers acting on another person's branch may be legitimate.

Repository-native controls remain authoritative for access and merge governance: Git branches and worktrees isolate changes; CODEOWNERS expresses review ownership; branch protection or rulesets enforce required checks and reviewers; GitHub permissions determine repository access; and the normal merge process resolves actual conflicts. ContextRail must not duplicate those systems.

## Notes

`project-memory/NOTES.md` answers: **What does this work mean, why does it exist, and what has been decided?**

Task, decision, requirement, and risk records require `Status`, `Related`, and `Last updated`. Accepted decisions should identify where the resulting current truth is reflected. External source identifiers, implementation boundaries that cannot carry comments, and handoff provenance also belong in the relevant Notes record.

## History

`project-memory/HISTORY.md` answers: **What was completed or cancelled, and what evidence supports that state?**

History contains only task records. Every record requires `Status`, `Related`, `Evidence`, and `Outcome`. Completed records require `Completed: YYYY-MM-DD`; cancelled records require `Cancelled: YYYY-MM-DD`.

## External handoffs

`handoffs/HANDOFF.md` defines how external specifications, assessments, plans, and exports enter the governed local model.

Raw packages under `handoffs/incoming/` are non-canonical source evidence. Before implementation, the agent searches existing records, preserves external provenance, converts durable meaning into Notes, derives independently verifiable local Board tasks, records conflicts, and validates the result. Adopted packages may move to `handoffs/processed/` when retention remains useful.

## Lifecycle

```text
proposed -> active -> blocked -> active -> completed
                \-> cancelled
```

The stable identity does not change when priority, milestone, owner, or status changes.

## Stable identities and titles

- Search before creating a task, decision, requirement, or risk.
- Reuse the same identity for the same work or durable meaning.
- The same stable identity should use the same normalized title wherever it appears.
- Do not create two identities of the same record type with the same normalized title.
- When later work changes prior behavior, relate or supersede the earlier record rather than opening an indistinguishable duplicate.

Title normalization ignores case, repeated whitespace, and punctuation. It is a deterministic identity guard, not semantic search.

## Canonical ownership

- current architecture and boundaries: System;
- unfinished task state and optional coordination metadata: Board;
- task detail and rationale: Notes;
- completion and cancellation evidence: History;
- external intake procedure: `handoffs/HANDOFF.md`;
- raw handoff packages: non-canonical source evidence under `handoffs/`;
- runtime behavior: source code and native tests;
- public promise: README and user-facing documentation;
- shared repository agent workflow and project instructions: `AGENTS.md`;
- personal agent preferences: contributor-local or tool-local configuration outside the shared repository contract;
- repository access, CODEOWNERS, branch protection, required review, and merge authority: repository-native hosting controls.

A task may appear in Board and Notes because they serve different roles. A task must not appear in Board and History simultaneously.

## Repository and personal agent instructions

`AGENTS.md` is the canonical repository-shared operating contract. Its protected project-maintained instruction block belongs to the project and is read by every contributor and coding agent that adopts the repository contract; it is not a place for one contributor's personal preferences.

The block continues to use the existing `CONTEXTRAIL:USER-INSTRUCTIONS` marker names for update compatibility, but its ownership semantics are project-level. ContextRail updates must preserve the block verbatim.

Personal preferences such as response style, individual workflow habits, or tool-local defaults stay in each contributor's local or agent-specific configuration. They must not override the shared repository contract.

Tool-specific repository files such as `CLAUDE.md`, `GEMINI.md`, Copilot instructions, and Cursor rules remain valid and useful in a mixed-agent team, but they stay thin entry points into `AGENTS.md`. They must not become competing copies of repository policy.

## Task-linked code trace

When a task creates or materially changes a durable behavior boundary, the smallest stable implementation scope carries a language-native comment:

```text
ContextRail: TASK-####
Invariant: <current behavior or constraint>
```

The marker points to the task that best explains the current invariant. It does not list every task that historically touched the code. The same task marker belongs on the principal regression test when the behavior is testable.

Place the marker before the complete symbol when the task governs the symbol, or immediately before the narrower block or statement when it governs only that behavior. Preserve it through refactoring, replace it when a later task changes the invariant, and leave it unchanged for mechanical edits that preserve the behavior contract.

Generated code, vendor code, binaries, lock files, and formats that cannot safely carry comments are not modified for traceability. Record those implementation boundaries in the task's Notes section.

Validators confirm that code markers point to a task with a Board or History lifecycle record and matching Notes detail. They do not prove that the stated invariant is semantically correct.

## Root cause before patch

A defect should be traced to the violated invariant, domain rule, state transition, parser contract, policy, or ownership boundary before an input-specific condition is added. Regression tests should cover the failure class, not only the reported phrase.

## Independent review

The implementing agent is also the first reviewer and QA layer. It must inspect its diff, verify acceptance criteria against evidence, state test limits, check relevant failure paths and system invariants, and confirm task-linked traces still point to the correct current scope before claiming completion.

## Incidental findings

Unrelated findings must be reported but should not silently expand the current task. Immediate scope expansion is reserved for security, data loss, verification blockers, or findings that invalidate the current result.

## Governed delegation

The primary agent retains end-to-end ownership of the selected task. It may use native workers or subagents for bounded, low-risk, objectively verifiable execution work when delegation reduces unnecessary primary-agent reasoning or context cost.

Delegation does not transfer durable project judgment. Ambiguous requirements, architecture and domain-boundary decisions, security and permission boundaries, destructive or data-risk operations, public-contract changes, final integration, independent review, and completion decisions remain with the primary agent.

Workers receive explicit scope, acceptance criteria, verification evidence, and stop conditions. Their output is reviewed as untrusted implementation input before it becomes completion evidence or canonical project memory. ContextRail does not prescribe provider or model names and does not authorize metered external usage; paid APIs or credits require explicit user authorization.

When no suitable native worker exists, a primary agent may offer a concise copy-paste delegation brief only when the expected savings are material enough to justify the handoff.

## Research before building

For non-trivial work, a custom implementation is not the default starting point. When a substantial capability is likely to have a proven existing solution, the agent performs a proportional ecosystem check before committing to bespoke implementation.

Prefer compatible standard or platform capabilities, official interfaces, maintained open-source components, and proven existing systems when they materially satisfy the requirement. Adoption considers fit, maintenance, security, license compatibility, portability, operating constraints, and replacement cost rather than convenience alone.

Code or components are incorporated only when their license and terms are compatible with the project's intended use and distribution. Incompatible implementations may still inform documented behavior, interfaces, architecture, failure modes, and tradeoffs, but the required behavior is implemented independently rather than copied or closely translated.

Third-party capability should remain behind a small project-owned boundary when replacement is plausible. Upstream use is preferred over unnecessary forks; justified forks or vendored patches keep a minimal, documented project-specific delta.

Custom infrastructure therefore requires justification. ContextRail favors owning the project-specific gap instead of rebuilding established commodity capability, while keeping research proportional so small or settled tasks do not become broad ecosystem surveys.

## Atomic completion

Complete implementation, native tests, code-trace maintenance, Board removal, Notes update, History evidence, System updates, public docs, self-review, and canonical verification as one lifecycle change.

## Adapter governance

`AGENTS.md` is the only canonical repository instruction file in a user project. Tool-specific files remain thin pointers so mixed-agent teams can keep the repository entry points their tools expect without duplicating policy.

## When to add another memory file

Add one only when a separate owner, security boundary, lifecycle, independent reuse need, or enough search noise creates a real boundary. Do not split merely because a section is long. External handoffs and implementation traces should point into the existing four memory roles rather than creating new canonical stores.
