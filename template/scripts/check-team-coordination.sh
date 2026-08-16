#!/usr/bin/env sh
set -eu

STRICT=0
ROOT=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --strict) STRICT=1 ;;
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

TMP=$(mktemp -d "${TMPDIR:-/tmp}/contextrail-team.XXXXXX")
trap 'rm -rf "$TMP"' EXIT HUP INT TERM
ERRORS="$TMP/errors"
WARNINGS="$TMP/warnings"
META="$TMP/meta"
: > "$ERRORS"
: > "$WARNINGS"
: > "$META"

error() { printf 'ERROR %s\n' "$*" | tee -a "$ERRORS" >&2; }
warn() { printf 'WARN  %s\n' "$*" | tee -a "$WARNINGS" >&2; }

awk '
function trim(value) {
  gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
  return value
}
function normalize_scope(value) {
  value=trim(value)
  gsub(/\\/, "/", value)
  while (substr(value,1,2)=="./") value=substr(value,3)
  gsub(/\/+$/, "", value)
  if (value=="") value="."
  return value
}
function github_owner_valid(value, login) {
  if (substr(value,1,1)!="@") return 1
  login=substr(value,2)
  if (length(login)<1 || length(login)>39) return 0
  if (login !~ /^[A-Za-z0-9][A-Za-z0-9-]*$/) return 0
  if (login ~ /--/ || login ~ /-$/) return 0
  return 1
}
function scope_valid(value) {
  if (value==".") return 1
  if (value ~ /^\//) return 0
  if (value ~ /(^|\/)\.\.($|\/)/) return 0
  if (value ~ /[*?\[]/) return 0
  return 1
}
function flush(    n,i,item,norm) {
  if (id=="") return
  if (substr(owner,1,1)=="@" && !github_owner_valid(owner))
    print "E|" id " has invalid GitHub-style Owner: " owner
  if (branch!="" && branch ~ /[[:space:]]/)
    print "E|" id " Branch must not contain whitespace: " branch
  if (scope!="") {
    n=split(scope,parts,",")
    for(i=1;i<=n;i++) {
      item=trim(parts[i])
      if (item=="") {
        print "E|" id " Scope contains an empty path entry"
        continue
      }
      norm=normalize_scope(item)
      if (!scope_valid(norm)) {
        print "E|" id " has invalid Scope path: " item
        continue
      }
      if (status=="active") print "S|" id "|" owner "|" branch "|" norm
    }
  }
  if (status=="active" && branch!="") print "B|" id "|" owner "|" branch
}
/^## TASK-[0-9][0-9][0-9][0-9][[:space:]]/ {
  flush()
  id=$2
  status=owner=branch=scope=""
  next
}
id!="" && /^- Status:[[:space:]]*/ {status=$0; sub(/^- Status:[[:space:]]*/,"",status); status=trim(status); next}
id!="" && /^- Owner:[[:space:]]*/ {owner=$0; sub(/^- Owner:[[:space:]]*/,"",owner); owner=trim(owner); next}
id!="" && /^- Branch:[[:space:]]*/ {branch=$0; sub(/^- Branch:[[:space:]]*/,"",branch); branch=trim(branch); next}
id!="" && /^- Scope:[[:space:]]*/ {scope=$0; sub(/^- Scope:[[:space:]]*/,"",scope); scope=trim(scope); next}
END {flush()}
' "$BOARD" > "$META"

awk -F'|' '$1=="E" {sub(/^E\|/,""); print}' "$META" | while IFS= read -r finding; do
  [ -n "$finding" ] && error "$finding"
done

awk -F'|' '
function overlaps(a,b) {
  if (a=="." || b==".") return 1
  return a==b || index(a,b "/")==1 || index(b,a "/")==1
}
$1=="S" {
  count++
  task[count]=$2
  owner[count]=$3
  branch[count]=$4
  scope[count]=$5
}
END {
  for(i=1;i<=count;i++) for(j=i+1;j<=count;j++) {
    if (task[i]==task[j]) continue
    if (!overlaps(scope[i],scope[j])) continue
    a=task[i]; b=task[j]
    if (a>b) {tmp=a; a=b; b=tmp}
    pair=a "|" b
    if (seen[pair]++) continue
    print task[i] " scope '" scope[i] "' overlaps active " task[j] " scope '" scope[j] "'"
  }
}
' "$META" | while IFS= read -r finding; do
  [ -n "$finding" ] && warn "$finding"
done

awk -F'|' '
$1=="B" {
  branch=$4
  if (first[branch]!="" && first[branch]!=$2 && !seen[branch]++)
    print first[branch] " and " $2 " declare the same active Branch: " branch
  else if (first[branch]=="") first[branch]=$2
}
' "$META" | while IFS= read -r finding; do
  [ -n "$finding" ] && warn "$finding"
done

current_branch=${GITHUB_HEAD_REF:-${GITHUB_REF_NAME:-}}
actor=${GITHUB_ACTOR:-}
if [ -n "$current_branch" ] && [ -n "$actor" ]; then
  actor_lower=$(printf '%s' "$actor" | tr '[:upper:]' '[:lower:]')
  awk -F'|' -v current="$current_branch" -v actor="$actor_lower" '
  function lower(value) { return tolower(value) }
  $1=="B" && $4==current && substr($3,1,1)=="@" {
    owner=substr($3,2)
    if (lower(owner)!=actor)
      print $2 " declares Owner " $3 " on branch " current " but GitHub actor is @" actor
  }
  ' "$META" | while IFS= read -r finding; do
    [ -n "$finding" ] && warn "$finding"
  done
fi

error_count=$(wc -l < "$ERRORS" | tr -d ' ')
warning_count=$(wc -l < "$WARNINGS" | tr -d ' ')
printf '\nCoordination summary: %s error(s), %s warning(s)\n' "$error_count" "$warning_count"

[ "$error_count" -eq 0 ] || exit 1
[ "$STRICT" -eq 0 ] || [ "$warning_count" -eq 0 ] || exit 2
echo "PASS  Team coordination metadata is consistent"
