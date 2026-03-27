#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(cd "$(dirname "$0")/../.." && pwd)}"

output="$(CLAUDE_PLUGIN_ROOT="$REPO_ROOT" "$REPO_ROOT/hooks/session-start")"

if echo "$output" | grep -q "using-superpowers"; then
    echo "[FAIL] session-start still injects using-superpowers"
    exit 1
fi

if echo "$output" | grep -q "You have superpowers"; then
    echo "[FAIL] session-start still injects bootstrap context"
    exit 1
fi

echo "[PASS] session-start does not inject bootstrap context"
