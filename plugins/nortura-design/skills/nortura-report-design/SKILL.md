---
name: nortura-report-design
description: Nortura-specific Power BI report design system. Use when creating, modifying, reviewing, or standardizing Nortura Power BI report pages, including native Power BI visuals, Deneb visuals, HTML Content visuals, page backgrounds, layout selection, visual placement, spacing, theme application, and visual consistency. Invoke whenever the user asks for a report to follow Nortura design, use the Nortura template, reproduce a Nortura layout, position visuals, choose a background, review report design, or build custom visuals that must match Nortura styling.
---

# Nortura Power BI Report Design

New Nortura pages are built from ready-made template pages, not computed pixel coordinates. This skill tells you which template to copy and what rules apply once it's copied. For *why* this works this way, see `README.md` — this file is instructions only.

## Build a page

1. Pick a layout from the catalog below based on how many analytical elements the page needs and whether it needs persistent nav/filters.
2. Run the add-page script:

   ```bash
   python plugins/nortura-design/skills/nortura-report-design/scripts/add_page.py \
     <LayoutName> "<New Page Display Name>" "<target>.Report"
   ```

   This copies the page (background, theme, unique page ID, `pages.json` entry all handled by the script), applies the Nortura theme to the target report if it doesn't have it yet, validates, and prints a slot map: `<slot name> -> <visual path> [<current type>]`.
3. For each slot in the map, decide the right visual type and fields, then replace the placeholder:
   - `pbir rm "<slot visual path>" -f`
   - `pbir add visual <type> "<target>.Report/<Page>.Page" --name <slot_name> -x <same x> -y <same y> -w <same w> -h <same h> -d "<role>:<Table.Field>"` — read the placeholder's x/y/width/height with `pbir get` *before* removing it, and reuse them exactly.
   - This is the one point where a freshly-named, readable container ID is possible (`pbir mv` cannot rename an existing visual's internal ID — only `add` can set one at creation). Use the slot name as `--name` so the real visual keeps a readable ID.
4. For the `title` slot specifically, just replace its text — don't change its type/position. See README for the known style limitation here.
5. Never call `pbir visuals position` / `resize` / `align` / `snap` on a slot. A hook asks for confirmation if you try; the only legitimate reason to touch position/size is a visual you're creating for the first time.

## Layout catalog

Template report: `Layout report/Layout positions PowerBI.pbix.Report` (canonical path lives in `scripts/add_page.py`'s `DEFAULT_TEMPLATE_REPORT`).

| Layout | Use when | Slots |
|---|---|---|
| `Plain1` | One dominant visual/table fills the page | `main` |
| `Plain2` | Four parallel, equally-weighted analyses | `top_left`, `top_right`, `bottom_left`, `bottom_right` |
| `Plain3` | One tall dominant area + two stacked supporting areas, dominant on the **left** | `left`, `top_right`, `bottom_right` |
| `Plain4` | Same as Plain3, mirrored — dominant on the **right** | `top_left`, `right`, `bottom_left` |
| `Plain5` | Two full-width stacked bands (e.g. trend above detail) | `top`, `bottom` |
| `Plain6` | Three columns, middle column split top/bottom | `left`, `top_center`, `bottom_center`, `right` |
| `Plain7` | Row of 4 KPIs above one dominant content area | `kpi_1`-`kpi_4`, `main` |
| `Plain8` | Full-width banner above a dense grid (7 cells; one cell spans double-width) | `kpi_strip`, `cell_1_1`-`cell_1_4`, `cell_2_1`, `cell_2_2`, `cell_2_4` |
| `Slicer1` | Needs persistent nav + filter panel + one dominant content area | `nav`, `side_panel`, `main` |
| `Slicer2` | Nav + filter panel + two stacked content areas | `nav`, `side_panel`, `top`, `bottom` |
| `Slicer3` | Nav + filter panel + two side-by-side content areas | `nav`, `side_panel`, `left`, `right` |
| `Slicer4` | Nav + filter panel + KPI banner + one dominant content area | `nav`, `side_panel`, `kpi_strip`, `main` |
| `Slicer5` | Nav + filter panel + KPI banner + secondary band + dominant area | `nav`, `side_panel`, `kpi_strip`, `top`, `main` |
| `Slicer6` | Executive-overview density: nav + filters + KPI banner + 4 small KPIs + 2x2 grid | `nav`, `side_panel`, `kpi_strip`, `kpi_1`-`kpi_4`, `cell_1_1`, `cell_1_2`, `cell_2_1`, `cell_2_2` |
| `Blank` | No approved layout fits — explain the deviation before using it | (none) |

Every layout also has a hidden `title` slot (a textbox at the top, not listed per-row above).

## Rules

- Native Power BI visuals first. Don't reach for Deneb/HTML/R/Python to reproduce what a native visual already does — see `references/custom-visuals.md` if one is genuinely justified.
- No extra backgrounds, borders, shadows, or panels on top of the slot — the template background already supplies the white panel. Keep each visual's own background transparent.
- Colors come from the Nortura theme (applied automatically by the script), never hardcoded hex, except inside Deneb/HTML visuals which don't inherit the report theme (`references/custom-visuals.md` covers that case).
- Keep slicers grouped and predictable across pages.
- Skip chart titles the page/header context already communicates.

## Render control

After filling a page's slots: screenshot it (`pbir desktop screenshot` if the report is open in Desktop, otherwise publish to a sandbox workspace and screenshot via browser) and look at it. Fix what's wrong and re-screenshot. **Max 2 rounds** — if it still isn't right after the second screenshot, stop and ask the user rather than continuing to iterate.

## Review mode

Reviewing an existing page (including ones built before this template system existed):

1. Does it use an approved background/theme (Nortura theme, not a default)?
2. Any duplicate panels/shadows/cards on top of the background?
3. Theme colors used consistently, no hardcoded hex outside custom visuals?
4. Typography and spacing consistent with other pages?
5. Custom visuals (if any) follow `references/custom-visuals.md`?
6. Accessibility: contrast, not color-only encoding.

Severity: **Blocking** (breaks layout/theme/usability) / **Major** (inconsistent styling/hierarchy) / **Minor** (polish) / **Accepted deviation** (documented exception).

## See also

- `README.md` — why this system works this way, known gaps/limitations, history.
- `references/custom-visuals.md` — Deneb/HTML theme inheritance.
- `references/design-system.md` — color palette and typography reference.
- `pbi-fabric-router` (harness plugin) — routes to `pbir-cli` for the actual field/formatting mechanics once a slot's visual type is decided.
- `bi-dev-process` (process plugin) — the render-control step above is a hard gate in that workflow, not optional polish.
