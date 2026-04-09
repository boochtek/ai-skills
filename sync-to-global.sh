#!/usr/bin/env bash
# Sync boochtek plugin commands and skills to the global ~/.config/ai/ directory
# via symlinks so Claude Code discovers them in every session.
#
# Run after adding new commands or skills to the plugin.
# Safe to re-run — skips existing symlinks, reports what it does.

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "$0")/plugins/boochtek" && pwd)"
GLOBAL_DIR="${HOME}/.config/ai"

synced=0
skipped=0

# Sync commands: symlink each .md file
for cmd in "${PLUGIN_DIR}"/commands/*.md; do
  [ -f "$cmd" ] || continue
  name="$(basename "$cmd")"
  target="${GLOBAL_DIR}/commands/${name}"
  if [ -e "$target" ]; then
    skipped=$((skipped + 1))
  else
    ln -s "../../claude/plugins/marketplaces/boochtek/plugins/boochtek/commands/${name}" "$target"
    echo "  linked command: ${name}"
    synced=$((synced + 1))
  fi
done

# Sync skills: symlink the SKILL.md inside a matching directory
for skill_dir in "${PLUGIN_DIR}"/skills/*/; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"
  target_dir="${GLOBAL_DIR}/skills/${name}"
  target="${target_dir}/SKILL.md"
  if [ -e "$target" ]; then
    skipped=$((skipped + 1))
  else
    mkdir -p "$target_dir"
    ln -s "../../../claude/plugins/marketplaces/boochtek/plugins/boochtek/skills/${name}/SKILL.md" "$target"
    echo "  linked skill:   ${name}/SKILL.md"
    synced=$((synced + 1))
  fi
done

echo "Done: ${synced} linked, ${skipped} already present."
