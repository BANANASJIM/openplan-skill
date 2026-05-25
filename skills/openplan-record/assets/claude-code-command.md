# OpenPlan Record

Organize and update memory or documentation while preserving the human goal/intent.

Rules:

1. Memory and docs represent the human goal/intent.
2. Do not record agent guesses as the human goal/intent.
3. Classify the information before editing:
   - explicit human goal/intent;
   - project fact;
   - agent observation;
   - temporary state;
   - unresolved question.
4. Choose the right destination:
   - memory for stable preferences and operating constraints;
   - docs for project truth and rationale;
   - handoff for session continuity;
   - review for findings;
   - HTML brief for temporary human visualization.
5. Preserve source evidence and scope.
6. Deduplicate before adding.
7. Before changing durable goal/intent from ambiguous input, ask only if you are the human-facing coordinator; otherwise report `Human decisions required`.

Output an update proposal before making durable changes unless the user explicitly requested the exact update.
