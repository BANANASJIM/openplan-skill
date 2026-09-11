# Doc-Driven Development with Agents

Documents are the source of truth. Agents and people read state from files and git, never from chat history. Any agent can start cold, find what it needs, do one bounded step, and leave the repository in a state the next agent can pick up.

This page explains the *form* of the workflow: what lives where, who may change what, how docs and code stay aligned, and how quality is checked. It does not describe any specific tool or project.

## 1. The problem

| Symptom | Cause |
|---|---|
| A new agent session knows nothing about yesterday's decisions | Decisions lived in a conversation, not in a file |
| Two agents (or two people) contradict each other | No single place says what is true |
| Docs say one thing, code does another | Nobody is obliged to reconcile them |
| An agent loads the whole repo and still gets it wrong | Too much irrelevant context, no reading order |
| "It's done" cannot be checked | Progress was claimed, not evidenced |

The workflow treats every one of these as a design flaw of the repository, not a failure of the agent.

## 2. The idea in one paragraph

Keep a small, layered set of documents that answer distinct questions. Give every document one owner question, one authority level and one lifetime. Let state be *detected* from the filesystem every time, never remembered. Make humans the only decision-makers and agents the only executors. Verify documents the same way you verify code: with checks that can fail.

## 3. Principles

| Principle | Meaning |
|---|---|
| Minimal effective context | Load only what changes the next decision. Context bloat is a smell, not a capability problem. |
| Humans decide, agents execute | Agents research, propose, implement and review. Acceptance, scope, trade-offs and bypasses belong to a person. |
| State lives in files and git | If it is not in the repository, it did not happen. |
| Authority flows one way | Intent constrains design; design constrains specs; specs constrain code. Downstream cites upstream, never the reverse. |
| Docs and code are separate surfaces | The design surface is the source of truth for intent and contracts. The code surface is the source of truth for what is implemented. |
| One human-facing coordinator | Only one agent talks to the human. Everyone else reports "needs a human decision" or "blocked". |
| Evidence before confidence | A claim points at a file, a diff, a log or a report. |
| Writing and reviewing are separate | The author of a change never reviews it. |
| No silent approval | "No findings" is a scoped result, not a sign-off. |
| Reversible by default | Prefer actions that can be inspected, interrupted and rolled back. |

## 4. Where truth lives

Every folder answers exactly one question. If a sentence answers a different question, it belongs somewhere else.

| Folder | Question it answers | Changes how |
|---|---|---|
| `design/` | What is this system and why? | Rarely. Every change needs a decision record. |
| `decisions/` | Why did we choose this? | Append only. To reverse a decision, write a new one that supersedes it. |
| `engineering/` | What are the current contracts and boundaries? | Evolves with practice. |
| `conventions/` | How do we work? | Rarely. |
| `planning/` | What should happen next? Which human decisions are still owed? | Continuously. |
| `research/` | What did we find out? | Snapshot. Never edited after the fact; archived or deleted once consumed. |
| `review/` | How good is it? | Snapshot per review. |
| `deviations/` | Where does reality differ from the design, and what was decided about it? | Opened by anyone, closed with an explicit resolution. |
| Agent state | What is the durable intent? What is the current checkpoint? | Short-lived files, replaced rather than appended. |
| Templates | What does a new file look like? | Framework-defined. |

Three rules follow from the table.

- **Upstream never cites downstream.** A design document does not link to a research note, a review or a plan. If a research conclusion matters to the design, the design states the conclusion in its own words.
- **State has one home.** Progress, current version, open issues: each has exactly one authoritative file. Every other mention is a pointer to it. A second copy will stop being updated and will mislead the next reader.
- **Only the present is kept.** Outdated text is deleted, not struck through or annotated. Git is the archive. The single exception is an accepted decision record, which is never edited.

## 5. Cold start: any agent, any time

An agent that starts with no context follows a fixed route.

1. Read three short root files: behaviour rules, roles and permissions, and a file index. Together they are "hot memory" and stay under a strict length limit.
2. Read the durable intent snapshot if the task touches what the project should be.
3. Read the current checkpoint (handoff) if resuming work.
4. Detect the current state from the filesystem: which files exist, which checks pass, which reviews have open findings. Never infer state from history or from the previous conversation.
5. Load only the documents the detected state requires.

Two small files carry continuity across sessions and agents.

| File | Holds | Lifetime |
|---|---|---|
| Needs snapshot | Refined goal, scope in/out, acceptance criteria, constraints, known unknowns. Written only after a human has aligned it. | Until the goal is consumed by a plan |
| Handoff | Objective, exact repository revision, what was verified and how, open blockers, the next safe action, what the next agent must *not* decide. | Replaced at every checkpoint |

Neither is a transcript. Both prefer paths over pasted content, and both mark what was not independently verified.

## 6. Writing for minimal context

The same document is read by people in full and by agents in fragments. It has to work both ways.

