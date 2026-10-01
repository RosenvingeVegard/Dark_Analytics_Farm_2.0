# Nortura design system (reference)

> **Status:** drafted by expanding what `SKILL.md` already states, not sourced
> from Nortura's original design template. Treat every value here as
> provisional until checked against `resources/theme/Nortura_template.json`
> — this file should end up as a *readable expansion* of what's in the real
> theme file, not a second source of truth competing with it.
>
> Canvas-profile and slot-padding content that used to live here was
> retired 2026-10-01 along with the pixel-math layout system it supported
> — see `../README.md`. Layout and slot placement now come from
> `SKILL.md`'s catalog and `scripts/add_page.py`, not from this file.

This is the deeper "why" and "what else" behind `SKILL.md`'s rule list.

## Typography

Default font is Arial (`SKILL.md`). A specific type scale — sizes
for titles, axis labels, data labels — isn't defined anywhere in the
source material yet; pull it from `Nortura_template.json` once
needed, rather than guessing sizes here.

## Color

The seven approved colors, in the fixed sequence `SKILL.md` defines:

1. `#084411` 2. `#F6C04B` 3. `#78993E` 4. `#546B86`
5. `#D79798` 6. `#A1869B` 7. `#BC6365`

`SKILL.md` says to "use stable semantic color meaning across pages" —
meaning once a color has been assigned to represent something (a region,
a product category, a status), that assignment should hold on every page
it appears on again, not be reassigned per-chart. This skill doesn't
prescribe *which* color means what — that mapping should get documented
here once it's established on real reports, so a second report doesn't
independently invent a conflicting assignment.

## Backgrounds and containers

The approved page background already supplies a white rounded panel
behind each content slot. Visual backgrounds inside that slot should be
transparent — adding a second background, shadow, card, or gradient on
top of the approved one is a **Blocking** finding under review mode, not
a stylistic choice.

## Native visual conventions

- Prefer native visuals over Deneb/HTML/R/Python when they satisfy the
  analytical requirement — see `pbi-fabric-router`'s guidance that
  custom visuals aren't a substitute for a native one that already works.
- Skip chart titles the page/header context already communicates.
- Group slicers together and keep their placement predictable across
  pages, rather than scattering them per-page.
- Only override theme defaults with a documented analytical reason —
  "it looked better" isn't one.

## See also

- `../SKILL.md` — layout catalog and the actual build steps.
- `custom-visuals.md` — applying this same palette/typography inside
  Deneb and HTML Content visuals, which don't inherit the report theme
  automatically.
