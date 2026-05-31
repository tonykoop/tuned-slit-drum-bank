(* Wolfram QA 2026-05-30: estimate - pending measurement, not fabrication authority.
   Variables and associations with Estimate suffix are planning values only unless
   later replaced by measured validation data or reviewed design-table authority. *)

# SPDX-License-Identifier: CERN-OHL-W-2.0

(* Tuned Slit Drum Bank starter acoustics.
   Authority: cantilever first pass only; tune by measured prototype boxes. *)

ClearAll["Global`*"];

csvPath = FileNameJoin[{DirectoryName[$InputFileName], "parameters.csv"}];
rows = Rest[Import[csvPath, "CSV"]];
paramsEstimate = AssociationThread[rows[[All, 1]] -> rows[[All, 2]]];
numEstimate[key_] := ToExpression[paramsEstimate[key]];

eSteelEstimate = numEstimate["steel_youngs_modulus"];
rhoSteelEstimate = numEstimate["steel_density"];
t = numEstimate["sheet_thickness"]/1000;
wPrimaryEstimate = numEstimate["primary_tongue_width"]/1000;
wSecondaryEstimate = numEstimate["secondary_tongue_width"]/1000;
targetPitchToleranceEstimate = numEstimate["target_pitch_tolerance"];

midiFreq[m_] := 440.0*2^((m - 69)/12);
noteNames = {"C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3"};
midis = Range[48, 59];

beamFreq[L_, w_] := Module[{I = w*t^3/12, A = w*t},
  (1.875104^2/(2*Pi*L^2))*Sqrt[eSteelEstimate*I/(rhoSteelEstimate*A)]
];

lengthForFreq[f_, w_] := Module[{I = w*t^3/12, A = w*t},
  Sqrt[(1.875104^2/(2*Pi*f))*Sqrt[eSteelEstimate*I/(rhoSteelEstimate*A)]]
];

primaryRows = Table[
  With[{f = midiFreq[midis[[i]]], l = lengthForFreq[midiFreq[midis[[i]]], wPrimaryEstimate]},
    <|"box" -> i, "note" -> noteNames[[i]], "targetHz" -> N[f, 6],
      "primaryLengthMM" -> N[1000*l, 6],
      "leaveBlankLengthMM" -> N[1000*l + numEstimate["tip_trim_reserve"], 6],
      "predictedCheckHz" -> N[beamFreq[l, wPrimaryEstimate], 6]|>
  ],
  {i, Length[midis]}];

secondaryRows = Table[
  With[{m = midis[[i]] + 7, f = midiFreq[midis[[i]] + 7],
        l = lengthForFreq[midiFreq[midis[[i]] + 7], wSecondaryEstimate]},
    <|"box" -> i, "colorMidi" -> m, "targetHz" -> N[f, 6],
      "secondaryLengthMM" -> N[1000*l, 6]|>
  ],
  {i, Length[midis]}];

lowestThree = Take[primaryRows, 3];

Print["Tuned Slit Drum Bank - starter tongue model"];
Print["Primary C3-B3 tongue estimates:"];
Print[Dataset[primaryRows]];
Print["Secondary fifth-above color tongue estimates:"];
Print[Dataset[secondaryRows]];
Print["Lowest three predicted validation rows:"];
Print[Dataset[lowestThree]];
Print["Pitch tolerance target: +/-", targetPitchToleranceEstimate, " cents; sustain target: ", numEstimate["minimum_sustain"], " s"];
