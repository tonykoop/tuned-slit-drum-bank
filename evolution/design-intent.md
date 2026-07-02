# Design Intent — tuned-slit-drum-bank rev A

- Master: `parameters.csv` (sha256: 34b18732e8a668fdc572c6269d5e6cfbe49e5800488f59025605dcfbd933353b); no CAD master exists yet (L1 — cad/slit-drum-bank.scad registered not-yet-generated pending coupon-validated tongue dimensions)
- Function: Bank of 12 chromatic (C3–B3) sheet-steel slit-drum boxes; each box is a 200×100×80 mm 1018 cold-rolled steel enclosure whose top plate carries a U-cut cantilever tongue tuned by length/width. Struck with mallets.
- Environment: percussion use; welded steel; pitch is set after welding (weld warp shifts pitch — risks.md).
- Target qty: 1 bank (12 boxes, prototype). Deadline: TBD. Budget: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Sheet thickness | 1.5 mm | coupon gate | tongue stiffness → pitch | parameters.csv (high confidence) |
| Tongue width | 18 mm starter | coupon-validated before release | pitch + durability | parameters.csv (medium — agent estimate) |
| Tongue root radius | 2.5 mm | preserve during cutting | crack prevention | risks.md |
| Box envelope | 200×100×80 mm | fabrication nominal | resonator volume | parameters.csv |
| Tongue lengths per note | TBD | measurement_required | chromatic tuning C3–B3 | validation-checklist.md gates |

## Incidental (free for DFM)

- Corner treatment, mounting/rack arrangement of the 12 boxes, surface finish.

## Must-nots (DFM may never violate)

- Do not release tongue-cut geometry before coupon validation (validation-checklist.md; register rows are pending_measurement).
- Preserve 2.5 mm tongue root radii — no sharp roots (crack risk).
- Tune AFTER welding — weld warp shifts pitch; short TIG stitches only (risks.md).

## Material intent

- 1018 cold-rolled steel sheet, 1.5 mm (parameters.csv; medium confidence on alloy choice).

## Stage status

Stage 0 intake complete 2026-07-01. Gate A NOT run — no concessions logged.
