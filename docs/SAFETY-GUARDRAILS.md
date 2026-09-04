# Agent Safety and Rationale Guardrails

ContextRail 1.5.1 strengthens two semantic operating boundaries for coding agents without adding a new runtime policy engine or validator schema.

## Proven recoverability before destructive change

Before a destructive, irreversible, or material data-loss-risk operation, the agent must establish a concrete recovery path appropriate to the affected asset. Recoverability is proven, not presumed.

For tracked source code, existing user changes must be preserved and the prior state must be recoverable from a known Git state. Databases, persistent data, external resources, untracked files, and non-reproducible assets require an appropriate backup, snapshot, export, version, rollback mechanism, or equivalent recovery path whose scope and freshness are understood.

A generic statement that backups exist is not enough when coverage or freshness is unknown. If recovery cannot reasonably be established, the destructive operation stops. The narrow exception is when irreversible destruction of the exact target is itself the explicitly user-authorized outcome; that authority does not extend to collateral loss outside the stated scope.

## Durable rationale for material agent decisions

ContextRail already separates current truth, unfinished work, durable rationale, and completion evidence. Version 1.5.1 makes the agent-side consequence explicit: when the user has not already made a material technical choice and the agent is authorized to make it, the decision must leave durable rationale when it materially constrains future behavior or work.

Examples include architecture and ownership boundaries, interfaces, security and permissions, data shape or migrations, dependencies and providers, compatibility behavior, cost/performance tradeoffs, scope or acceptance interpretation, durable invariants, and deliberate technical debt.

The rationale belongs in the appropriate `project-memory/NOTES.md` task detail, `DEC-####`, `REQ-####`, or `RISK-####` record. It should explain why the choice was made and which material constraints or tradeoffs shaped it. Important rationale must not exist only in chat, private reasoning, scratchpads, generated prose, or commit messages.

Rationale never grants authority. If the choice exceeds the task, delegated scope, accepted requirements, security boundary, public contract, or another authority the agent does not own, the agent must obtain user direction instead of making a unilateral decision and documenting it afterward.

Trivial local implementation choices do not require durable records. Deliberate technical debt does: record what was deferred, why, its consequence or risk, and a concrete repayment trigger or condition.

## Why these rules are semantic

These boundaries depend on asset-specific recovery sufficiency, decision materiality, delegated authority, and technical context. ContextRail therefore treats them as agent operating invariants rather than pretending they can be reliably enforced by filename or keyword heuristics. Project-native controls, database backup policies, cloud safeguards, branch protection, tests, and human approvals remain authoritative where they apply.
