# Review Output Contract

Use this structure for final review reports.

## If Findings Exist

```markdown
## Findings

### P1: Short Finding Title

- Evidence: `path/to/file.ext:line` or command/diff reference
- Invariant: Which OpenPlan rule was violated
- Impact: What can go wrong
- Recommendation: Direction only, not an auto-fix unless separately requested
- Confidence: high|medium|low

## Open Questions

## Tests / Checks Run

## Residual Risk
```

Order findings by severity: P0, P1, P2, P3.

## If No Findings

```markdown
No blocking findings.

## Tests / Checks Run

## Residual Risk
```

Always state checks not run. Do not say "approved"; say "no findings in reviewed scope".

## BLOCKED Form

Use this when the review cannot proceed safely:

```markdown
BLOCKED: <one-line reason>

Missing artifact:
- <path or command>

Why it matters:
- <OpenPlan invariant or review dependency>

Next safe step:
- <what a human or dispatcher should provide>
```

## Evidence Rules

- Prefer exact local file links and line numbers.
- Do not quote long source passages.
- If line numbers are unstable, cite function/section and command used.
- Never invent a path or commit.
- Mark inference explicitly.
