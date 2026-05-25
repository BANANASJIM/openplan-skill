# OpenPlan Handoff

Create a minimal cross-agent or cross-session handoff snapshot.

Rules:

1. Do not continue or approve the work.
2. Summarize only what the next agent needs to resume safely.
3. Use path references instead of pasted bulk content.
4. Separate human decisions from non-decisions.
5. Separate authority surfaces when present:
   - goal/intent/design/docs;
   - plan/spec;
   - implementation/execution;
   - review/evidence.
6. Mark stale or unverified facts.
7. Include next safe action and residual risk.

Output:

```markdown
# Handoff Snapshot

## Objective

## Current Mode

## Authority Surfaces

## Human Decisions

## Non-Decisions

## Artifacts Touched or Reviewed

## Evidence

## Open Questions and Blockers

## Next Safe Action

## Residual Risk

## Staleness Notes
```
