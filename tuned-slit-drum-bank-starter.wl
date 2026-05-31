# SPDX-License-Identifier: CERN-OHL-W-2.0

(* Tuned Slit Drum Bank starter acoustics.
   Authority: cantilever first pass only; tune by measured prototype boxes. *)

ClearAll["Global`*"];

csvPath = FileNameJoin[{DirectoryName[$InputFileName], "parameters.csv"}];
rows = Rest[Import[csvPath, "CSV"]];
params = AssociationThread[rows[[All, 1]] -> rows[[All, 2]]];
num[key_] := ToExpression[params[key]];

Esteel = num["steel_youngs_modulus"];
rho = num["steel_density"];
t = num["sheet_thickness"]/1000;
wPrimary = num["primary_tongue_width"]/1000;
wSecondary = num["secondary_tongue_width"]/1000;
tol = num["target_pitch_tolerance"];

midiFreq[m_] := 440.0*2^((m - 69)/12);
noteNames = {"C3", "C#3", "D3", "D#3", "E3", "F3", "F#3", "G3", "G#3", "A3", "A#3", "B3"};
midis = Range[48, 59];

beamFreq[L_, w_] := Module[{I = w*t^3/12, A = w*t},
  (1.875104^2/(2*Pi*L^2))*Sqrt[Esteel*I/(rho*A)]
];

lengthForFreq[f_, w_] := Module[{I = w*t^3/12, A = w*t},
  Sqrt[(1.875104^2/(2*Pi*f))*Sqrt[Esteel*I/(rho*A)]]
];

primaryRows = Table[
  With[{f = midiFreq[midis[[i]]], l = lengthForFreq[midiFreq[midis[[i]]], wPrimary]},
    <|"box" -> i, "note" -> noteNames[[i]], "targetHz" -> N[f, 6],
      "primaryLengthMM" -> N[1000*l, 6],
      "leaveBlankLengthMM" -> N[1000*l + num["tip_trim_reserve"], 6],
      "predictedCheckHz" -> N[beamFreq[l, wPrimary], 6]|>
  ],
  {i, Length[midis]}];

secondaryRows = Table[
  With[{m = midis[[i]] + 7, f = midiFreq[midis[[i]] + 7],
        l = lengthForFreq[midiFreq[midis[[i]] + 7], wSecondary]},
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
Print["Pitch tolerance target: +/-", tol, " cents; sustain target: ", num["minimum_sustain"], " s"];
