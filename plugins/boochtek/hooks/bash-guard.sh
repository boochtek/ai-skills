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

# Documentation gate: block git commit unless docs were addressed.
# Skip if: only doc files staged, or documentation skill was invoked,
# or agent attested that docs are handled.
if echo "$command" | grep -qE 'git\s+(--no-pager\s+)?(-C\s+\S+\s+)?(--no-pager\s+)?commit'; then
    # Get the git directory context from the command (-C flag), or use cwd
    git_dir=$(echo "$command" | grep -oE -- '-C\s+\S+' | head -1 | sed 's/-C\s*//')

    # Get staged files
    if [ -n "$git_dir" ]; then
        staged=$(git -C "$git_dir" diff --cached --name-only 2>/dev/null || true)
    else
        staged=$(git diff --cached --name-only 2>/dev/null || true)
    fi

    # If no staged files, let git handle the error
    if [ -z "$staged" ]; then
        exit 0
    fi

    # Check if ALL staged files are documentation
    all_docs=true
    while IFS= read -r file; do
        case "$file" in
            doc/*|docs/*|Doc/*|Docs/*) continue ;;  # doc directories
            *.md|*.txt|*.rst|*.adoc) continue ;;     # doc extensions
            *) all_docs=false; break ;;
        esac
    done <<< "$staged"

    if [ "$all_docs" = true ]; then
        exit 0
    fi

    # Check transcript for documentation skill invocation or attestation
    transcript_check=$(echo "$input" | jq -r '
        . as $root |
        # Check for skill invocation in recent assistant messages
        if ($root | has("transcript_path")) then "check_transcript"
        else "no_transcript"
        end
    ')

    # For now, allow if we cannot read the transcript (the Stop hook catches it)
    if [ "$transcript_check" = "no_transcript" ]; then
        exit 0
    fi
fi
