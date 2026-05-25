# Auto Stop Rules

Stop immediately and report `HUMAN_DECISION_REQUIRED` when:

- the next action changes durable goal/intent;
- an inferred preference would become memory;
- a design/rationale change lacks explicit human confirmation;
- risk acceptance is needed;
- a bypass or safety relaxation is needed;
- approval, merge, release, or success declaration is requested implicitly;
- destructive filesystem or branch action is needed;
- evidence is missing for a material claim;
- source-of-truth conflict affects behavior;
- a subagent needs human input;
- review or garden finds a blocking issue and fixes were not explicitly authorized;
- a required check is unsafe or outside allowed scope;
- multiple plausible routes have different costs or risks.

Use this shape:

```markdown
HUMAN_DECISION_REQUIRED

Reason:
Options:
Evidence:
Recommended next safe action:
```

Auto mode may still prepare options and evidence before stopping.

Stop immediately and report `BLOCKED` when:

- a required artifact cannot be found;
- evidence is unavailable or cannot be gathered safely;
- a required check is unsafe or outside allowed scope;
- the source of truth cannot be identified;
- local instructions conflict and no higher-priority instruction resolves the conflict;
- access or permissions prevent a scoped review or action.

Use this shape:

```markdown
BLOCKED

Missing prerequisite:
Why it matters:
Evidence:
Checks skipped:
Next safe action:
Residual risk:
```
