# The repo is the memory

*Coding agents forget everything between sessions. The fix is not a longer prompt. It is treating the repository as the memory: the one place where intent, decisions and current truth live in a form that people, agents and scripts read the same way, and that is kept true on purpose.*

---

## Start from what an agent actually is

An agent is a stateless worker. It wakes up with no past, does a bounded piece of work, and disappears. Anything it should know has to be handed to it at the start, and anything it learned is gone unless it wrote it down somewhere that outlives the session.

The obvious response is to keep the conversation alive and pour more into it. That only hides the problem. A conversation is private to one process. Nobody else can read it, nothing can diff it or check it, and when two sessions disagree about what was decided there is no way to settle the dispute. It is memory that cannot be shared, audited or trusted.

So the memory has to be external, shared and checkable. In a software project that means files under version control. If a fact is not in the repository, it does not exist for the next session, the next agent or the next colleague. Those three are the same reader, and that is the point.

## Why documents, specifically

A memory feature belongs to one tool. A system prompt belongs to one session. A file in git belongs to everyone: the person who wrote it, the person who joins next month, every agent product, every CI job. It is the only substrate all of them read identically.

Files can be checked. You can verify that links resolve, that a design change came with a rationale, that nothing cites something that no longer exists. You cannot run a check over a chat.

And files accumulate. A recorded decision, with the options that were rejected and why, is still useful a year later to someone who was not there. Research is done once, its conclusion absorbed, the raw notes set aside. Recurring lessons harden into conventions. Knowledge settles into a durable form instead of scrolling away.

## Intent is the scarce input

Agents are good at execution. What they lack is knowing what you want. Most bad outcomes are not incompetence; they are competent work aimed at the wrong target, because the target was never written down in a form the work could be checked against.

So intent comes first, and it goes on disk before anything else starts. Not a task list. The goal, the boundary, how you will know it is done, and what you know you do not know. That file is the contract every later artifact answers to. If it is missing, the right first move is to go back to the human, not to start guessing.

Intent has to be kept separate from inference. When a document records what a person decided, it should quote the person. What the agent concluded from that goes in its own place, labelled as a conclusion. Otherwise an agent's guess gets written down in the same voice as the human's decision, and three sessions later nobody can tell which was which. Assumptions are marked as assumptions. A plan that is full of unmarked assumptions looks aligned and is not.

Uncertainty has to be visible too. Write down the known unknowns; that list is what research is for, and research should reduce uncertainty without quietly making decisions. Unknown unknowns need a different tool: a reader who does not share your context. Hand the design to someone, human or agent, with no background, ask them to explain it back, and treat every place they stumble as a defect in the document, not in the reader. Authors cannot see their own gaps. And when reality later contradicts the plan, that contradiction gets written down the moment it is noticed, because a surprise that stays in one person's head is a surprise the next reader will hit again.

Decisions stay with humans for a structural reason. An agent optimises for the goal as written. A person holds the goal as meant. Acceptance, scope, trade-offs and bypasses are exactly the places where the written version and the meant version can diverge, so those are the places where an agent proposes and a person decides. One agent talks to the human; the rest report what decision they need.

## Less context, deliberately

Given a shared memory, the instinct is to load all of it. That makes agents worse. Irrelevant material competes with relevant material for attention, and a superseded note in context is indistinguishable from a current one unless something says so. Every extra page is a chance to be misled. A task that cannot be done from a small slice is a task that is coupled to too many things and should be split.

This changes how the memory is written, not just how much of it is read.

Any fragment has to stand alone. The first line states the conclusion. Nothing says "as mentioned above," because the reader may never have seen above. Enumerable facts go in tables, not prose, so they can be skimmed and diffed.

Each fact has one home. Every other mention is a pointer. Two copies of the same fact will disagree eventually, and the reader has no way to know which one to believe.

Each place answers one question. Where you would look for "why was this chosen" is not where you would look for "what is the current contract" or "what should happen next." A reader with a question should know where the answer lives before opening anything, and should be able to stop reading once they have it.

Authority points one way. What the system is supposed to be constrains how it is built, which constrains what the code does. The upstream document never cites the downstream one, because the moment it does, the reader cannot tell which layer is the source of truth. If a downstream finding matters upstream, the upstream document states it in its own words.

And the state of the project is derived, not remembered. What should happen next follows from what exists on disk right now: whether intent is written, whether research is done, whether checks pass, whether a review left something open. Not from what the previous session thought it was doing.

## Why docs rot, and the one thing that stops it

Everything above fails if the memory drifts from reality. It always drifts, for a simple reason: updating a document is optional and shipping code is not. Any process that relies on remembering to update the docs will lose to that asymmetry, every time.

The only thing that works is to make updates non-optional. Tie them to events instead of to discipline. A design changed: a rationale is now owed. A feature finished: its scratch material is now archived. A merge is about to happen: any recorded contradiction must be resolved first. None of these depend on anyone remembering.

Make drift detectable. When one document is written against another, record which version it was written against. Then a change upstream lights up everything that depended on the old version, instead of leaving it quietly wrong.

Make words mean one thing. "Merged," "proposed," "installed," "measured" are different states, and a document that uses them loosely will describe an open change as delivered behaviour. Readers should be able to trust the word.

Keep only the present. Outdated text is deleted, not struck through or annotated. Version control is the archive; the document is what is true now. The one exception is a recorded decision, which is never edited. To reverse it, write a new one that supersedes it, so the reasoning trail survives.

And treat disagreement between documents and code as a defect, closed in the same change that found it. Either the code is fixed to match what was intended, or the document is fixed to match what exists, and the change says which. Leaving both standing and letting the reader guess is how "the docs are the source of truth" turns into a wish.

## Conventions first

None of this needs tooling to start. Hooks and enforced permissions make the rules hard to break, but the rules are what you are adopting, and they work as conventions on day one. Add enforcement when a second person or a second agent starts stepping on things; by then you know which rules you keep breaking, and those are the ones worth automating.

The repository is the memory. Keep it small enough to read, true enough to trust, and checked often enough that you find out when it is not.
