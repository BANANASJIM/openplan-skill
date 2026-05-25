# OpenPlan-Style Initialization Protocol

This protocol is platform-neutral and treats local enforcement tooling as optional evidence.

## Step 1: Establish Instruction Stack

Respect instruction priority:

1. system/developer/platform instructions;
2. user request;
3. repo-local instructions;
4. skill/reference guidance;
5. inferred conventions.

If instructions conflict, follow the higher-priority instruction and report the conflict when it matters.

## Step 2: Locate Hot Memory

Load only immediately relevant hot memory:

- `AGENTS.md` for role and agent behavior;
- `CLAUDE.md` for Claude Code local memory;
- `RULES.md` for project constraints;
- `ENTRYPOINTS.md` for navigation;
- active plan/spec/review target.

Do not bulk-read archives unless the task specifically depends on history.

## Step 3: Detect Surfaces

Classify available artifacts:

- goal/intent/design/docs surface;
- plan/spec/task surface;
- implementation/code surface;
- review/evidence surface.

When two repos or surfaces exist, preserve their separation and compare drift explicitly.

Also identify the docs root when it matters. It may be `.openplan/`, `docs/`, repo root, a separate docs repo, or another user-provided path. Treat document-map paths as relative to that root.

## Step 4: Select Mode

Choose exactly one primary mode:

- `align`: clarify goal/intent;
- `research`: reduce uncertainty;
- `design`: propose architecture/rationale;
- `implement`: change artifacts;
- `review`: inspect and report;
- `operate`: coordinate or delegate;
- `blocked`: report missing prerequisite.

Mode can change after an explicit state update, but do not silently mix modes.

## Step 5: Define Safety Envelope

Before acting, know:

- what may be read;
- what may be written;
- what commands are safe;
- what decisions are reserved for the human;
- what evidence is required to finish.

In auto/YOLO mode, default to read-only unless the task explicitly authorizes writes.
