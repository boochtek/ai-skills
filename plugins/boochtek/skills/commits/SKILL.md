---
name: commits
description: Git commit practices including AI attribution trailers, atomic commits, and commit message guidelines. Use when preparing commits, suggesting commit messages, or when AI-assisted code is being committed.
---

# Commits

## Commit Style

- Keep commits small, focused, and atomic
- Each commit should be safe for `git bisect` and easy to rollback
- Suggest multiple commits when appropriate to maintain atomicity
- Ensure tests and linting pass before each commit

## Commit Messages

- Concise — 1-2 sentence summary on the first line
- Focus on **why**, not what (the diff shows the what)
- Have commit messages approved before committing

## Batching

- When told to "proceed through to commit," batch reviews and lint fixes aggressively — aim for one CI run after all reviews
- When implementing multiple steps with a commit per step, run reviews and ensure tests/lint pass before each commit

## AI Attribution Trailers

When creating commits for work done with AI assistance, include git trailers to indicate the level and source of AI involvement.

- **`AI-Generated-By:`** — AI wrote (substantially) all of the code in the commit
- **`AI-Assisted-By:`** — Human collaborated with AI, beyond prompting and answering questions

Format: `<Trailer>: <Model Name> (<model-id>) via <tool> (<version>)`

Determine the tool version dynamically (e.g., `claude --version` for Claude Code).
Do not hardcode versions from examples.

Example: `AI-Assisted-By: Claude Sonnet 4.5 (claude-sonnet-4-5-20250514) via Claude Code (2.1.72)`

**Note:** AI attribution trailers may exceed the 72-character line limit. This is acceptable.

**Note:** When using these trailers, a `Co-Authored-By:` trailer should **not** be included (unless there was a 2nd human collaborator).
