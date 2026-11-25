---
name: pr-review
description: One independent multi-model review round of a PR before it merges, run by the review-lead and reviewer subagents (Sonnet and Haiku lenses). Use when the user types /pr-review or asks for the review round before merging a PR.
---

# PR Review

Run one independent review round on the PR, fix what it confirms, and report the outcome.

## Review Round

- Target: the PR number the user gives; else the open PR of the current branch (`gh pr view --json number,baseRefName`). No PR → ask.
- Spawn one fresh subagent: `reviewer` for a UI-only change (layout, styles, components, copy), `review-lead` for any other change.
- Brief: PR number, base ref, and spec reference (linked issue or plan path, if any) only. Never pass your own summary or conclusions.
- The round returns one finding list. Assess each finding against the intent of the change. Fix confirmed findings in one round, in this PR. Defer a confirmed defect only for a stated reason beyond "out of scope" (large, risky, blocked on unknowns).
- Commit and push fixes to the PR branch.
- One round per PR: commits that fix review findings get no second round.

## Report

Post the outcome as a PR comment (`gh pr comment <n> --body-file <file>`) and give it to the user:

- The covered commit range.
- One line per finding: the defect, then the fix commit or the rejection reason.

Never restate the PR description or its verification. Do not merge; the user decides.
