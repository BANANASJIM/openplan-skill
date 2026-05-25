---
name: "openplan-record"
description: "Organize, update, and reconcile memory and documentation as human goal/intent records in an OpenPlan-style workflow. Use when Codex or Claude Code must classify or propose what belongs in memory, docs, handoff snapshots, review reports, or temporary briefs; when consolidating user preferences, project philosophy, design decisions, workflow constraints, or lessons learned; or when preventing agent inference from being recorded as the human goal/intent. This skill is for goal/intent preservation and documentation maintenance, not code implementation."
---

# OpenPlan Record

Use this after `$openplan-core` when conversation, review, or implementation output needs to become durable memory or documentation.

## Core Principle

Memory and docs represent the human goal/intent. Do not record agent guesses as the human goal/intent. If the source is not explicit, mark it as inference or pending confirmation.

## Record Types

| Type | Purpose | Lifetime | Examples |
|---|---|---|---|
| Memory | Standing human preference or operating constraint | Long-lived, compact | "Do not checkout without permission", "docs in Chinese" |
| Docs | Project source of truth and rationale | Long-lived, structured | architecture, workflow, ADR, conventions |
| Handoff | Cross-agent/session continuity | Short/medium-lived | current objective, blockers, next safe action |
| Review | Evidence-backed quality finding | Snapshot | blocking issue, residual risk |
| HTML brief | Temporary human frontend | Disposable | visual summary, teaching page |

## Update Flow

1. Classify the information:
   - explicit human goal/intent;
   - agent observation;
   - evidence-backed project fact;
   - temporary session state;
   - unresolved question.
2. Choose destination:
   - durable preference -> memory;
   - project rule/rationale -> docs;
   - current continuation state -> handoff;
   - quality issue -> review;
   - human-facing visualization -> HTML brief.
3. Resolve destination root:
   - memory location from platform or user instruction;
   - docs root such as `.openplan/`, `docs/`, repo root, separate docs repo, or user-provided path;
   - temporary output path for disposable briefs.
4. Preserve provenance:
   - source statement or artifact;
   - date/session when useful;
   - confidence;
   - scope.
5. Deduplicate before adding.
6. Mark stale or superseded entries instead of silently overwriting when history matters.
7. Before changing durable goal/intent from ambiguous input, ask only if this agent is the human-facing coordinator; otherwise report `Human decisions required`.

## Memory Rules

- Keep memory short and operational.
- Record only stable preferences, constraints, and project-level lessons.
- Do not store transient task progress in memory.
- Do not store secrets.
- Do not inflate memory with explanations that belong in docs.
- If a memory contradicts current docs, report the conflict instead of choosing silently.

## Docs Rules

- Docs carry rationale, structure, and shared project truth.
- Separate stable docs from drafts.
- Design/rationale changes need a decision record in projects that use decision records.
- Do not rewrite docs just to mirror conversation unless the human goal/intent is clear.
- Prefer references over duplicated content.
- Keep docs readable by a zero-context future agent or human.
- Treat docs paths as relative to the selected docs root. Do not assume project root.

## Output

When asked to update records, produce:

```markdown
Record classification:
Proposed destination:
Destination root:
Source evidence:
Exact update:
Requires human confirmation: yes/no
Staleness/conflict notes:
```

If editing is authorized, make the narrowest update and report the changed path.

Use `$openplan-garden` before broad documentation cleanup, and use it after cleanup when zero-context readability matters.

## References

- `references/record-policy.md`: detailed memory/docs decision policy.
- `references/update-contract.md`: update proposal and changelog contract.
- `assets/claude-code-command.md`: Claude Code prompt seed.
