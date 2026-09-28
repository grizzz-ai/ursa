#!/bin/sh

set -eu

ROOT=$(CDPATH='' cd "$(dirname "$0")/.." && pwd -P)
INSTALLER=$ROOT/install.sh
SKILLS="ursa-discover ursa-plan ursa-plan-audit ursa-implement ursa-code-audit ursa-handoff"
TMP_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/workflow-install-test.XXXXXX")
trap 'chmod -R u+w "$TMP_ROOT" 2>/dev/null || true; rm -R "$TMP_ROOT"' EXIT HUP INT TERM

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

new_repo() {
  repo=$1
  mkdir -p "$repo"
  git -C "$repo" init -q
  printf 'fixture\n' > "$repo/fixture.txt"
}

run_fail() {
  if "$@" > "$TMP_ROOT/stdout" 2> "$TMP_ROOT/stderr"; then
    fail "command unexpectedly succeeded: $*"
  fi
}

assert_installed() {
  target=$1
  source_ref=$(git -C "$ROOT" rev-parse HEAD)
  for name in $SKILLS; do
    source_file=$ROOT/.agents/skills/$name/SKILL.md
    target_file=$target/.agents/skills/$name/SKILL.md
    origin=$target/.agents/skills/$name/.ursa-origin
    link=$target/.claude/skills/$name
    [ -f "$target_file" ] || fail "missing installed skill: $name"
    cmp -s "$source_file" "$target_file" || fail "installed bytes differ: $name"
    source_blob=$(git -C "$ROOT" hash-object "$source_file")
    expected=$(printf 'ref=%s\nhash=%s' "$source_ref" "$source_blob")
    [ "$(cat "$origin")" = "$expected" ] || fail "origin metadata differs: $name"
    [ -L "$link" ] || fail "missing Claude link: $name"
    [ "$(readlink "$link")" = "../../.agents/skills/$name" ] || fail "Claude link differs: $name"
  done
}

test_current_repository_install() {
  target=$TMP_ROOT/current
  new_repo "$target"
  (cd "$target" && "$INSTALLER") >/dev/null
  assert_installed "$target"
  (cd "$target" && "$INSTALLER" --check) >/dev/null
}

test_explicit_target_preserves_user_files() {
  target="$TMP_ROOT/explicit target"
  outside=$TMP_ROOT/outside
  new_repo "$target"
  mkdir -p "$outside" "$target/.agents/skills/unrelated"
  printf 'agents\n' > "$target/AGENTS.md"
  printf 'claude\n' > "$target/CLAUDE.md"
  printf 'unrelated\n' > "$target/.agents/skills/unrelated/SKILL.md"
  before=$(git -C "$target" hash-object AGENTS.md CLAUDE.md .agents/skills/unrelated/SKILL.md)
  (cd "$outside" && "$INSTALLER" --target "$target") >/dev/null
  after=$(git -C "$target" hash-object AGENTS.md CLAUDE.md .agents/skills/unrelated/SKILL.md)
  [ "$before" = "$after" ] || fail "user-owned files changed"
  assert_installed "$target"
  "$INSTALLER" --check --target "$target" >/dev/null
}

test_invalid_invocations_refuse() {
  target=$TMP_ROOT/invalid
  new_repo "$target"
  run_fail "$INSTALLER" --unknown
  run_fail "$INSTALLER" --target
  run_fail "$INSTALLER" --target "$TMP_ROOT"
  run_fail "$INSTALLER" --target "$ROOT"
  [ ! -e "$target/.agents" ] || fail "invalid invocation mutated target"
}

