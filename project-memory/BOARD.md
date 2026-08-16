# Board

The short, canonical view of unfinished ContextRail work.

Allowed statuses: `proposed`, `active`, `blocked`.

## TASK-0008 — Add lightweight shared-work coordination
- Status: active
- Priority: P2
- Owner: @muisik
- Branch: feature/team-coordination
- Scope: template/AGENTS.md, template/project-memory/BOARD.md, template/scripts/, tests/fixtures/team-coordination/, .github/workflows/validate-memory.yml, docs/GOVERNANCE.md
- Related: DEC-0009
- Summary: Add optional branch and scope metadata plus deterministic overlap and GitHub-actor warnings without turning ContextRail into a lock or permission system.
- Acceptance: Shared-repository guidance is explicit; Linux/macOS and Windows coordination checks detect active scope overlap and GitHub branch-owner mismatch; source CI proves the same behavior; existing project-memory and code-trace validation remains unchanged.
