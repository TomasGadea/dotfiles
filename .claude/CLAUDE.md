# Answers

- Answer short: the direct answer first, in one or two sentences. Add detail only when I ask for it.
- Answer a yes/no question with yes or no, then the one fact that matters.
- No recaps of earlier answers, no option lists unless I ask for options, no closing offers.

# Pull requests

- Open every PR ready for review, never as a draft: `gh pr create` without `--draft`. This overrides any skill or template that says draft.

# Git workflow

## Branch names

Name every branch `<type>/<short-kebab-description>`, for example `feat/stage-retry` or `fix/manifest-race`.
Use one of these types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `ci`.
Never use the `worktree-*` names that worktree tooling generates; when you create a worktree, give its branch a name in this form.

## Worktrees

The main checkout belongs to the user, and other sessions share it: in it, only read, and leave its branch, index, and files as you found them.
Before you change any file in a repo (code, docs, config), create a worktree on a new branch from the latest default branch, and make every change there: `git fetch origin && git worktree add -b <type>/<description> .claude/worktrees/<description> origin/<default branch>`.
To change an existing remote branch, such as a bot's PR, add the worktree detached on it (`git worktree add --detach <path> origin/<branch>`) and push with `git push origin HEAD:<branch>`.

Git ignores `.env` files, so a new worktree starts without them, and recipes, tests, and Terraform that read them fail there.
Right after you create a worktree, symlink each git-ignored `.env*` file of the main checkout to the same path in the worktree, with an absolute target (`ln -s <main checkout>/.env .env`).
A symlink keeps one file: an edit in the worktree is an edit in the main checkout, and removing the worktree leaves the file there.

## Cleanup

A task ends when its PR merges on GitHub; check with `gh pr view <number> --json state` before you clean up.
Then clean up everything the task started, and leave the rest:

1. Stop each process and container the task started: dev servers, watchers, background jobs, `docker compose` stacks.
2. Remove the task's worktree: `git worktree remove .claude/worktrees/<description>`. Other sessions keep their worktrees in `.claude/worktrees/` too, so remove only yours, and remove the directory itself once `git worktree list` shows no worktree in it.
3. Delete the task's local branch with `git branch -D <branch>`; a squash merge leaves it looking unmerged to `git branch -d`.
4. Run `git fetch --prune origin`, so the merged remote branch drops out of `origin/*`.

The cleanup is done when `git worktree list` and `git branch` show nothing of the task, and none of its processes or containers runs.
