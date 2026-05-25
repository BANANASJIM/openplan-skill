# OpenPlan Skill

Portable OpenPlan-style Agent Skills for Codex, Claude Code, and other clients that support the `SKILL.md` standard.

This repository packages the OpenPlan philosophy as composable skills without requiring project-specific enforcement tooling. It covers intent alignment, bounded research, test evidence, dispatcher/subagent boundaries, dual-surface discipline, evidence-backed review, documentation governance, handoff, and safe auto/YOLO operation.

## Install

Quick start for first-time users:

```bash
git clone git@github.com:BANANASJIM/openplan-skill.git
cd openplan-skill
./install.sh
```

Then restart Codex, Claude Code, or GitHub Copilot CLI so the new skills are discovered. In Copilot CLI, you can also run `/skills reload`.

Install to Codex and Claude Code personal skill directories:

```bash
./install.sh
```

Default destinations for `./install.sh`:

- Codex: `${CODEX_HOME:-$HOME/.codex}/skills`
- Claude Code: `${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}`

Install to all supported personal skill directories, including GitHub Copilot CLI:

```bash
./install.sh --only all
```

Copilot CLI destination:

- GitHub Copilot CLI: `${COPILOT_SKILLS_DIR:-${COPILOT_HOME:-$HOME/.copilot}/skills}`

Install only one client:

```bash
./install.sh --only codex
./install.sh --only claude
./install.sh --only copilot
```

Install Claude project skills into the current repository:

```bash
./install.sh --only claude --claude-dir .claude/skills
```

Install Copilot CLI project skills into the current repository:

```bash
./install.sh --only copilot --copilot-dir .github/skills
```

If an existing `openplan-*` skill directory was not installed by this script, replacement requires explicit confirmation:

```bash
./install.sh --force
```

Existing installed skills are backed up before replacement. Backups are written to a sibling directory such as `~/.codex/skills.openplan-skill-backups/` so Codex, Claude, and Copilot do not discover backup folders as active skills.

If old skill names such as `openplan-yolo` or `openplan-doc-init` are still installed, the installer warns but does not delete them. Review those directories manually before removing them.

Generate optional Claude slash-command prompts:

```bash
./install.sh --commands-dir ~/.claude/commands
```

Validate the packaged skills:

```bash
./scripts/validate-skills
```

Run an isolated install smoke test:

```bash
./scripts/smoke-test
```

After installing new Codex skills, restart Codex so discovery reloads. Claude Code may also need a restart after a newly created top-level skills directory appears. In Copilot CLI, use `/skills reload` and `/skills info openplan-core` to confirm discovery.

## First Use

Start with the smallest skill that matches the job.

For a normal agent session:

```text
Use $openplan-core and $openplan-operate for this repo. Identify the goal, docs root, code surface, local instructions, and next safe route.
```

To initialize OpenPlan-style docs in a project without mixing them into product docs:

```text
Use $openplan-docs-init with docs root .openplan/ to initialize the minimal governed docs surface for this project. Preserve human goal/intent, label assumptions, and do not create broad empty scaffolding.
```

To run a safe automatic pass:

```text
Use $openplan-auto to inspect this repo, identify the docs root and code surface, run only bounded safe checks, and stop at human decision boundaries. End with checks run/skipped, next safe action, and residual risk.
```

To design or audit a project test framework:

```text
Use $openplan-test to map the project's test layers, prove regression tests are meaningful, classify skipped checks, and report residual risk without treating passing tests as approval.
```

To periodically clean up docs:

```text
Use $openplan-garden on docs root .openplan/ to check staleness, duplication, authority labels, memory/docs conflicts, and zero-context readability. Report first; do not rewrite durable intent unless explicitly asked.
```

To prepare a cross-session or cross-agent handoff:

```text
Use $openplan-handoff to create a minimal handoff snapshot with objective, docs root, authority surfaces, evidence, blockers, next safe action, and residual risk.
```

For Claude Code project-local installation:

```bash
git clone git@github.com:BANANASJIM/openplan-skill.git
cd openplan-skill
./install.sh --only claude --claude-dir /path/to/project/.claude/skills
```

For optional Claude slash-command prompts:

```bash
./install.sh --only claude --commands-dir ~/.claude/commands
```

For GitHub Copilot CLI personal installation:

```bash
./install.sh --only copilot
```

Inside Copilot CLI:

```text
/skills reload
/skills info openplan-core
Use the /openplan-core skill to apply OpenPlan principles before acting.
```

Recommended first project prompt:

