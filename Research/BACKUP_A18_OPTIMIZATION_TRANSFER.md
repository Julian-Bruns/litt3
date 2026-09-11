# A18 optimizations tested on the backup

Updated 2026-09-11 02:36 CEST. These are actual implementation experiments,
not new geometric exclusions. A18 itself remains parked. The main pair
is unchanged; the backup still has degree 84 and degree 2 open.

## What was learned from the original A18 work

The sources examined were `ATLAS_OPERATION_LOGGING.md`, `ATLAS_PLAYGROUND.md`,
`ATLAS_NORMALIZATION_CANCELLATION.md`, the checkpoint metadata, and the
corresponding native RREF, coefficient-table, and Lanczos implementations.

| A18 approach | Backup experiment | Judgment |
|---|---|---|
| Sparse coefficient maps instead of generic repeated substitution | Three identical cofactor pivots: clean replay generic 3.583 s; cached sparse 1.774 s. Complete equation hashes agree; 19 variables, 86 equations, 51,135 terms. | About twice as fast for construction, not a cure for expression growth. |
| Keep coefficient-field structure; avoid scalar expansion | The same degree-84 finite span left inconclusive by the 30-minute run was decided over its original field in 2.023 s; independent replay passed. | Largest established improvement. It proved the span cannot contain a unit, not geometric existence. |
| Reuse predecessor relations | From the old full-quadratic span, 76 independently replayed low-degree consequences; linear multiples then produced 31 more in 2.35 s and 75 more in 22.55 s. | Useful new equations without constructing the next full-degree matrix. |
| Sparse basis/row ordering | Replacing 75 raw consequences by their echelon versions reduced their term total from 17,572 to 13,217; two representative certificates independently replayed. | Promising, but all 75 and the next-round speed still require comparison. Echelon form is not always sparser. |
| Tracked affine elimination | Repeating elimination exposed two additional pivots missed by the one-pass exporter: 34 to 32 variables, 355,833 to 254,864 full-quadratic monomials. | Useful. The first extraction was not faster, but found 117 new consequences rather than 76, including two genuinely new linear relations. |
| Native constant RREF | On 252 low-degree rows, the existing native backend took 0.305 s including its matrix-identity check; row terms fell from 24,195 to 19,546. | Fast enough to use as preprocessing. A smaller basis is not automatically a faster nonlinear solve. |
| Support components and pruning | The initial backup support pruning removed only 600 columns and slowed the native run from about 41 to 18.3 steps/s. | Do not reuse A18's component scheduling blindly. Original-field singleton elimination is more effective here. |
| Tensor/grading-specific kernels | A18's 32-direction tensor and old chart grading have no corresponding structure in this backup system. | Do not transfer those assumptions. |
| More worker threads | Requested ten-thread trial averaged only 6.63 actual cores; original A18 small kernels also sometimes ran faster with four threads. | Improve the representation before adding cores. No second long ten-core run is authorized. |
| Eliminate as many variables as possible | Full cofactor substitution reaches 11 variables but creates severe fill-in; both generic and cached variants failed bounded construction tests. | Reject as the default representation for now. Retain its valid mathematical formula. |
| Choose affine pivots by actual support cost | Tested all ten pairs for the new linear constraints: nine invertible, one singular. Even the best leaves 1,523,219 terms after peeling, versus 597,704 when those constraints remain as equations. | Retain the two relations without substitution for the next solve. |
| Fill-in-aware sparse pivot scoring | Same 32-variable matrix: a 24-column Markowitz look-ahead used 21,703,837 updates versus 17,884,343 for the simpler rule; same final low rank171. | Reject this tested variant: about21% more arithmetic. |
| Symmetry/orbit work sharing | Degree-2 necessary Prym test reduced to 1,533 carrier labels; all 262,143 nonzero double-cover labels were independently partitioned in 0.356 s. | Exact finite worklist is ready. Actual carrier equations and Prym-factor tests are still missing. |
| Check normalization/boundaries before expensive searches | The degree-84 necessary system retains `loc*s-1`, but not all squarefree/disjointness conditions. | Diagnose any surviving weak solutions before interpreting a failed unit search. No such point has yet been certified here. |

Timings compare the stated tasks only. The 30-minute run and the two-second
field solve sought a verdict on the same span, but the former did not
finish; this is not a measured 900-fold speedup for a completed solve.
Different relation-reuse rounds are different matrices, not identical-input
benchmarks.

## Exact finite-span results

All use the audited necessary dictionary in
`triangle237_cofactor_necessary_system` and retain the full passport,
both derivative identities, the horizontal equation, and the scale guard.

| Span | Field rows | Field monomials | Solve | Independent replay |
|---|---:|---:|---:|---:|
| Original C3/linear | 12,880 | 110,433 | 2.023 s | 61,410,920 expanded terms, 5.395 s |
| Reduced C4-only | 25,942 | 205,519 | 3.370 s | 98,966,588 terms, 9.410 s |
| Full quadratic, 34 variables | 68,670 | 355,833 | 35.599 s | 261,970,380 terms, 24.336 s |

Each result is an exact dual excluding a unit certificate in that finite
span. None excludes the geometric cover. Do not resume their old Krylov
checkpoints: a unit is impossible in those recorded spans.

## Relation extraction and the new linear pivots

`extract_macaulay_low_degree.py` eliminates high monomials, retains low-degree
consequences, and records row-combination certificates. The independent
standard-library verifier replays those combinations against the original
field equations. The unit branch was separately exercised on a small known
inconsistent system and its identity independently replayed.

