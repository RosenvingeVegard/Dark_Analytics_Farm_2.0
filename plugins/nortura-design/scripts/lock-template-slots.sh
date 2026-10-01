#!/bin/bash
# PreToolUse hook (matcher: Bash).
#
# Nortura design rule: once a page is built from a template layout
# (nortura-report-design SKILL.md), its placeholder containers (slots) never
# move or resize. The agent fills a slot's visual type/fields; it never calls
# `pbir visuals position` / `pbir visuals resize` / `pbir visuals align` /
# `pbir visuals snap` on them. New visuals get their position at creation
# time via `pbir add visual ... -x -y -w -h`.
#
# This is pattern-matching on the command line, not a content-aware check —
# it cannot tell whether a given visual is actually a template slot. It asks
# for confirmation on every position/resize/align/snap call so a human
# reviews the intent, except when the target path is the canonical template
# report itself (maintaining the master layouts is expected to need this).
#
# Deliberately "ask", not "deny": fixing the master template (see
# nortura-report-design/scripts/add_page.py's DEFAULT_TEMPLATE_REPORT) is a
# legitimate, if infrequent, operation.

set -euo pipefail

# No jq dependency: this machine doesn't have jq on PATH (true for the
# existing harness hooks too, as of 2026-10 -- see nortura-report-design's
# README for that finding). python3 is confirmed present; use it instead.
input=$(cat)
command=$(echo "$input" | python3 -c "import json,sys; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null || true)

if ! echo "$command" | grep -qiE 'pbir .*(visuals[[:space:]]+(position|resize|align|snap))'; then
  exit 0
fi

# Allow template-maintenance edits on the canonical layout report itself.
if echo "$command" | grep -qiE 'Layout positions PowerBI\.pbix\.Report'; then
  exit 0
fi

reason="This command repositions/resizes a visual. Nortura template-derived pages never move or resize their slot containers (nortura-report-design SKILL.md) -- a new visual's position is set once at creation via 'pbir add visual ... -x -y -w -h'. Confirm this isn't touching a template slot before proceeding."
python3 -c "
import json
print(json.dumps({
    'hookSpecificOutput': {
        'hookEventName': 'PreToolUse',
        'permissionDecision': 'ask',
        'permissionDecisionReason': '''$reason'''
    }
}))
"
exit 0
