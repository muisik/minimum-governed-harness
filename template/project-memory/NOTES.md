# Notes

Open or planned task detail, durable rationale, decisions, requirements, risks, source provenance, and implementation context.

Search by exact `TASK-####`, `DEC-####`, `REQ-####`, or `RISK-####` ID. Do not read this file in full by default. Each record requires `Status`, `Related`, and `Last updated`.

Accepted decisions should also identify where the resulting current truth is reflected.

When useful, an open task detail may include its governing invariant, external handoff references, acceptance detail, and code or test boundaries that cannot safely carry native comments.

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