| Rule | Why |
|---|---|
| First line is the conclusion | A reader who stops after one line still leaves with the point. |
| Tables over prose for anything enumerable | Three parallel facts in three sentences cost more tokens and are harder to diff. |
| No back-references ("as mentioned above") | A fragment must stand alone. |
| No hedging words ("usually", "generally", "depending") | Conditions are enumerated exhaustively or not stated. |
| Every identifier resolves | Every acronym, number or code name is defined somewhere in the repository, or it is replaced by what it means. |
| Reference by path, never by copy | One fact, one owner. Copies drift. |
| Keep files short; split when a file owns too many things | Compliance drops as files grow, for agents and for people. |
| Three layers of depth | An index points to a compact document, which points to a deep discussion. Readers descend only as far as they need. |

Long files are not forbidden. A file that is the sole authority for six subsystems is not too long; it is unsplit.

## 7. Roles and boundaries

Work is divided into roles. Each role has a read scope, a write scope and a commit prefix, so `git log` and `git blame` show who did what.

| Role | Produces | May write |
|---|---|---|
| Coordinator | Next-step decisions, questions to the human | Almost nothing |
| Advisor | Aligned requirement snapshot | Agent state |
| Researcher | Evidence reports | Research |
| Doc writer | Design, decisions, engineering, planning | The document layer |
| Spec writer | Implementation specs and task lists | The spec folder in the code repo |
| Implementer | Code and tests for one task | Code, tests, deviations |
| Reviewer | Findings with severity and evidence | Review, deviations |
| Gardener | Document-quality findings | Nothing (reports only) |

The scopes are enforced, not merely agreed: an agent working in a role sees only the files the role permits. What it cannot see, it cannot accidentally change.

Humans do three things: start work by stating intent, review outputs, and choose among options the coordinator presents. Humans keep an emergency bypass that agents do not have; using it leaves an audit trail and a reminder to update the docs afterwards.

## 8. Working together: many people, many agents

| Concern | Form |
|---|---|
| Identity | Every role commits under its own author name. People commit as themselves. |
| Isolation | Each agent works in its own isolated checkout on its own branch. Parallel agents cannot see each other. |
| Merging | Parallel work is merged one at a time. A merge conflict stops and asks a human; it is never auto-resolved. |
| Decision path | Sub-agents never ask the human. They report what decision is needed; the coordinator asks. |
| Independent review | Every hand-off between layers gets a reviewer who did not write the work. A merge needs a human sign-off. |
| Human words vs agent words | When a document records a human decision, it quotes the words and the date. An agent's interpretation is labelled as such and kept in a separate paragraph, so it can be corrected without touching the quote. |
| Lessons | Operational lessons accumulate in one file and are periodically promoted into conventions by a person. |

Because state is in files, "many people" and "many agents" are the same case. A colleague joining tomorrow and an agent starting a fresh session read the same route from Section 5.

## 9. Keeping docs and code in sync

This is the part most teams get wrong, so it gets its own rules.

**Two surfaces, one direction.** The docs repository owns intent, design and contracts. The code repository owns implementation and a spec folder that translates design into tasks. Code cites specs, specs cite design. Design never cites code.

**Docs first, then specs, then code.** A change moves through three stages in order. Design changes are finished and reviewed before a spec is written; specs are finished and reviewed before implementation starts. Implementation commits do not touch the design layer. If implementation reveals that the design is wrong, that is recorded as a deviation and routed back upstream, not fixed in place.

**Every downstream reference carries a version.** A spec or a commit that cites a design document names the exact revision it was based on. That makes drift detectable: when the design moves, everything anchored to the old revision is flagged for review instead of silently going stale.

**Disagreement is a defect, closed in the same change.** When docs and code disagree, one of them is wrong. Either the code is fixed to match the contract, or the doc is fixed to match reality and the change says which. Leaving both versions in place and letting readers guess is not an option.

**Deviations are first-class.** Any role that finds a difference between design and reality records it. A deviation is closed only with one of three explicit outcomes: fixed (with the fixing commit), accepted as-is (signed by a human), or deferred (to a named target). Open deviations block a merge.

**State words are literal.** Docs that describe delivery distinguish *on main*, *candidate* (an open change), *installed* (a specific verified build) and *evidence* (a dated measurement). Candidate behaviour is never described as delivered behaviour.

**Branches pair up.** A feature has the same branch name in both repositories, and the two are merged together by a person.

## 10. The loop

Work advances in rounds. Each round is the same shape.

```
detect state from files
  → pick the single next action the state calls for
  → show the human a short status and the proposed action
  → dispatch one role in isolation
  → merge its result
  → repeat
```

The state is recomputed every round. There is no "we were in the middle of X" carried in memory. The documentation side converges through a small set of states (needs alignment, needs research, needs design, needs cleanup, needs review, needs fix, converged). The code side is simpler: a task is either committed or not started; there is no in-progress state.

"Converged" is not the end. It means the documents are stable enough to write specs against. Specs, implementation and archiving follow in the same session.

## 11. Verification

