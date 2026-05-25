---
name: "openplan-research"
description: "Run bounded OpenPlan-style research before design, implementation, review, or documentation generation. Use when Codex or Claude Code must reduce uncertainty with evidence, compare options, inspect source material, or produce a research report without turning findings into human decisions, design approval, or durable intent."
---

# OpenPlan Research

Use this after `$openplan-core` and usually after `$openplan-align` when the next safe action depends on evidence that is not already in the loaded context.

## Core Rule

Research reduces uncertainty. It does not decide scope, architecture, acceptance, bypasses, or durable goal/intent.

## When To Use

Use this skill when:

- a claim affects design, safety, compatibility, cost, or user workflow;
- external facts, library behavior, standards, or platform behavior may have changed;
- competing approaches need evidence before design;
- generated docs need source material;
- a reviewer needs to know whether research was skipped or insufficient.

Do not use this skill to pad obvious work. If the needed fact is already in durable local context, cite it and continue.

## Research Flow

1. Define the research question.
2. State why the answer matters to the goal/intent.
3. Set a narrow scope and stop condition.
4. Identify source types:
   - local project docs/code;
   - official docs or primary sources;
   - direct experiments;
   - prior reports or handoffs;
   - external secondary sources, labeled as lower authority.
5. Gather evidence using the smallest source set that can answer the question.
6. Separate facts, observations, inferences, and recommendations.
7. Report confidence and residual uncertainty.
8. Route outcomes:
   - design implication -> human-facing coordinator or design task;
   - docs implication -> `$openplan-record` or `$openplan-docs-init`;
   - quality issue -> `$openplan-review`;
   - continuation risk -> `$openplan-handoff`.

## Source Rules

- Prefer primary sources and local durable artifacts.
- For current external facts, verify with up-to-date sources when the platform allows it.
- Cite files, commands, URLs, versions, dates, or experiment steps.
- Do not treat an LLM summary as a source.
- Do not promote research notes into source-of-truth docs without record/garden review.
- If evidence is missing, report `BLOCKED` instead of inventing a conclusion.

## Dispatcher Boundary

Only the active human-facing coordinator asks the human follow-up questions. A delegated researcher reports `Human decisions required`, `Open questions`, or `BLOCKED`.

## Output Contract

```markdown
Research question:
Why it matters:
Scope:
Sources reviewed:
Findings:
Inferences:
Options or implications:
Human decisions required:
Confidence:
Residual uncertainty:
Recommended next route:
```

## References

- `references/report-contract.md`: research report shape.
- `assets/claude-code-command.md`: Claude Code command/prompt seed.
