# Test Evidence Output Contract

Use this shape for test strategy or verification reports.

```markdown
## Test Evidence

Goal/intent:
Failure mode or risk:
Scope:

## Sources Reviewed

- <path or command source>

## Selected Test Layers

- <layer>: <why this layer answers the risk>

## Test Map

- <command/evidence>: <prerequisites, default status, skip behavior, diagnostics>

## Regression Proof

- Baseline or old behavior:
- Candidate behavior:
- Result:
- Proven or provisional:

## Checks Run

- <command or evidence source>: <result and confidence gained>

## Checks Skipped

- <check>: <reason, impact, next safe way to run>

## Findings Or Gaps

- <test gap, flaky risk, missing fixture, weak assertion, or no finding>

## Human Decisions Required

- <risk acceptance, expensive/privileged check approval, scope choice, or none>

## Next Route

- <openplan-review | openplan-record | openplan-garden | openplan-handoff | bounded implementation task>

## Residual Risk

- <what remains unproven>
```

## BLOCKED Form

```markdown
BLOCKED: <one-line reason>

Missing evidence:
- <artifact, environment, command, fixture, or access>

Why it matters:
- <risk or failure mode that cannot be checked>

Next safe step:
- <what to provide or run>
```

## Quality Bar

- Every important claim cites a path, command, log, fixture, or explicit missing artifact.
- Checks skipped are as visible as checks run.
- Regression proof distinguishes proven coverage from provisional coverage.
- The report never uses approval language.
