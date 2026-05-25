# Subagent Protocol

Use this to delegate without leaking scope or decision authority.

## Delegation Prompt Shape

```text
Task: <one concrete objective>
Mode: read-only | edit | verify
Scope: <paths or artifacts>
Context: <minimal references, not pasted bulk content>
Allowed actions: <commands/tools or none>
Forbidden actions: <decisions, writes, destructive operations>
Output contract: <sections required>
Blocker rule: if missing <artifact>, report BLOCKED instead of guessing
```

## Good Delegation

- "Read these three skill folders and report whether they over-rely on hardgates."
- "Review this diff for human-decision bypasses; do not edit files."
- "Inspect this design and list unanswered risks; do not write the design."

## Bad Delegation

- "Understand the whole project."
- "Fix anything you find."
- "Approve whether this is ready."
- "Ask the user what to do."

## Result Contract

```markdown
Objective:
Scope:
Evidence reviewed:
Findings:
Actions taken:
Blocked items:
Human decisions required:
Residual risk:
```

## Parent Responsibilities

The parent agent remains responsible for:

- choosing the delegation boundary;
- integrating results;
- checking for conflicts between subagent outputs;
- preserving the human interaction boundary;
- not treating subagent confidence as approval.
