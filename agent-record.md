<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Agent Record - Tuned Slit Drum Bank

- Runtime: gpt-5.5 Codex CLI
- Skills loaded: sheet-metal, instrument-maker
- Date executed: 2026-05-21
- Repo: `tonykoop/tuned-slit-drum-bank`

## QMD Queries

- `qmd search "Tuned Slit Drum Bank" -c instrument-builds`: returned `qmd://instrument-builds/docs/solidworks/skeletal-modeling-tutorial.md` for a tongue-drum box tutorial.
- `qmd search "Tuned Slit Drum Bank" -c instrument-wiki`: returned `qmd://instrument-wiki/sources/legacy-rectangular-tongue-drum.md` and the instrument wiki index tongue-drum classes.
- `qmd vector_search "Tuned Slit Drum Bank sheet metal forming bore profile"`: unsupported command.
- `qmd get /mnt/c/Users/Tony/Documents/GitHub/handpan/design.md`: returned unrelated WRFCoin economic-design text, likely index mismatch.
- `qmd get /mnt/c/Users/Tony/Documents/GitHub/handpan/validation.csv`: document not found.
- `qmd get /mnt/c/Users/Tony/Documents/GitHub/handpan/wolfram-starter.wl`: document not found.

## Phase PRs

- PR #1: `feat(tuned-slit-drum-bank): license scaffold`
- PR #2: `feat(tuned-slit-drum-bank): design model`
- PR #3: `feat(tuned-slit-drum-bank): cad and flat patterns`
- PR #4: `feat(tuned-slit-drum-bank): fabrication plan`
- PR #5: `feat(tuned-slit-drum-bank): validation and risks`
- PR #6: `feat(tuned-slit-drum-bank): explorer and readme`

## Major Assumptions

- 1.5 mm 1018 cold-rolled steel behaves close enough to the starter beam model for first coupons.
- Keeping every box envelope identical is more useful than resizing boxes by pitch for the first prototype.
- Secondary tongues are optional color features, not validation-critical notes.
- Laser cutting is preferred over plasma if tongue-root quality is poor.

## Coupon Tests Recommended

- C3 long tongue coupon.
- F#3 middle tongue coupon.
- B3 short tongue coupon.
- Welded prototype box pitch-shift test.
- Rack isolation sustain/cross-talk test.

## Confidence

- Acoustic targets: medium-low until C3/F#3/B3 coupons are measured.
- Flat patterns: medium for folded boxes and rack.
- Fabrication plan: medium.
- BOM: medium.

## Retrospective

Across the four rounds, the recurring lesson is that the most valuable sprint
artifact is not a pretty object description; it is a measurement-ready path
from optimistic geometry to honest tuning corrections. Horns, dishes, harps,
and slit tongues all need the same discipline: name the coupling assumption,
make the first model runnable, isolate prototype variables, and avoid claiming
CAD or acoustic authority before coupons and measurements exist.

## Suggested Next-Round Task

Build and measure the three-note coupon/prototype set, then update the Wolfram
model with empirical root-stiffness and kerf correction factors before cutting
the remaining nine boxes.
