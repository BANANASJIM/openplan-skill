# The repo is the memory

*Why I make my coding agents read three files and nothing else, why the docs are the source of truth, and why none of that matters if the docs go stale.*

---

Two months ago I found a lie in one of my repositories. Not a big one. A "current status" block in the agent instructions file said the project was at a certain version with a certain set of open issues. It had been true once. Then the real status moved to a roadmap file, the block never got touched again, and for about two months every fresh agent session read the stale block first, believed it, and started work from a world that no longer existed. Nobody noticed because the block *looked* fine. It was well formatted. It just wasn't true.

That was the moment I stopped thinking of documentation as something you write for people and started thinking of it as the only memory my agents have. Everything below follows from that.

## Agents forget. Stop fighting it.

A coding agent starts every session from zero. Whatever you explained yesterday is gone. The usual reactions are to paste more into the prompt, or to keep one long chat alive and pray it doesn't get compacted. I did both for a while. They fail the same way: the knowledge lives somewhere only one process can see.

A chat is private. A second person can't read it. A second agent can't read it. You can't diff it, blame it, or review it. If two sessions disagree about what was decided, there is no way to settle it except asking the human, who has also forgotten.

So the rule I landed on is blunt: if it isn't in the repository, it didn't happen. A decision is a file. Progress is a commit. A finding from a review is a file with a severity and a line number. "I'm pretty sure we agreed to X" is not a state my workflow recognises.

Once you accept that, "many people" and "many agents" become the same problem with the same solution. A colleague joining tomorrow and an agent starting a fresh session both open the same repo, read the same few files in the same order, and get the same answer about what's going on.

## Why minimal context, not maximal

The tempting move, once the docs exist, is to load all of them. Bigger context window, more docs, better agent. Right?

No. In my experience it goes the other way. An agent given the whole repo gets *worse*, not because it runs out of room but because the irrelevant material competes with the relevant material. It will happily reason from a research note that was superseded a month ago, because the note was in context and nothing told it not to. Context isn't free even when it fits. Every extra page is a chance to be misled.

I now treat "this task needs more context than fits comfortably" as a smell about the task, not a limit of the model. Usually it means the task is coupled to too many things and should be split.

The practical version of this is a handful of rules that all push in the same direction:

**Three root files, all short, all with a hard length limit.** Behaviour rules, roles and what each may touch, and an index of where things are. That's the whole "hot memory." Everything else is loaded on demand. I keep them under 150 lines each because past that, compliance visibly drops. The agent starts skimming, same as a person.

**Every folder answers exactly one question.** Design answers "what is this and why." Decisions answer "why this and not that." Engineering answers "what is the current contract." Planning answers "what next." An agent with a question should know, before opening anything, which single folder holds the answer, and should stop reading the moment it has it. A sentence that answers the wrong question for its folder is a bug. That status block I mentioned was exactly this: delivery status living inside an instructions file, where nobody updating delivery status would think to look.

**A fact has one home. Everything else is a pointer.** Copying is how you get two versions that disagree. The stale status block was a copy. The fix wasn't to update it; it was to delete it and leave one line saying where the real one lives.

**First line is the conclusion. No "as mentioned above."** Because the agent may only ever see a fragment. A doc that only makes sense read top to bottom is a doc that will be misread.

**Upstream never cites downstream.** The design doesn't link to a research note or a review. If a research conclusion matters, the design states it in its own words. This felt pedantic until I watched an agent follow a link from the design into a research doc, then into a second research doc that contradicted the first, and come back confused about what the design actually said.

None of this is about being terse. It's about making sure that whatever slice of the repo an agent happens to load, that slice is true and self-contained.

## Why docs, and not memory features or better prompts

People ask why I don't just use the agent's built-in memory, or write a really good system prompt. Three reasons, and they're the reasons docs have always been good, just sharper now.

**Docs sync people.** A memory feature is per-tool and per-user. A system prompt is per-session. A markdown file in git is read identically by me, my collaborator, three different agent products, and a CI script. It's the only substrate everyone shares.

**Docs are checkable.** You can lint a folder of markdown. You can check that every path reference resolves, that every design change has a decision record next to it, that nothing references a file that was archived. You cannot lint a conversation.

**Docs accumulate.** This is the one I underrated. A decision record written today, with the alternatives that were rejected and why, is still useful in a year, to a person or an agent who wasn't there. Research gets done once, its conclusion gets absorbed into the design, and the raw note is archived. Lessons from execution collect in one file and, when one keeps recurring, a human promotes it into a convention. Knowledge precipitates out of the day-to-day and settles into a form that survives everyone forgetting. A chat log can't do that. It just gets longer.

