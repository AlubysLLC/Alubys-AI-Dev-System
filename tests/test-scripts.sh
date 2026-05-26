#!/bin/bash
# Lightweight regression tests for the Alubys installer scripts.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
INIT_SCRIPT="$PROJECT_ROOT/scripts/init-new-project.sh"
COPY_SCRIPT="$PROJECT_ROOT/scripts/copy-agent-system.sh"
PDF_SCRIPT="$PROJECT_ROOT/scripts/build-guide-pdf.sh"
GUIDE_MD="$PROJECT_ROOT/Alubys_AI_Dev_System_Guide.md"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

pass() {
  echo "PASS: $1"
}

assert_file() {
  local path="$1"
  [ -f "$path" ] || fail "Expected file: $path"
}

assert_no_file() {
  local path="$1"
  [ ! -f "$path" ] || fail "Unexpected file: $path"
}

assert_dir() {
  local path="$1"
  [ -d "$path" ] || fail "Expected directory: $path"
}

assert_contains() {
  local path="$1"
  local expected="$2"
  grep -Fq "$expected" "$path" || fail "Expected '$expected' in $path"
}

assert_not_contains() {
  local path="$1"
  local unexpected="$2"
  if grep -Fq "$unexpected" "$path"; then
    fail "Did not expect '$unexpected' in $path"
  fi
}

assert_same_hash() {
  local before="$1"
  local path="$2"
  local after
  after="$(shasum "$path" | awk '{print $1}')"
  [ "$before" = "$after" ] || fail "Expected unchanged file: $path"
}

run_copy_script() {
  local target="$1"
  printf 'y\n' | bash "$COPY_SCRIPT" "$target" >/dev/null
}

TMP_ROOT="$(mktemp -d /private/tmp/alubys-tests.XXXXXX)"
trap 'rm -rf "$TMP_ROOT"' EXIT

bash -n "$INIT_SCRIPT"
bash -n "$COPY_SCRIPT"
bash -n "$PDF_SCRIPT"
pass "scripts parse"

assert_file "$GUIDE_MD"
assert_contains "$GUIDE_MD" "This Markdown file is the source of truth"
assert_contains "$PROJECT_ROOT/README.md" "Alubys_AI_Dev_System_Guide.md"
pass "guide source is documented"

# New project from parent directory.
PARENT_CASE="$TMP_ROOT/new-parent"
mkdir -p "$PARENT_CASE"
bash "$INIT_SCRIPT" sample-project "$PARENT_CASE/sample-project" >/dev/null
NEW_PROJECT="$PARENT_CASE/sample-project"

assert_dir "$NEW_PROJECT/.agent"
assert_file "$NEW_PROJECT/AGENTS.md"
assert_file "$NEW_PROJECT/CLAUDE.md"
assert_file "$NEW_PROJECT/README.md"
assert_file "$NEW_PROJECT/.agent/.gitignore"
assert_file "$NEW_PROJECT/.agent/secrets.example.md"
assert_file "$NEW_PROJECT/.agent/memory/active-context.md"
assert_file "$NEW_PROJECT/.agent/memory/decisions.md"
assert_file "$NEW_PROJECT/.agent/tasks/in-progress.md"
assert_file "$NEW_PROJECT/.agent/sessions/README.md"
assert_contains "$NEW_PROJECT/AGENTS.md" "sample-project"
assert_contains "$NEW_PROJECT/AGENTS.md" "Approval Mode"
assert_contains "$NEW_PROJECT/.agent/memory/active-context.md" "Approval Mode"
assert_contains "$NEW_PROJECT/README.md" "sample-project"
assert_not_contains "$NEW_PROJECT/AGENTS.md" "[PROJECT NAME]"
assert_not_contains "$NEW_PROJECT/README.md" "[project-name]"
assert_not_contains "$NEW_PROJECT/CLAUDE.md" "[DATE]"
pass "init-new-project creates expected files"

# New project from inside an already-created same-name directory.
NESTED_CASE="$TMP_ROOT/nested"
mkdir -p "$NESTED_CASE/my-project"
(
  cd "$NESTED_CASE/my-project"
  bash "$INIT_SCRIPT" my-project >/dev/null
)
assert_file "$NESTED_CASE/my-project/AGENTS.md"
assert_no_file "$NESTED_CASE/my-project/my-project/AGENTS.md"
pass "init-new-project avoids same-name nested project"

# Existing project with README.md should get README.ToBeMerged.md and preserve README.md.
EXISTING_README_CASE="$TMP_ROOT/existing-readme"
mkdir -p "$EXISTING_README_CASE/.agent/memory"
printf '# Existing README\nDo not change me.\n' > "$EXISTING_README_CASE/README.md"
printf 'existing context\n' > "$EXISTING_README_CASE/.agent/memory/active-context.md"
README_HASH="$(shasum "$EXISTING_README_CASE/README.md" | awk '{print $1}')"
ACTIVE_CONTEXT_HASH="$(shasum "$EXISTING_README_CASE/.agent/memory/active-context.md" | awk '{print $1}')"

run_copy_script "$EXISTING_README_CASE"

assert_same_hash "$README_HASH" "$EXISTING_README_CASE/README.md"
assert_same_hash "$ACTIVE_CONTEXT_HASH" "$EXISTING_README_CASE/.agent/memory/active-context.md"
assert_file "$EXISTING_README_CASE/README.ToBeMerged.md"
assert_file "$EXISTING_README_CASE/AGENTS.md"
assert_file "$EXISTING_README_CASE/CLAUDE.md"
assert_contains "$EXISTING_README_CASE/README.ToBeMerged.md" "README Sections To Merge"
pass "copy-agent-system preserves existing README and creates merge file"

# Existing project without README.md should get a normal README.md.
MISSING_README_CASE="$TMP_ROOT/missing-readme"
mkdir -p "$MISSING_README_CASE"
run_copy_script "$MISSING_README_CASE"

assert_file "$MISSING_README_CASE/README.md"
assert_no_file "$MISSING_README_CASE/README.ToBeMerged.md"
assert_contains "$MISSING_README_CASE/README.md" "missing-readme"
pass "copy-agent-system creates README when missing"

# Secret local file should be ignored by nested .agent/.gitignore.
(
  cd "$MISSING_README_CASE"
  git init >/dev/null
  git check-ignore -q .agent/secrets.local.md || fail ".agent/secrets.local.md should be ignored"
)
pass "secrets.local.md is ignored"

echo "All tests passed."
