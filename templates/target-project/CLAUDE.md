# Nortura Power BI / Fabric project

Semantic models (TMDL), reports (PBIP/PBIR), and their supporting Power
Query/DAX. Built and maintained with Claude Code via the
`nortura-power-bi-agentic` and `power-bi-agentic-development` plugin
marketplaces — see `.claude/settings.json` for the exact plugin list.

This file is intentionally short. It's for orientation and the handful of
things worth stating before any skill even triggers — the actual workflow
and policy detail lives in the skills below, not here. Don't copy their
content into this file; link to it instead, or it'll drift out of sync.

## Before starting any task

1. Route it — use `pbi-fabric-router` to find the right skill rather than
   guessing which plugin owns the work.
2. Write the intake record — every task, light or heavy, writes
   `.claude-governance/current-task.json` with at least its weight before
   touching a report or model file. `process-gate.sh` blocks the edit
   without it, regardless of task size.
3. A user story or loose business ask ("can we get a view of...") goes
   through `report-from-user-story` first — not straight to layout or
   visuals.
4. Weigh it light vs heavy using `bi-dev-process` before deciding how much
   process ceremony it actually needs.

## Non-negotiables

These are enforced by hooks (`harness` plugin), not just this file — but
stating them here means they're obvious before a task even starts:

- Never write to a workspace not listed in `.claude-governance/workspaces.json`,
  or to one tiered `prod` there.
- Never run a row-level query against a dataset classified `personal` or
  `sensitive_personal` in `.claude-governance/data-classification.json`.
- Never run `fab admin` / tenant-setting commands autonomously.

Full policy, including what "ask" vs "deny" actually means per tier: the
`data-governance-policy` skill.

## Nortura-specific standards

- Report layout, theme, backgrounds, branding → `nortura-design`.
- Semantic model naming and BPA conventions → `nortura-semantic-standards`
  — currently placeholder defaults, not a confirmed Nortura standard; read
  that skill before treating it as authoritative.

## Repo layout

*(Fill this in once this file is copied into the real project repo —
where the `.pbip`/`.Report`/`.SemanticModel` folders live, which
workspace(s) this repo deploys to, the main branch name, anything else
someone would need to get oriented in ten seconds.)*
