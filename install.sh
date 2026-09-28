#!/bin/sh

set -eu

SKILLS="ursa-discover ursa-plan ursa-plan-audit ursa-implement ursa-code-audit ursa-handoff"
MODE=install
TARGET_INPUT=
SEEN_MODE=0
SEEN_TARGET=0

fail() {
  printf '%s\n' "error: $*" >&2
  exit 1
}

usage() {
  printf '%s\n' "usage: $0 [--check] [--target <path>]"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --check)
      [ "$SEEN_MODE" -eq 0 ] || fail "--check specified more than once"
      MODE=check
      SEEN_MODE=1
      ;;
    --target)
      [ "$SEEN_TARGET" -eq 0 ] || fail "--target specified more than once"
      shift
      [ "$#" -gt 0 ] || fail "--target requires a path"
      TARGET_INPUT=$1
      SEEN_TARGET=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *) fail "unknown argument: $1" ;;
  esac
  shift
done

CALLER_ROOT=$(pwd -P) || fail "cannot resolve current directory"
SCRIPT_DIR=$(CDPATH='' cd "$(dirname "$0")" && pwd -P) || fail "cannot resolve installer directory"
SOURCE_ROOT=$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null) || fail "installer is not in a Git repository"
[ "$SOURCE_ROOT" = "$SCRIPT_DIR" ] || fail "installer must run from the workflow repository root"
SOURCE_REF=$(git -C "$SOURCE_ROOT" rev-parse --verify HEAD 2>/dev/null) || fail "cannot resolve workflow source commit"

if [ -z "$TARGET_INPUT" ]; then
  TARGET_INPUT=$CALLER_ROOT
fi
[ -d "$TARGET_INPUT" ] || fail "target is not a directory"
TARGET_ROOT=$(git -C "$TARGET_INPUT" rev-parse --show-toplevel 2>/dev/null) || fail "target is not a Git repository"
[ "$TARGET_ROOT" != "$SOURCE_ROOT" ] || fail "workflow source cannot be its own installation target"

for name in $SKILLS; do
  rel=.agents/skills/$name/SKILL.md
  source_file=$SOURCE_ROOT/$rel
  [ -f "$source_file" ] && [ ! -L "$source_file" ] || fail "missing canonical source skill: $name"
  expected_blob=$(git -C "$SOURCE_ROOT" rev-parse "HEAD:$rel" 2>/dev/null) || fail "source skill is not tracked: $name"
  actual_blob=$(git -C "$SOURCE_ROOT" hash-object "$source_file") || fail "cannot hash source skill: $name"
  [ "$actual_blob" = "$expected_blob" ] || fail "source skill differs from HEAD: $name"
done

validate_installation() {
  for name in $SKILLS; do
    rel=.agents/skills/$name/SKILL.md
    canonical_dir=$TARGET_ROOT/.agents/skills/$name
    canonical_file=$canonical_dir/SKILL.md
    origin_file=$canonical_dir/.ursa-origin
    claude_link=$TARGET_ROOT/.claude/skills/$name
    expected_blob=$(git -C "$SOURCE_ROOT" rev-parse "HEAD:$rel") || return 1
    [ -f "$canonical_file" ] && [ ! -L "$canonical_file" ] || return 1
    [ -f "$origin_file" ] && [ ! -L "$origin_file" ] || return 1
    [ -L "$claude_link" ] || return 1
    [ "$(readlink "$claude_link")" = "../../.agents/skills/$name" ] || return 1
    expected_origin=$(printf 'ref=%s\nhash=%s' "$SOURCE_REF" "$expected_blob")
    [ "$(cat "$origin_file")" = "$expected_origin" ] || return 1
    [ "$(git -C "$SOURCE_ROOT" hash-object "$canonical_file")" = "$expected_blob" ] || return 1
  done
}

if [ "$MODE" = check ]; then
  validate_installation || fail "installation validation failed"
  printf 'valid: six workflow skills at %s\n' "$SOURCE_REF"
  exit 0
fi

for parent in "$TARGET_ROOT/.agents" "$TARGET_ROOT/.agents/skills" "$TARGET_ROOT/.claude" "$TARGET_ROOT/.claude/skills"; do
  if [ -e "$parent" ] || [ -L "$parent" ]; then
    [ -d "$parent" ] && [ ! -L "$parent" ] || fail "installation parent is not a real directory"
  fi
done
for name in $SKILLS; do
  canonical_dir=$TARGET_ROOT/.agents/skills/$name
  claude_link=$TARGET_ROOT/.claude/skills/$name
  [ ! -e "$canonical_dir" ] && [ ! -L "$canonical_dir" ] || fail "canonical destination occupied: $name"
  [ ! -e "$claude_link" ] && [ ! -L "$claude_link" ] || fail "Claude destination occupied: $name"
done

CREATED_AGENTS=0
CREATED_AGENTS_SKILLS=0
CREATED_CLAUDE=0
CREATED_CLAUDE_SKILLS=0
COMMITTED=0

cleanup() {
  rc=$?
  trap - EXIT HUP INT TERM
  if [ "$COMMITTED" -eq 0 ]; then
    for name in $SKILLS; do
      rm -f "$TARGET_ROOT/.claude/skills/$name"
      rm -f "$TARGET_ROOT/.agents/skills/$name/.ursa-origin"
      rm -f "$TARGET_ROOT/.agents/skills/$name/SKILL.md"
      rmdir "$TARGET_ROOT/.agents/skills/$name" 2>/dev/null || true
    done
    [ "$CREATED_CLAUDE_SKILLS" -eq 0 ] || rmdir "$TARGET_ROOT/.claude/skills" 2>/dev/null || true
    [ "$CREATED_CLAUDE" -eq 0 ] || rmdir "$TARGET_ROOT/.claude" 2>/dev/null || true
    [ "$CREATED_AGENTS_SKILLS" -eq 0 ] || rmdir "$TARGET_ROOT/.agents/skills" 2>/dev/null || true
    [ "$CREATED_AGENTS" -eq 0 ] || rmdir "$TARGET_ROOT/.agents" 2>/dev/null || true
  fi
  exit "$rc"
}
trap cleanup EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

[ -d "$TARGET_ROOT/.agents" ] || { mkdir "$TARGET_ROOT/.agents"; CREATED_AGENTS=1; }
[ -d "$TARGET_ROOT/.agents/skills" ] || { mkdir "$TARGET_ROOT/.agents/skills"; CREATED_AGENTS_SKILLS=1; }
[ -d "$TARGET_ROOT/.claude" ] || { mkdir "$TARGET_ROOT/.claude"; CREATED_CLAUDE=1; }
[ -d "$TARGET_ROOT/.claude/skills" ] || { mkdir "$TARGET_ROOT/.claude/skills"; CREATED_CLAUDE_SKILLS=1; }

for name in $SKILLS; do
  rel=.agents/skills/$name/SKILL.md
  canonical_dir=$TARGET_ROOT/.agents/skills/$name
  mkdir "$canonical_dir"
  cp "$SOURCE_ROOT/$rel" "$canonical_dir/SKILL.md"
  source_blob=$(git -C "$SOURCE_ROOT" rev-parse "HEAD:$rel")
  printf 'ref=%s\nhash=%s\n' "$SOURCE_REF" "$source_blob" > "$canonical_dir/.ursa-origin"
  ln -s "../../.agents/skills/$name" "$TARGET_ROOT/.claude/skills/$name"
done

validate_installation || fail "post-install validation failed"
COMMITTED=1
printf 'installed: six workflow skills at %s\n' "$SOURCE_REF"