```text
Use $openplan-auto. This is the first OpenPlan-style pass for the project. Treat docs root as .openplan/ unless existing project docs indicate a better root. Do not make human-owned decisions. If initialization is appropriate, route through $openplan-docs-init; if docs already exist, route through $openplan-garden and $openplan-record proposals only.
```

## Repository Layout

```text
openplan-skill/
├── skills/
│   ├── openplan-core/
│   ├── openplan-operate/
│   ├── openplan-align/
│   ├── openplan-research/
│   ├── openplan-test/
│   ├── openplan-docs-init/
│   ├── openplan-review/
│   ├── openplan-garden/
│   ├── openplan-record/
│   ├── openplan-handoff/
│   ├── openplan-html-brief/
│   └── openplan-auto/
├── install.sh
└── scripts/
    ├── validate-skills
    └── smoke-test
```

Each skill is a normal Agent Skill directory with `SKILL.md`. In this repo every skill also includes Codex `agents/openai.yaml` metadata and a Claude command seed under `assets/claude-code-command.md`; `references/` and `scripts/` are added only when useful. Claude Code consumes the same `SKILL.md` directories directly.

## Skill Set

| Skill | Purpose |
|---|---|
| `openplan-core` | Base invariants: minimal context, human-owned decisions, externalized state, role separation, dual-surface discipline, reversible automation. |
| `openplan-operate` | Session startup, mode selection, behavior constraints, and subagent delegation rules. |
| `openplan-align` | Clarify ambiguous requests and shape goal/intent before implementation or review. |
| `openplan-research` | Gather bounded evidence before design, implementation, review, or documentation generation. |
| `openplan-test` | Build proportional test evidence: test maps, regression proof, property/oracle/fixture strategy, and skipped-check risk. |
| `openplan-docs-init` | Initialize governed documentation generation before durable docs or memory are created. |
| `openplan-review` | Review automated or YOLO output without treating "no findings" as approval. |
| `openplan-garden` | Check docs, memory, handoffs, and reports for semantic drift, periodic maintenance needs, and future-agent readability. |
| `openplan-record` | Decide what belongs in memory, docs, handoff, review reports, or disposable briefs. |
| `openplan-handoff` | Create cross-agent or cross-session snapshots with evidence, blockers, next action, and risk. |
| `openplan-html-brief` | Produce temporary human-facing HTML summaries or teaching artifacts. |
| `openplan-auto` | Orchestrate the other skills in auto/YOLO mode while preserving human decision boundaries. |

## Philosophy

OpenPlan starts from a simple claim: the human goal/intent is the highest authority. Agents can research, structure, implement, test, review, summarize, and automate, but they do not own acceptance, bypass, scope, architecture, or tradeoff decisions.

The skill layer keeps the philosophy without depending on project-local enforcement. The core invariants are:

1. Minimal effective context: load only what changes the next decision or review.
2. Human-owned decisions: agents may recommend and execute; humans decide acceptance, bypass, scope, and tradeoffs.
3. Externalized state: important claims must point to files, diffs, logs, reports, or other observable artifacts.
4. Layered authority: goal/intent and design constrain plans; plans constrain execution; execution must not silently rewrite the goal.
5. Dual-surface discipline: when docs/design and code/execution are separate, preserve that separation.
6. Dispatcher boundary: only the active human-facing coordinator asks the human; subagents report `Human decisions required` or `BLOCKED`.
7. Role separation: alignment, research, design, implementation, testing, review, recording, gardening, and handoff are different modes even when one agent performs several of them.
8. Evidence before confidence: review findings and progress claims need scoped evidence.
9. Reversible automation: unattended work should be inspectable, interruptible, replayable, and recoverable.
10. No silent approval: a scoped review result is not human approval.

## Dispatcher And Subagents

OpenPlan uses a dispatcher boundary even on ordinary agent platforms:

- The dispatcher is the only human-facing coordinator.
- Subagents receive bounded work; they do not ask the human directly.
- Subagents report needed decisions instead of converting questions into decisions.
- Subagents do not make acceptance, bypass, merge, scope, or architecture decisions.
- Reviewers do not review their own authored work.
- Subagent confidence is evidence, not approval.

A subagent prompt should include:

```markdown
Objective:
Scope:
Minimal context:
Read/write status:
Allowed actions:
Forbidden actions:
Output contract:
Blocker rule:
```

A subagent result should include:

```markdown
Objective:
Scope:
Actions taken:
Evidence:
Findings or output:
Open questions:
Human decisions required:
Residual risk:
```

## Research

Research is a first-class mode because OpenPlan separates "what is true" from "what we choose." Use `openplan-research` before design, implementation, review, or documentation generation when uncertainty affects architecture, safety, compatibility, cost, or user workflow.

