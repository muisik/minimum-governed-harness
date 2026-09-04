# Notes

Open or planned task detail, durable rationale, decisions, requirements, risks, source provenance, and implementation context.

Search by exact `TASK-####`, `DEC-####`, `REQ-####`, or `RISK-####` ID. Do not read this file in full by default. Each record requires `Status`, `Related`, and `Last updated`.

Accepted decisions should also identify where the resulting current truth is reflected.

When useful, an open task detail may include its governing invariant, external handoff references, acceptance detail, and code or test boundaries that cannot safely carry native comments.

Material agent-made technical decisions that constrain future work should preserve durable rationale here when the user did not already make that choice and the agent had authority to decide it. Record enough context to explain why the choice was made and which material constraints or tradeoffs shaped it. Do not create durable records for trivial local implementation choices.

Deliberate technical debt should state what was deferred, why it was deferred, its consequence or risk, and a concrete repayment trigger or condition. Avoid anonymous TODOs whose rationale and exit condition will be lost.

When a task is completed or cancelled, detailed implementation notes, acceptance proof, test evidence, outcome, and remaining boundary move to `HISTORY.md`. Keep only a short Notes stub when discoverability is useful. Durable `DEC`, `REQ`, and `RISK` records remain here when they still explain current or future work.

Completed-task stub example:

```text
## TASK-NNNN — Example completed task
- Status: completed
- Related: DEC-NNNN, REQ-NNNN
- Last updated: YYYY-MM-DD
- History: project-memory/HISTORY.md#task-nnnn--example-completed-task
```

No task details or durable records yet.
