# Platform Usage

This skill is platform-neutral. Keep the protocol identical across Codex and Claude Code.

## Codex

Install as a Codex skill under:

```text
${CODEX_HOME:-$HOME/.codex}/skills/openplan-review
```

Invoke explicitly for review:

```text
Use $openplan-review to review the current diff against OpenPlan invariants.
```

Recommended behavior:

- read files and run safe checks;
- do not edit;
- report findings first;
- preserve untracked/dirty workspace state.

## Claude Code

Use the command assets as reviewer prompts, generated slash-command prompts, or pasted command prompts in auto review mode. The canonical command assets live under each `skills/openplan-*/assets/claude-code-command.md` file; avoid maintaining a partial hand-written list.

Recommended read-oriented tools:

```text
Read, Grep, Glob, Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(pixi run test:*), Bash(bun test:*), Bash(bats:*)
```

Avoid write tools for review-only mode. If the platform requires broader tool access in YOLO mode, the prompt must still state that the review is read-only and must not modify files.

## CI or Scheduled Review

For unattended review:

1. Mount the artifacts in a disposable workspace when possible.
2. Run deterministic checks only when safe and proportionate.
3. Run the LLM review prompt.
4. Validate report structure with `scripts/validate_review_report.py`.
5. Treat `BLOCKED`, `P0`, or `P1` as failing statuses.

The validator checks shape only. It does not prove correctness.
