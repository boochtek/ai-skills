# BoochTek AI Skills

AI commands and skills for development workflows,
packaged as a [Claude Code plugin][plugins].

By [Craig Buchek][buchek] / [BoochTek][boochtek].

## Installation

```bash
/plugin marketplace add boochtek/ai-skills
/plugin install boochtek@boochtek
```

Then restart Claude Code.

## Commands

- **`/brew-update`** — Update Homebrew and all installed packages, with a summary of changes
- **`/commit-msg`** — Suggest a concise commit message for staged changes
- **`/learn`** — Persist insights and learnings across sessions
- **`/new-project`** — Collaboratively create a new project with scaffolding, AI config, docs, and GitHub repo
- **`/pre-commit`** — Pre-commit checks: verify tests, lint, review, and suggest a commit message
- **`/refactor`** — Refactor code: improve structure while preserving behavior
- **`/refactor-shrink`** — Reduce code length when linting reports files, classes, or methods are too long
- **`/remember`** — Remember something for future sessions (alias for `/learn`)
- **`/restore-website`** — Restore a lost website from the Wayback Machine and convert it to a Hugo static site
- **`/retro`** — Retrospective on a session: what worked, what didn't, and improvements
- **`/review`** — Run the 3-review SDLC code review process on recent changes
- **`/simplify`** — Review code for simplification opportunities
- **`/tdd`** — Start a TDD workflow: write tests first, then implement
- **`/what-next`** — Suggest what to work on next based on project status and TODOs

## Skills

- **`bash-tool`** — Rules for using the Bash tool in Claude Code
- **`code-quality`** — Naming, structure, and maintainability guidelines
- **`coding`** — Code implementation and feature development (the GREEN phase of TDD)
- **`commits`** — Git commit practices: atomic commits and AI attribution trailers
- **`creating-skills`** — Guidance for creating or editing skills (TDD-style, with a review pass)
- **`design`** — Software design principles and patterns (SOLID, coupling, cohesion)
- **`documentation`** — Keeping documentation up to date alongside code
- **`html`** — HTML and CSS guidelines (Markdown-first output)
- **`lang-elixir`** — Elixir language conventions, tooling, and known issues
- **`lang-javascript`** — JavaScript language conventions, tooling, and known issues
- **`lang-ruby`** — Ruby language conventions, tooling, and known issues
- **`learn`** — Cross-platform memory system for persisting learnings
- **`markdown`** — Writing and editing Markdown files
- **`refactor`** — Code refactoring methodology
- **`restore-website`** — Workflow for restoring a site from the Wayback Machine into Hugo
- **`sdlc`** — Software development lifecycle and code review process
- **`security`** — Secure coding and code review (OWASP Top 10)
- **`tdd`** — Test-Driven Development methodology (the RED phase)
- **`testing`** — Testing philosophy and practices

## Cross-Agent Compatibility

These commands and skills are plain Markdown with YAML frontmatter, usable by any
AI agent that reads command/skill files. Install via the marketplace above for
Claude Code; for other agents (OpenCode, Codex, etc.), symlink the files into that
agent's command/skill directory.

## License

See [LICENSE](LICENSE.txt).

[plugins]: https://docs.anthropic.com/en/docs/claude-code/plugins
[buchek]: https://craigbuchek.com
[boochtek]: https://boochtek.com
