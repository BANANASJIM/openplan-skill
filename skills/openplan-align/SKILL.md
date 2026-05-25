---
name: "openplan-align"
description: "Clarify and structure ambiguous OpenPlan-style requests before research, design, implementation, or review. Use with OpenPlan philosophy when a user request is underspecified, strategically risky, solution-first, missing success criteria, or needs blind-spot analysis, advisor-style questions, route selection, or a needs-snapshot-style summary. This skill does not implement or review changes directly."
---

# OpenPlan Align

Use this after `$openplan-core` when the next safe action depends on understanding the goal/intent.

## Alignment Flow

1. Restate the user's request in one paragraph.
2. Separate facts from assumptions.
3. Walk the 7-layer funnel only as far as needed.
4. Identify blind spots and human decisions.
5. Recommend the next route: ask via the human-facing coordinator, research, design, implement, review, or stop.

## 7-Layer Funnel

| Layer | Question | Enough When |
|---|---|---|
| L1 WHY | Why does this need to exist? | Job-to-be-done is explicit |
| L2 WHO/WHERE | Who uses it and in what constraints? | Context and stakeholders are clear |
| L3 WHAT | What is in and out of scope? | Boundaries are explicit |
| L4 HOW macro | What modules or artifacts are involved? | Interfaces and ownership are named |
| L5 RISK | What might fail or be unknown? | Risks have a research or mitigation path |
| L6 VERIFY | How will success be checked? | Testable criteria exist |
| L7 DETAIL | What exact implementation detail matters? | Work is actionable |

Do not force all seven layers for a small request. Use the smallest depth that prevents a wrong next action.

## Output

For lightweight alignment:

```markdown
Goal/Intent:
Known facts:
Assumptions:
Blind spots:
Human decisions:
Recommended next route:
```

For formal alignment, use `references/alignment-contract.md`.

## Rules

- When the user gives a solution, identify what problem it solves unless already clear.
- Ask at most 1-3 questions only if this agent is the human-facing coordinator; otherwise list `Human decisions required`.
- Do not make the human's tradeoff decision.
- If enough is clear, proceed with a stated assumption instead of blocking.
- If evidence is missing, recommend research rather than inventing facts.

For Claude Code, use `assets/claude-code-command.md` as a slash command or prompt seed.
