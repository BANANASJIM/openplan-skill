# OpenPlan Core Checklist

## Minimal Effective Context

- Load context by relevance, not by availability.
- Prefer paths and stable references over copied content.
- Treat context bloat as a coupling smell.
- Re-read durable state instead of relying on conversation state.

## Human-Owned Decisions

Humans own:

- product goals;
- architecture tradeoffs;
- scope changes;
- acceptance of risk;
- bypasses;
- merge/release/approval decisions.

Agents own:

- investigation;
- structured recommendations;
- assigned execution;
- evidence collection;
- review reports.

## Layered Authority

Use this conceptual flow even outside OpenPlan repos:

```text
goal/intent -> design/rationale -> plan/spec -> implementation -> review evidence
```

Lower layers may cite upper layers. Lower layers should not silently redefine upper layers.

## Dual-Surface Separation

OpenPlan's concrete form is dual repo:

```text
docs/design surface -> implementation/code surface
```

This is not a mandatory implementation for every project, but the separation is core philosophy:

- keep goal/intent, rationale, and decisions distinct from execution artifacts;
- let execution cite upstream authority instead of rewriting it;
- review drift between the surfaces explicitly;
- if a project has separate docs and code repos, do not collapse them into one mental model;
- if a project has one repo, preserve the same separation through folders, specs, plans, or reports.

## Separation of Modes

- Alignment asks what should be true.
- Research finds what is true.
- Design decides a coherent approach for human review.
- Implementation changes artifacts.
- Review checks evidence against expectations.

Do not mix these modes without saying so.

## Dispatcher Boundary

- The active human-facing coordinator may ask the human concise questions.
- Subagents, reviewers, and delegated workers do not ask the human directly.
- A delegated agent reports `Human decisions required` or `BLOCKED` with evidence when a human decision is needed.
- Human-facing coordination is a role boundary, not a permission to approve, bypass, or accept risk.

## Evidence and Traceability

Good evidence:

- file path and line;
- diff hunk;
- command output;
- test result;
- structured report;
- explicit user statement.

Weak evidence:

- memory of a previous chat;
- inferred goal/intent without confirmation;
- "seems fine";
- passing tests without scope statement.

## Automation Discipline

In auto or YOLO mode:

- inspect before acting;
- avoid irreversible operations;
- write reports before fixes;
- separate review from remediation;
- report blocked states explicitly;
- never convert absence of findings into approval.