Documents are verified in three layers, cheapest first.

| Layer | Checks | Cost |
|---|---|---|
| Structural | Links resolve, templates are followed, references point the right direction, version anchors are reachable, no orphan files | Deterministic, zero-cost, run every round |
| Semantic | First line is a conclusion, no hedging, no back-references, headings match bodies, terminology is consistent, files are within size | One agent pass, reports only |
| Alignment | Does the design serve the intent? Does the spec serve the design? Does the code serve the spec? | Independent reviewer per layer transition |

Two extra gates run once per feature.

- **Adversarial review.** A reviewer is asked to challenge every decision: is it needed, can it be simpler, which principle does it violate?
- **Zero-context test.** A fresh agent with no project background reads only the design and engineering documents and explains the system back, then lists what it found confusing or contradictory. Where it stumbles is a documentation defect, not a reader problem. This is the only real test of readability, because authors cannot judge their own context.

Tests are evidence for the reviewer, not approval. A regression test counts only if it has been shown to fail on the old behaviour. Checks that were skipped are reported with their impact.

## 12. Keeping docs fresh

| Trigger | Obligation |
|---|---|
| A design document changes | A decision record is written or amended with context, decision, alternatives and consequences. Typos and factual corrections are edited in place; reversals get a new record. |
| A decision is superseded | The old record stays and points to the new one. |
| Reality differs from design | A deviation is opened. |
| A feature completes | Research, reviews and intermediate files for that feature are archived or deleted. Design, decisions, engineering and conventions stay. |
| Periodically | A gardening pass reports stale claims, duplicated rationale, unclear authority labels, unresolved questions and readability gaps. It reports first; it rewrites only when asked. |
| Something was learned | It goes into the lessons file, and is promoted to a convention only after a person confirms it. |

Nothing in this table depends on remembering to do it. Each obligation is either checked or visible in the next round's state.

## 13. Finding answers

An agent with a question goes to one place.

| Question | Place |
|---|---|
| What is this and why does it exist? | Design |
| Why was it done this way and not another? | Decisions |
| What is the exact current contract for X? | Engineering index, then the owning document |
| What is the state on main right now? | The single status file |
| What should happen next? | Planning |
| Which human decisions are still owed? | Open questions |
| What did we find out about Y? | Research |
| Why does the code differ from the design here? | Deviations |
| Where did the last session stop, and what must I not decide? | Handoff |
| What does a new file of type Z look like? | Templates |

Conventions are chosen so answers are greppable: one checkbox syntax, one path syntax, one commit-prefix per role, one name per concept.

## 14. Adoption ladder

The philosophy does not depend on tooling. Start with conventions and add enforcement as the team grows.

| Level | What exists | What enforces it |
|---|---|---|
| Conventions only | The folder map, the writing rules, the role boundaries, decision records, handoff and needs snapshots | Agent skills that encode the behaviour, plus a pull-request template that asks for the authority behind every change |
| Checked | Structural checks run before every round | A small script; failures are visible, not blocking |
| Enforced | Role scopes, reference direction, version anchors, deviation reconciliation, docs-before-code | Commit and merge hooks; violations ask a human before proceeding |

Repository shape is a separate choice: one repository with a dedicated docs folder, one repository with docs and code kept apart by folders, or two repositories. The rules in Section 9 are the same in all three; only the boundary moves.

For an existing project: an agent drafts the design documents from the code, a person corrects them and confirms intent, and from that point the documents are the source of truth.

## 15. Anti-patterns

| Symptom | What went wrong |
|---|---|
| The coordinator edits files itself | Role boundary broken; dispatch a writer instead |
| A sub-agent asks the user a question | Decision path broken; it should report the needed decision |
| A design file links to a research note | Authority flows backwards |
| The same status appears in two files | State has two homes; one will rot |
| A reviewer fixes what it found | Writing and reviewing merged |
| "Done" with no commit, or a commit with no version anchor | Claim without evidence |
| A design changed with no decision record | Rationale lost |
| A doc and the code disagree and both stay | Drift accepted silently |
| The same finding survives several rounds | Context is polluted; start a fresh session |
| An agent reasons from what happened earlier in the chat | State inferred from memory instead of files |

## Glossary

| Term | Meaning |
|---|---|
| Source of truth (SSOT) | The one file that owns a fact. Everything else points to it. |
| Authority flow | The direction in which documents may cite each other: intent → design → spec → code. |
| Hot memory | The few root files every agent reads first. |
| Needs snapshot | The human-aligned statement of goal, scope and acceptance criteria. |
| Handoff | The current checkpoint for the next session: revision, evidence, blockers, next safe action. |
| Deviation | A recorded difference between design and reality, with an explicit resolution. |
| Decision record | An append-only note of a choice, its alternatives and its consequences. |
| Gardening | A read-only quality pass over documents. |
| Zero-context test | Readability check by an agent with no prior knowledge of the project. |
| Coordinator | The single agent that talks to the human and dispatches everyone else. |
