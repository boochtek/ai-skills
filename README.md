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

### `/brew-update`

Updates Homebrew and all installed packages.
Provides a summary of what changed, with TLDRs for notable upgrades.

### `/learn`

Persist learnings and insights across sessions.
Stores memories in XDG-compliant directories
(`${XDG_DATA_HOME}/ai/memory/` for global, `.ai/memory/` for project).
Lazily bootstraps storage on first use, including Claude Code symlinks.

### `/remember`

Alias for `/learn` — quick way to persist a single insight.

### `/retro`

Session retrospective — analyzes what worked, what didn't,
and proposes improvements to skills, commands, and workflow.

### `/restore-website`

Restore a lost website from the Internet Archive's Wayback Machine
and convert it to a Hugo static site.

### `/publish-to-plugin`

Migrate a local command or skill to the boochtek plugin for publishing.
Handles quality review, file migration, symlinks, and commits in both repos.

## Skills

### `bash-tool`

Rules for using the Bash tool in Claude Code.
Covers stderr redirections, dedicated tools, permissions, and common pitfalls.

### `learn`

Cross-platform memory system for persisting learnings.
Routes insights to the right destination: memory files, skill updates,
or AGENTS.md. See the `/learn` command above.

### `restore-website`

Detailed workflow for the `/restore-website` command,
including inventory, download, and Hugo conversion phases.

## Cross-Agent Compatibility

These skills and commands are designed for Claude Code
but can also be used by other AI agents.
Run the sync script to create symlinks in your agent's config directory:

```bash
./sync-to-global.sh
```

Or symlink individual files manually:

```bash
BOOCHTEK_PLUGIN_PATH='~/.config/claude/plugins/marketplaces/boochtek/plugins/boochtek'
ln -s "$BOOCHTEK_PLUGIN_PATH"/commands/learn.md ~/.config/ai/commands/learn.md
ln -s "$BOOCHTEK_PLUGIN_PATH"/skills/learn/SKILL.md ~/.config/ai/skills/learn/SKILL.md
```

## License

See [LICENSE](LICENSE.txt).

[plugins]: https://docs.anthropic.com/en/docs/claude-code/plugins
[buchek]: https://craigbuchek.com
[boochtek]: https://boochtek.com
