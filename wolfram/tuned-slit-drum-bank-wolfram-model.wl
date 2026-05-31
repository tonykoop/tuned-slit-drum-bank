(* Wolfram QA 2026-05-30: estimate - pending measurement, not fabrication authority.
   Variables and associations with Estimate suffix are planning values only unless
   later replaced by measured validation data or reviewed design-table authority. *)

(* SPDX-License-Identifier: CERN-OHL-W-2.0 *)

(* Tuned Slit Drum Bank starter acoustics.
   Authority: cantilever first pass only; tune by measured prototype boxes.
   Self-contained: default material/geometry params inlined (no CSV / online calls). *)

ClearAll["Global`*"];

(* --- Default planning parameters (EMPIRICAL ESTIMATES, not authority) --- *)
eSteelEstimate = 2.0*10^11;        (* steel Young's modulus, Pa *)
rhoSteelEstimate = 7850.0;         (* steel density, kg/m^3 *)
tipTrimReserveEstimate = 8.0;      (* leave-blank tip trim reserve, mm *)
targetPitchToleranceEstimate = 10; (* +/- cents *)
minimumSustainEstimate = 2.0;      (* s *)

midiFreq[m_] := 440.0*2^((m - 69)/12);
noteNames = {"C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3"};
midis = Range[48, 59];

(* Cantilever (clamped-free) beam fundamental for a flat tongue of *)
(* length L (m), width w (m), thickness tt (m). Width cancels; kept *)
(* explicit so the relation reads as built. *)
beamFreq[L_, w_, tt_] := Module[{Inertia = w*tt^3/12, A = w*tt},
  (1.875104^2/(2*Pi*L^2))*Sqrt[eSteelEstimate*Inertia/(rhoSteelEstimate*A)]
];

(* Invert: tongue length (m) needed to land fundamental f (Hz). *)
lengthForFreq[f_, w_, tt_] := Module[{Inertia = w*tt^3/12, A = w*tt},
  Sqrt[(1.875104^2/(2*Pi*f))*Sqrt[eSteelEstimate*Inertia/(rhoSteelEstimate*A)]]
];

(* Build the chromatic primary + fifth-above secondary tongue tables. *)
primaryTable[wPrimary_, tt_] := Table[
  With[{f = midiFreq[midis[[i]]], l = lengthForFreq[midiFreq[midis[[i]]], wPrimary, tt]},
    <|"box" -> i, "note" -> noteNames[[i]], "targetHz" -> N[f, 6],
      "primaryLengthMM" -> N[1000*l, 6],
      "leaveBlankLengthMM" -> N[1000*l + tipTrimReserveEstimate, 6],
      "predictedCheckHz" -> N[beamFreq[l, wPrimary, tt], 6]|>
  ],
  {i, Length[midis]}];

secondaryTable[wSecondary_, tt_] := Table[
  With[{m = midis[[i]] + 7, f = midiFreq[midis[[i]] + 7],
        l = lengthForFreq[midiFreq[midis[[i]] + 7], wSecondary, tt]},
    <|"box" -> i, "colorMidi" -> m, "targetHz" -> N[f, 6],
      "secondaryLengthMM" -> N[1000*l, 6]|>
  ],
  {i, Length[midis]}];

(* --- Interactive estimate explorer --- *)
Manipulate[
  Module[
   {tt = thicknessMM/1000., wP = primaryWidthMM/1000., wS = secondaryWidthMM/1000.,
    pRows, sRows, lenRange},
   pRows = primaryTable[wP, tt];
   sRows = secondaryTable[wS, tt];
   lenRange = {Min[#], Max[#]} &@(#["primaryLengthMM"] & /@ pRows);
   Column[{
     Style["Tuned Slit Drum Bank - tongue length explorer (EMPIRICAL ESTIMATES)",
       Bold, 14],
     Style["Cantilever first-pass only; tune by measured prototype boxes.", Italic, 11],
     Grid[{
        {"sheet thickness (mm)", NumberForm[thicknessMM, {4, 2}]},
        {"primary tongue width (mm)", NumberForm[primaryWidthMM, {4, 1}]},
        {"secondary tongue width (mm)", NumberForm[secondaryWidthMM, {4, 1}]},
        {"pitch tolerance (cents)", Row[{"+/-", targetPitchToleranceEstimate}]},
        {"sustain target (s)", minimumSustainEstimate},
        {"primary length span (mm)", NumberForm[lenRange, {5, 1}]}
       }, Alignment -> Left, Frame -> All, Background -> {None, {LightYellow, None}}],
     Style["Primary chromatic C3-B3 tongues (ESTIMATE):", Bold, 12],
     Grid[Prepend[
        (Values /@ pRows) /. x_Real :> NumberForm[x, {7, 2}],
        {"box", "note", "targetHz", "primaryLenMM", "leaveBlankMM", "predictedHz"}],
       Frame -> All, Alignment -> Right,
       Background -> {None, {LightBlue, None}}],
     Style["Secondary fifth-above color tongues (ESTIMATE):", Bold, 12],
     Grid[Prepend[
        (Values /@ sRows) /. x_Real :> NumberForm[x, {7, 2}],
        {"box", "colorMidi", "targetHz", "secondaryLenMM"}],
       Frame -> All, Alignment -> Right,
       Background -> {None, {LightGreen, None}}],
     Style["Predicted-check Hz should track targetHz within tolerance (ESTIMATE).",
       Italic, 10]
    }, Spacings -> 1.2]
  ],
  {{thicknessMM, 3.0, "sheet thickness (mm) - ESTIMATE"}, 1.0, 6.0, 0.5,
    Appearance -> "Labeled"},
  {{primaryWidthMM, 40.0, "primary tongue width (mm) - ESTIMATE"}, 15.0, 80.0, 5.0,
    Appearance -> "Labeled"},
  {{secondaryWidthMM, 30.0, "secondary tongue width (mm) - ESTIMATE"}, 10.0, 70.0, 5.0,
    Appearance -> "Labeled"},
  ControlPlacement -> Left,
  SaveDefinitions -> True
]
