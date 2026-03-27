#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(cd "$(dirname "$0")/../.." && pwd)}"
SKILL_FILE="$REPO_ROOT/skills/using-superpowers/SKILL.md"
GEMINI_FILE="$REPO_ROOT/GEMINI.md"
OPENCODE_PLUGIN="$REPO_ROOT/.opencode/plugins/superpowers.js"

fail() {
    echo "[FAIL] $1"
    exit 1
}

grep -q "description: Use when starting any conversation" "$SKILL_FILE" && \
    fail "using-superpowers description is still scoped to every conversation"

grep -q "BEFORE any response or action" "$SKILL_FILE" && \
    fail "using-superpowers still requires activation before any response"

grep -qi "design" "$SKILL_FILE" || \
    fail "using-superpowers no longer mentions design-oriented trigger conditions"

grep -qi "solution" "$SKILL_FILE" || \
    fail "using-superpowers no longer mentions solution-oriented trigger conditions"

grep -qi "greeting\\|casual chat\\|simple factual" "$SKILL_FILE" || \
    fail "using-superpowers does not explicitly exclude lightweight conversations"

grep -q "@./skills/using-superpowers/SKILL.md" "$GEMINI_FILE" && \
    fail "GEMINI.md still force-loads using-superpowers at session start"

grep -q "experimental.chat.system.transform" "$OPENCODE_PLUGIN" && \
    fail "OpenCode plugin still injects bootstrap context into every conversation"

echo "[PASS] using-superpowers is scoped to design/solution work and not startup-loaded everywhere"
