<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# SolidWorks Plan

## Model Structure

Use a master-layout assembly driven by `parameters.csv`:

1. `slit-box-master.SLDPRT` - folded 200 x 100 x 80 mm box with configurable tongue sketch.
2. `bank-rack.SLDPRT` - two side rails, tilt blocks, and box locating slots.
3. `mallet-rest.SLDPRT` - optional bent sheet strip.
4. `tuned-slit-drum-bank.SLDASM` - twelve configured box instances.

## Configurations

Create twelve configurations named `BOX-01-C3` through `BOX-12-B3`. Each
configuration changes only:

- Primary tongue length.
- Secondary tongue length, if included.
- Etched note label.
- Final trim witness marks.

Do not change box envelope per note in the first prototype. Keeping all boxes
identical isolates tuning variables to tongue geometry.

## Feature Sequence

1. Master layout sketch for the 200 x 100 x 80 mm box.
2. Base flange/tab with 1.5 mm thickness.
3. Edge flanges for long sides, short sides, and closure tabs.
4. Corner reliefs sized at least 1.5 x thickness.
5. U-shaped primary tongue cut sketch with 2.5 mm root radii.
6. Optional secondary tongue cut sketch on the opposite half of the top.
7. Note label etch and trim witness marks.
8. Flat pattern configuration and drawing.

## Rack

The rack holds boxes chromatically left-to-right with 12 mm gaps and an 8 degree
tilt toward the player. Use rubber isolation strips between rack and boxes so
the rack does not kill sustain.

## Authority Boundary

The CAD can define the folded boxes and initial tongue geometry. It cannot
certify pitch. Final tongue length requires prototype tuning and measurement.
