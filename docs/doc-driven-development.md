# Proposal: a doc-based workflow for agent-assisted development

*Status: proposal, open for comments. Scope: how we and our coding agents organise project knowledge, where each kind of information lives, and how it stays current.*

---

## Summary

I am proposing that we keep a small docs repository next to each code repository, that every working session, human or agent, starts there, and that the docs hold only what is needed to understand the project while pointing at the code for everything that changes often. Git tracks how the project's intent moves over time. The high-level picture stays synchronised because it has one home, and it stays true because updating it is part of doing the work rather than a step after it.

## The problem this solves

Coding agents start every session with no memory. Today the context they need lives in three places: someone's head, a chat history nobody else can read, and the code itself. The first two do not transfer between people or sessions. The third can tell an agent what the system does, but not what it is supposed to do, why it is shaped the way it is, what was tried and rejected, or what we care about.

The result is familiar. Each session reconstructs the project from the code, guesses at the intent, and does competent work on a slightly different understanding of the goal. Decisions get re-litigated. Preferences get relearned or ignored. Two agents pull the code in two directions. And the notes that would have prevented it are in a conversation that ended last week.

## The proposal in one paragraph

Two repositories per project. The code repo holds the implementation. The docs repo holds what the implementation is for: the goal, the principles, the architecture and why its boundaries are where they are, the decisions with their rejected alternatives, the conventions, and a pointer to where the work currently stands. Every session starts in the docs repo, reads a short entry point, follows references down to exactly the documents the task needs, does the work, and before it ends writes back anything that changes the high-level picture. The next session starts the same way and inherits everything.

## Why the docs repo is the starting point

Starting in the docs repo puts the design intent in context before a single line of implementation is. The first thing loaded is the map: what this project is, what it must not become, where the current work sits. Only then does the agent descend into the code, already knowing what it is looking at.

It also keeps the memory current without a separate effort. A session that begins at the map and ends by updating the map maintains it as a side effect of working. A session that begins in the code has no natural place to write down what it understood, so it does not, and the next session starts from zero.

## Progressive disclosure

No session should need the whole docs repo. It needs a route.

The entry point is a few lines: what the project is, where the pieces live, how to read the rest. From there an index per area points to one document per topic. Each document names where its detail lives, which for anything concrete is a path into the code. So a session reads the entry, then an index, then the one document its task touches, then the specific code files that document names. Four hops, stopping as soon as it has what it needs.

Loading more than that makes agents worse, not better. Irrelevant material competes with relevant material, and an old note in context is indistinguishable from a current one. Two writing rules keep the route working: every document leads with its conclusion, and nothing refers to "above" or "elsewhere" without a path, because the reader may have arrived from anywhere.

## What goes in the docs, and what stays in the code

This is the rule that decides whether the docs repo survives a real project.

The docs repo holds only what is needed to understand the project: what it is, why it exists, the principles it must obey, how it is divided and why, which decisions were made and what they ruled out, the conventions the code follows, and where the work currently stands. That material changes slowly, and only when a human changes their mind about the project.

Everything that changes often stays in the code, and the docs point at it by path. Function signatures, config keys, file lists, enum values, exact commands, test counts, version numbers. If a sentence would have to change whenever the code changes, it does not belong in a document. A document that copies such a detail becomes a second owner of it, and the second owner is never the one that gets updated. A document that points at it is always right.

The test is mechanical: would this sentence still be true after a refactor that preserved the design? If yes, it is documentation. If no, it is code, and the document should say where to look instead of what is there.

This keeps the docs small enough to actually read, and it keeps the two repositories from contradicting each other, because they do not try to say the same thing.

## One source of truth, tracked by git

Every fact has exactly one home. Current status has one file; every other mention is a pointer to it. A decision has one record; the design document refers to it rather than restating it. A copy is a future contradiction, and a reader cannot tell which copy to believe.

Git makes this practical. Outdated text is deleted, not struck through or annotated, because history is already kept. Decisions are the one exception: an accepted decision is never edited, and reversing it means a new record that supersedes the old one, so the reasoning trail survives. Commits name which role made them and which upstream document they were based on, so the log of the docs repo reads as the history of how the project's intent moved, and blame on any sentence shows when and why it was written.

## Synchronising the high-level space

What actually needs synchronising between people, sessions and agents is not the code. Git handles code. It is the high-level space: what we want, what the system is meant to be, which trade-offs are settled and which are still open.

That space drifts silently when it lives in conversations. Writing the intent down, in one place, before work starts, is what stops the drift. The design document becomes the reference every session checks itself against, and a reviewer can point at the exact sentence a change violates.

The record has to say who said what. When a document captures a decision, it quotes the person. What an agent inferred from that goes in its own place, labelled as inference. Otherwise a guess ends up written in the same voice as a decision, and later nobody can tell them apart.

Over time this space accumulates the project's preferences: the naming we like, the dependencies we refuse, how we want errors handled, the lessons from the last three incidents. Each session inherits those instead of relearning them, and the code converges toward one taste instead of reflecting whichever agent touched it last.

## Keeping it true

A docs repo that lags reality is worse than none, because it is trusted. Updating a document is optional and shipping code is not, so any process that relies on remembering will lose.

So updates are tied to events. Changing a design document means a decision record is owed. Finishing a feature means its scratch material is archived and the status pointer moves. Ending a session means the handoff is rewritten with the exact revision, what was verified, and the next safe step.

Disagreement between a document and the code is a defect, closed in the same change that finds it. Either the code is fixed to match the intent, or the document is fixed to match reality and the change says which. Leaving both standing is not allowed.

References carry versions. A document written against another names the revision it was written against, so when the upstream changes, everything that depended on the old version is flagged rather than quietly staying wrong.

## What this asks of us

- Start every session, human or agent, in the docs repo, and end it by updating what changed.
- Write intent down before work starts. Quote people; label inference.
- Keep the docs to what is needed to understand the project. Point at the code for details.
- One home per fact. Delete what is outdated. Never edit an accepted decision; supersede it.
- Treat a doc/code disagreement as a bug to fix in the same change.

None of this needs tooling to begin. These work as conventions on day one. We add enforcement, hooks and checks, once we know which rules we keep breaking. I would like to trial this on one project for a month and review.
