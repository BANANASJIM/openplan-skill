---
name: "openplan-docs-init"
description: "Initialize OpenPlan-style documentation generation before durable docs, memory, specs, or project knowledge are created. Use when Codex or Claude Code must bootstrap a docs repo, add OpenPlan-style docs to an existing repo, create initial doc maps/templates/needs snapshots/decision records, or prepare a project for document generation while preserving human goal/intent, dual-surface authority, ADR discipline, and garden/review follow-up."
---

# OpenPlan Docs Init

Use this after `$openplan-core` and usually after `$openplan-align` when a project needs an initial governed documentation surface before agents start generating durable docs.

## Core Principle

Document generation begins with authority and provenance, not with a pile of files. Generated docs must not present agent assumptions as human intent.

## When To Use

Use this skill when asked to:

- initialize an OpenPlan-style docs repo;
- add OpenPlan-style documentation governance to an existing code repo;
- create a minimal document map before generating project docs;
- seed needs snapshots, decision records, templates, or planning docs;
- prepare memory/docs for future Codex, Claude Code, or subagent sessions.

Do not use it for ordinary documentation edits after the document structure already exists. Use `$openplan-record` and `$openplan-garden` for that.

## Init Flow

1. Identify the target surface:
   - docs repo;
   - code repo;
   - single-repo project;
   - temporary teaching/reporting surface.
2. Identify authority sources:
   - explicit human goal/intent;
   - existing docs/design/ADR files;
   - code evidence;
   - prior handoff or needs snapshot;
   - agent inference.
3. Decide the minimum document map needed for the next phase.
4. Before creating durable docs, state:
   - what will be generated;
   - which source backs each file;
   - what is inferred or pending confirmation;
   - whether the file is source of truth, draft, handoff, review, or disposable.
5. Generate only the smallest useful scaffold unless the user explicitly asks for a broader docs package.
6. Record an explicit human decision, or propose/request a decision record, when initialization creates or changes durable design/governance.
7. Seed a needs snapshot when the human goal/intent or project direction must survive across agents or sessions.
8. Run `$openplan-garden` after broad generation and `$openplan-record` for durable memory/docs updates.
9. Use `$openplan-research` first when the docs scaffold depends on facts not already backed by local durable context.

## Minimal Document Map

Use project conventions first. If no convention exists, start from this map and prune aggressively:

| Path | Purpose | Durable |
|---|---|---|
| `README.md` or docs index | Entry point and navigation | yes |
| `design/` | Goal, principles, architecture, workflow | yes |
| `decisions/` | ADRs or decision records | yes |
| `planning/` | Roadmap, phases, open work | yes |
| `conventions/` | Naming, style, workflow rules | yes |
| `research/` | Evidence and investigations | medium-lived |
| `review/` | Review reports and findings | snapshot |
| `deviations/` | Accepted exceptions and rationale | durable until superseded |
| `_agent/state/needs-snapshot.md` | Cross-session intent snapshot | short/medium-lived |
| `_templates/` | Reusable document shapes | yes |

For a code repo, keep implementation specs and task artifacts separate from upstream design authority. For a docs repo, keep implementation notes out unless they explain documentation infrastructure.

## Generation Rules

- Do not copy OpenPlan internal docs into the target project as if they were project truth.
- Do not create many empty files to simulate maturity.
- Do not promote a draft into source of truth without explicit human confirmation.
- Mark assumptions as `Assumption`, `Inference`, or `Pending confirmation`.
- Prefer links and short summaries over duplicated rationale.
- If `design/` changes are introduced in an ADR-governed project, create or request a matching decision record.
- If docs and code disagree, report the conflict instead of choosing silently.
- If the generated docs affect future automation behavior, surface that as a human-owned decision.

## Stop Conditions

Stop and ask/report when:

- the human goal/intent is unclear;
- the target surface is ambiguous;
- generation would overwrite existing docs;
- the initial document map changes governance or architecture;
- a durable decision is needed but no human decision exists;
- the repo already has stronger local documentation governance and this skill would conflict with it.

Only the active human-facing coordinator asks the human. A delegated agent reports `Human decisions required` or `BLOCKED` with the missing decision.

## Output Contract

```markdown
Docs init mode:
Target surface:
Authority sources:
Generated/proposed paths:
Assumptions:
Human decisions required:
Follow-up skills:
Residual risk:
```

If editing is authorized, make the narrowest scaffold and report the changed paths.

## References

- `references/doc-map.md`: portable docs surface map.
- `references/init-contract.md`: initialization report and scaffold contract.
- `assets/claude-code-command.md`: Claude Code command/prompt seed.
