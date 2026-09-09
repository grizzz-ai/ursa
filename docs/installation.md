# Repository-local installation

These recipes install one skill into a user-owned Git repository. They never write to global Codex
or Claude Code configuration.

## Prerequisites

Authenticate Git for private GitHub repositories once:

```sh
gh auth status
gh auth setup-git
```

Set a full source commit, a skill name, and the consuming repository. `WORKFLOW_SOURCE` may be a
local clone during verification; its default is the canonical GitHub repository.

```sh
WORKFLOW_SOURCE=${WORKFLOW_SOURCE:-https://github.com/grizzz-ai/ai-engineering-workflow.git}
WORKFLOW_REF=${WORKFLOW_REF:?set a full source commit}
SKILL_NAME=${SKILL_NAME:?set a skill directory name}
TARGET_REPO=${TARGET_REPO:-$(git rev-parse --show-toplevel)}
```

Names are restricted before they become paths:

```sh
case "$SKILL_NAME" in
  ''|*[!a-z0-9-]*) echo "invalid skill name" >&2; exit 1 ;;
esac
```

## Install

Run the prerequisite blocks above, then run this block unchanged:

```sh
set -eu
source_checkout=$(mktemp -d)
cleanup_source() { rm -R "$source_checkout"; }
trap cleanup_source EXIT HUP INT TERM
git clone --quiet "$WORKFLOW_SOURCE" "$source_checkout"
git -C "$source_checkout" checkout --quiet --detach "$WORKFLOW_REF"
resolved_ref=$(git -C "$source_checkout" rev-parse HEAD)
[ "$resolved_ref" = "$WORKFLOW_REF" ] || { echo "source ref mismatch" >&2; exit 1; }

source_skill=$source_checkout/.agents/skills/$SKILL_NAME/SKILL.md
canonical_dir=$TARGET_REPO/.agents/skills/$SKILL_NAME
canonical_skill=$canonical_dir/SKILL.md
origin_file=$canonical_dir/.ai-engineering-workflow-origin
claude_link=$TARGET_REPO/.claude/skills/$SKILL_NAME
[ -f "$source_skill" ] || { echo "source skill missing" >&2; exit 1; }
[ ! -e "$canonical_dir" ] && [ ! -L "$canonical_dir" ] || { echo "canonical destination occupied" >&2; exit 1; }
[ ! -e "$claude_link" ] && [ ! -L "$claude_link" ] || { echo "Claude destination occupied" >&2; exit 1; }

mkdir -p "$TARGET_REPO/.agents/skills" "$TARGET_REPO/.claude/skills"
mkdir "$canonical_dir"
cp "$source_skill" "$canonical_skill"
source_hash=$(git hash-object "$source_skill")
printf 'ref=%s\nhash=%s\n' "$resolved_ref" "$source_hash" > "$origin_file"
if ! ln -s "../../.agents/skills/$SKILL_NAME" "$claude_link"; then
  rm "$origin_file" "$canonical_skill"
  rmdir "$canonical_dir"
  exit 1
fi
printf 'installed %s at %s\n' "$SKILL_NAME" "$resolved_ref"
```

The origin file records the exact source commit and canonical file hash. It is adapter metadata,
not a second skill body.

## Validate

```sh
set -eu
canonical_dir=$TARGET_REPO/.agents/skills/$SKILL_NAME
canonical_skill=$canonical_dir/SKILL.md
origin_file=$canonical_dir/.ai-engineering-workflow-origin
claude_link=$TARGET_REPO/.claude/skills/$SKILL_NAME
[ -f "$canonical_skill" ] && [ -f "$origin_file" ] && [ -L "$claude_link" ]
[ "$(readlink "$claude_link")" = "../../.agents/skills/$SKILL_NAME" ]
recorded_hash=
while IFS='=' read -r key value; do
  [ "$key" = hash ] && recorded_hash=$value
done < "$origin_file"
[ -n "$recorded_hash" ]
[ "$(git hash-object "$canonical_skill")" = "$recorded_hash" ]
printf 'valid %s\n' "$SKILL_NAME"
```

