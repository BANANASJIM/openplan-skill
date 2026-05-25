---
name: "openplan-auto"
description: "Orchestrate OpenPlan-style skills in auto or YOLO mode while preserving human decision boundaries. Use when Codex, Claude Code, or another agent should automatically inspect, align enough to proceed, research, test, review, garden, summarize, hand off, or generate temporary HTML without silently approving, changing durable goal/intent, bypassing risk decisions, or pretending soft guidance is hard enforcement. This skill coordinates openplan-core, openplan-operate, openplan-align, openplan-research, openplan-test, openplan-review, openplan-garden, openplan-record, openplan-handoff, openplan-html-brief, and openplan-docs-init."
---

# OpenPlan Auto

Use this as the orchestration layer for unattended or low-interaction workflows.

## Core Rule

Auto mode can gather evidence, classify, review, summarize, and prepare proposals. It cannot make human-owned decisions, accept risk, approve changes, or silently mutate durable goal/intent.

## Skill Order

Default chain:

```text
core -> operate -> (align/research if needed) -> action/test/review/garden -> record proposal -> handoff -> html brief
```

Use only the stages needed.

| Stage | Skill | Auto Can Do | Must Stop For |
|---|---|---|---|
| Principles | `$openplan-core` | Apply invariants | Conflicting human/platform instruction |
| Startup | `$openplan-operate` | Load minimal context, choose mode | Destructive or broad action |
| Alignment | `$openplan-align` | Infer safe route, ask limited questions only as the human-facing coordinator | Scope/architecture/risk decision |
| Research | `$openplan-research` | Gather bounded evidence | Turning findings into decisions |
| Test | `$openplan-test` | Choose proportional checks, prove regression coverage, report skipped checks | Approval, merge/release, or risk acceptance |
| Review | `$openplan-review` | Read-only findings | Approval or fixes |
| Garden | `$openplan-garden` | Semantic doc report | Durable doc rewrite |
| Record | `$openplan-record` | Propose memory/docs updates | Ambiguous durable goal/intent update |
| Docs Init | `$openplan-docs-init` | Initialize governed document generation | Durable governance/design decision |
| Handoff | `$openplan-handoff` | Snapshot state | None, unless it would assert unverified facts |
| HTML | `$openplan-html-brief` | Temporary human frontend | Persisting or committing HTML |

## State Machine

1. `INIT`: read request and local instructions.
2. `CLASSIFY`: choose primary mode and surfaces.
3. `EVIDENCE`: collect minimal durable evidence.
4. `DECIDE_ROUTE`: bounded action, align, research, test, docs-init, review, garden, record proposal, handoff, HTML brief, or block.
5. `EXECUTE_SAFE`: perform read-only work or explicitly authorized writes inside scope.
6. `VERIFY`: run the proportional test, review, garden, or evidence check for the artifact touched.
7. `RECORD`: propose durable memory/docs updates only when warranted.
8. `HANDOFF`: write or emit a minimal continuation snapshot when work is long-running, cross-agent, blocked, or risky.
9. `REPORT`: summarize scope, evidence, actions, decisions needed, next safe action, and residual risk.
10. `STOP`: stop at the human decision boundary.

## Closed Loop

An auto run is closed only when every routed branch ends in one of these states:

- `completed in scope`: evidence and checks are reported, with no approval claim;
- `blocked`: the missing artifact, decision, or authority is named;
- `human decision required`: options and evidence are prepared, but no decision is made;
- `handoff emitted`: another agent/session can continue from a minimal snapshot;
- `disposable brief emitted`: HTML is clearly temporary and points back to durable artifacts.

Closure rules:

- If files are changed, run the relevant proportional check before reporting.
- If docs, memory, handoff, or generated documentation are touched, run `$openplan-garden` when in scope; otherwise report the skipped check, impact, and next safe action.
- If durable memory/docs should change, use `$openplan-record` as a proposal layer.
- If uncertainty affects route choice, use `$openplan-research` before design or execution.
- If broad docs generation starts, use `$openplan-docs-init` before writing durable docs.
- If bounded action changes implementation artifacts, verify with proportional checks and report no approval claim.
- If testing strategy, regression proof, or skipped-check meaning matters, route through `$openplan-test`.
- If review or garden reports blocking findings, do not auto-fix unless the original task explicitly authorized fixes in that scope.
- If a handoff or report contains facts another agent will rely on, include evidence paths and residual risk.

## Human Decision Boundaries

Stop and report instead of continuing when the next step requires:

- accepting or deferring risk;
- changing durable memory or source-of-truth docs from ambiguous input;
- approving, merging, releasing, or declaring success;
- choosing architecture or scope;
- bypassing a safety rule;
- destructive file or branch operation;
- conflicting instructions or unclear authority;
- source-of-truth conflict between docs, memory, specs, or code;
- a subagent needs human input;
- a check is unsafe, unavailable, or outside the allowed scope but materially affects confidence;
- review/garden returns a blocking finding and fixes were not explicitly authorized;
- expanding beyond the user's requested scope.

Report `BLOCKED` when progress requires a missing artifact, unavailable evidence source, unsafe/out-of-scope check, or inaccessible authority source.

Report `HUMAN_DECISION_REQUIRED` when progress requires a human choice, risk acceptance, scope/architecture decision, approval, bypass, or durable intent change.

## Auto-Allowed Work

Allowed by default when safe:

- read files;
- inspect diffs or provided artifacts;
- run non-destructive checks;
- perform explicitly authorized scoped writes;
- produce alignment summaries;
- produce review/garden reports;
- propose record updates;
- create handoff snapshots;
- create temporary HTML briefs under `/tmp`.

## Output Contract

At the end of an auto or YOLO-style run, report:

```markdown
Mode:
Scope:
Evidence collected:
Actions performed:
Findings/proposals:
Test evidence:
Checks run:
Checks skipped:
Human decisions required:
Blocked items:
Next safe action:
Handoff snapshot:
Temporary HTML brief:
Residual risk:
```

## References

- `references/orchestration.md`: detailed flow.
- `references/stop-rules.md`: stop conditions.
- `assets/claude-code-command.md`: Claude Code command/prompt seed.
