---
name: "openplan-operate"
description: Initialize and run an OpenPlan-style agent session on Codex, Claude Code, or another agent platform. Use after openplan-core when a task needs startup discipline, behavior constraints, subagent delegation rules, mode selection, dual-surface awareness, or safe auto/YOLO execution before alignment, research, design, implementation, testing, or review. This skill is platform-neutral and treats enforcement checks as optional evidence, not prerequisites.
---

# OpenPlan Operate

Use this after `$openplan-core` when the agent is about to do work, delegate work, or run unattended.

## Session Init

1. Read the user's latest request.
2. Identify local instructions in this order when present:
   - system/developer instructions;
   - repository rules such as `AGENTS.md`, `CLAUDE.md`, `RULES.md`, `ENTRYPOINTS.md`;
   - task-specific specs, plans, or review targets.
3. Load only files needed for the next action.
4. Detect whether the project has two surfaces:
   - goal/intent/design/docs surface;
   - implementation/code/execution surface.
5. Identify configurable roots when present:
   - docs root such as `.openplan/`, `docs/`, repo root, separate docs repo, or user-provided path;
   - code root when separate from docs;
   - temporary output root for disposable briefs.
6. Classify the mode:
   - align;
   - research;
   - design;
   - implement;
   - test;
   - review;
   - operate/dispatch;
   - stop and report blocked.
7. State any assumption that affects the route, including assumed docs root.

## Behavior Constraints

- Understanding-only requests do not edit files.
- Review-only requests do not fix files.
- Auto/YOLO mode still must preserve human-owned decisions.
- Do not switch branches, delete untracked state, clean working directories, or perform destructive recovery unless explicitly asked.
- Prefer existing project infrastructure and language features.
- Avoid hardcoded roles, paths, permissions, or backend names when the project is config-driven.
- Avoid hardcoded documentation roots. Use the user-provided docs root or existing project convention before proposing `.openplan/`, `docs/`, or repo root.
- Keep comments and explanations minimal unless they clarify non-obvious logic.
- If a required artifact is missing, report the missing artifact and why it matters.

## Subagent Constraints

Use subagents only when delegation is explicitly requested or platform policy allows it for the task.

Subagents must receive:

- one concrete objective;
- minimal file/path context;
- read/write scope or read-only status;
- expected output contract;
- whether they may edit files;
- whether they may run commands;
- how to report blockers.

Subagents must not:

- ask the human directly when the parent is the interaction boundary;
- make acceptance, bypass, merge, scope, or architecture decisions;
- review their own authored work;
- expand scope without reporting;
- hide uncertainty;
- return ungrounded approval.

## Result Contract

Every delegated or automated operation should return:

```markdown
Objective:
Scope:
Actions taken:
Evidence:
Findings or output:
Open questions:
Human decisions required:
Residual risk:
```

## References

- `references/init-protocol.md`: detailed initialization checklist.
- `references/subagent-protocol.md`: delegation prompt and result contract.
- `assets/claude-code-command.md`: Claude Code command/prompt seed.

Use `$openplan-handoff` before ending a long session, delegating complex work, or crossing from one agent platform to another.

Use `$openplan-research` when the selected route depends on evidence that is not already in loaded durable context.
