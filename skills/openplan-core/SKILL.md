---
name: "openplan-core"
description: "Apply OpenPlan philosophy as a platform-neutral agent operating protocol. Use when Codex, Claude Code, or another coding agent must preserve OpenPlan-style principles without depending on project-specific enforcement tools: minimal effective context, human-owned decisions, dispatcher/subagent boundaries, evidence-backed state, separation of roles, authority flow from goal/intent and design to execution, reversible automation, and no silent approval."
---

# OpenPlan Core

Use this as the base layer for other OpenPlan-style skills. It is deliberately independent of any project-specific enforcement tooling or single agent platform.

Terminology: `goal` and `intent` are both valid. Use `goal` when emphasizing the desired outcome and verification. Use `intent` when emphasizing the human meaning, motivation, or decision behind that outcome.

## Core Invariants

1. Minimal effective context: load only what changes the next decision or review.
2. Human-owned decisions: agents may suggest and execute, but humans own acceptance, bypass, scope, and tradeoff decisions.
3. Externalized state: ground claims in files, diffs, reports, logs, or other durable artifacts, not chat memory.
4. Layered authority: goal/intent and design constrain specs/plans; specs/plans constrain execution; execution does not silently rewrite the goal/intent.
5. Dual-surface separation: when a project separates design/docs from implementation/code, preserve that separation and do not let execution redefine the source of truth.
6. Dispatcher boundary: only the active human-facing coordinator asks the human; subagents report `Human decisions required` or `BLOCKED` instead.
7. Role separation: alignment, research, design, implementation, review, recording, gardening, and handoff are different modes even when one agent performs them.
8. Evidence before confidence: every important claim needs observable support.
9. Reversible automation: prefer actions that can be inspected, interrupted, replayed, or rolled back.
10. No silent approval: "no findings" is not approval; it is a scoped review result.

## Enforcement Is Optional

Hooks, isolated workspaces, CI checks, and other enforcement layers can strengthen the philosophy, but they are not the philosophy itself. In a Codex or Claude Code skill, keep the invariants as behavior, evidence, and reporting even when enforcement is unavailable.

## Composition

Use this skill with:

- `$openplan-auto` for orchestrating automatic/YOLO workflows.
- `$openplan-operate` for session initialization, behavior constraints, and subagent delegation.
- `$openplan-align` for ambiguity and requirement shaping.
- `$openplan-research` for bounded evidence gathering before design or execution.
- `$openplan-docs-init` for governed documentation generation setup.
- `$openplan-review` for YOLO/auto-mode review.
- `$openplan-handoff` for cross-agent or cross-session snapshots.
- `$openplan-html-brief` for temporary human-facing HTML summaries.
- `$openplan-record` for maintaining memory and documentation as human goal/intent records.
- `$openplan-garden` for semantic document gardening and goal/intent drift checks.

When another OpenPlan skill conflicts with this one, follow this skill first and report the conflict.

## Operating Defaults

- If context is missing, say what is missing instead of filling the gap.
- If a decision belongs to the human, list it under non-decisions.
- If a task is too broad, split by responsibility or artifact.
- If review evidence is weak, lower confidence.
- If automation is running unattended, fail closed with a clear report.

## Reference

Read `references/principles.md` when you need the full checklist.

For Claude Code, use `assets/claude-code-command.md` as a slash command or prompt seed.
