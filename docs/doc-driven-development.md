# The repo is the memory

*Coding agents forget everything between sessions. The fix is not a longer prompt. It is a repository that holds intent, decisions and contracts in a form that people, agents and scripts all read the same way, and that stays true.*

---

## Agents forget. Use it.

Every agent session starts from zero. A chat is private to one process: no second person or agent can read it, nothing can diff or review it, and when two sessions disagree about what was decided there is no way to settle it.

So the rule is blunt: if it isn't in the repository, it didn't happen. A decision is a file. Progress is a commit. A review finding is a file with a severity and a line number.

This collapses two problems into one. A colleague joining tomorrow and an agent starting a fresh session open the same repo, read the same few files in the same order, and get the same answer about what is going on.

## Why docs, not prompts or memory features

A memory feature is per tool. A system prompt is per session. A markdown file in git is read identically by me, a collaborator, several different agent products and a CI job. It is the only substrate everyone shares.

Docs are checkable. A folder of markdown can be linted: every path reference resolves, every design change has a decision record beside it, nothing points at a file that was archived. A conversation cannot be linted.

Docs accumulate. A decision record with the alternatives that were rejected is still useful in a year, to someone who wasn't there. Research is done once, its conclusion absorbed into the design, the raw note archived. Lessons from execution collect in one file and, when one keeps recurring, get promoted into a convention. Knowledge settles into a form that survives everyone forgetting. A chat log just gets longer.

## Intent first, and keep it in sync

Most agent failures I see are not capability failures. The agent did competent work on the wrong problem, because what the human wanted was never written down in a form the agent could check against.

So nothing starts until intent is aligned and on disk. A few rounds of questions with the person: why does this need to exist, who is it for, what is out of scope, how will we know it is done. The result is a short **needs snapshot**: goal, boundary, acceptance criteria, constraints, and, explicitly, the known unknowns. It is the contract for everything downstream. Design is checked against it. Reviews cite it. If it is missing, the only legal first move is to go back to the human.

Three habits keep it honest.

**Human words and agent words stay separate.** When a doc records a decision, it quotes the person and the date. The agent's interpretation goes in its own paragraph, labelled as interpretation. A wrong reading can then be corrected without touching the quote, and nobody later mistakes an agent's guess for the human's intent. Assumptions are marked as assumptions. A snapshot full of the advisor's inferences looks aligned and isn't.

**One channel to the human.** A single coordinating agent asks questions and presents options. Every other agent reports "needs a human decision" or "blocked" instead of asking directly. Humans own acceptance, scope, trade-offs and bypasses. Agents own investigation, proposals, execution and evidence.

**Unknowns are tracked, not hidden.** The snapshot lists what we know we don't know. Research exists to move items off that list, and it reduces uncertainty without making decisions. Two checks are there for the unknown unknowns: an adversarial review that attacks every design decision (is it needed, can it be simpler, what does it violate), and a zero-context test where a fresh agent with no project knowledge reads the design docs, explains the system back, and lists what confused it. Where it stumbles is a documentation defect. When reality later disagrees with the plan, that becomes a written deviation, not a private observation.

## Minimal context, on purpose

Loading the whole repo makes an agent worse, not better. Irrelevant material competes with relevant material, and a superseded note in context will be reasoned from as if it were current. A task that needs more context than fits comfortably is coupled to too many things and should be split.

The rules that follow all push the same way.

**Three root files, all short, hard length limit.** Behaviour rules, roles with what each may touch, and an index. That is the whole hot memory. Everything else loads on demand. Past about 150 lines, compliance visibly drops.

**Every folder answers exactly one question.** Design: what is this and why. Decisions: why this and not that. Engineering: what is the current contract. Planning: what next, and which human decisions are still owed. Research and reviews: dated evidence. Deviations: where reality differs from the plan. An agent should know which single folder holds its answer before opening anything, and stop reading once it has it. A sentence that answers the wrong question for its folder is a bug.

**A fact has one home. Everything else is a pointer.** Copies are how two versions come to disagree.

**First line is the conclusion. No "as mentioned above."** The agent may only ever see a fragment.

**Upstream never cites downstream.** Design does not link to research or reviews. If a research conclusion matters, the design states it in its own words and stands alone.

**Docs and code are two surfaces.** The docs repo owns intent, design, decisions and contracts. The code repo owns the implementation and a spec folder that turns design into tasks. The docs say what should be true; the code says what is. Different questions, so both are authoritative at once.

## Docs that stay current

Everything above is worthless if the docs drift, and they drift because updating a doc is optional and shipping code is not. The answer is obligations triggered by events and checked by something other than memory.

**A disagreement between docs and code is a defect, closed in the same change that found it.** Either the code is fixed to match the contract, or the doc is fixed to match reality and the commit says which. Both left standing is not an option.

**References carry a version.** A spec that cites a design doc names the revision it was written against. When the design moves, everything anchored to the old revision lights up instead of silently staying wrong.

**Status words are literal.** "On main" means merged. "Candidate" means an open change. "Installed" means one specific build someone ran. "Evidence" means a dated measurement. Candidate behaviour is never written as delivered behaviour.

**Only the present is kept.** Outdated text is deleted, not struck through or annotated. Git is the archive. The single exception is an accepted decision record, which is never edited; to reverse it you write a new one that supersedes it.

**Changing a design file creates a debt.** A decision record is owed, with context, alternatives and consequences. This is checked, not remembered.

**Deviations close explicitly.** Fixed, with the commit. Accepted as-is, signed by a person. Deferred, to a named target. An open deviation blocks the merge.

**A gardening pass runs on a schedule.** Read everything, report stale claims, duplicated rationale, unclear ownership, unresolved questions. Report first, rewrite only when asked.

Each of these fires from an event or a check that runs anyway. That is the difference between "we should keep the docs updated" and docs that stay updated.

## Start here

Conventions before tooling. Hooks and isolated checkouts make the rules hard to break, but the rules work as conventions first, and they are what you are adopting.

Write a needs snapshot before the next feature. Adopt the one-question-per-folder map and the three short root files. Write a decision record the next time a design changes. Leave a handoff at the end of the next long session: exact revision, what was verified, what is blocked, the next safe step, what the next agent must not decide. Enforce "disagreement is a defect" on yourself for a month.

Add enforcement when a second person or a second agent starts stepping on things. By then you know which rules you keep breaking, and those are the ones worth a hook.

The repository is the memory. Keep it small enough to read, true enough to trust, and checked often enough that you find out when it isn't.
