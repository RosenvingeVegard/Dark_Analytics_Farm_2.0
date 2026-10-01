# Nortura report design — rationale and history

This is the "why" behind `SKILL.md`. `SKILL.md` is instructions for the agent;
this file is context for humans maintaining the system. Read `SKILL.md` first.

## Why this exists: from pixel math to template pages

Before 2026-09, this skill had the agent compute visual placement itself:
detect the canvas profile, look up a slot's pixel coordinates in
`layouts/layouts.json`, apply a padding formula, and write the result into
PBIR. That worked but cost real time and tokens on every page, and it was
only ever fully specified for one canvas size (`nortura_custom`,
1819×1030) — a real report built at the standard 1280×720 widescreen size
(`Kvalitetsrapportering POC`) had nothing to look up and fell back to an
ad-hoc grid.

The replacement: a single template report
(`Layout report/Layout positions PowerBI.pbix.Report`) already has one page
per approved layout, each with the Nortura theme, the right background
image, and placeholder containers sitting at the exact position/size they
should have. The agent copies a page and fills placeholders; it never
computes a coordinate. Mechanics (copying, unique IDs, `pages.json`,
background resource registration, theme application) live in
`scripts/add_page.py`; layout choice and slot content are still the
agent's judgment call.

`layouts/layouts.json`, `layouts/Bakgrunner_PP/`, and `resources/backgrounds/`
are the *old* system's assets. They're left in place (not deleted) since
nothing currently depends on removing them, but they're superseded — don't
use them for new pages. `resources/theme/Nortura_template.json` is still
the right theme file (also installed as a reusable `pbir` theme template
named `Nortura` — see below).

## Why placeholder slot names live in a hidden title, not the folder name

PBIR stores a visual container's internal identity as `name`, which is also
its folder name. `pbir mv` on an existing visual **does not rename this** —
tested directly: renaming `e9e58408...` to `main` left the folder and
`name` field untouched and instead set the (normally invisible)
`visualContainerObjects.title.text` property to `'main'` with
`title.show: false`. This is consistent, not a bug: Power BI Desktop itself
never lets you rename a visual's internal ID either, probably because
other PBIR structures (interactions, bookmarks, visual groups) reference it
by that ID and an uncontrolled rename could silently break them.

So slot names in the template report are the hidden `title.text`, not the
folder name — read it with `pbir get "<visual path>.title.text"`, or let
`add_page.py` print the whole slot map for you.

There's one exception: a **freshly created** visual has no prior references
to break, so `pbir add visual <type> ... --name <anything>` *does* accept
an arbitrary readable name as the real folder/`name` field (confirmed: a
test `add visual card --name test_slot` produced a literal `test_slot/`
folder with `"name": "test_slot"` in its JSON). This is why `SKILL.md`'s
fill-in-a-slot steps delete the placeholder and recreate it with
`--name <slot_name>` rather than trying to convert it in place — that's
the one point where a readable *and* real container ID is achievable.

## Known limitation: the title placeholder's text style

Every template page's `title` slot was originally a textbox literally
containing `"Page title"` **including the quote characters** — a
pre-existing authoring mistake in the source file, rendering visibly as
`"Page title"` on screen. `pbir set` cannot patch a textbox's rich-text
paragraph content directly (`general.paragraphs` is structural, not a
flat formatting property — confirmed: `pbir set ...general.paragraphs`
with a JSON string value wrapped the whole string as one literal value
instead of structurally replacing the array). The only CLI-sanctioned way
to produce correct paragraph content is to create a fresh textbox via
`pbir add title`, which doesn't expose font-size or alignment flags.

The fix applied to the template (2026-10-01): deleted and recreated all 15
`title` placeholders via `pbir add title`, then repositioned each to the
original slot (x=18, y=14, w=448, h=48) via `pbir visuals position`. Net
effect: the quote bug is gone, but the title text is now 24pt left-aligned
instead of the original 16pt centered — there's no CLI-supported way to
set a textbox's per-run font size or paragraph alignment without hand-
editing JSON, which the `pbir-cli` skill's own rules forbid. Treat this as
an accepted, documented deviation, not a regression to silently fix later
by editing JSON directly.

While fixing this, the batch `rm` of all 15 old placeholders failed with
Windows "Access denied" (`WinError 5`) on `pbir`'s `.visual-delete-*`
staging folder — almost certainly OneDrive file-lock/sync interference on
a continuously-synced folder, not a `pbir` bug. The script still proceeded
to create replacement visuals anyway, leaving 14 empty orphaned visual
folders that `pbir validate --all` correctly flagged as
`MISSING_VISUAL_JSON` errors. They were empty (no JSON content to lose)
and no longer referenced by `pbir`'s own view of the page, so removing the
bare directories was safe filesystem cleanup, not a JSON edit. If a future
`pbir rm`/`cp`/`add` batch against this report errors with "Access denied"
on a `.{something}-{guid}-{guid}` staging path, suspect the same cause and
check for the same kind of orphaned folder afterward with
`pbir validate --all`.

## Known limitation: the harness's existing hooks may not be enforcing anything

`policy-check.sh` and `process-gate.sh` (in the `harness` plugin) both
shell out to `jq` for every decision. As of 2026-10-01, this machine has no
`jq` on `PATH` (`command -v jq` fails, and no `jq.exe` exists anywhere
findable). A hook script that errors doesn't necessarily block the tool
call it's attached to — depending on how the harness treats a failing hook
process, this plausibly means those two hooks have been silently failing
open (no enforcement) rather than "working well" as assumed. This wasn't
fixed here (out of this skill's scope — `harness` owns those files), but
it's worth the project owner confirming jq is actually installed and that
a `jq`-dependent hook actually fires a deny/ask when it should, rather than
trusting "no prompts appeared" as evidence it's working.

The new hook this skill ships (`scripts/lock-template-slots.sh`,
registered in `hooks/hooks.json`) deliberately uses `python3` instead of
`jq` for exactly this reason — `python3` is confirmed present on this
machine; `jq` is not.

## Canvas size

The template report's pages are the Power BI Desktop default, 1280×720.
The *old* system's `nortura_custom` 1819×1030 profile (derived from the
original Nortura PowerPoint export) has no equivalent template page yet.
If a page genuinely needs that larger canvas, it isn't covered by the
layout catalog in `SKILL.md` — treat it the same as any other case nothing
in the catalog fits: use `Blank` and say why, rather than falling back to
the old pixel-math approach.

## Color palette

Fixed, approved sequence (do not introduce other colors):

1. `#084411` 2. `#F6C04B` 3. `#78993E` 4. `#546B86`
5. `#D79798` 6. `#A1869B` 7. `#BC6365`

These are baked into the `Nortura` theme template (`pbir theme list-templates`
shows it as "Approved Nortura Power BI theme (design system)", recommended,
last updated 2026-08-31) and into `resources/theme/Nortura_template.json`.
`add_page.py` applies this theme automatically the first time a target
report doesn't already have it.

## The sibling skill, `powerbi-nortura-backgrounds`

That skill still exists and covers the *same* ground (choosing a
background, placing visuals) via the old percentage-coordinate approach.
It now carries a deprecation note pointing here. It wasn't deleted or
rewritten — only flagged — since retiring it properly is a separate
decision, not something to do silently as a side effect of this rewrite.

## See also

- `SKILL.md` — the actual instructions.
- `scripts/add_page.py` — the mechanics; re-derive its `LAYOUT_SLOTS` table
  from the template report (`pbir tree` + `pbir get ...title.text` per
  visual) if the template report ever changes.
