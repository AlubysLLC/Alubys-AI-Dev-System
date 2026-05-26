#!/bin/bash
# ============================================================
# init-new-project.sh
# Alubys AI Development System
#
# Usage:
#   bash init-new-project.sh <project-name>
#   bash init-new-project.sh <project-name> <target-directory>
#
# Creates a new project directory, renders the template files,
# and copies the workflow prompts into the project.
# ============================================================

set -e

# ── Config ─────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEM_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$SYSTEM_ROOT/templates"
TODAY=$(date +%Y-%m-%d)

# ── Arguments ──────────────────────────────────────────────
PROJECT_NAME="${1:-my-project}"

if [ -n "$2" ]; then
  TARGET_DIR="$2"
elif [ "$(basename "$(pwd)")" = "$PROJECT_NAME" ]; then
  TARGET_DIR="$(pwd)"
else
  TARGET_DIR="$(pwd)/$PROJECT_NAME"
fi

# ── Helpers ────────────────────────────────────────────────
print_step() { echo ""; echo "▶ $1"; }
print_ok()   { echo "  ✅ $1"; }
print_info() { echo "  ℹ  $1"; }
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
    print_info "Kept existing: ${destination#$TARGET_DIR/}"
  else
    render_template "$template" "$destination"
    print_ok "${destination#$TARGET_DIR/}"
  fi
}

render_agent_templates() {
  local template destination relative

  while IFS= read -r template; do
    relative="${template#$TEMPLATES_DIR/}"
    destination="$TARGET_DIR/${relative%.template}"
    render_template "$template" "$destination"
    print_ok "${destination#$TARGET_DIR/}"
  done < <(find "$TEMPLATES_DIR/.agent" -type f -name "*.template" | sort)
}

copy_prompt_files() {
  local prompt

  for prompt in MASTER_SYSTEM_PROMPT.md START_NEW_PROJECT_PROMPT.md ONBOARD_EXISTING_PROJECT_PROMPT.md \
                BRAINSTORMING_MODE_PROMPT.md PLANNING_MODE_PROMPT.md EXECUTION_MODE_PROMPT.md REFLECTION_MODE_PROMPT.md; do
    if [ -f "$SYSTEM_ROOT/$prompt" ]; then
      cp "$SYSTEM_ROOT/$prompt" "$TARGET_DIR/$prompt"
      print_ok "$prompt"
    else
      print_warn "Missing prompt: $prompt"
    fi
  done
}

# ── Main ───────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   Alubys AI Development System                   ║"
echo "║   Initializing new project: $PROJECT_NAME"
echo "╚══════════════════════════════════════════════════╝"

if [ ! -d "$TEMPLATES_DIR" ]; then
  echo "Templates directory not found: $TEMPLATES_DIR"
  exit 1
fi

print_step "Creating project directory"
mkdir -p "$TARGET_DIR"
print_ok "Created: $TARGET_DIR"

print_step "Rendering .agent/ templates"
render_agent_templates

print_step "Rendering root templates"
render_template "$TEMPLATES_DIR/AGENTS.md.template" "$TARGET_DIR/AGENTS.md"
print_ok "AGENTS.md"
render_template "$TEMPLATES_DIR/CLAUDE.md.template" "$TARGET_DIR/CLAUDE.md"
print_ok "CLAUDE.md"
render_template_if_missing "$TEMPLATES_DIR/README.md.template" "$TARGET_DIR/README.md"

print_step "Copying workflow prompt files"
copy_prompt_files

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║   ✅ Project initialized successfully!           ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
print_info "Project location: $TARGET_DIR"
print_info ""
print_info "Next steps:"
print_info "  1. cd $TARGET_DIR"
print_info "  2. Open your AI assistant"
print_info "  3. Ask your file-aware AI agent to follow AGENTS.md and use START_NEW_PROJECT_PROMPT.md"
print_info "  4. Choose approval mode and begin brainstorming"
print_info "  Fallback: for chat-only tools, paste MASTER_SYSTEM_PROMPT.md and START_NEW_PROJECT_PROMPT.md manually."
echo ""