test_occupied_destinations_refuse_before_write() {
  for kind in canonical link partial; do
    target=$TMP_ROOT/occupied-$kind
    new_repo "$target"
    case "$kind" in
      canonical) mkdir -p "$target/.agents/skills/ursa-discover" ;;
      link) mkdir -p "$target/.claude/skills"; ln -s elsewhere "$target/.claude/skills/ursa-discover" ;;
      partial) mkdir -p "$target/.agents/skills/ursa-plan"; printf 'existing\n' > "$target/.agents/skills/ursa-plan/SKILL.md" ;;
    esac
    run_fail "$INSTALLER" --target "$target"
    [ ! -e "$target/.agents/skills/ursa-handoff" ] || fail "occupied target was partially installed: $kind"
    [ ! -e "$target/.claude/skills/ursa-handoff" ] || fail "occupied target gained links: $kind"
  done
}

test_late_link_failure_rolls_back() {
  target=$TMP_ROOT/rollback
  new_repo "$target"
  mkdir -p "$target/.claude/skills"
  chmod 500 "$target/.claude/skills"
  run_fail "$INSTALLER" --target "$target"
  chmod 700 "$target/.claude/skills"
  [ ! -e "$target/.agents" ] || fail "failed install left canonical paths"
  for name in $SKILLS; do
    [ ! -e "$target/.claude/skills/$name" ] && [ ! -L "$target/.claude/skills/$name" ] || fail "failed install left link: $name"
  done
  [ "$(cat "$target/fixture.txt")" = fixture ] || fail "failed install changed unrelated file"
}

test_check_rejects_mutations() {
  for kind in file link metadata; do
    target=$TMP_ROOT/mutated-$kind
    new_repo "$target"
    "$INSTALLER" --target "$target" >/dev/null
    case "$kind" in
      file) printf '\nchanged\n' >> "$target/.agents/skills/ursa-discover/SKILL.md" ;;
      link) rm "$target/.claude/skills/ursa-discover"; ln -s wrong "$target/.claude/skills/ursa-discover" ;;
      metadata) printf 'ref=wrong\nhash=wrong\n' > "$target/.agents/skills/ursa-discover/.ursa-origin" ;;
    esac
    run_fail "$INSTALLER" --check --target "$target"
  done
}

test_rerun_refuses_completed_install() {
  target=$TMP_ROOT/rerun
  new_repo "$target"
  "$INSTALLER" --target "$target" >/dev/null
  before=$(git -C "$target" hash-object .agents/skills/ursa-discover/SKILL.md)
  run_fail "$INSTALLER" --target "$target"
  after=$(git -C "$target" hash-object .agents/skills/ursa-discover/SKILL.md)
  [ "$before" = "$after" ] || fail "rerun changed installed bytes"
}

test_dirty_source_refuses_before_target_write() {
  source_copy=$TMP_ROOT/dirty-source
  target=$TMP_ROOT/dirty-target
  git clone -q "$ROOT" "$source_copy"
  cp "$INSTALLER" "$source_copy/install.sh"
  chmod +x "$source_copy/install.sh"
  printf '\nchanged\n' >> "$source_copy/.agents/skills/ursa-discover/SKILL.md"
  new_repo "$target"
  run_fail "$source_copy/install.sh" --target "$target"
  [ ! -e "$target/.agents" ] || fail "dirty source mutated target"
}

test_documented_lifecycle_uses_tmpdir() {
  # shellcheck disable=SC2016
  count=$(grep -F -c 'source_checkout=$(mktemp -d "${TMPDIR:-/tmp}/workflow-source.XXXXXXXXXX")' "$ROOT/docs/installation.md")
  [ "$count" -eq 2 ] || fail "documented lifecycle does not contain two TMPDIR-scoped checkouts"
  # shellcheck disable=SC2016
  if grep -F -x 'source_checkout=$(mktemp -d)' "$ROOT/docs/installation.md" >/dev/null; then
    fail "documented lifecycle contains an unscoped temporary checkout"
  fi
}

test_current_repository_install
test_explicit_target_preserves_user_files
test_invalid_invocations_refuse
test_occupied_destinations_refuse_before_write
test_late_link_failure_rolls_back
test_check_rejects_mutations
test_rerun_refuses_completed_install
test_dirty_source_refuses_before_target_write
test_documented_lifecycle_uses_tmpdir

printf 'PASS: repository-local installer integration suite\n'
