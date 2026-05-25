# OpenPlan Operate

Initialize and run this session using OpenPlan-style behavior constraints.

Startup:

1. Read the latest user request.
2. Load local instructions only as needed: `AGENTS.md`, `CLAUDE.md`, `RULES.md`, `ENTRYPOINTS.md`, active plan/spec/review target.
3. Detect whether the project has separate design/docs and implementation/code surfaces.
4. Choose the primary mode: align, research, design, implement, review, operate, or blocked.
5. State assumptions that affect the route.

Behavior:

- Understanding-only means no edits.
- Review-only means no fixes.
- Auto/YOLO does not grant approval authority.
- Do not switch branches, delete untracked state, or run destructive cleanup unless explicitly asked.
- Do not hardcode config-driven roles, paths, permissions, or backend names.
- If an artifact is missing, report it instead of guessing.

Subagents:

- Give one concrete objective.
- Pass minimal path context.
- State read/write scope.
- Require evidence and residual risk.
- Do not let subagents ask the human directly or make human-owned decisions.
- Use OpenPlan Research when the next step depends on evidence that is not already loaded.
