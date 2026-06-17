---
name: creating-skills
description: Use whenever creating or editing a skill — directs you to the TDD-style skill-creator (superpowers:writing-skills) by default and mandates a second-skill code-review pass before declaring done.
---

# Creating Skills — Craig's protocol

Craig has multiple skill-creation skills available and a preferred ordering. Apply this skill before invoking any of them, so you start with the right one and don't skip the review pass.

## Default: TDD-style first

Three skill-creation skills are installed. **Default to `superpowers:writing-skills`** — it treats skills as documentation under TDD discipline (write pressure scenarios → run baseline → write the skill → verify compliance → refactor loopholes). That mirrors Craig's TDD preference for code, applied to documentation.

Deviate only for these specific reasons:

| Use | When |
|---|---|
| **`superpowers:writing-skills`** | Default. Use this unless one of the cases below is unambiguously true. |
| `anthropic-skills:skill-creator` | The skill must compete with many similar skills for triggering — discoverability/description tuning matters more than rationalization-proofing. Or Craig explicitly opts in. |
| `plugin-dev:skill-development` | The skill is destined to ship inside a Claude Code plugin (`boochtek` or otherwise) and you need plugin manifest integration up front. |

Don't agonize over the choice. The cost of switching mid-draft is low. If unsure, pick `superpowers:writing-skills`.

## Mandatory: second-skill review pass

After writing the skill, **always do a code-review of the skill with a different skill-creation skill before declaring it done.** A skill written with one creator has blind spots that the same creator can't critique — its own conventions look invisible.

| Wrote with | Review with | Why pairing works |
|---|---|---|
| `superpowers:writing-skills` | `anthropic-skills:skill-creator` | TDD lens misses discoverability + token efficiency; anthropic lens covers them |
| `anthropic-skills:skill-creator` | `superpowers:writing-skills` | Discoverability lens misses rationalization loopholes; TDD lens probes them |
| `plugin-dev:skill-development` | `superpowers:writing-skills` | Plus manually validate plugin manifest integration |

The review produces a punch list. Apply the changes, then the skill is done.

## End-state: publish if portable

If the skill is broadly useful (not user-specific config or Craig's personal accounts), suggest running `/publish-to-plugin` to migrate it into the `boochtek` plugin so it's portable across machines. Skills that bake in personal paths or account specifics stay local at `~/.claude/skills/`.

## Why this protocol exists

Skills that ship without a second-perspective review tend to fail in production with subtle issues: bloated descriptions that overtrigger, missing bundled scripts that force every invocation to re-derive the same code, triggering ambiguity that makes the skill never load. Two perspectives cost ~10 minutes and catch most of these. The TDD-first default reflects Craig's broader philosophy: tests-as-executable-specifications, applied to skills-as-executable-process-documentation.
