---
name: "openplan-html-brief"
description: Create a temporary human-facing HTML frontend for OpenPlan-style agent work. Use when an agent needs to present what it did, what it found, what decisions remain, a handoff snapshot, an auto-review report, or a compact teaching/explanation artifact in a clearer visual format. Generate disposable, self-contained HTML for human reading; do not treat it as persistent project documentation or a committed artifact unless the user explicitly asks.
---

# OpenPlan HTML Brief

Use this as a better temporary frontend for human understanding. It turns agent output into a concise, readable HTML page.

## Default Behavior

- Generate a single self-contained `.html` file.
- Default location: `/tmp/openplan-brief-<timestamp>.html`.
- Do not add it to git.
- Do not place it in the project repo unless the user explicitly asks.
- Do not make it the source of truth. It is a visual summary over durable artifacts.
- If file writing is unavailable, return the HTML in a fenced code block.

## Good Uses

- Summarize what an agent did.
- Present auto-review findings.
- Teach a project concept visually.
- Show a handoff snapshot to a human.
- Compare goal/intent/design/spec/code surfaces.
- Explain next safe actions and human decisions.

## Page Shape

Keep it simple:

1. Header: title, timestamp, scope.
2. Status strip: mode, result, risk level, human decision needed.
3. Main summary: 3-6 bullets.
4. Evidence cards: paths, commands, reports, or missing artifacts.
5. Findings or lessons: grouped by severity or topic.
6. Human decisions: explicit non-automated decisions.
7. Next safe action.
8. Residual risk.

## Frontend Rules

- Use plain HTML/CSS/JS only.
- Inline CSS; avoid external CDN dependencies.
- Responsive layout, readable on laptop and mobile.
- No heavy decoration, no marketing hero, no gradients unless useful for status.
- Prefer tables for comparisons, cards for repeated findings, and callouts for decisions/blockers.
- Keep text concise; do not dump raw logs.
- Escape user/file content before embedding.
- Do not include secrets or credentials.

## Visual Semantics

Use calm status colors:

- green: no blocking findings;
- amber: attention or uncertainty;
- red: blocked/P0/P1;
- blue/gray: informational.

Do not let color be the only signal; include text labels.

## Minimal Template

```html
<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>OpenPlan Brief</title>
<style>
  :root { color-scheme: light; font-family: Inter, ui-sans-serif, system-ui, sans-serif; }
  body { margin: 0; background: #f6f7f9; color: #1f2937; }
  main { max-width: 1080px; margin: 0 auto; padding: 28px; }
  header { margin-bottom: 18px; }
  h1 { margin: 0 0 6px; font-size: 28px; letter-spacing: 0; }
  h2 { margin: 22px 0 10px; font-size: 18px; }
  .meta { color: #667085; font-size: 14px; }
  .strip { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 10px; }
  .tile, .card { background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 14px; }
  .label { color: #667085; font-size: 12px; text-transform: uppercase; letter-spacing: .04em; }
  .value { margin-top: 4px; font-weight: 650; }
  .ok { border-left: 4px solid #16a34a; }
  .warn { border-left: 4px solid #d97706; }
  .bad { border-left: 4px solid #dc2626; }
  ul { padding-left: 20px; }
  code { background: #f2f4f7; padding: 2px 5px; border-radius: 4px; }
  table { width: 100%; border-collapse: collapse; background: white; border: 1px solid #e5e7eb; }
  th, td { text-align: left; padding: 10px; border-bottom: 1px solid #e5e7eb; vertical-align: top; }
  th { background: #f9fafb; font-size: 13px; color: #475467; }
</style>
<main>
  <header>
    <h1>OpenPlan Brief</h1>
    <div class="meta">Scope: ... · Generated: ...</div>
  </header>
  <section class="strip">
    <div class="tile"><div class="label">Mode</div><div class="value">Review</div></div>
    <div class="tile"><div class="label">Result</div><div class="value">No blocking findings</div></div>
    <div class="tile warn"><div class="label">Human Decision</div><div class="value">Needed</div></div>
  </section>
  <section>
    <h2>Summary</h2>
    <div class="card"><ul><li>...</li></ul></div>
  </section>
</main>
</html>
```

## Handoff

If the HTML summarizes work for another agent, pair it with `$openplan-handoff`. The HTML is for people; the handoff snapshot is for agents.

For Claude Code, use `assets/claude-code-command.md` as a slash command or prompt seed.
