#!/usr/bin/env sh
set -eu

ROOT=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --root)
      shift
      [ "$#" -gt 0 ] || { echo "ERROR --root requires a path" >&2; exit 2; }
      ROOT=$1
      ;;
    *) echo "ERROR unknown argument: $1" >&2; exit 2 ;;
  esac
  shift
done

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
[ -n "$ROOT" ] || ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
ROOT=$(CDPATH= cd -- "$ROOT" && pwd)
BOARD="$ROOT/project-memory/BOARD.md"

if [ ! -f "$BOARD" ]; then
  echo "ERROR Missing required file: project-memory/BOARD.md" >&2
  exit 1
fi

TMP=$(mktemp -d "${TMPDIR:-/tmp}/contextrail-coordination.XXXXXX")
trap 'rm -rf "$TMP"' EXIT HUP INT TERM
ACTIVE="$TMP/active.tsv"
WARNINGS="$TMP/warnings"
: > "$WARNINGS"

warn() {
  printf 'WARN  %s\n' "$*" | tee -a "$WARNINGS" >&2
}

awk '
function trim(value) {
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
  return value
}
function flush() {
  if (id != "" && status == "active")
    printf "%s\t%s\t%s\t%s\n", id, owner, branch, scope
}
/^## TASK-[0-9][0-9][0-9][0-9][[:space:]]/ {
  flush()
  id=$2
  status=owner=branch=scope=""
  next
}
id != "" && /^- Status:[[:space:]]*/ {
  status=$0; sub(/^- Status:[[:space:]]*/, "", status); status=tolower(trim(status)); next
}
id != "" && /^- Owner:[[:space:]]*/ {
  owner=$0; sub(/^- Owner:[[:space:]]*/, "", owner); owner=trim(owner); next
}
id != "" && /^- Branch:[[:space:]]*/ {
  branch=$0; sub(/^- Branch:[[:space:]]*/, "", branch); branch=trim(branch); next
}
id != "" && /^- Scope:[[:space:]]*/ {
  scope=$0; sub(/^- Scope:[[:space:]]*/, "", scope); scope=trim(scope); next
}
END { flush() }
' "$BOARD" > "$ACTIVE"

while IFS="$(printf '\t')" read -r task owner branch scope; do
  [ -n "$task" ] || continue
  if [ "$owner" = "unassigned" ]; then
    warn "$task is active but Owner is unassigned"
  fi
  if [ -n "$branch" ] && [ -z "$scope" ]; then
    warn "$task declares Branch '$branch' but no Scope; parallel-work overlap cannot be assessed"
  fi
done < "$ACTIVE"

awk -F '\t' '
function trim(value) {
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
  return value
}
function normalize(value) {
  value=trim(value)
  sub(/^\.\//, "", value)
  gsub(/\/+$/, "", value)
  return value
}
function overlaps(a,b) {
  return a == b || index(a, b "/") == 1 || index(b, a "/") == 1
}
{
  id[NR]=$1; owner[NR]=$2; branch[NR]=$3; scope[NR]=$4
}
END {
  for (i=1; i<=NR; i++) {
    if (scope[i] == "") continue
    for (j=i+1; j<=NR; j++) {
      if (scope[j] == "") continue
      na=split(scope[i], left, ",")
      nb=split(scope[j], right, ",")
      found=0
      for (a=1; a<=na && !found; a++) {
        pa=normalize(left[a]); if (pa == "") continue
        for (b=1; b<=nb; b++) {
          pb=normalize(right[b]); if (pb == "") continue
          if (overlaps(pa,pb)) {
            printf "%s scope %c%s%c overlaps active %s scope %c%s%c", id[i], 39, pa, 39, id[j], 39, pb, 39
            if (owner[i] != "" || owner[j] != "")
              printf " (%s / %s)", owner[i], owner[j]
            if (branch[i] != "" || branch[j] != "")
              printf " [%s / %s]", branch[i], branch[j]
            printf "\n"
            found=1
            break
          }
        }
      }
    }
  }
}
' "$ACTIVE" | while IFS= read -r finding; do
  [ -n "$finding" ] && warn "$finding"
done

current_branch=${GITHUB_HEAD_REF:-${GITHUB_REF_NAME:-}}
if [ -z "$current_branch" ] && command -v git >/dev/null 2>&1; then
  current_branch=$(git -C "$ROOT" branch --show-current 2>/dev/null || true)
fi
actor=${GITHUB_ACTOR:-}

if [ -n "$current_branch" ] && [ -n "$actor" ]; then
  awk -F '\t' -v current_branch="$current_branch" -v actor="$actor" '
  $3 == current_branch && $2 ~ /^@[A-Za-z0-9][A-Za-z0-9-]*$/ {
    expected=substr($2,2)
    if (tolower(expected) != tolower(actor))
      printf "%s branch %c%s%c is owned by %s but GitHub actor is @%s\n", $1, 39, $3, 39, $2, actor
  }
  ' "$ACTIVE" | while IFS= read -r finding; do
    [ -n "$finding" ] && warn "$finding"
  done
fi

warning_count=$(wc -l < "$WARNINGS" | tr -d ' ')
printf '\nCoordination summary: %s advisory finding(s)\n' "$warning_count"
echo "PASS  Shared-work coordination check completed"
