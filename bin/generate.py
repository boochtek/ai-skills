#!/usr/bin/env python3
"""Regenerate plugins/boochtek/ from canonical ~/.config/ai.

The canonical source of truth is ~/.config/ai (override with CONFIG_AI, or
XDG_CONFIG_HOME). An item ships iff its frontmatter contains `publish: true`;
that marker is stripped from the generated copy. Items no longer marked are
removed from the plugin.

Maintainer-only: this copies *out* of a personal canonical tree, so it refuses
to run when that tree is missing or has no published items — which would
otherwise wipe the plugin.
"""
import os
import shutil
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PLUGIN = os.path.join(REPO, "plugins", "boochtek")
CANON = os.environ.get("CONFIG_AI") or os.path.join(
    os.environ.get("XDG_CONFIG_HOME") or os.path.expanduser("~/.config"), "ai")


def _frontmatter_close(lines):
    if not lines or lines[0].strip() != "---":
        return None
    try:
        return lines.index("---", 1)
    except ValueError:
        return None


def _has_marker(path):
    try:
        with open(path, encoding="utf-8") as f:
            lines = f.read().split("\n")
    except OSError:
        return False
    close = _frontmatter_close(lines)
    return close is not None and any(
        line.strip() == "publish: true" for line in lines[1:close])


def _strip_marker(path):
    with open(path, encoding="utf-8") as f:
        lines = f.read().split("\n")
    close = _frontmatter_close(lines)
    if close is None:
        return
    kept = [line for i, line in enumerate(lines)
            if not (i < close and line.strip() == "publish: true")]
    with open(path, "w", encoding="utf-8") as f:
        f.write("\n".join(kept))


def _published_commands(src):
    return sorted(n[:-3] for n in os.listdir(src)
                  if n.endswith(".md") and _has_marker(os.path.join(src, n)))


def _published_skills(src):
    return sorted(d for d in os.listdir(src)
                  if os.path.isdir(os.path.join(src, d))
                  and _has_marker(os.path.join(src, d, "SKILL.md")))


def _sync_commands(src, published):
    dest_dir = os.path.join(PLUGIN, "commands")
    existing = sorted(n[:-3] for n in os.listdir(dest_dir) if n.endswith(".md"))
    for name in published:
        dest = os.path.join(dest_dir, name + ".md")
        shutil.copyfile(os.path.join(src, name + ".md"), dest)
        _strip_marker(dest)
    removed = [n for n in existing if n not in published]
    for name in removed:
        os.remove(os.path.join(dest_dir, name + ".md"))
    return removed


def _sync_skills(src, published):
    dest_dir = os.path.join(PLUGIN, "skills")
    existing = sorted(d for d in os.listdir(dest_dir)
                      if os.path.isdir(os.path.join(dest_dir, d)))
    for name in published:
        dest = os.path.join(dest_dir, name)
        if os.path.exists(dest):
            shutil.rmtree(dest)
        shutil.copytree(os.path.join(src, name), dest,
                        ignore=shutil.ignore_patterns(".DS_Store"))
        _strip_marker(os.path.join(dest, "SKILL.md"))
    removed = [d for d in existing if d not in published]
    for name in removed:
        shutil.rmtree(os.path.join(dest_dir, name))
    return removed


def main():
    cmd_src = os.path.join(CANON, "commands")
    skill_src = os.path.join(CANON, "skills")
    if not (os.path.isdir(cmd_src) and os.path.isdir(skill_src)):
        sys.exit(f"canonical source not found under {CANON} (set CONFIG_AI)")

    pub_cmds = _published_commands(cmd_src)
    pub_skills = _published_skills(skill_src)
    if not pub_cmds and not pub_skills:
        sys.exit(f"refusing to publish: no 'publish: true' items in {CANON}")

    removed_c = _sync_commands(cmd_src, pub_cmds)
    removed_s = _sync_skills(skill_src, pub_skills)
    print(f"commands: {len(pub_cmds)} published"
          + (f", removed {removed_c}" if removed_c else ""))
    print(f"skills:   {len(pub_skills)} published"
          + (f", removed {removed_s}" if removed_s else ""))


if __name__ == "__main__":
    main()