- Define one bounded research question.
- Prefer local source-of-truth files, official docs, primary sources, and direct experiments.
- Separate findings, inferences, options, and human-owned decisions.
- Do not turn research findings into approval, scope changes, or durable intent.

## Testing

Testing is evidence, not approval. Use `openplan-test` when a project needs a test framework, regression proof, or a clear account of checks run/skipped.

- Map project-native test layers before inventing new commands.
- Keep default checks stable, repeatable, and proportionate.
- Separate privileged, slow, flaky, external, or environment-touching checks from fast local checks.
- Prove regression tests fail against the old behavior or an equivalent baseline before calling them proven.
- Treat property, metamorphic, fixture, corpus, and independent-oracle tests as ways to reduce self-deception.
- Report skipped checks and residual risk as visibly as checks run.

## Dual Repo And Dual Surface

OpenPlan distinguishes goal/intent/design authority from implementation/execution. This remains true in a single repo:

- If a project has a docs repo and a code repo, treat docs/design as upstream authority and code as downstream execution.
- If a project has one repo, still separate goal/intent, design, plan, implementation, review, and memory as distinct layers.
- Do not let code changes silently change the user's goal or documented rationale.
- When a durable design change is needed, surface it as a human decision and record the rationale in the appropriate document layer.

The optional environment names `OPENPLAN_DOCS_REPO` and `OPENPLAN_CODE_REPO` may help an agent locate those surfaces, but the skills do not require them.

## Documentation Location

Documentation location is configurable. OpenPlan skills use a "docs root" instead of assuming docs live at the project root.

Valid docs roots include:

- `.openplan/` in the project root, useful when OpenPlan-governed docs should stay separate from product docs;
- `docs/` when the project already uses that convention;
- repository root for a dedicated docs repo;
- a separate docs repository;
- any relative or absolute path explicitly supplied by the human.

When a docs root is selected, document-map paths are relative to that root. For example, with `Docs root: .openplan/`, `design/` means `.openplan/design/` and `decisions/` means `.openplan/decisions/`.

Example invocation:

```text
Use $openplan-docs-init with docs root .openplan/ to initialize the minimal governed docs surface.
```

If no docs root is specified, the agent should discover existing conventions before proposing one. It should not migrate or rewrite existing docs into a new root without an explicit human decision.

## Documentation Generation

Documentation generation has its own initialization step. Use `openplan-docs-init` before creating durable docs, memory, templates, or project knowledge at scale.

The rule is: initialize authority first, then generate content.

- Identify whether the target is a docs repo, code repo, single repo, or disposable report.
- Identify the docs root before proposing paths.
- Map each generated file to explicit human intent, existing docs, code evidence, or labeled inference.
- Generate the smallest useful scaffold.
- Do not copy OpenPlan internal docs into a project as if they were project truth.
- Do not create many empty files to simulate maturity.
- If generated docs affect future automation behavior, treat that as a human-owned decision.

## Documentation Governance

OpenPlan treats memory and documentation as records of human intent:

- Durable memory contains stable human preferences and operating constraints, not transient progress.
- Project docs carry source-of-truth structure, rationale, and decision history.
- Design changes should have decision records when the project uses decision records.
- Handoff snapshots preserve the minimum state needed for another agent or future session to continue safely.
- Review reports are scoped evidence, not approval.
- HTML briefs are disposable frontends for human reading; they should not become persistent project truth unless the human explicitly asks.
- Agent inference must be labeled as inference and must not be recorded as human intent without confirmation.

Use `openplan-garden` for regular document garden passes: staleness checks, duplicate cleanup proposals, archive/promote suggestions, memory/docs conflict checks, and zero-context readability review. Garden reports first. It edits only when explicitly asked, and durable intent changes still route through `openplan-record`.

## Auto And YOLO Mode

OpenPlan does not reject automation. It rejects automation that hides decisions.

Use the skills as a soft control loop. Route conditionally; do not run unnecessary stages just because they appear in this list:

```text
openplan-core
  -> openplan-operate
  -> openplan-align when the request is ambiguous
  -> openplan-research when uncertainty affects the next action
  -> openplan-docs-init before broad documentation generation
  -> perform the bounded task only with explicit scope
  -> openplan-test when testing evidence, regression proof, or skipped-check risk matters
  -> openplan-review for scoped evidence-backed review
  -> openplan-garden when docs or memory are touched
  -> openplan-record for durable memory/docs updates
  -> openplan-handoff when work crosses agents or sessions
  -> openplan-html-brief when a human needs a temporary visual summary
```

Auto mode must stop or report when it encounters a human-owned decision, unclear source of truth, destructive action, missing evidence, or residual risk that changes the meaning of the goal.

