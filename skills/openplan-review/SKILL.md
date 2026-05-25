---
name: "openplan-review"
description: "Review automated or YOLO-mode agent output using OpenPlan philosophy without requiring project-specific enforcement tools. Use for Codex or Claude Code automated review flows when changes, plans, generated docs, specs, code patches, skill/plugin artifacts, or multi-agent workflow results must be checked for minimal context, human decision boundaries, layered authority, role/mode separation, research-before-design, evidence-backed findings, reversible automation, and no silent approval. This is a read-only review skill, not an implementation or auto-fix skill."
---

# OpenPlan Review

Use this after `$openplan-core` to review automated agent work without becoming another ungoverned agent. The review must be evidence-backed, read-only by default, preserve dual-surface separation when present, and remain independent of any one platform's enforcement implementation.

## Core Rule

Do not approve, merge, commit, rewrite, or fix the work under review. Inspect, verify, classify, and report. If the user explicitly asks for fixes after the review, treat that as a separate task.

## Review Flow

1. Define scope from the user request and durable artifacts such as files, diffs, reports, logs, transcripts, or git metadata when available.
2. Load only context needed for review: request, changed artifacts, declared goal/intent/spec/plan if available, and any local project rules that directly constrain the artifact.
3. Identify what layer is being reviewed: goal/intent, design/rationale, plan/spec, implementation, review report, or generated skill/plugin surface.
4. Run safe deterministic checks only when they are available and proportionate. Treat checks as evidence sources, not approval gates.
5. Apply the invariant checklist in `references/invariants.md`.
6. Produce findings using `references/output-contract.md`.
7. Optionally validate the report shape:

```bash
python3 scripts/validate_review_report.py <report.md>
```

## YOLO/Auto Rules

- Prefer fail-closed reporting over guessing.
- Ask no broad clarification questions during unattended review; instead record `BLOCKED` with the exact missing artifact.
- Never use destructive commands (`git reset --hard`, branch checkout, deleting working directories, cleanup of untracked files).
- Do not rely on chat memory for state. Re-read durable artifacts where available.
- Do not treat passing tests as approval. Tests are evidence, not a decision.
- Do not treat reviewer non-blocking findings as automatic fix permission.
- Do not create human decisions. List them under `Non-Decisions`.

## Severity Model

- `P0`: false approval risk, data loss, security leak, broken authority flow, or review cannot establish what changed.
- `P1`: architectural/workflow contradiction, human decision bypass, mode/role boundary bypass, research skipped where required, generated workflow divergence.
- `P2`: test gap, stale reference, incomplete traceability, unclear ownership, missing evidence.
- `P3`: style, naming, wording, or maintainability issue with low behavioral risk.

## Platform Use

- Codex: install this folder as a Codex skill and invoke `$openplan-review`.
- Claude Code: use `assets/claude-code-command.md` as a slash command or reviewer-agent prompt.
- Any platform: keep the review read-only unless the human explicitly starts a separate fix task.
- For long auto/YOLO runs, finish with `$openplan-handoff` so the next agent gets a minimal snapshot instead of a transcript.

## References

- `references/invariants.md`: OpenPlan philosophy and review checklist.
- `references/output-contract.md`: required report shape.
- `references/platform-usage.md`: Codex and Claude Code integration notes.
