# Record Update Contract

Use this before changing memory or docs.

```markdown
# Record Update Proposal

## Trigger

## Classification

- explicit human goal/intent / project fact / agent observation / temporary state / unresolved question

## Destination

- memory / docs / handoff / review / html brief / no durable record

## Destination Root

- memory store / `.openplan/` / `docs/` / repo root / separate docs repo / user-provided path / temporary path

## Source Evidence

## Proposed Change

## Why This Destination

## Human Confirmation Needed

## Conflict or Staleness Notes
```

## Changelog After Editing

```markdown
Updated:
- path:
- reason:
- source:
- residual risk:
```

## Confirmation Rules

Human confirmation is required when:

- the update changes durable goal/intent;
- the source is inferred rather than explicit;
- memory and docs conflict;
- the update would supersede an existing rule;
- the update affects future automation behavior.

Only the active human-facing coordinator asks for that confirmation. Delegated agents record the need under `Human Confirmation Needed` or `Human decisions required`.

Human confirmation is not required when:

- the user explicitly asks to record a stated preference;
- the edit is a narrow typo/format correction;
- a handoff snapshot records current session state without changing durable goal/intent.
