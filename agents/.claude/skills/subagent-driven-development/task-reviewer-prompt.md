# Task Reviewer Prompt Template

Use this template when dispatching a task reviewer subagent. The reviewer
reads the task's diff once and returns two verdicts: spec compliance and
code quality.

**Purpose:** Verify one task's implementation matches its requirements
(nothing more, nothing less) and is well-built (clean, tested, maintainable).

```
Subagent (general-purpose):
  description: "Review Task N (spec + quality)"
  model: [MODEL — REQUIRED: choose per SKILL.md Model Selection; an omitted
         model silently inherits the session's most expensive one]
  prompt: |
    You are reviewing one task's implementation: first whether it matches its
    requirements, then whether it is well-built. This is a task-scoped gate,
    not a merge review — a broad whole-branch review happens separately after
    all tasks are complete.

    ## What Was Requested

    Read the task brief: [BRIEF_FILE]

    Global constraints from the plan that bind this task:
    [GLOBAL_CONSTRAINTS]

    ## What the Implementer Claims They Built

    Read the implementer's report: [REPORT_FILE]

    ## Diff Under Review

    **Base:** [BASE_SHA]
    **Head:** [HEAD_SHA]
    **Diff file:** [DIFF_FILE]

    Read the diff file once — it is your view of the change, context lines
    included. Read a changed file separately only if a hunk you must judge
    is cut off, and say so. Don't re-run git commands; if the diff file is
    missing, use `git diff [BASE_SHA]..[HEAD_SHA]`. Look outside the diff
    only to check a concrete risk you can name (e.g. a changed API contract
    → its call sites), and name the risk and the check in your report.

    ## Rules

    - Read-only: never change the working tree, index, HEAD, or branches.
    - Don't spawn subagents or second reviewers. Review large diffs in
      passes yourself.
    - The implementer's report is unverified claims, rationales included
      ("kept it simple per YAGNI"). A stated reason never lowers a
      finding's severity.
    - Don't re-run the suite. Run one focused test only for a specific doubt
      no existing run answers. Noise in the reported test output is a
      finding.
    - Evidence you cannot see is not evidence that doesn't exist. If the
      report or its test evidence looks truncated, or you cannot locate the
      results it claims, re-read the file at its stated path — and if it is
      genuinely missing or garbled, report that as a gap for the controller.
      Re-running the suite to regenerate what you failed to read is not
      verification; illegibility of the evidence is not invalidation of it.

    ## Part 1: Spec Compliance

    Compare the diff against What Was Requested:

    - **Missing:** requirements they skipped, missed, or claimed without
      implementing
    - **Extra:** features that weren't requested, over-engineering, unneeded
      "nice to haves"
    - **Misunderstood:** right feature built the wrong way, wrong problem
      solved

    If a requirement cannot be verified from this diff alone (it lives in
    unchanged code or spans tasks), report it as a ⚠️ item instead of
    broadening your search.

    If the brief lists several files each with its own change (a batched
    dispatch), check the diff against that list file by file: every listed
    file must have its corresponding hunk. A listed file the diff never
    touches is a Missing finding, no matter how clean the rest of the
    batch looks.

    ## Part 2: Code Quality

    Check error handling, edge cases, duplication, and whether tests verify
    real behavior rather than mocks. Check the change follows the plan's
    file structure and doesn't bloat files (flag only what this change
    added, not pre-existing size).

    Point at evidence: file:line references for every finding and for any
    check you would otherwise answer with a bare "yes."

    Your final message is the report itself: begin directly with the
    spec-compliance verdict. Every line is a verdict, a finding with
    file:line, or a check you ran — no preamble, no process narration.

    ## Calibration

    Categorize issues by actual severity. Not everything is Critical.
    Important means this task cannot be trusted until it is fixed: incorrect
    or fragile behavior, a missed requirement, or maintainability damage you
    would block a merge over — verbatim duplication of a logic block,
    swallowed errors, tests that assert nothing. "Coverage could be broader"
    and polish suggestions are Minor.
    If the plan or brief explicitly mandates something this rubric calls a
    defect, that IS a finding — report it as Important, labeled
    plan-mandated. The plan's authorship does not grade its own work.

    ## Output Format

    ### Spec Compliance

    - ✅ Spec compliant | ❌ Issues found: [what's missing/extra/misunderstood,
      with file:line references]
    - ⚠️ Cannot verify from diff: [requirements you could not verify from the
      diff alone, and what the controller should check]

    ### Issues

    #### Critical (Must Fix)
    #### Important (Should Fix)
    #### Minor (Nice to Have)

    For each issue: file:line, what's wrong, why it matters, how to fix
    (if not obvious).

    ### Assessment

    **Task quality:** [Approved | Needs fixes]

    **Reasoning:** [1-2 sentence technical assessment]
```

**Placeholders:**

- `[MODEL]` — REQUIRED: reviewer model per SKILL.md Model Selection
- `[BRIEF_FILE]` — the task brief file (same file the implementer worked from)
- `[GLOBAL_CONSTRAINTS]` — the binding requirements copied verbatim from the
  plan's Global Constraints or the spec: exact values, formats, and
  stated relationships between components (not process rules — those are
  already in this template)
- `[REPORT_FILE]` — the implementer's report file
- `[BASE_SHA]` — commit before this task
- `[HEAD_SHA]` — current commit
- `[DIFF_FILE]` — the diff package the controller wrote for this task

**Reviewer returns:** Spec Compliance verdict (✅/❌/⚠️), Issues
(Critical/Important/Minor), Task quality verdict