The shape that came out of this is a docs repo that owns intent, design, decisions and contracts, separate from the code repo that owns the implementation. Two surfaces, kept apart on purpose. The docs say what should be true. The code says what is. They answer different questions, which is exactly why they can both be authoritative at the same time.

## The part that actually matters: docs that don't rot

Everything above is worthless if the docs drift from reality. And they always drift, because updating a doc is optional and shipping code is not. Every doc-driven attempt I've seen die, died here.

So I stopped treating "keep the docs updated" as a discipline and started treating it as a set of obligations that are triggered by events and checked by something other than memory.

**A disagreement between docs and code is a defect, closed in the same change that found it.** This is the rule. Either the code is wrong and gets fixed to match the contract, or the doc is stale and gets fixed to match reality, and the commit says which. What you may not do is leave both standing and let the next reader guess. I once audited a docs repo against its code and found batches of confident sentences describing behaviour the code had never had. That's what "docs are the source of truth" looks like without this rule: a wish.

**References carry a version.** When a spec cites a design doc, it names the revision it was written against. When the design moves, everything anchored to the old revision lights up as stale instead of silently staying wrong. This costs nothing to write and turns "is this still current?" from a judgement call into a diff.

**Status words are literal.** "On main" means merged. "Candidate" means an open change. "Installed" means one specific build someone actually ran. "Evidence" means a measurement with a date. I got burned by docs describing a branch's behaviour as if it had shipped. Now candidate behaviour is never written as delivered behaviour, and a reader can trust the word.

**Only the present tense is kept.** Outdated text gets deleted. Not struck through, not annotated with "revised on," not moved to a "history" section. Git is the archive; the doc is what's true now. The single exception is an accepted decision record, which is never edited. To reverse one you write a new one that supersedes it, so the reasoning trail survives.

**Changing a design file creates a debt.** A decision record is owed, with context, alternatives and consequences. Typos get fixed in place; reversals get a new record. This is checked, not remembered.

**Reality diverging from the plan gets written down as a deviation.** Anyone who notices, agent or human, opens one. It closes only as fixed (with the commit), accepted as-is (signed by a person), or deferred (to a named target). An open deviation blocks the merge. The point is that "the code does something the design didn't say" is never a private observation. It's a file.

**Someone with no context reads the docs and says what confused them.** Periodically I hand the design and engineering docs to a fresh agent session with zero project knowledge, ask it to explain the system back to me, and then ask what it couldn't follow. Where it stumbles is a documentation defect. This is the only readability test that works, because I can't un-know what I know. A structural linter catches broken links; only a cold reader catches a paragraph that made sense to its author and no one else.

**A gardening pass runs on a schedule.** Read everything, report stale claims, duplicated rationale, unclear ownership, unresolved questions. Report first, rewrite only when asked. Cheap, boring, and it's caught more rot than any review.

None of these rules require willpower. Each one fires from an event (a design changed, a feature finished, a merge is about to happen) or from a check that runs anyway. That's the difference between "we should keep the docs updated" and docs that stay updated.

## What a day looks like

An agent starts. It reads the three root files. It looks at the disk and works out the state: is there an aligned statement of what the human wants? Is there research yet? Do the structural checks pass? Does the last review have open blocking findings? Is there an open deviation? Those answers, not the previous conversation, decide the next move. If the intent file is missing, the only legal move is to go back to the human and align. If a review has a blocking finding, the only legal move is to fix it.

It does one bounded thing in an isolated checkout, as one role, seeing only the files that role may touch. It commits under that role's name. If it needs a decision, it writes "needs a human decision" in its report; it does not ask me directly, because only one agent talks to me and that's how three sub-agents stop asking slightly different versions of the same question.

When it stops, it leaves a handoff: exact revision, what was verified and how, what's blocked, the next safe step, and what the next agent must not decide on its own. The next session reads that and starts cold, the same way.

## If you want to try this

Don't start with tooling. The hooks, the isolated checkouts, the automated checks make the rules hard to break, but the rules work as conventions first, and they're what you're actually adopting.

Start with the folder map and the one-question-per-folder rule. Add the three short root files. Start writing decision records the next time you change a design. Write a handoff at the end of your next long session and read it back at the start of the one after. Pick the "disagreement is a defect" rule and actually enforce it on yourself for a month.

Then, when a second person or a second agent shows up and starts stepping on things, add enforcement. By then you'll know which rules you keep breaking, and those are the ones worth a hook.

The whole thing fits on one principle: the repository is the memory, so treat it like one. Keep it small enough to read, true enough to trust, and checked often enough that you find out when it isn't.
