---
name: "openplan-handoff"
description: Create a minimal OpenPlan-style handoff snapshot for cross-agent or cross-session continuity. Use when work must move between Codex, Claude Code, subagents, reviewers, auto/YOLO runs, or compacted sessions while preserving minimal context, human decisions, dual-surface state, evidence, blockers, next safe action, and residual risk. This skill creates handoff artifacts; it does not approve or continue the work itself.
---

# OpenPlan Handoff

Use this after `$openplan-core` and `$openplan-operate` when another agent or future session needs to resume without inheriting a long conversation.

## Snapshot Rule

A handoff snapshot is not a memory bank and not a full transcript. It is the smallest durable artifact that lets the next agent decide what to read and what not to assume.

## When To Create

- Before ending a long session.
- Before delegating to a subagent with non-trivial context.
- After an auto/YOLO review run.
- Before context compaction.
- When switching between Codex and Claude Code.
- When dual-surface state matters and the next agent must know which surface is authoritative.

## Snapshot Contents

Use `references/snapshot-template.md` unless the user gives a project-native template.

Required sections:

- Objective
- Current mode
- Authority surfaces
- Human decisions
- Non-decisions
- Artifacts touched or reviewed
- Evidence
- Open questions and blockers
- Next safe action
- Residual risk

## Rules

- Prefer path references over pasted content.
- Mark stale or unverified facts explicitly.
- Do not include secrets, credentials, or private tokens.
- Do not record guesses as decisions.
- Do not say approved; say reviewed scope and result.
- If dual repo or dual surface exists, record both surfaces separately.
- If no write occurred, say so.

## Claude Code

Use `assets/claude-code-command.md` as a slash command or prompt seed.

Use `$openplan-html-brief` when the same snapshot needs a human-friendly visual frontend.

Use `$openplan-record` when a handoff lesson should be promoted into durable memory or documentation.

Use `$openplan-garden` when a handoff or document needs a semantic quality check before another agent relies on it.
