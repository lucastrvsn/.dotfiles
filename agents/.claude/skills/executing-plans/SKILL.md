---
name: executing-plans
description: Use when executing an implementation plan in the current session as the implementer yourself — your human partner chose native execution, or no subagent tool is available
---

# Executing Plans

Execute the plan yourself, task by task, in this session: no implementer
subagent per task, no reviewer per task. One fresh-context review of the
whole branch at the end.

**Why native:** subagent-driven-development pays for a fresh implementer
and a fresh reviewer on every task, each re-reading the codebase from zero.
Native execution pays for one context (yours) plus one reviewer at the end.
What it gives up is a fresh context per task and a second pair of eyes per
task. This skill keeps what those two things bought, by other means: the
brief is the spec, the ledger is your memory, TDD is the per-task
gate, and the final reviewer is the second pair of eyes.

**Core principle:** The plan already did the thinking. Execute it exactly,
prove each step with a test you watched fail and then pass, and leave a
record that survives your own forgetting.

**Announce at start:** "I'm using the executing-plans skill to implement this plan natively."

**Narration:** between tool calls, narrate at most one short line — the
ledger and the tool results carry the record.

**Commits:** ALWAYS use the caveman-commit skill for commit messages.

**Continuous execution:** Do not pause to check in with your human partner
between tasks. They chose native execution to spend less, not to answer
"should I continue?" after every task. Execute all tasks from the plan
without stopping.

**Rulings, not stalls.** Conflicts, ambiguities, plan defects — decide them.
The spec is the binding authority, the plan is its argument, and your
judgment settles what neither answers. Record every decision in the ledger
as `Ruling: <what you decided> — <why> — <what it costs if wrong>`, and keep
going. Deviating from the plan without a ledgered ruling is a decision made
in secret.

Four things stop you, and only these: an irreversible or destructive
operation; a security-sensitive action; a side effect outside this branch
(a merge, a push to a shared branch, a publish); and a plan so broken that
every path forward is a guess. For those, stop and ask.

## When to Use

- You have a plan from writing-plans and your human partner chose native
  execution at the handoff.
- Your harness has no subagent tool. Never fabricate a dispatch; run the
  plan here.
- Tasks are mostly independent — the same precondition as
  subagent-driven-development.

A fully specified plan makes native execution transcription plus testing:
it runs well on a mid-tier session model, and the one place a strong
model earns its cost is the final review, which this skill
dispatches separately. Tell your human partner so when they choose native.

Prefer subagent-driven-development when your human partner wants a review
gate on every task, or when the plan is long enough that its later tasks
would run on a compacted context. Native execution over a long plan still
works — the ledger is what makes it recoverable — but the last tasks
get the least of you.

## Setup

Set up exactly as subagent-driven-development's Step 1: feature branch,
baseline test run (red baseline → report and ask), workspace, and ledger.
Never start implementation on main/master without your human partner's
explicit consent.

The workspace and ledger are shared with subagent-driven-development —
same `<workspace>/progress.md`, same line formats — so a plan can change
executors mid-flight and the new one resumes from the same ledger. A native
executor that loses its place re-implements tasks whose commits already
exist; after compaction, trust the ledger and `git log` over your own
recollection. Harness todos are a live view; the ledger is the record.

Read the plan once, note its Global Constraints and Review Focus, and
create a todo per task. If the plan names a Spec, read that too: conflicts
inside the plan resolve against it. A plan with no reachable spec gets a
ledger note saying so — rulings made without one are
provisional. The plan and spec are gitignored on purpose; never
`git add -f` them.

Before Task 1, scan the plan for conflicts between tasks. The plan's
Interfaces blocks tell you where to look: for every task that consumes
what an earlier task produces, one ledger row — the two tasks,
what one produces against what the other consumes, and what you found.
Tasks that share nothing get no row; a plan whose tasks share nothing gets
the single line `Pre-flight: no shared interfaces`. Rule on each conflict a
row surfaces with the spec as the binding authority, record the ruling
beside its row, and start Task 1. Each task's own text is checked when you
read its brief, not here.

## The Task Loop

Everything you print, and every tool result, stays resident in your
context for the rest of the session. Redirect long test output to a file
in `<workspace>` and read its tail; read a brief, not the whole plan.

### 1. Take the task

