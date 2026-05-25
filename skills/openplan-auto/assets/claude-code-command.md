# OpenPlan Auto

Run an automatic OpenPlan-style workflow while preserving human decision boundaries.

Order:

1. Apply OpenPlan core principles.
2. Initialize with minimal context.
3. Classify the mode and authority surfaces.
4. Collect durable evidence.
5. Route to align, research, docs-init, test, review, garden, record proposal, handoff, or HTML brief.
6. If files are changed, use proportional checks and report test evidence before reporting.
7. Route durable memory/docs changes through record proposals and docs through garden.
8. Handoff if blocked, cross-agent, long-running, or risky.
9. Stop at human decision boundaries.

Auto can:

- read and inspect;
- run safe checks;
- perform explicitly authorized scoped writes;
- produce reports;
- propose updates;
- create handoff snapshots;
- create temporary HTML briefs.

Auto cannot:

- approve;
- merge/release;
- accept risk;
- change durable goal/intent from ambiguous input;
- bypass safety;
- perform destructive cleanup;
- expand scope silently.

Final output:

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
