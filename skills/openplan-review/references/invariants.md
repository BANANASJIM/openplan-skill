# OpenPlan Review Invariants

Use this checklist to review agent output. A finding needs evidence from a durable artifact: file path, line, diff hunk, command output, report section, transcript excerpt, or explicit missing artifact.

## I1: Minimal Effective Context

- Agent work should load only task-relevant files.
- State must come from durable artifacts such as files, diffs, reports, logs, transcripts, or git metadata when available, not chat memory.
- Subtasks should have isolated context and ownership where the platform allows it.
- Coordinators should pass references and goal/intent, not large copied context.
- Repeated content across docs/spec/code is suspect; prefer path references.

Review questions:

- Did the agent edit or reason over unrelated areas?
- Did it duplicate upstream content instead of referencing it?
- Did parallel work share mutable state or visible context?

## I2: Human Is Final Decision-Maker

- Agent may suggest and execute assigned work, but must not make product, architecture, bypass, or acceptance decisions for the human.
- Dispatcher is the sole human-interactive agent in OpenPlan workflow.
- Sudo/HOTFIX/relaxed-mode choices are human decisions and require traceable evidence.
- Reviewer must not approve its own authored work.

Review questions:

- Did the agent silently approve, merge, accept, defer, or bypass?
- Did subagent output ask the human directly instead of routing via dispatcher?
- Did automated mode convert a recommendation into a decision?

## Layered Authority

Authority direction:

```text
goal/intent -> design/rationale -> plan/spec -> execution -> review evidence
```

Concrete OpenPlan repos implement this as docs layer -> OpenSpec layer -> code layer, but the skill does not require that exact file layout.

Review questions:

- Does a lower layer preserve the upstream goal/intent it implements?
- Did execution silently rewrite design or scope?
- Does the review cite the plan/spec/goal/intent it is judging against?
- Are provenance links present when the project expects them?

## Dual-Surface Separation

OpenPlan's concrete architecture uses a docs/design surface and a code/execution surface. Other projects may express the same separation as folders, specs, plans, tickets, or reports.

Review questions:

- Is the design/docs surface still the source of truth?
- Did implementation or generated config silently redefine upstream goal/intent?
- Does the review compare both surfaces when both are present?
- If only one surface is available, does the report state that limitation?

## Research Before Design

- If the problem is novel, externally dependent, high-risk, or architecture-affecting, research must precede design.
- Skipping NEEDS_RESEARCH is a P1 issue when the design rests on unresolved facts.

Review questions:

- Are assumptions presented as facts?
- Is there a research artifact or explicit reason research is unnecessary?
- Does the design include unknowns and verification path?

## Design Governance

- New unstable design should remain provisional until reviewed.
- Stable design changes need rationale, alternatives, and consequences.
- The exact artifact can be an ADR, decision note, design rationale, or another project-native decision record.

Review questions:

- Did design change without rationale?
- Is the decision record only a restatement of implementation?
- Does the change contradict an older decision without acknowledging it?

## Mode and Permission Boundaries

- Permissions and ownership should be explicit and configurable where the project has a config system.
- Hardcoded roles, paths, backend names, or permissions are suspect unless justified.
- Reviewers write reports, not code fixes.
- Implementers change assigned artifacts, not the upstream goal/intent.

Review questions:

- Did a mode write outside its declared responsibility?
- Does generated platform config preserve boundaries?
- Are permission assumptions visible enough to review?

## Platform Parity

- A lightweight platform adaptation should not silently weaken the philosophy.
- Platform-specific implementations may differ, but goal/intent, boundaries, review semantics, and human decision points should remain equivalent.

Review questions:

- Did the lightweight version drop a decision point or review meaning?
- Did generated platform behavior diverge from the declared protocol?
- Is generated output traceable to the source protocol?

## Auto Review Integrity

- Findings must come first.
- Each finding needs severity, evidence, impact, and suggested direction.
- "No findings" must mention residual risk and tests not run.
- The review must not become a patch.

Review questions:

- Is there enough evidence for each claim?
- Are missing artifacts reported as `BLOCKED` instead of guessed?
- Did the reviewer overstate confidence?
