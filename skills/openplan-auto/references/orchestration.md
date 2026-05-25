# Auto Orchestration

## Minimal Flow

```text
openplan-core
  -> openplan-operate
  -> route:
      ambiguous -> openplan-align
      uncertainty -> openplan-research
      bounded action -> explicit scoped work
      test evidence -> openplan-test
      artifact review -> openplan-review
      doc quality -> openplan-garden
      docs generation init -> openplan-docs-init
      memory/docs update -> openplan-record proposal
      continuation risk -> openplan-handoff
      human presentation -> openplan-html-brief
  -> openplan-handoff if continuity matters
  -> openplan-html-brief if human visual presentation helps
```

## Closed Loop Definition

Every auto route must end as one of:

- completed in reviewed scope;
- blocked with missing evidence or authority named;
- human decision required with options and evidence;
- handoff emitted for continuation;
- disposable HTML brief emitted for human presentation.

Do not leave an auto run at "I changed things" or "looks good." Report evidence, checks run, checks skipped, next safe action, and residual risk.

## Common Recipes

### Auto Review A Patch

1. Core invariants.
2. Operate startup.
3. Review changed artifacts.
4. Handoff if there are blockers or next steps.
5. HTML brief if user needs a readable dashboard.

Do not fix in the same pass unless explicitly authorized.

### Auto Research A Risk

1. Core invariants.
2. Operate startup.
3. Define one research question and a stop condition.
4. Gather primary/local evidence.
5. Report implications without choosing the human-owned decision.

### Auto Garden Docs

1. Core invariants.
2. Operate startup.
3. Garden target docs.
4. Record proposal for durable updates.
5. Stop for explicit human confirmation if changing goal/intent.

### Auto Initialize Docs

1. Core invariants.
2. Align the documentation goal if unclear.
3. Run docs-init to propose the smallest governed scaffold.
4. Record only explicit human intent or evidence-backed project facts.
5. Garden generated docs before treating them as useful context.

### Auto Implement Within Explicit Scope

1. Core invariants.
2. Operate startup and confirm write scope was explicitly authorized.
3. Research only if uncertainty affects the route.
4. Make the narrow scoped change.
5. Use openplan-test to select proportional checks when test selection, regression proof, or skipped-check meaning matters.
6. Run the selected checks when safe and in scope.
7. Review or garden the touched artifact type.
8. Record only proposed durable memory/docs changes.
9. Handoff if continuation state matters.
10. Report residual risk without claiming approval.

## Blocked Versus Human Decision

Use `BLOCKED` when the missing prerequisite is evidence, access, an artifact, a safe check, or an authority source.

Use `HUMAN_DECISION_REQUIRED` when the missing prerequisite is a human choice: scope, architecture, risk acceptance, approval, bypass, or durable intent change.

### Auto Capture A Session

1. Core invariants.
2. Handoff snapshot.
3. Record only stable, explicit human preferences.
4. HTML brief for human reading if useful.

### Auto Teaching / Explanation

1. Core invariants.
2. Align audience and goal if unclear.
3. Generate temporary HTML brief.
4. Do not persist as docs unless requested.

## Composition Rule

Each stage should emit enough structured output for the next stage to consume without reading the whole transcript.