- Run this skill's `scripts/task-start PLAN_FILE N`. It prints the brief
  path and BASE (the commit the task's range is cut from) in one call.
  Read the brief for every task, including ones you remember from setup:
  what you remember is a summary, the brief has the exact values,
  signatures, and test cases.
- Mark the task's todo in_progress.

Every tool call is a turn that re-reads your whole context. Bookkeeping
rides along with work — a ledger append in the same call as the commit,
never in a call of its own.

### 2. Work the steps

The plan's steps are already in RED-GREEN order; follow them in that
order. A test step's code is written first and run first. Watching it fail
is a step, not a formality — a test that passes before the implementation
exists is a finding about the test. Write only the code that makes the
failing test pass.

Every step that runs a command has an `Expected:` line. Run the command,
read its output, and compare. Three outcomes:

- **Matches.** Next step.
- **The code is wrong.** Find the root cause before changing anything;
  never patch the symptom to make the step's output match.
- **The plan is wrong** — a step contradicts the spec, an interface from an
  earlier task doesn't match what this task consumes, a command that
  cannot work. Rule on the smallest change that satisfies the spec, ledger
  it as `Task <N>: Ruling: <finding> — <what you decided and why>`, and
  continue. The ruling is carried, not remembered: later tasks that touch
  the same interface read it from the ledger.

Commit as the plan's commit steps say. A task that spans several commits
is fine; BASE is what the review range is cut from, never `HEAD~1`.

### 3. The completion contract

Before a task's ledger line, all of the following are true, with
evidence in this session — not inferred from the diff looking right:

- Every test the brief names exists and ran in this task, and you read
  the output.
- The final test run for the task passed — `task-done` is that run, and
  it writes the command and result into the completion line.
- Every `Expected:` line in the brief was compared against real output.
- Every deviation from the brief has a `Ruling:` line in the ledger.

If any item is missing, the task is not complete: finish it. "Should
work" is not evidence; a green run is.

### 4. Complete the task

Run this skill's `scripts/task-done PLAN_FILE N BASE -- <test command>`
with the test command the brief names for the whole task. It runs the
tests, keeps the full output in `<workspace>`, prints the tail, and — only
if they pass — appends the completion line to the ledger:

`Task <N>: complete (commits <base7>..<head7>, tests: <command> → <result>)`

A failing run records nothing; the task is not complete. When it records,
mark the todo complete and take the next task.

## Final Review

Run the full test suite yourself. If it fails, fix it before the review.
Then run `../subagent-driven-development/scripts/review-package PLAN_FILE MERGE_BASE HEAD`
(`MERGE_BASE=$(git merge-base <base-branch> HEAD)`) and review from the
file it prints.

**With a subagent tool:** dispatch the reviewer on a strong model — the
whole-branch review is a judgment task — using requesting-code-review's
[code-reviewer.md](../requesting-code-review/code-reviewer.md), with the
package path, the plan and spec paths, the plan's Review Focus section
verbatim (the input classes and failure modes the plan's tests do not
exercise — the reviewer checks each deliberately), and a pointer to the
ledger's `Ruling:` lines so it can weigh the calls you made. Specify the
model explicitly; an omitted model inherits the session's, which may not
be a strong one. This is the one fresh context the whole run buys. Do not
skip it, and do not replace it with your own read of the diff.

**Without a subagent tool:** read code-reviewer.md and perform that review
yourself against the package, as a separate pass after the last task's
ledger line. Write `Final review: self-review (no subagent tool)` to the
ledger, and say so in your final message: a self-review by the author is
weaker than a fresh reviewer, and your human partner decides whether that
is enough before merge.

Sort the findings before you act on any of them. The reviewer's severity
labels are advice; the gate is yours. Its "Declined to judge" list is
yours too: every line there is a ruling you make and ledger, exactly like
a plan conflict — `Final: Ruling: <behavior the reviewer set aside> —
<what a reasonable person using this software gets, and why that stands
or why it is now a finding> — <cost if wrong>`. Re-grade first, by effect: the spec
is a vision document, and a finding's grade is what a reasonable person
using this software gets if it ships, not whether the spec names the input
that triggers it. Then:

- **Critical and Important** enter the fix pass.
- **Minor** goes to the ledger as `Final: minor (deferred): <one-liner>`
  and to your final message under "Deferred minors". Minors never enter
  the fix pass, and never become rulings.

Fix the Critical and Important findings yourself — you are the
implementer here — in ONE pass. Each fix is verified by TDD, not by a
second reviewer: write the test that reproduces the finding, watch it
fail, make it pass, then run the whole suite. Record each as
`Final: fixed <finding> — <test name> RED→GREEN, suite <N>/<N>` in the
ledger. A fix
without a test that failed first is not verified; a suite that is not
green after the pass means the pass is not over. Do not dispatch a
re-review: the covering tests already answer "addressed" and the suite run
already answers "broke nothing".

A finding you decide not to fix is a ruling — `Final: Ruling: <finding> —
<why the code stands> — <cost if wrong>` — and reaches your human partner
in the rulings list. There is no second fix pass.

## Finish

Before you delete anything, collect every ledger line containing
`Ruling:` into your final message
under "Rulings I made", in the order you made them, each with what it
costs if wrong, and every `minor (deferred)` line under "Deferred minors".
Both lists are exhaustive. Your final message is the only place the
decisions you took on your human partner's behalf — and the findings you
chose not to act on — reach them.

Then finish the branch exactly as subagent-driven-development's Step 6:
base branch, the integration menu, and cleanup of `<workspace>`.

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "I remember what Task N says" | You remember a summary. The brief has the exact values. Read it. |
| "The plan's code is right, skip watching the test fail" | A test you never saw fail proves nothing. It is one step. Run it. |
| "I'll run the full suite at the end instead of per step" | Per-step runs are how you learn which step broke it. The end-of-task run is the contract, not a substitute. |
| "The plan is wrong here, I'll just do the right thing" | Do the right thing and record the ruling. Unrecorded deviation is a decision made in secret. |
| "I'll write the ledger lines after a few tasks" | Compaction does not wait for a convenient moment. One line per task, in the same message as the commit. |
| "Let me check in before the next task" | They chose native to spend less. Progress prompts spend their time instead. Only the four stops stop you. |
| "I read my own diff carefully; the final reviewer is redundant" | Same author, same blind spots. The reviewer is the only fresh context this run buys. |
| "Tests should pass, the change was trivial" | "Should" is not evidence. The contract requires the command and its output. |
| "The reviewer said Minor, so it's Minor" | The label graded the spec's silence. Grade what the person gets. Re-grade, then gate. |
| "The fix is obvious, no need for a failing test first" | The failing test is the only proof the finding was real and is now gone. |
| "I'll fix the minors too while I'm in there" | Every minor you fix is a test, a fix, and a suite run your partner did not ask for. Record them; your partner decides. |
