# Start every session in the docs repo

*A doc-based workflow for working with coding agents: keep a small docs repository that holds only what you need to understand the project, open every session there, let the agent pull detail progressively, and let git track how the project's intent moves.*

---

## The workflow in one paragraph

There are two repositories. The code repo holds the implementation. The docs repo holds what the implementation is for: the goal, the principles, the architecture, the decisions and the reasons behind them, the conventions, and a pointer to where things currently stand. Every session, human or agent, starts in the docs repo. It reads a small entry point, follows references down to exactly the documents the task needs, does the work, and before it ends, writes back whatever it learned that changes the high-level picture. The next session starts the same way and inherits everything.

## Why start in the docs repo

The code repo can tell you what the system does. It cannot tell you what it is supposed to do, why it is shaped the way it is, what was tried and rejected, or what the owner cares about. An agent that starts in the code repo reconstructs those from the code, which means it guesses, and its guesses become the basis for its work.

Starting in the docs repo flips the order. The first thing loaded is the map: what this project is, what it must never become, where the current work sits. Only then does the agent descend into the code, already knowing what it is looking at. The design intent is in context before a single line of implementation is.

It also fixes the memory problem. A session that begins at the map and ends by updating the map keeps the map current as a side effect of doing work. A session that begins in the code has nowhere natural to write down what it understood, so it doesn't, and the next session starts from zero again.

## Progressive disclosure

An agent should never need the whole docs repo. It needs a route.

The entry point is short: a few lines on what the project is, where the pieces live, and how to read the rest. From there, an index for each area points to one document per topic. Each document says where its detail lives, which for anything concrete is a path into the code. So the agent reads entry, then index, then the one document its task touches, then the specific files in the code repo that document names. Four hops, and it stops as soon as it has what it needs.

Loading more than that makes the agent worse, not better. Irrelevant material competes with relevant material, and an old note in context is indistinguishable from a current one. Small, layered, and self-contained beats complete.

Two writing rules make the route work. Every document leads with its conclusion, because the reader may only ever see the top. Nothing refers to "above" or "elsewhere" without a path, because the reader may have arrived from anywhere.

## What belongs in the docs, and what belongs in the code

This is the part that decides whether the docs repo survives contact with a real project.

The docs repo holds only what you need to understand the project: what it is, why it exists, the principles it must obey, how it is divided into parts and why the boundaries are where they are, which decisions were made and what they ruled out, what conventions the code follows, and where the current work stands. That material changes slowly, and it changes only when a human changes their mind about the project.

Everything that changes often lives in the code, and the docs point at it by path. Function signatures, config keys, file lists, enum values, exact commands, test counts, version numbers: if a sentence would have to change whenever the code changes, it does not belong in a document. A document that copies such a detail becomes a second owner of it, and the second owner is never the one that gets updated. A document that points at it is always right.

The test is mechanical. Read a sentence and ask whether it would still be true after a refactor that preserved the design. If yes, it is documentation. If no, it is code, and the document should say where to look instead of what is there.

This keeps the docs repo small enough that it can actually be read, and it keeps the two repositories from disagreeing, because they do not try to say the same thing.

## One source of truth, and git to track it

Every fact has exactly one home. The current status has one file; every other mention is a pointer to it. A design decision has one record; the design document refers to it rather than restating it. A copy is a future contradiction, and a reader cannot tell which copy to believe.

Git is what makes a single source of truth practical. Outdated text is deleted, not struck through or annotated, because the history is already kept. Decisions are the one exception: an accepted decision is never edited. To reverse it, a new record supersedes it, so the trail of reasoning survives. Every commit says which role made it and which upstream document it was based on, so `git log` on the docs repo reads as the history of how the project's intent moved, and `git blame` on any sentence shows when and why it was written.

## Syncing the high-level space

What actually needs to be synchronised between people, sessions and agents is not the code. Git already handles code. It is the high-level space: what the owner wants, what the system is meant to be, which trade-offs have been settled and which are still open.

That space drifts silently when it lives in conversations. Each session forms its own picture, the pictures diverge, and the code gets pulled in different directions by agents that were each doing competent work on a slightly different understanding of the goal. Writing the intent down, in one place, before work starts, is what stops that. The design document is the reference every session checks itself against, and a reviewer can point at the sentence a change violates.

It also has to record who said what. When a document captures a decision, it quotes the person. What an agent inferred from that goes in its own place, labelled as inference. Otherwise a guess ends up written in the same voice as a decision, and later nobody can tell them apart.

Over time this space accumulates the project's preferences: the naming the owner likes, the dependencies they refuse, the way they want errors handled, the lessons from the last three times something went wrong. Each session inherits those instead of relearning them, and the code converges toward one taste instead of reflecting whichever agent touched it last.

## Keeping it true

A docs repo that lags reality is worse than none, because it is trusted. Updating a document is optional and shipping code is not, so any process that relies on remembering loses.

So updates are tied to events. Changing a design file means a decision record is owed. Finishing a feature means its scratch material is archived and the status pointer moves. Ending a session means the handoff is rewritten with the exact revision, what was verified, and the next safe step. None of these depend on anyone remembering.

Disagreement between a document and the code is a defect, and it is closed in the same change that finds it. Either the code is fixed to match the intent, or the document is fixed to match reality and the change says which. Both left standing is not allowed.

And references carry versions. A document written against another names the revision it was written against, so when the upstream document changes, everything that depended on the old version is flagged instead of quietly staying wrong.

---

That is the whole workflow. A small docs repo that holds the understanding and points at the code for everything else. Every session starts there, reads only its route, and writes back what it learned. Git tracks how the intent moved. The high-level picture stays synchronised because it has one home, and it stays true because updating it is part of the work, not an extra step after it.
