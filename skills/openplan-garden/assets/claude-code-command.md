# OpenPlan Garden

Inspect documentation for goal/intent drift, periodic maintenance needs, and future-agent readability.

Rules:

1. Read only the target docs and directly necessary references.
2. Identify the docs root when reviewing a surface: `.openplan/`, `docs/`, repo root, separate repo, or user-provided path.
3. Do not rewrite durable docs or memory unless explicitly asked.
4. Distinguish human goal/intent, agent inference, project fact, and temporary state.
5. Check authority, layer, rationale, staleness, duplication, traceability, zero-context readability, periodic maintenance needs, and next-action clarity.
6. Use optional deterministic checks only when available.
7. Report findings as G0/G1/G2/G3.

Output:

```markdown
# Garden Report

## Scope

## Docs Root

## Findings

## Checks Run

## Checks Not Run

## Maintenance Suggestions

## Suggested Record Updates

## Residual Risk
```