## Update

Set `WORKFLOW_REF` to the new full commit. The update refuses a locally modified canonical file or a
changed Claude link.

```sh
set -eu
source_checkout=$(mktemp -d)
cleanup_source() { rm -R "$source_checkout"; }
trap cleanup_source EXIT HUP INT TERM
git clone --quiet "$WORKFLOW_SOURCE" "$source_checkout"
git -C "$source_checkout" checkout --quiet --detach "$WORKFLOW_REF"
resolved_ref=$(git -C "$source_checkout" rev-parse HEAD)
[ "$resolved_ref" = "$WORKFLOW_REF" ] || { echo "source ref mismatch" >&2; exit 1; }

source_skill=$source_checkout/.agents/skills/$SKILL_NAME/SKILL.md
canonical_dir=$TARGET_REPO/.agents/skills/$SKILL_NAME
canonical_skill=$canonical_dir/SKILL.md
origin_file=$canonical_dir/.ai-engineering-workflow-origin
claude_link=$TARGET_REPO/.claude/skills/$SKILL_NAME
[ -f "$source_skill" ] && [ -f "$canonical_skill" ] && [ -f "$origin_file" ] || { echo "installation incomplete" >&2; exit 1; }
[ -L "$claude_link" ] && [ "$(readlink "$claude_link")" = "../../.agents/skills/$SKILL_NAME" ] || { echo "Claude link changed" >&2; exit 1; }
recorded_hash=
while IFS='=' read -r key value; do
  [ "$key" = hash ] && recorded_hash=$value
done < "$origin_file"
[ -n "$recorded_hash" ] && [ "$(git hash-object "$canonical_skill")" = "$recorded_hash" ] || { echo "installed skill modified" >&2; exit 1; }

next_skill=$canonical_dir/.SKILL.md.next
next_origin=$canonical_dir/.origin.next
cp "$source_skill" "$next_skill"
source_hash=$(git hash-object "$source_skill")
printf 'ref=%s\nhash=%s\n' "$resolved_ref" "$source_hash" > "$next_origin"
mv "$next_skill" "$canonical_skill"
mv "$next_origin" "$origin_file"
printf 'updated %s to %s\n' "$SKILL_NAME" "$resolved_ref"
```

## Remove

Removal refuses a locally modified file or changed link and deletes only paths owned by this skill.

```sh
set -eu
canonical_dir=$TARGET_REPO/.agents/skills/$SKILL_NAME
canonical_skill=$canonical_dir/SKILL.md
origin_file=$canonical_dir/.ai-engineering-workflow-origin
claude_link=$TARGET_REPO/.claude/skills/$SKILL_NAME
[ -f "$canonical_skill" ] && [ -f "$origin_file" ] || { echo "installation incomplete" >&2; exit 1; }
[ -L "$claude_link" ] && [ "$(readlink "$claude_link")" = "../../.agents/skills/$SKILL_NAME" ] || { echo "Claude link changed" >&2; exit 1; }
recorded_hash=
while IFS='=' read -r key value; do
  [ "$key" = hash ] && recorded_hash=$value
done < "$origin_file"
[ -n "$recorded_hash" ] && [ "$(git hash-object "$canonical_skill")" = "$recorded_hash" ] || { echo "installed skill modified" >&2; exit 1; }
if find "$canonical_dir" -mindepth 1 -maxdepth 1 \
  ! -name SKILL.md ! -name .ai-engineering-workflow-origin -print -quit | grep -q .; then
  echo "skill directory contains unrelated files" >&2
  exit 1
fi
rm "$claude_link"
rm "$origin_file" "$canonical_skill"
rmdir "$canonical_dir"
printf 'removed %s\n' "$SKILL_NAME"
```

Parent directories are deliberately retained because they may contain unrelated user skills or
configuration.
