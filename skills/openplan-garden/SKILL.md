---
name: "openplan-garden"
description: "Inspect and improve documentation quality using OpenPlan-style document gardening. Use when Codex or Claude Code must check memory, docs, design notes, handoff snapshots, review reports, specs, or generated documentation for goal/intent drift, broken structure, missing rationale, stale claims, duplicated content, unclear authority, poor future-agent readability, zero-context comprehension gaps, or periodic documentation maintenance. This skill is platform-neutral and read-only by default; local link checkers and linters are optional evidence sources, not required gates."
---

# OpenPlan Garden

Use this after `$openplan-core` for document quality, periodic documentation maintenance, and semantic drift inspection. Garden is about preserving the clarity of human goal/intent over time.

## Core Rule

Garden first reports. It does not rewrite durable docs or memory unless the user explicitly asks for a cleanup/edit pass.

## What Garden Checks

1. Goal/intent clarity: can a future human or agent tell why this exists?
2. Authority clarity: is this source of truth, draft, handoff, review, or temporary brief?
3. Layer clarity: does it mix goal/intent, design, spec, implementation, and review without labels?
4. Rationale: are decisions explained, not just stated?
5. Staleness: are time-sensitive or superseded claims marked?
6. Duplication: is content copied where a reference would work?
7. Traceability: are important claims tied to sources or evidence?
8. Zero-context readability: can a competent reader understand it without the chat?
9. Human-decision boundary: does it record human decisions separately from agent suggestions?
10. Next-action clarity: does it say what should happen next, if anything?

## Periodic Garden Pass

Use garden as the periodic documentation cleanup workflow. A periodic pass checks:

- stale or superseded documents;
- duplicated rationale that should become references;
- missing or unclear authority labels;
- memory/docs conflicts;
- abandoned TODOs or unresolved questions;
- research/review/handoff artifacts that should be archived, promoted, or left alone;
- docs that no longer pass zero-context comprehension.

Garden first reports proposed cleanup. It may edit only when the user explicitly asks for a cleanup pass, and durable goal/intent changes still require `$openplan-record` and human confirmation through the human-facing coordinator.

## Workflow

1. Identify document type: memory, design, decision, spec, handoff, review, tutorial, temporary brief.
2. Load only the document and directly referenced context needed to judge it.
3. Run optional deterministic checks if available and safe.
4. Apply `references/checklist.md`.
5. Report findings using `references/report-contract.md`.
6. If the user requests cleanup, use `$openplan-record` before editing durable memory/docs.
7. For periodic maintenance, separate safe mechanical cleanup from human-owned meaning changes.

## Severity

- `G0`: misleading human goal/intent, wrong source of truth, or future agent likely to act incorrectly.
- `G1`: missing rationale, stale unmarked claim, authority/layer confusion, or broken decision boundary.
- `G2`: duplicated content, weak traceability, incomplete next action, or zero-context readability gap.
- `G3`: wording, formatting, title, or navigation improvement.

## Optional Checks

Use deterministic tools only when available:

- markdown link check;
- local docs linter;
- grep for TODO/stale/duplicate markers;
- template section checks.

If not available, continue with semantic review and state checks not run.

## Claude Code

Use `assets/claude-code-command.md` as a slash command or prompt seed.