An auto run is closed only when it ends in a scoped report, a blocked state, a human-decision-required state, a handoff snapshot, or a disposable HTML brief. If it changes files, it must run proportional checks before reporting. If it touches docs or memory, it must route through garden/record when in scope, or report skipped checks, impact, and next safe action rather than silently rewriting durable intent.

## Capability Boundaries

| Capability | Plain skills provide |
|---|---|
| Intent alignment | Prompts, contracts, stop rules, and explicit questions. |
| Research | Bounded evidence reports with sources, inferences, confidence, and residual uncertainty. |
| Testing | Proportional test maps, regression proof, skipped-check reports, and test evidence without approval claims. |
| Subagent organization | Delegation protocol and result contract. |
| Review | Read-only evidence-backed findings. |
| Documentation garden | Semantic checks, periodic maintenance reports, and optional local linters. |
| Memory/docs update | Classification and provenance rules. |
| Handoff | Minimal cross-agent/session snapshot. |
| HTML presentation | Disposable human-readable frontend artifacts. |
| Enforcement | Not provided; the human-facing coordinator asks, while subagents report boundaries and required decisions. |

If a host project has stronger local rules, those rules win. These skills should adapt to the project rather than overwrite it.

## OpenPlan Coverage

This package maps OpenPlan philosophy into portable skills rather than copying OpenPlan implementation tooling.

| OpenPlan idea | Portable skill coverage |
|---|---|
| Goal/intent as highest authority | `openplan-core`, `openplan-align`, `openplan-record` |
| Minimal effective context | `openplan-core`, `openplan-operate`, `openplan-handoff` |
| Dispatcher-only human interaction | `openplan-core`, `openplan-operate`, `openplan-auto` |
| Subagent scoped delegation and result contracts | `openplan-operate`, `openplan-handoff`, `openplan-auto` |
| Dual repo / dual surface authority | `openplan-core`, `openplan-operate`, `openplan-docs-init`, `openplan-review` |
| Docs/design before implementation | `openplan-align`, `openplan-research`, `openplan-docs-init`, `openplan-review` |
| Research before risky design | `openplan-research`, `openplan-review` |
| Test evidence and regression proof | `openplan-test`, with `openplan-review` consuming the evidence |
| Documentation generation initialization | `openplan-docs-init`, then `openplan-garden` and `openplan-record` |
| Periodic documentation garden | `openplan-garden`, with `openplan-record` for durable updates |
| Memory/docs as human-intent records | `openplan-record`, `openplan-garden` |
| Evidence-backed review, no silent approval | `openplan-test`, `openplan-review`, `openplan-auto` |
| Auto/YOLO closed loop | `openplan-auto`, with `test/review/garden/record/handoff/html` terminal routes |
| Cross-agent/session continuity | `openplan-handoff` |
| Human-readable temporary frontend | `openplan-html-brief` |
| Implementation enforcement and hard gates | Not included; reported as boundaries, checks, and residual risk |

Intentionally not skillized as enforcement: hooks, worktree creation, merge gates, git notes, sandbox policy, and other project-specific automation. The skills preserve the philosophy and make missing enforcement visible.

## Claude Code Compatibility

Claude Code supports Agent Skills in:

- personal scope: `~/.claude/skills/<skill-name>/SKILL.md`
- project scope: `.claude/skills/<skill-name>/SKILL.md`

This repo installs the same `skills/openplan-*` directories into those locations. Optional command shims can be generated from each skill's `assets/claude-code-command.md`, but native Claude skills are the primary path.

## Codex Compatibility

Codex discovers skills from `${CODEX_HOME:-$HOME/.codex}/skills/<skill-name>/SKILL.md`. The packaged skills also include `agents/openai.yaml` metadata for Codex UI surfaces.

## GitHub Copilot CLI Compatibility

Copilot CLI discovers personal skills from `${COPILOT_HOME:-$HOME/.copilot}/skills/<skill-name>/SKILL.md`. It also supports project skills under `.github/skills/<skill-name>/SKILL.md`, `.claude/skills/<skill-name>/SKILL.md`, or `.agents/skills/<skill-name>/SKILL.md`.

Use `/skills reload` after installing during an active session, then `/skills info openplan-core` to verify loading. To force use of a skill, reference it with a slash name, such as `Use the /openplan-test skill to map this project's test layers.`

## License

MIT. See `LICENSE`.

## What This Repo Does Not Do

- It does not install project-specific enforcement tools.
- It does not install project hooks or hard gates.
- It does not create isolated workspaces.
- It does not replace a docs repo or code repo.
- It does not grant agents permission to approve their own work.

This repo is the portable philosophy and workflow layer.
