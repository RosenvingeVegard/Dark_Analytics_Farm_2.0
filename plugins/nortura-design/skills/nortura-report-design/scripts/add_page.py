#!/usr/bin/env python3
"""Copy a Nortura template layout page into a target report.

Mechanics only: this script never decides what goes into a page. It copies a
ready-made layout page (background + placeholder containers) from the template
report into the target report, applies the Nortura theme once if missing, and
reports back the slot names available on the new page. The calling agent is
responsible for choosing visual types and fields for each slot -- this script
never touches visual type, fields, position, or size.

Usage:
    python add_page.py <layout> <page_name> <target_report_path> [--template PATH]

Example:
    python add_page.py Slicer3 "Ar-over-ar" "C:/Reports/Sales.Report"
"""

import argparse
import json
import os
import subprocess
import sys

for _stream in (sys.stdout, sys.stderr):
    if hasattr(_stream, "reconfigure"):
        _stream.reconfigure(encoding="utf-8", errors="replace")

DEFAULT_TEMPLATE_REPORT = (
    r"C:\Users\vrosenvi\OneDrive - Nortura SA\Dark Analytics Farm"
    r"\Layout report\Layout positions PowerBI.pbix.Report"
)

NORTURA_THEME_TEMPLATE = "Nortura"

# Slot names per layout, in the order they should be filled (title is always
# present but hidden -- it is the placeholder's own label, not a visual on
# the page). Keep this in sync with the template report; re-derive it with
# `pbir tree` + `pbir get ...title.text` if the template report changes.
LAYOUT_SLOTS = {
    "Plain1": ["main"],
    "Plain2": ["top_left", "top_right", "bottom_left", "bottom_right"],
    "Plain3": ["left", "top_right", "bottom_right"],
    "Plain4": ["top_left", "right", "bottom_left"],
    "Plain5": ["top", "bottom"],
    "Plain6": ["left", "top_center", "bottom_center", "right"],
    "Plain7": ["kpi_1", "kpi_2", "kpi_3", "kpi_4", "main"],
    "Plain8": [
        "kpi_strip",
        "cell_1_1", "cell_1_2", "cell_1_3", "cell_1_4",
        "cell_2_1", "cell_2_2", "cell_2_4",
    ],
    "Slicer1": ["nav", "side_panel", "main"],
    "Slicer2": ["nav", "side_panel", "top", "bottom"],
    "Slicer3": ["nav", "side_panel", "left", "right"],
    "Slicer4": ["nav", "side_panel", "kpi_strip", "main"],
    "Slicer5": ["nav", "side_panel", "kpi_strip", "top", "main"],
    "Slicer6": [
        "nav", "side_panel", "kpi_strip",
        "kpi_1", "kpi_2", "kpi_3", "kpi_4",
        "cell_1_1", "cell_1_2", "cell_2_1", "cell_2_2",
    ],
    "Blank": [],
}


def run(args):
    proc = subprocess.run(
        ["pbir", "-q", *args],
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )
    return proc.returncode, (proc.stdout or "").strip(), (proc.stderr or "").strip()


def get_report_property(report_path, prop):
    code, out, err = run(["get", report_path])
    if code != 0:
        print(err or out, file=sys.stderr)
        sys.exit(code)
    for line in out.splitlines():
        if line.startswith(f"{prop} "):
            return line.split("=", 1)[1].strip()
    return None


def ensure_nortura_theme(target_report):
    current = get_report_property(target_report, "theme")
    if current and NORTURA_THEME_TEMPLATE.lower() in current.lower():
        print(f"Theme already Nortura ({current}); skipping.")
        return
    print(f"Current theme is '{current}'; applying Nortura theme template.")
    code, out, err = run(
        ["theme", "apply-template", target_report, NORTURA_THEME_TEMPLATE]
    )
    print(out)
    if code != 0:
        print(err, file=sys.stderr)
        sys.exit(code)


def add_page(layout, page_name, target_report, template_report):
    if layout not in LAYOUT_SLOTS:
        print(
            f"Unknown layout '{layout}'. Available: {', '.join(LAYOUT_SLOTS)}",
            file=sys.stderr,
        )
        sys.exit(1)

    ensure_nortura_theme(target_report)

    from_path = f"{template_report}/{layout}.Page"
    to_path = f"{target_report}/{page_name}.Page"
    print(f"Copying {from_path} -> {to_path}")
    code, out, err = run(["cp", from_path, to_path])
    print(out)
    if code != 0:
        print(err, file=sys.stderr)
        sys.exit(code)

    code, out, err = run(["validate", target_report, "--qa"])
    print(out)
    if code != 0:
        print(err, file=sys.stderr)

    print(f"\nPage '{page_name}' created from layout '{layout}'.")
    print(print_slot_map(target_report, page_name))
    print(
        "Each row above is <slot name> -> <visual path>. The slot name is the "
        "visual's hidden title.text (title.show is false, so it never renders). "
        "Fill in visual type and fields for each slot; never move/resize/rename "
        "the container."
    )


def print_slot_map(target_report, page_name):
    code, out, err = run(
        ["find", f"{target_report}/{page_name}.Page/*.Visual", "--json"]
    )
    if code != 0:
        print(err or out, file=sys.stderr)
        sys.exit(code)
    matches = json.loads(out).get("matches", [])
    lines = []
    for m in matches:
        visual_path = f"{target_report}/{page_name}.Page/{m['name']}.Visual"
        _, title, _ = run(["get", f"{visual_path}.title.text"])
        slot = title or "(untitled)"
        lines.append(f"  {slot:<14} -> {visual_path}  [{m['visualType']}]")
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("layout", help="Template layout page name, e.g. Slicer3")
    parser.add_argument("page_name", help="Display name for the new page")
    parser.add_argument("target_report", help="Path to the target .Report")
    parser.add_argument(
        "--template",
        default=DEFAULT_TEMPLATE_REPORT,
        help="Path to the template report (default: canonical Nortura layout report)",
    )
    args = parser.parse_args()
    add_page(args.layout, args.page_name, args.target_report, args.template)


if __name__ == "__main__":
    main()
