# Record Policy

## What Belongs In Memory

Record in memory when the information is:

- explicitly stated by the human;
- stable across tasks;
- useful before reading repo docs;
- short enough to keep hot;
- about preference, behavior, or durable constraint.

Examples:

- "Never checkout branches without permission."
- "Commit messages must not include AI attribution."
- "Use Chinese for Obsidian vault notes and English for code/tests."

Do not record in memory:

- temporary task progress;
- a bug found once;
- long explanations;
- design details better kept in docs;
- agent guesses;
- credentials or secrets.

## What Belongs In Docs

Record in docs when the information is:

- project-specific truth;
- architectural rationale;
- workflow definition;
- convention;
- decision history;
- quality standard;
- something a future agent/human must understand in context.

Docs should include enough rationale to be understandable without the original chat.

Docs may live under `.openplan/`, `docs/`, repo root, a separate docs repo, or another user-provided path. Choose the existing or explicit docs root before proposing paths.

## What Belongs In Handoff

Record in handoff when the information is:

- current objective;
- work completed in this session;
- current blockers;
- next safe action;
- residual risk;
- artifact list.

Handoff is not long-term memory. Promote only stable lessons to memory/docs after review.

## Conflict Handling

When memory and docs disagree:

1. Identify both sources.
2. Determine whether one is stale.
3. Do not silently pick one.
4. If the conflict changes behavior, ask only if this agent is the human-facing coordinator; otherwise report `Human decisions required`.
5. Record resolution with provenance.

## Promotion Path

Use this path for learnings:

```text
observation -> handoff/review -> repeated or human-confirmed lesson -> memory or docs
```

One-off observations should not become permanent memory without confirmation.
