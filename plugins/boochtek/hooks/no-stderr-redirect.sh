#!/bin/bash
# PreToolUse hook: Block stderr redirections in Bash commands.
# The Bash tool captures both streams; redirections break permission matching.
set -euo pipefail

# Read the tool input JSON from stdin
input=$(cat)

# Extract the command field from the tool input
command=$(echo "$input" | jq -r '.tool_input.command // empty')

# Check for stderr redirection patterns: 2>&1, 2>/dev/null, 2>file, etc.
if echo "$command" | grep -qE '2>[>&/]'; then
    echo '{"decision": "block", "reason": "Stderr redirections (2>&1, 2>/dev/null, etc.) are not allowed. The Bash tool already captures both stdout and stderr. Run the command without the redirection."}'
    exit 0
fi
