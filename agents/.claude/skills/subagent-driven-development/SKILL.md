---
name: subagent-driven-development
description: Use when executing a written implementation plan with subagents - your human partner chose subagent-driven execution. Dispatches a fresh implementer subagent per task, reviews each task, verifies with real output, and integrates the finished branch
---

# Subagent-Driven Development

## Overview

Set up, review the plan critically, then execute every task through the
subagent loop: a fresh implementer subagent per task, a task review after
each one, a whole-branch review at the end. Verify with real output, then
integrate the branch.

**Why subagents:** each implementer gets exactly the context its task needs —
no session history bleeding in — and each reviewer judges the diff without
trusting the implementer's claims. Your own context stays clean for
coordination, so a long plan doesn't degrade as you go.

**Announce at start:** "I'm using the subagent-driven-development skill to implement this plan."

**Commits:** ALWAYS use the caveman-commit skill for commit messages — every
commit this skill produces: implementer commits, fix commits, merge commits.
The plan's commit steps may carry a suggested message; caveman-commit's
format wins (Conventional Commits, subject ≤50 chars, body only when the
why isn't obvious). The dispatch carries this rule to implementers.

## Continuous Execution

Do not pause to check in with your human partner between tasks. They asked
you to execute the plan; execute it. "Should I continue?" prompts and
progress summaries waste their time.

**Rulings, not stalls.** A running plan does not wait on a human. Conflicts,
ambiguities, plan defects discovered mid-execution — decide them. The spec the plan
names (with no spec, the plan's Goal and Global Constraints) is the
binding authority, the tasks are its argument, and your judgment settles
what neither answers. Record every decision in the ledger (see Step 1) as:

```
Ruling: <what you decided> — <why> — <what it costs if wrong>
```

A wrong ruling costs rework your human partner can see and undo; a session
parked on a question costs their whole day and buys nothing.

Four things stop you, and only these:

1. An irreversible or destructive operation
2. A security-sensitive action
3. A side effect outside this branch (a merge, a push to a shared branch, a
   publish)
4. A plan so broken that every path forward is a guess

For those, stop and ask.

## Step 1: Set Up

1. **Feature branch.** Check where you are:

   ```bash
   BRANCH=$(git branch --show-current)
   ```

   Stay on it if it is a feature branch for this work. On main/master or an
   unrelated branch, make a new one named `<prefix>/<feature-name>`:

   - **Prefix:** ask which to use (`feature/`, `chore/`, `fix/`,
     `refactor/`). With no answer, pick one from what the plan does and say
     which.
   - **Feature name:** the plan's feature folder without its date, plus the
     sub-project unless it is `main` (`2026-08-17-user-auth/oauth/` →
     `user-auth-oauth`).

   Check the name is free — fetch first, or you only see stale remote refs.
   Empty output means available:

   ```bash
   git fetch --quiet
   git branch -a --list "<prefix>/<feature-name>" "*/<prefix>/<feature-name>"
   git checkout -b "<prefix>/<feature-name>"
   ```

   If taken, make it more specific (`feature/user-auth-login`), not
   numbered, and say which name you chose. Never implement on main/master
   without explicit consent.

2. **Baseline.** Install dependencies if needed, then run the full test suite
   before changing anything. A green baseline is what makes a later failure
   attributable to your work. If the suite is red, report the failures and
   ask whether to proceed or investigate — proceeding past a red baseline is
   your human partner's call, not yours. If they say proceed, ledger the
   failing tests so later runs are read against them.

3. **Workspace.** Run this skill's `scripts/sdd-workspace PLAN_FILE`. It
   prints the plan's workspace — `.work/` inside the plan's folder (plan
   `.agentsout/2026-08-17-user-auth/core/plan.md` →
   `.agentsout/2026-08-17-user-auth/core/.work/`) — and creates it,
   self-ignored. Below, `<workspace>` means that folder. It holds every
   artifact for THIS plan: ledger, briefs, reports, review packages.
   Another plan's workspace is never yours to read or write.

   These files are the handoff medium: subagents read and write files, not
   your context. Everything you paste into a dispatch prompt — and everything
   a subagent prints back — stays resident in your context for the rest of
   the session. Hand artifacts over as paths.

4. **Ledger.** Conversation memory does not survive compaction. In real
   sessions, controllers that lost their place have re-dispatched entire
   completed task sequences — the single most expensive failure observed.
   Track progress in `<workspace>/progress.md`, not only in todos.

   - If the ledger exists and its first line names your plan file, tasks
     with a `Task <N>: complete` line are DONE — do not re-dispatch them;
     resume at the first task without one. A task whose last line is a fix
     round is mid-loop: resume the loop at the next round.
   - Otherwise create it with its identity as the first line:
     `# SDD ledger — plan: <plan file path>`.
   - The commits the ledger names exist in git even when your context no
     longer remembers creating them. After compaction, trust the ledger and
     `git log` over your own recollection.
   - `git clean -fdx` destroys the workspace; if that happens, recover from
     `git log`.

## Step 2: Load and Review the Plan

1. Read the plan file. If its header names a Spec, read that too.
   Conflicts between a task and the spec resolve against the spec.
2. Note the plan's Global Constraints. They bind every task.
3. The plan and any spec are gitignored on purpose. Never `git add -f` them.
4. Review critically: identify questions, gaps, or contradictions.
5. Concerns found now — before any execution — are cheap to raise, so raise
   them. Once execution starts, defects you discover get a ruling instead
   (see Continuous Execution).
6. **Pre-flight scan.** Before dispatching Task 1, scan the plan once for
   conflicts, writing down what you checked as you check it:

   - tasks that contradict each other or the plan's Global Constraints
   - anything the plan explicitly mandates that the review rubric treats
     as a defect (a test that asserts nothing, verbatim duplication of a
     logic block)

   The scan's output is a table, not a verdict. One row for every pair of
   tasks that share a file or an interface: the two tasks, what one
   produces against what the other consumes, and what you found. One row
   for every task: whether its own text agrees with itself — the tests it
   specifies against the code it specifies, the files it creates against
   the files it later touches. "The scan is clean" without those rows is
   not a scan you ran.

   Write the table to the ledger. Rule on each conflict it surfaces — the
   spec is the binding authority, the plan is its argument — and record
   each ruling beside its row. The review loop remains the net for
   conflicts that only emerge from implementation.
7. Create a todo per task and proceed.

## Model Selection

Use the least powerful model that can handle each role. Cheaper models save
tokens and run faster — but only when they don't burn the savings on extra
turns or fix rounds.

**Always specify the model explicitly when dispatching a subagent.** An
omitted model inherits your session's model — often the most capable and
most expensive — which silently defeats this section.

**Implementers:**

- Single-file mechanical fixes and batched same-shape edits → `haiku`
- Default: the implementer writes code from the task's Interfaces,
  signatures, and test code → `sonnet`
- Requires design judgment or broad codebase understanding → `opus`

**Reviewers:** scale to the diff's size, complexity, and risk. A small
mechanical diff doesn't need a capable model; a subtle concurrency change
does. Use `sonnet` as the floor for task reviews; scoped re-reviews of small
fix diffs take `haiku`.

**Final whole-branch review:** a strong model — this is
the last gate before integration, not the place to economize.

**Turn count beats token price.** Wall-clock and context cost scale with how
many turns a subagent takes, and the cheapest models routinely take 2-3× the
turns on multi-step work — costing more overall. When in doubt between
tiers, take the higher one for anything requiring judgment.

**Fix-loop escalation (rounds 4-5):** a fresh implementer at least one
tier above the one that got stuck, never the same model unchanged.

## Step 3: The Task Loop

For each task, in order — never dispatch implementers in parallel (they'd
conflict), and never implement in the controller session yourself:

1. **Mark it in progress.** Record the base:

   ```bash
   BASE=$(git rev-parse HEAD)
   ```

2. **Write the brief.** Run this skill's `scripts/task-brief PLAN_FILE N`.
   It extracts the task's full text to `<workspace>/task-N-brief.md` and
   prints the path. The brief is the single source of requirements: exact
   values, signatures, and test cases appear there, not in the dispatch
   prompt. Never make a subagent read the whole plan file.

3. **Dispatch the implementer** using `implementer-prompt.md` (in this
   skill's directory), on the model Model Selection picks for the task. The
   dispatch contains: one line on where the task fits
   in the project; the brief path ("read this first — it is your
   requirements"); interfaces and decisions from earlier tasks the brief
   cannot know, including any relevant rulings and a pointer to any
   finding an earlier task parked in the area this task touches; the
   plan's Global Constraints; and the report path
   `<workspace>/task-N-report.md`. Nothing else — no accumulated session
   history, no prior-task summaries. Record the implementer's agent
   identity: fix rounds 1-3 resume it.

4. **Handle the report.** Implementers return one of four statuses:

   - **DONE** — proceed to the review.
   - **DONE_WITH_CONCERNS** — read the concerns first. Correctness or scope
     concerns get addressed before review; observations get recorded in
     the ledger.
   - **NEEDS_CONTEXT** — provide the missing context and re-dispatch.
   - **BLOCKED** — assess: a context problem gets more context; a task too
     large gets split into smaller dispatches; a wrong plan gets a ruling
     (recorded in the ledger) and a re-dispatch carrying it. Never
     force an unchanged retry — if the implementer said it's stuck,
     something needs to change.

   If the implementer asks questions — before starting or mid-task — answer
   clearly and completely. Don't rush it into implementation.

5. **Review the task.** Run this skill's
   `scripts/review-package PLAN_FILE $BASE HEAD`. It writes the commit
   list, stat summary, and full diff with context to one file in
   `<workspace>` and prints the path, so the reviewer reads one file and
   the diff never enters your context. Use the recorded `$BASE` — never
   `HEAD~1`, which silently drops all but the last commit of a
   multi-commit task. Dispatch a reviewer using `task-reviewer-prompt.md`
   with the brief, report, and package paths, plus the Global Constraints
   copied verbatim. Never skip it — implementer self-review never replaces
   it. Don't pre-judge findings for the reviewer ("don't flag X" means
   you're dodging a review loop), and don't ask it to re-run tests the
   implementer already ran.

   A ⚠️ "cannot verify from diff" item is yours to resolve — you hold the
   cross-task context the reviewer lacks. If it's a real gap, it enters the
   fix loop with the other findings.

6. **The fix loop** — triggers on spec ❌, any Critical/Important finding,
   or a ⚠️ item you confirmed as a real gap. Two routes leave it before it
   starts:

   - Minor findings never enter the loop: ledger them as
     `Task <N>: minor (deferred): <one-liner>` for the final review to
     triage.
   - A finding labeled plan-mandated — or any finding that conflicts with
     what the plan's text requires — is yours to rule on: weigh it against
     the plan text with the spec as the binding authority, and ledger the
     ruling before you act on it.

   Everything else enters the loop. A round is one fix dispatch plus one
   scoped re-review, five rounds maximum per task:

   - **Rounds 1-3** resume the original implementer with the open findings
     verbatim — its context is intact.
   - **Rounds 4-5** dispatch a fresh implementer one tier up (per Model
     Selection) with the brief path, the report-file path, the open
     findings, and: "A prior implementer attempted this task [N] times;
     you own it now. Read the report file for what was tried."
   - **Every round:** record `FIX_BASE=$(git rev-parse HEAD)` (the head the
     review saw) before the fix. The implementer fixes, re-runs the
     covering tests, appends a fix report to its report file, and returns
     the short status contract. Confirm the fix report names the covering
     tests, the command, and the output, then run
     `scripts/review-package PLAN_FILE $FIX_BASE HEAD` and dispatch a
     re-review using `re-review-prompt.md` (`haiku` for small fix diffs)
     with the findings list, brief, report, and package paths. New
     Critical/Important breakage in the fix diff joins the open findings;
     out-of-scope observations go to the ledger as deferred minors — they
     never extend the loop.
   - **After each round,** ledger:
     `Task <N>: fix round <R>/5 (<X> addressed, <Y> open — <finding one-liners>; commits <a7>..<b7>)`

   Never fix findings yourself in the controller session: your context
   stays clean for coordination, and controller fixes skip review.

   **The breaker.** When round 5's re-review still leaves findings open,
   stop dispatching and adjudicate each open finding yourself:

   - **The reviewer is wrong, or the point is contestable:** park it —
     `Task <N>: parked — <finding> — Ruling: <why the code stands>`. The
     final review sees both sides.
   - **Real, but nothing downstream builds on it:** park it the same way,
     with a ruling that says it's real and deferred.
   - **Real and load-bearing** — a later task builds on it, or it reveals
     a plan defect: rule on the smallest change that unblocks the dependent
     work, ledger it as `Task <N>: Ruling: <finding> — <what you decided and why>`,
     and carry it into the next task's dispatch. Stop only when the defect
     leaves every path forward a guess.

   Adjudicate only at the cap. Adjudicating earlier to end a loop is
   pre-judging with a different name. Every adjudication is a ledger
   entry — a silent discard is forbidden.

7. **Complete the task.** When the review comes back clean — or every open
   finding is parked with a ruling at the cap — append the completion line
   to the ledger in the same message as your other bookkeeping:

   - `Task <N>: complete (commits <base7>..<head7>, review clean)`
   - `Task <N>: complete (commits <base7>..<head7>, <K> parked)` after a
     tripped breaker

   Then mark the todo complete and move on. Never advance with open
   Critical/Important findings that are neither fixed nor parked with a
   ruling at the cap.

**Batch small same-shape work.** When the plan lists several tasks that are
each a tiny, independent edit of the same kind — the same one-line fix or
field addition repeated across files — compose ONE brief listing every file
and its change, dispatch one implementer, and review the batch as one diff.
Reserve one-dispatch-per-task for work that needs its own judgment, tests,
or review surface.

## Step 4: Verify Before Claiming Done

Evidence before assertions. Before calling any task — or the whole plan —
complete:

- **Run the actual command.** Never infer from the code that it would pass.
- **Read the actual output.** "Should work" is not evidence; a green run is.
- **If you didn't run it, say so.** Report what you verified and what you
  didn't, plainly. Never let silence imply a check you skipped.

Subagent reports are claims, not evidence — the task review checks the diff,
and this step is where you run the suite with your own eyes.

## Step 5: Final Review

After the last task, run the full test suite yourself. If it fails, report
the failures and stop.

Then run `scripts/review-package PLAN_FILE MERGE_BASE HEAD`
(`MERGE_BASE=$(git merge-base <base-branch> HEAD)`) and dispatch one
whole-branch review on a strong model (per Model Selection), using
requesting-code-review's
[code-reviewer.md](../requesting-code-review/code-reviewer.md). Fill
`[PLAN_OR_REQUIREMENTS]` with the plan path and the spec path if there is
one; give it the package path so it reads one file instead of re-deriving
the diff, the plan's Review Focus section verbatim (the input classes and
failure modes the plan's tests do not exercise — the reviewer checks each
deliberately), and a pointer to the ledger's deferred-minor and parked
lines so it can triage which must be fixed before merge.

Its "Declined to judge" list is yours: rule on each line and ledger it —
`Final: Ruling: <behavior the reviewer set aside> — <what a reasonable
person using this software gets, and why that stands or why it is now a
finding> — <cost if wrong>`.

If it returns findings: ONE fix dispatch with the complete findings list —
not one fixer per finding — then exactly one scoped re-review of the fix
wave (`scripts/review-package PLAN_FILE FIX_BASE HEAD`,
`re-review-prompt.md`). Adjudicate residual findings as in the breaker:
park with rulings, or rule on the load-bearing ones and ledger what you
decided. There is no second fix wave — residual load-bearing findings
surface to your human partner alongside the integration menu.

## Step 6: Finish the Branch

**Surface your rulings first.** Collect every ledger line containing
`Ruling:` — preflight rulings, parked findings, breaker adjudications, all
of them — into your completion message, in order, each with what it costs
if wrong. The list is exhaustive. That list is the only place the decisions you took on your human
partner's behalf reach them — a ruling they never see was a decision made in
secret.

**Detect environment:**

```bash
BRANCH=$(git branch --show-current)
```

**Determine the base branch.** It's whatever this work forked from — usually
named in the plan, the conversation, or the branch's upstream. If it isn't
already known, ask: "This branch split from <your best guess> - is that
correct?" Merging into the wrong base is expensive to undo.

**Offer these options, then wait.** The integration decision is your human
partner's.

```
Implementation complete. What next?
1. Merge into <base-branch> locally
2. Push and open a PR
3. Keep the branch as-is
```

On a detached HEAD (`BRANCH` empty), drop option 1; option 2 pushes it as a
new branch.

**Option 1 — merge locally:**

```bash
git checkout <base-branch>
git pull
git merge <feature-branch>
<test command>
```

If tests fail on the merged result, stop and investigate — nothing is pushed,
so the merge is local and recoverable. Once green, `git branch -d <feature-branch>`.

**Option 2 — push and PR:** `git push -u origin <feature-branch>`, then open
the PR against the base branch with the forge's CLI or the URL the push
prints. ALWAYS look for a pull request template in the repo first —
`.github/PULL_REQUEST_TEMPLATE.md`, `.github/pull_request_template.md`, a
`.github/PULL_REQUEST_TEMPLATE/` directory, or the repo root/`docs/` — and
fill it in as the PR body; only write a free-form body when no template
exists. Report the URL. Keep the branch — PR feedback gets fixed there.

**Option 3 — keep as-is:** Report "Keeping branch <name>."

After integration (options 1 or 2), delete this plan's workspace
(`rm -rf <workspace>`) — git history is the record now. Keep `plan.md` and any `spec.md`. Sibling sub-project folders belong to
other plans; leave them alone.

**Discarding** happens only when your human partner asks for it in so many
words. Confirm first, listing the branch and its commits, and require the
typed word `discard`. Then check `git status --porcelain -uall` for work that
exists nowhere else — show anything you find and ask before proceeding, and only then `git checkout <base-branch> && git branch -D <feature-branch>`.

## When to Stop and Ask

Before Task 1, a red baseline stops you (Step 1). Once running, only the
four conditions in Continuous Execution stop the plan. Everything else —
ambiguity, plan defects, conflicts, findings open at the breaker — gets a
ruling in the ledger and execution continues.

## Common Rationalizations

| Excuse                                                | Reality                                                                                                                                |
| ----------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| "I'm already on a branch, that's good enough"         | main/master and someone else's feature branch are both wrong. Check the name, then create `<prefix>/<feature-name>` if it isn't yours. |
| "I'll just pick a prefix, no need to ask"             | Conventions are per-repo. Ask first; fall back to the four types only when you get no answer, and say which you picked.                |
| "The branch name is probably free"                    | Run the `git branch -a --list` check. Colliding with an existing branch costs a rename mid-flight.                                     |
| "The baseline suite takes a while — I'll start now"   | One run up front is cheaper than debugging a failure your work never caused, and you run it at the end regardless.                     |
| "This failing test was probably already broken"       | Without a recorded baseline you cannot know. That's what Step 1 is for.                                                                |
| "The baseline is red but it's unrelated — I'll proceed" | Report it and ask. Proceeding past a red baseline is your human partner's call.                                                      |
| "This task is small, I'll just do it myself"          | Controller fixes and controller implementations skip review and pollute your coordination context. Dispatch it.                        |
| "I'll fix the finding myself, dispatching is overhead" | Same problem. Resume the implementer — its context is intact and its fix gets re-reviewed.                                            |
| "The fix was small, skip the re-review"               | Unreviewed fixes are how regressions land. Every round ends with a scoped re-review.                                                   |
| "The implementer spawned its own reviewer — free extra assurance" | It duplicates the task review at full cost and its approval counts for nothing. It's a defect to flag, not rigor.          |
| "Close enough on spec compliance"                     | Reviewer found spec gaps = not done. Fix or hit the cap and adjudicate — those are the only exits.                                     |
| "One more round will converge"                        | Past the cap, rounds don't converge — the failure is structural. Adjudicate and route.                                                 |
| "This finding is obviously wrong, I'll drop it"       | You adjudicate only at the cap, and every ruling is a ledger entry. Silent discards are forbidden.                                     |
| "Ledger bookkeeping is overhead"                      | The ledger is what survives compaction. Controllers without one have re-dispatched entire completed task sequences.                    |
| "I'll check in with a progress summary between tasks" | They asked you to execute the plan. Rulings go in the ledger; only the four stop conditions interrupt.                               |
| "The plan's step is clumsy — I'll do it a better way" | The tasks argue from the spec.   Rule on it, record the ruling, and carry it into the dispatch — don't silently redesign.                |
| "The code obviously works, no need to run it"         | Evidence before assertions. Run the command, read the output.                                                                          |
| "The subagent said tests pass, that's my verification" | A report is a claim. Step 4 is you running the suite and reading the output yourself.                                                 |
| "Tests passed earlier this session"                   | A green run only proves the tree it ran on. Run the suite on the tree you are about to integrate.                                      |
| "They obviously want it merged"                       | Integration is your human partner's decision. Present the menu and wait.                                                               |
| "'Yeah, get rid of it' counts as confirmation"        | Only the typed word `discard` authorizes deletion.                                                                                     |
| "The base branch is obviously main"                   | Confirm the fork point or ask.                                                                                                         |
| "The push was rejected — force-push will fix it"      | A rejected push means the remote moved. Investigate; force-push only on explicit request.                                              |
