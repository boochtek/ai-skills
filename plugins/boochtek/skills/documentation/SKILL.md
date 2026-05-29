---
name: documentation
description: "Keeping documentation up to date. Use when making any code changes. Covers READMEs, code comments, AGENTS.md, docs/, etc."
---

# Documentation Updates

Keep documentation in sync with code changes.
When you change behavior, update the docs that describe it.
When you add new functionality, create documentation for it.

## Source Documents Are Read-Only

Primary source documents — specifications, requirements, design docs, RFCs,
and other authoritative references — must not be modified by AI agents.
These documents represent human decisions and intent.
If a source document conflicts with the code, the code is wrong, not the document.

Make source documents read-only (`chmod a-w`) to enforce this mechanically.
If you encounter a read-only document that seems outdated,
flag it to the user rather than changing it.

## Checklist

For each file changed in this session, check for related documentation:

1. **Same-directory or parent README** — does it describe the changed behavior?
2. **Docstrings and comments in the file** — do they describe changed functions, methods, or classes?
3. **AGENTS.md / CLAUDE.md** — does it reference changed commands, workflows, or skills?
4. **docs/ folder** — do any docs describe the changed behavior or API?
5. **Other references** — search for mentions of changed functions, classes, or file names in documentation files

## Actions

| Finding | Action |
|---------|--------|
| Documentation describes old behavior | Update it to match the new behavior |
| New feature, API, or behavior has no docs | Create documentation, following the project's existing conventions |
| Documentation references removed code | Remove or update the reference |
| Comment describes what the code does, not why | Rewrite to explain intent, or remove if the code is self-explanatory |

## Creating New Documentation

When creating documentation for new functionality:

- Follow the project's existing documentation conventions (format, location, level of detail)
- If no conventions exist, place a README in the relevant directory
- Document interfaces, APIs, behaviors, and configuration — not internal implementation details
- Write for the audience: other developers, users, or future AI agents

## What Not to Document

- Internal implementation details that are clear from reading the code
- Trivial getters, setters, or boilerplate
- Anything that would just restate what the code already says
