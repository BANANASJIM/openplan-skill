# Portable Document Map

Use this map only when the project has no stronger convention. Prune it to the smallest structure that can preserve the next decision.

## Documentation Root

Choose a docs root before creating files. All paths below are relative to that root.

Common roots:

- `.openplan/` inside a code repo when OpenPlan-governed docs should stay separate from product docs.
- `docs/` when the project already uses docs as the documentation surface.
- repository root for a dedicated docs repo.
- any explicit relative/absolute path supplied by the user.
- a separate docs repository when the project uses dual repos.

Do not migrate existing docs into a new root unless the human explicitly asks.

## Docs Repo Surface

- `README.md`: entry point, navigation, and current status pointer.
- `design/`: principles, architecture, workflow, role definitions, lifecycle.
- `decisions/`: ADRs or decision records. Append new decisions instead of rewriting history.
- `planning/`: phases, roadmap, sequencing, open work.
- `conventions/`: naming, style, document rules, operating rules.
- `research/`: evidence and investigations. Archive or mark stale when superseded.
- `review/`: review reports and quality findings.
- `deviations/`: accepted exceptions with rationale and scope.
- `_agent/state/needs-snapshot.md`: compact cross-session goal/intent snapshot.
- `_templates/`: reusable shapes for specs, ADRs, reviews, handoffs, and reports.

## Code Repo Surface

- `openspec/` or equivalent: implementation-facing specs and tasks.
- `deviations/`: implementation exceptions that need later reconciliation.
- `review/`: code/spec review findings.
- `_agent/`: local session state, reports, and handoff snapshots.

Code repo artifacts should point back to docs/design authority instead of redefining it.

## Single Repo Surface

When docs and code live together, preserve the layers explicitly:

- goal/intent;
- design/rationale;
- decisions;
- implementation plan;
- code;
- review;
- handoff/memory.

Use headings, directories, or frontmatter labels so future agents can tell which layer they are reading.
