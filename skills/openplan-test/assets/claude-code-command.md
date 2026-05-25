# OpenPlan Test

Design, run, and report a proportional test evidence framework.

Rules:

1. Start from the human goal/intent and the concrete failure mode.
2. Read only local test instructions, build scripts, CI config, and nearby tests needed for the risk.
3. Choose the smallest useful test layers: fast local, safety/adversarial, integration, end-to-end, oracle/property/metamorphic/fixture/corpus.
4. For regression tests, prove they fail on the old behavior or an equivalent baseline and pass on the candidate fix.
5. Mark unproven regression coverage explicitly.
6. Report checks run, checks skipped, skip reason, confidence gained, and residual risk.
7. Do not treat passing tests as approval, merge permission, release permission, or risk acceptance.
8. Route review evidence to OpenPlan Review, durable conventions to OpenPlan Record, and continuation risk to OpenPlan Handoff.

Return a test evidence report with goal, risk, selected layers, commands or evidence sources, regression proof, skipped checks, human decisions required, and residual risk.
