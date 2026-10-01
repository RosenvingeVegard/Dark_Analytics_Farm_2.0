#!/bin/bash
# task.sh -- validating CLI for .claude-governance/current-task.json.
#
# Replaces hand-editing that file. See process-gate-policy (harness plugin)
# for the schema this enforces and why each field exists; this script only
# enforces shape, not truth -- it can reject a missing self_eval, it can't
# tell you the self_eval is honest.
#
# Usage:
#   task.sh start <light|heavy> "<description>" [--force]
#   task.sh status
#   task.sh phase <scoping|modeling|report_build|deploy> <complete|failed|not_applicable> --self-test "..." --self-eval "..."
#   task.sh batches <modeling|report_build> init "<name 1>" "<name 2>" ...
#   task.sh batch <modeling|report_build> <name-or-1-based-index> <in_progress|complete|failed> --self-test "..." --self-eval "..."
#
# "failed" only requires --self-eval (the reason); "complete" requires both
# --self-test and --self-eval, non-empty -- process-gate-policy's "a
# self-test with no evaluation is just a claim; an evaluation with no test
# is just an opinion" rule, enforced here instead of trusted to memory.

set -euo pipefail

GOV_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude-governance"
TASK_FILE="${GOV_DIR}/current-task.json"

die() { echo "task.sh: $1" >&2; exit 1; }

need_jq() { command -v jq >/dev/null 2>&1 || die "jq is required and not on PATH."; }

parse_kv() {
  # Parses --self-test / --self-eval from the remaining args into globals.
  SELF_TEST=""
  SELF_EVAL=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --self-test) SELF_TEST="${2:-}"; shift 2 ;;
      --self-eval) SELF_EVAL="${2:-}"; shift 2 ;;
      --force) FORCE=true; shift ;;
      *) die "Unrecognized argument: $1" ;;
    esac
  done
}

cmd_start() {
  local weight="${1:-}" desc="${2:-}"
  shift 2 || true
  FORCE=false
  parse_kv "$@"
  case "$weight" in light|heavy) ;; *) die "weight must be 'light' or 'heavy', got '${weight}'" ;; esac
  [ -n "$desc" ] || die "a task description is required: task.sh start <light|heavy> \"<description>\""

  if [ -f "$TASK_FILE" ] && [ "$FORCE" != true ]; then
    local age_minutes
    age_minutes=$(( ( $(date +%s) - $(stat -c %Y "$TASK_FILE" 2>/dev/null || stat -f %m "$TASK_FILE") ) / 60 ))
    if [ "$age_minutes" -lt 480 ]; then
      die "current-task.json already exists and is ${age_minutes} min old. If it's genuinely finished/abandoned, pass --force. If it's still active, don't start a new one over it."
    fi
  fi

  mkdir -p "$GOV_DIR"
  local started_at
  started_at=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  if [ "$weight" = "light" ]; then
    jq -n --arg d "$desc" --arg w "$weight" --arg t "$started_at" \
      '{task_description: $d, weight: $w, started_at: $t}' > "$TASK_FILE"
  else
    jq -n --arg d "$desc" --arg w "$weight" --arg t "$started_at" '{
      task_description: $d, weight: $w, started_at: $t,
      phases: {
        scoping:      {status: "not_started", self_test: "", self_eval: "", plan_approved: false},
        modeling:     {status: "not_started", self_test: "", self_eval: "", entry_prompted: false, batches: []},
        report_build: {status: "not_started", self_test: "", self_eval: "", entry_prompted: false, batches: []},
        deploy:       {status: "not_started", self_test: "", self_eval: ""}
      }
    }' > "$TASK_FILE"
  fi
  echo "Wrote ${TASK_FILE} (weight: ${weight})."
}

require_heavy() {
  [ -f "$TASK_FILE" ] || die "No current-task.json yet. Run 'task.sh start <light|heavy> \"<description>\"' first."
  local w
  w=$(jq -r '.weight // empty' "$TASK_FILE")
  [ "$w" = "heavy" ] || die "current-task.json is weight '${w}'; phases/batches only apply to heavy tasks."
}

cmd_phase() {
  local phase="${1:-}" status="${2:-}"
  shift 2 || true
  parse_kv "$@"
  case "$phase" in scoping|modeling|report_build|deploy) ;; *) die "phase must be one of: scoping, modeling, report_build, deploy" ;; esac
  case "$status" in complete|failed|not_applicable) ;; *) die "status must be one of: complete, failed, not_applicable" ;; esac
  require_heavy

  if [ "$phase" != "deploy" ]; then
    local batch_count
    batch_count=$(jq -r ".phases.${phase}.batches // [] | length" "$TASK_FILE")
    if [ "$batch_count" -gt 0 ] && [ "$status" = "complete" ]; then
      local incomplete
      incomplete=$(jq -r "[.phases.${phase}.batches[] | select(.status != \"complete\")] | length" "$TASK_FILE")
      [ "$incomplete" -eq 0 ] || die "${phase} has ${incomplete} batch(es) not yet complete; mark those complete with 'task.sh batch' first, not the parent phase directly."
    fi
  fi

  if [ "$status" = "complete" ]; then
    [ -n "$SELF_TEST" ] || die "--self-test is required to mark a phase complete."
    [ -n "$SELF_EVAL" ] || die "--self-eval is required to mark a phase complete."
    jq --arg p "$phase" --arg t "$SELF_TEST" --arg e "$SELF_EVAL" \
      '.phases[$p].status = "complete" | .phases[$p].self_test = $t | .phases[$p].self_eval = $e' \
      "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"
  elif [ "$status" = "failed" ]; then
    [ -n "$SELF_EVAL" ] || die "--self-eval (the reason it failed) is required."
    jq --arg p "$phase" --arg e "$SELF_EVAL" \
      '.phases[$p].status = "failed" | .phases[$p].self_eval = $e' \
      "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"
  else
    jq --arg p "$phase" '.phases[$p].status = "not_applicable"' \
      "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"
  fi
  echo "Set phases.${phase}.status = ${status}."
}