The first predecessor experiment used all 76 raw quadratic consequences.
Its later 60-second round hit the time limit with 4,632 high rows still
unprocessed. That is a partial run, not proof of stabilization. Dense
quadratic generators were the new cost.

The recursive-linear source instead has 32 variables, 106 equations,
3,631 terms. Its protected full-quadratic extraction completed with
25,543 high pivots and 17,884,343 field updates; writing all 117 echelon
certificates took 47.468 s in total. Two are affine-linear:
`consequence96.json` and `consequence114.json`. Both have now independently
replayed, checking 3,053 and 12,897 source-polynomial terms respectively.
These are deductions from the full polynomial system, not genericity
assumptions or fitted finite-field relations.

The linear-only feedback experiment is complete. Substitution to30 variables
caused more fill-in: the default c0/c1 chart stopped at the two-million-term
safety cap with17,729high rows still unprocessed. It was NOT stabilized and
did not produce a unit.

All ten candidate pairs were inspected. Nine have invertible coefficient
matrices; c3/c5 is singular. Among the nine, c1/c3 is best by initial peeled
term count (1,523,219), but it is still more than twice the unspecialized
32-variable representation. Eliminating c5 is particularly expensive.

Keeping the two certified linear consequences as equations instead completed
the next full-quadratic extraction in52.041s, including102 new witness-equipped
consequences. It found no further linear equation and no unit. Those102 are
search-side exact row identities; independent batch replay is pending and
none has yet been used as a new input. The completed finite span is not a
claim that the full ideal has stabilized.

The two known linear equations alone do not force a pole/branch collision:
none of C(0),C(1),C(2),C(3),C(alpha) vanishes identically after their reduction.
The generic C still has gcd(C,C')=1 over its remaining three-parameter
fraction field. This rules out that proposed shortcut only; it is not a
point of the complete necessary system.

An alternative sparse pivot rule was also tested on the identical32-variable
matrix: look ahead at24low-incidence columns and minimize a Markowitz fill-in
estimate. It recovered the same low rank171 but used21.704million updates,
against17.884million for the default. Its43.427s includes only three saved
certificates, so it must not be called faster than the47.468s run which saved
all117. A representative new certificate independently replayed; the tiny
unit regression passes for both pivot rules.

## Selected next computation

Keep the32-variable sparse representation over F_(5^15), the two certified
linear equations as constraints, and the simple sparse pivot rule. Reuse
only independently replayed low-degree consequences and choose sparse
quadratic generators before growing the multiplier set. The next bottleneck
is sparse higher-degree cancellation, not the old expanded-field Krylov
kernel. Do not schedule another30-minute ten-core run of an exhausted span.

For degree2, case-label enumeration is already negligible. Its next task is
an actual genus8 carrier construction or a direct Frobenius/Prym-factor
algorithm on that carrier data, not further optimization of the1533-label
enumeration.

## Data and reproducibility

External data root: `/Users/julian/Documents/litt3-computation-data/`.

- `degree84-native-20260910-krDJ5g/c3`: completed original run/checkpoints.
- `degree84-field-mask-20260911-IjsCZZ`: independently replayed C3/C4 duals.
- `degree84-mixed-20260911-q64tkA/quadratic_v2`: full-quadratic dual and
  the original 76 consequences in `low2_all`.
- `degree84-predecessor-reuse-20260911`: the 31/75/partial relation rounds.
- `degree84-recursive-linear-20260911`: new 32-variable source and 117
  certificates. Source SHA256
  `2930c1cf3e4645b4b3edd3ffc04b90428e7078796241ac7c017def1baf5df609`.
- `degree84-linear-reuse-20260911-v2`: completed substituted linear-only test;
  the directory without-v2 is an aborted receipt-glob attempt.
- `degree84-linear-factored-20260911/round0`: completed retained-linear test,
  sourceSHA `ead48d0df03feec29a99177be83b700cac4a5dedab395ac8247fbca3d0042842`.
- `degree84-pivot-scan-20260911`: all nine invertible affine pivot charts;
  c3/c5 is the sole singular pair.
- `degree84-recursive-linear-20260911/markowitz24`: alternative pivot test.
- `degree2-carrier-labels-20260911.json`: verified 1,533-label worklist,
  SHA256 `37ea5af38067dc2c66bc128b0f078a1b5fd1cb6abe7927ee9e621f2ee1419830`.

Relevant code: `export_polynomial_macaulay.py`,
`diagnose_macaulay_field_support.py`, `solve_macaulay_field_dual.py`,
`extract_macaulay_low_degree.py`, `iterate_macaulay_relations.py`,
`verify_field_macaulay_certificate.py`, `sparse_polynomial_substitution.py`,
`diagnose_backup_low_row_basis.py`, and `enumerate_degree2_carrier_labels.py`
in `scripts/`.

The full generic/sparse substitution outputs and matching hash are in
`Research/computations/backup_cofactor_substitution_comparison.json`.
The new recursive-affine regression exposed and fixed an exporter edge
case when only one variable remains (univariate versus tuple exponents).
It now passes, as do independent primal/dual and both low-unit branches.
That edge case did not affect the30/32/34-variable backup matrices.

The verifier's carry-free packed arithmetic was checked against separate
slow convolution/reduction in 5,207 cases, including maximal coefficients
and extension degrees through 80. Its degree-15 multiplication kernel was
about 1.8 times faster in that microbenchmark; one actual certificate replay
only improved from 0.458 to 0.419 s. Do not present the kernel ratio as an
end-to-end speedup.
