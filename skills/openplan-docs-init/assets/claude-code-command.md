# OpenPlan Docs Init

Initialize a governed documentation surface before generating durable project docs.

Rules:

1. Start from human goal/intent and existing project authority.
2. Identify whether the target is a docs repo, code repo, single repo, or temporary report.
3. Identify the docs root: explicit path, existing convention, `.openplan/`, `docs/`, repo root, or separate docs repo.
4. Generate the smallest useful scaffold under that docs root.
5. Label assumptions and pending confirmations.
6. Keep docs/design authority separate from implementation artifacts.
7. Record an explicit human decision, or propose/request a decision record, when initialization changes durable governance or design.
8. Use OpenPlan Garden after broad generation and OpenPlan Record for durable memory/docs updates.
9. Ask the human only if you are the human-facing coordinator; otherwise report `Human decisions required`.
10. Use OpenPlan Research first when missing evidence affects generated docs.

Return the docs init mode, docs root, generated or proposed paths, authority sources, human decisions required, and residual risk.
