#!/bin/bash
# ============================================================
# copy-agent-system.sh
# Alubys AI Development System
#
# Usage: bash copy-agent-system.sh [target-directory]
#
# Adds the Alubys templates and prompt files to an existing
# project without overwriting existing files.
# ============================================================

set -e

# ── Config ─────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEM_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$SYSTEM_ROOT/templates"
TODAY=$(date +%Y-%m-%d)

# ── Arguments ──────────────────────────────────────────────
TARGET_DIR="${1:-$(pwd)}"
PROJECT_NAME="$(basename "$TARGET_DIR")"

# ── Helpers ────────────────────────────────────────────────
print_step() { echo ""; echo "▶ $1"; }
print_ok()   { echo "  ✅ $1"; }
print_skip() { echo "  ⏭  Skipped (already exists): $1"; }
print_warn() { echo "  ⚠️  $1"; }

render_template() {
  local template="$1"
  local destination="$2"
  local content

  content="$(<"$template")"
  content="${content//\[PROJECT NAME\]/$PROJECT_NAME}"
  content="${content//\[project-name\]/$PROJECT_NAME}"
  content="${content//\[DATE\]/$TODAY}"

  mkdir -p "$(dirname "$destination")"
  printf "%s\n" "$content" > "$destination"
}

render_template_if_missing() {
  local template="$1"
  local destination="$2"

  if [ -f "$destination" ]; then
    print_skip "${destination#$TARGET_DIR/}"
  else
    render_template "$template" "$destination"
    print_ok "${destination#$TARGET_DIR/}"
  fi
}

render_agent_templates_if_missing() {
  local template destination relative

  while IFS= read -r template; do
    relative="${template#$TEMPLATES_DIR/}"
    destination="$TARGET_DIR/${relative%.template}"
    render_template_if_missing "$template" "$destination"
  done < <(find "$TEMPLATES_DIR/.agent" -type f -name "*.template" | sort)
}

copy_prompt_if_missing() {
  local prompt="$1"

  mkdir -p "$TARGET_DIR/_PROMPTS"
  if [ -f "$TARGET_DIR/_PROMPTS/$prompt" ]; then
    print_skip "_PROMPTS/$prompt"
  elif [ -f "$SYSTEM_ROOT/_PROMPTS/$prompt" ]; then
    cp "$SYSTEM_ROOT/_PROMPTS/$prompt" "$TARGET_DIR/_PROMPTS/$prompt"
    print_ok "_PROMPTS/$prompt"
  else
    print_warn "Missing prompt: _PROMPTS/$prompt"
  fi
}

# ── Confirm ────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   Alubys AI Development System                   ║"
echo "║   Onboarding existing project                    ║"
echo "╚══════════════════════════════════════════════════╝"

# ── Terms of Use acceptance ────────────────────────────────
echo ""
echo "  TERMS OF USE — Alubys, LLC"
echo "  ──────────────────────────────────────────────────"
echo "  This software is provided without warranty of any kind."
echo "  By proceeding, you accept full responsibility for all"
echo "  outcomes, including data loss and AI token costs."
echo "  Alubys, LLC is held harmless from any claims."
echo ""
echo "  Full Terms of Use: https://alubysllc.github.io/terms"
echo ""
read -p "  Type YES to accept the Terms of Use and continue: " _terms_accept
if [ "$_terms_accept" != "YES" ]; then
  echo "  Terms not accepted. Exiting."
  exit 0
fi

echo ""
echo "  Target project: $TARGET_DIR"
echo "  Project name:   $PROJECT_NAME"
echo ""
read -p "  Proceed? This will ADD files only (never overwrite). [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "  Cancelled."
  exit 0
fi

if [ ! -d "$TEMPLATES_DIR" ]; then
  echo "Templates directory not found: $TEMPLATES_DIR"
  exit 1
fi

# ── Render templates ───────────────────────────────────────
print_step "Rendering .agent/ templates (skip if exist)"
render_agent_templates_if_missing

print_step "Rendering root templates (skip if exist)"
render_template_if_missing "$TEMPLATES_DIR/AGENTS.md.template" "$TARGET_DIR/AGENTS.md"
render_template_if_missing "$TEMPLATES_DIR/CLAUDE.md.template" "$TARGET_DIR/CLAUDE.md"

if [ -f "$TARGET_DIR/README.md" ]; then
  render_template_if_missing "$TEMPLATES_DIR/README.ToBeMerged.md.template" "$TARGET_DIR/README.ToBeMerged.md"
else
  render_template_if_missing "$TEMPLATES_DIR/README.md.template" "$TARGET_DIR/README.md"
fi

# ── Copy workflow prompts ──────────────────────────────────
print_step "Copying workflow prompt files (skip if exist)"
for prompt in MASTER_SYSTEM_PROMPT.md ONBOARD_EXISTING_PROJECT_PROMPT.md \
              BRAINSTORMING_MODE_PROMPT.md PLANNING_MODE_PROMPT.md \
              EXECUTION_MODE_PROMPT.md REFLECTION_MODE_PROMPT.md; do
  copy_prompt_if_missing "$prompt"
done

# ── Git tracking note ──────────────────────────────────────
print_step "Git tracking note"
print_warn "Commit .agent/ memory, planning, tasks, reflections, and sessions unless your project policy says otherwise."
print_warn "Do not commit real secrets. Use environment variables, a password manager, or .agent/secrets.local.md."

# ── Done ───────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   ✅ Alubys system added to existing project!    ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "  Next steps:"
echo "  1. Open your AI assistant"
echo "  2. Ask your file-aware AI agent to follow AGENTS.md and use _PROMPTS/ONBOARD_EXISTING_PROJECT_PROMPT.md"
echo "  3. Choose approval mode and let the AI inspect and document the project"
echo "  Fallback: for chat-only tools, paste _PROMPTS/MASTER_SYSTEM_PROMPT.md and _PROMPTS/ONBOARD_EXISTING_PROJECT_PROMPT.md manually."
echo ""