cmd_batches() {
  local phase="${1:-}"; shift || true
  local action="${1:-}"; shift || true
  case "$phase" in modeling|report_build) ;; *) die "batches only apply to 'modeling' or 'report_build'" ;; esac
  [ "$action" = "init" ] || die "usage: task.sh batches <modeling|report_build> init \"<name 1>\" \"<name 2>\" ..."
  [ $# -ge 1 ] || die "at least one batch name is required"
  require_heavy

  local existing
  existing=$(jq -r ".phases.${phase}.batches // [] | length" "$TASK_FILE")
  [ "$existing" -eq 0 ] || die "${phase} already has ${existing} batch(es). Delete/edit current-task.json by hand if you really need to redefine them -- this is deliberately not a one-liner."

  local names_json="[]"
  for n in "$@"; do
    names_json=$(echo "$names_json" | jq --arg n "$n" '. + [$n]')
  done
  jq --arg p "$phase" --argjson names "$names_json" \
    '.phases[$p].batches = ($names | map({name: ., status: "not_started", self_test: "", self_eval: "", entry_prompted: false}))' \
    "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"
  echo "Set phases.${phase}.batches to $# batch(es)."
}

resolve_batch_index() {
  local phase="$1" ref="$2"
  if echo "$ref" | grep -qE '^[0-9]+$'; then
    echo $(( ref - 1 ))
    return
  fi
  local idx
  idx=$(jq -r --arg p "$phase" --arg n "$ref" '.phases[$p].batches | map(.name) | index($n) // -1' "$TASK_FILE")
  [ "$idx" != "-1" ] || die "No batch named '${ref}' in phases.${phase}.batches."
  echo "$idx"
}

cmd_batch() {
  local phase="${1:-}" ref="${2:-}" status="${3:-}"
  shift 3 || true
  parse_kv "$@"
  case "$phase" in modeling|report_build) ;; *) die "batch phase must be 'modeling' or 'report_build'" ;; esac
  case "$status" in in_progress|complete|failed) ;; *) die "batch status must be one of: in_progress, complete, failed" ;; esac
  require_heavy

  local count
  count=$(jq -r ".phases.${phase}.batches // [] | length" "$TASK_FILE")
  [ "$count" -gt 0 ] || die "phases.${phase} has no batches. Run 'task.sh batches ${phase} init ...' first."
  local idx
  idx=$(resolve_batch_index "$phase" "$ref")
  [ "$idx" -ge 0 ] && [ "$idx" -lt "$count" ] || die "Batch index ${idx} out of range (0..$((count-1)))."

  if [ "$status" = "complete" ]; then
    [ -n "$SELF_TEST" ] || die "--self-test is required to mark a batch complete."
    [ -n "$SELF_EVAL" ] || die "--self-eval is required to mark a batch complete."
    jq --arg p "$phase" --argjson i "$idx" --arg t "$SELF_TEST" --arg e "$SELF_EVAL" \
      '.phases[$p].batches[$i].status = "complete" | .phases[$p].batches[$i].self_test = $t | .phases[$p].batches[$i].self_eval = $e' \
      "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"
  elif [ "$status" = "failed" ]; then
    [ -n "$SELF_EVAL" ] || die "--self-eval (the reason) is required."
    jq --arg p "$phase" --argjson i "$idx" --arg e "$SELF_EVAL" \
      '.phases[$p].batches[$i].status = "failed" | .phases[$p].batches[$i].self_eval = $e' \
      "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"
  else
    jq --arg p "$phase" --argjson i "$idx" '.phases[$p].batches[$i].status = "in_progress"' \
      "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"
  fi
  local name
  name=$(jq -r --arg p "$phase" --argjson i "$idx" '.phases[$p].batches[$i].name' "$TASK_FILE")
  echo "Set phases.${phase}.batches[${idx}] ('${name}') status = ${status}."
}

cmd_status() {
  [ -f "$TASK_FILE" ] || die "No current-task.json. Run 'task.sh start <light|heavy> \"<description>\"' first."
  local weight desc
  weight=$(jq -r '.weight' "$TASK_FILE")
  desc=$(jq -r '.task_description' "$TASK_FILE")
  echo "Task: ${desc} (weight: ${weight})"
  [ "$weight" = "heavy" ] || { echo "Light task -- no phase tracking."; return; }
  jq -r '
    .phases | to_entries[] |
    if (.value.batches // [] | length) > 0 then
      "\(.key): " + ([.value.batches[] | "\(.name)=\(.status)"] | join(", "))
    else
      "\(.key): \(.value.status)"
    end
  ' "$TASK_FILE"
}

need_jq
cmd="${1:-}"; shift || true
case "$cmd" in
  start)    cmd_start "$@" ;;
  phase)    cmd_phase "$@" ;;
  batches)  cmd_batches "$@" ;;
  batch)    cmd_batch "$@" ;;
  status)   cmd_status "$@" ;;
  *) die "usage: task.sh <start|phase|batches|batch|status> ..." ;;
esac
