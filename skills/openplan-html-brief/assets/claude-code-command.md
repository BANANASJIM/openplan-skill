# OpenPlan HTML Brief

Create a temporary human-facing HTML frontend for agent work.

Rules:

1. Generate one self-contained HTML page.
2. Default to `/tmp/openplan-brief-<timestamp>.html`.
3. Do not commit it or treat it as source of truth.
4. Use it to show what happened, findings, evidence, human decisions, next action, and residual risk.
5. Keep it concise and readable; do not dump raw logs.
6. Escape embedded user/file content.
7. Do not include secrets or credentials.
8. If the content is also needed by another agent, create an OpenPlan handoff snapshot separately.

Layout:

- Header: title, timestamp, scope.
- Status strip: mode, result, risk, human decision needed.
- Summary bullets.
- Evidence cards.
- Findings or lessons.
- Human decisions.
- Next safe action.
- Residual risk.
