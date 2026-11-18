---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

If the user passes a ticket reference, fetch it from the issue tracker and state its title before starting. If the reference is ambiguous, ask.

## Brief, then wait

Before any code change, give the user a very concise brief, in this shape and nothing more:

1. One line: what the work does, at a high level.
2. Three to five bullets: what the change does. One short line each.
3. Open questions: only what the spec leaves undecided and you cannot settle yourself. One short line each, reasoned from first principles, straight to the point. Write "None" if there are none.

No preamble, no recap of the spec, no file lists.

Then stop and end your turn. This step is done only when the user gives an explicit green light. Treat any other reply as feedback: revise the brief and wait again.

## Build

Call the Skill tool with "tdd" where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, call the Skill tool with "code-review" to review the work.

Commit your work to the current branch.
