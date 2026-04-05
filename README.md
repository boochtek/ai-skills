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

## Cross-Agent Compatibility

These skills and commands are designed for Claude Code
but can also be used by other AI agents.
Symlink from your agent's config directory into the plugin:

```bash
BOOCHTEK_PLUGIN_PATH='~/.config/claude/plugins/marketplaces/boochtek/plugins/boochtek'
ln -s "$BOOCHTEK_PLUGIN_PATH"/commands/brew-update.md ~/.config/ai/commands/brew-update.md
```

## License

See [LICENSE](LICENSE.txt).

[plugins]: https://docs.anthropic.com/en/docs/claude-code/plugins
[buchek]: https://craigbuchek.com
[boochtek]: https://boochtek.com
