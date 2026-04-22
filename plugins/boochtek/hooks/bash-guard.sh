#!/bin/bash
# PreToolUse hook: Enforce Bash tool usage rules.
# Each check either blocks (with reason) or falls through to allow.
set -euo pipefail

# Read the tool input JSON from stdin
input=$(cat)

# Extract the command field from the tool input
command=$(echo "$input" | jq -r '.tool_input.command // empty')

# Block stderr redirections: 2>&1, 2>/dev/null, 2>file, etc.
# The Bash tool captures both streams; redirections break permission matching.
if echo "$command" | grep -qE '2>[>&/]'; then
    echo '{"decision": "block", "reason": "Stderr redirections (2>&1, 2>/dev/null, etc.) are not allowed. The Bash tool already captures both stdout and stderr. Run the command without the redirection."}'
    exit 0
fi

# Block git commit with Co-Authored-By for AI attribution.
# Must use AI-Assisted-By or AI-Generated-By trailers instead.
if echo "$command" | grep -qiE 'git\s+(--no-pager\s+)?commit' && echo "$command" | grep -qiE 'Co-Authored-By:.*Claude'; then
    echo '{"decision": "block", "reason": "Do not use Co-Authored-By for AI attribution. Use AI-Assisted-By or AI-Generated-By trailers per the commits skill. See: commits skill for correct format."}'
    exit 0
fi

# Block cd && command patterns: use tool-specific flags instead.
# Allowed: plain "cd /some/dir" to change session directory.
# Blocked: "cd /some/dir && git status" or "cd dir; make test".
if echo "$command" | grep -qE '^cd\s+\S.*[;&]'; then
    echo '{"decision": "block", "reason": "Do not use cd with && or ; for single commands. Use tool-specific flags instead: git -C <dir>, npm --prefix <dir>, hugo -s <dir>, or absolute paths."}'
    exit 0
fi
