<!-- SPDX-License-Identifier: CC-BY-4.0 -->

---
instrument: tuned_slit_drum_bank
family: idiophone
acoustic_class: tuned_sheet_metal_tongues
scale: chromatic_C3_B3
authority: private_review_blueprint
---

# Design

## Summary

The Tuned Slit Drum Bank is a 12-note chromatic idiophone. Each note is a small
welded cold-rolled steel box with a U-shaped tongue cut into its top plate. The
boxes mount in a shallow rack in chromatic order, played with soft mallets like
a compact marimba.

## Lineage

This Round 4 idiophone pulls from the R1 handpan/tongue-field craft and the R2
mute-tuned horn idea: small geometry changes become tuning changes. QMD also
surfaced a tongue-drum SolidWorks skeletal-modeling tutorial and rectangular
tongue-drum wiki/source stream, so this packet uses a skeletal master-layout
approach and keeps tuning authority measurement-gated.

## Acoustic Model

Each primary tongue is approximated as a rectangular cantilever beam:

`f = beta1^2 / (2 pi L^2) * sqrt(E I / (rho A))`

For a rectangular tongue, `I = w t^3 / 12` and `A = w t`, so width mostly
affects loudness/stiffness margin and root behavior while length and thickness
dominate the first estimate.

## Note Plan

| Box | Note | Frequency Hz | Primary Role | Secondary Tongue |
| ---: | --- | ---: | --- | --- |
| 1 | C3 | 130.81 | validated pitch | G3 color |
| 2 | C#3 | 138.59 | validated pitch | G#3 color |
| 3 | D3 | 146.83 | validated pitch | A3 color |
| 4 | D#3 | 155.56 | validated pitch | A#3 color |
| 5 | E3 | 164.81 | validated pitch | B3 color |
| 6 | F3 | 174.61 | validated pitch | C4 color |
| 7 | F#3 | 185.00 | validated pitch | C#4 color |
| 8 | G3 | 196.00 | validated pitch | D4 color |
| 9 | G#3 | 207.65 | validated pitch | D#4 color |
| 10 | A3 | 220.00 | validated pitch | E4 color |
| 11 | A#3 | 233.08 | validated pitch | F4 color |
| 12 | B3 | 246.94 | validated pitch | F#4 color |

The secondary tongues are lower-amplitude color features. If they cross-talk or
destabilize tuning, omit them from the first prototype.

## Geometry

- Box outside envelope: 200 x 100 x 80 mm.
- Top material: 1.5 mm cold-rolled steel.
- Primary tongue width: 18 mm.
- Primary tongue estimated length range: about 70-100 mm.
- Root radius: 2.5 mm minimum after cutting.
- Side seams: TIG welded after brake forming from a single blank.
- Rack spacing: 12 mm gap between boxes, 8 degree player tilt.

## Tuning

Coarse tune by lengthening/shortening the tongue tip cut. Fine tune by removing
small mass near the tongue tip to raise pitch, or adding small removable mass to
lower pitch during tests. Do not grind near the root unless resetting the whole
box; root stiffness changes are hard to control.

## Readiness

This is a private-review blueprint. The first build must start with tongue-root
coupons and three prototype boxes (C3, F#3, B3) before cutting all twelve.
