# One bounded native-F25 pilot with32 certified inverse-cup seeds

2026-09-07. No Groebner basis or atlas exclusion was obtained. The single
authorized run stopped at its180second wall bound, still processing
degree7. No retry or watcher was launched.

The new input contains ALL97 original canonical equations and the32
smallest-support entries of B Gamma-I. It has64 variables,129 equations,
degree at most7 overF25 and4,064,687 bytes. The extra seeds contain130,471
nonzero terms. Source hashes were checked against the complete coefficient
certificate. All original equations were reconstructed and matched the
earlier native export byte-for-byte. For every seed, the saved2048
original-generator multipliers were decoded and multiplied into the
original2048 by16896 coefficient matrix. ALL32 by16896 resulting
coefficients matched the independently reconstructed inverse-cup targets.
This verification did not use sampled solutions.

The32 smallest-support entries are all OFF-DIAGONAL. Their certificates
therefore use only U_i N_r, without a normalization term. These particular
seeds express part of the matrix scalar condition, but do not by themselves
force its scalar to equal1. No completeness claim is made for this subset.

| Quantity | Previous native pilot | Seeded native pilot |
| --- | ---: | ---: |
| Original plus seed equations |97+0|97+32|
| Wall time to forced stop |180.016sec|180.031sec|
| Sampled peak RSS |1,415,331,840bytes|1,394,032,640bytes|
| Last visible degree |7|7|
| Saved basis bytes |0|0|

Both runs used Singular slimgb with the same nativeF25 field and variable
order. The seeded run monitored the SUM of RSS for every member of the
solver process group at0.5second intervals, with a4GiB kill threshold.
Only one process-group member was observed. The threshold was not reached.
This is sampled monitoring, so it is not a kernel-enforced hard memory
cap. The solver process was confirmed absent after termination.

The latest completed progress counters were19095 in the old log and18283
in the new log. These internal counters are not a mathematical measure
of distance to completion. The bounded test shows no clear improvement
in stage reached; its small RSS difference is not a reliable performance
advantage from a single comparison. It does not rule out better seed
choices or benefits from a different algorithm.

Both forced stops returned exit code0, but neither printed
`BASIS_COMPUTATION_RETURNED` or `OUTPUT_WRITTEN`; neither produced a basis.
Exit code0 is explicitly NOT success here. There is no computed basis to
certify. A future completed output would still need exact two-way ideal
containment and Groebner verification before any scheme conclusion.

The prototype exporter, runner and exact input were subsequently retired
recoverably to `/Users/julian/.Trash/litt3-atlas-pilots.sucrLn` together
with the other unsuccessful pilot algorithms. There is no active retry
recipe. Exact mathematical certificate scripts remain. Evidence remains in
`Research/computations/canonical_atlas_seeded_native_export.json`,
`canonical_atlas_seeded_native_pilot.json`, and
`canonical_atlas_seeded_native_pilot.log`. All previous pilot evidence
remains untouched. The original common-cover problem is still unsolved.
