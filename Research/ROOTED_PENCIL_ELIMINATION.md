# Exact pencil elimination: first oper, rooted chart23

2026-09-07. The original common-cover problem remains unsolved. This result
excludes one coordinate chart of the first untwisted oper only.

The chart substitutes b0,...,b22=0 and b23=1 in the rooted tensors. Its
88 low equations are n0,...,n63 and s0,...,s22,s23-1. They are affine
linear in32 variables v, with8 remaining b variables. The computation uses
the original F25 coefficients, including the coefficient fifth-root step.
The saved88x88 constant equation basis change was checked invertible, and
its multiplication identity was checked against the original tensor rows.

`scripts/mixed_atlas_certificate.sage --chart 23 --v-degree 0 --b-degree 4`
multiplies these equations by all495 b monomials of total degree at most4.
It eliminates all v-bearing columns before pure-b columns, using exact F25
arithmetic. This is a finite linear computation on the pencil, not a
Groebner-basis calculation. The full potential matrix is43560x41679.

The run found1 after38710 independent rows, retaining440 pure-b relations.
Its exact provenance was expanded into88 polynomial multipliers w_i(b),
each of degree at most4. Sage independently verified the polynomial identity

    sum_i w_i(b) * original_low_equation_i(v,b) = 1.

Thus chart23 is empty even before using its additional Frobenius equations
or nonvanishing equation. This statement does not exclude a whole oper.
The proof is the verified identity, not a matrix count, solver exit code,
generic-rank claim, or an assumed necessity of b-only unit certificates.

External evidence directory:
`/Users/julian/Documents/litt3-computation-data/atlas-pencil-b4/chart-23/`.
`result.json` contains the full original-row multipliers and verification
flags; `pure_b_relations.json` retains the440 relations and provenance nodes.
`matrix.json` records the input hash and exact monomial-bound parameters.
The source tensor SHA256 is
`bcc027f5e4c283d35f71bc0cdd58a404ee880a5f65b6df1685a62fa670339a06`.

Measured total159.743sec, native151.498sec, peak757284864 bytes. There were
105730316 pivot-row subtraction calls and108527051 stored pivot coefficients.
The former is NOT a coefficient-operation count. All38710 processed rows
became pivots, so in this run the provenance DAG contains every subtraction;
its edges and the checkpoint supports suffice to reconstruct coefficient
touch counts without rerunning the algebra.

## Restart and verification

Completed-row checkpoints save all pivots, input position, provenance offsets
and counters, with a payload checksum and an atomic previous snapshot.
Live status is `state.cp.progress.json`. Repeating the same command/output
resumes; incompatible input or engine fingerprints are rejected. A partial
row at a limit is discarded, preserving the last completed-row state.

The chart28 test stopped at150 rows and resumed. Its final input, provenance,
expanded multipliers, selected relation and pure-b relation binary were all
byte-identical to an uninterrupted run. Both independently verified1 against
the original equations. All625 F25 products and625 subtractions were checked
against Sage, and the mixed-only counterexample certificate test passed.
An intentionally corrupted primary checkpoint was rejected by its checksum;
resuming the previous snapshot reproduced the uninterrupted provenance,
weights and pure-b relations byte for byte.

The older exhaustive mixed-degree(1,1) calculation found no unit in its
restricted multiplier space:26136 rows, rank22227. That failed ansatz does
not contradict the successful b-degree4 identity above. No dense/SIMD
arithmetic optimization was introduced in this implementation.
The new checkpoint engine reran that same cached matrix and reproduced
rank22227,172777371 subtraction calls and68399085 stored coefficients
exactly, in343.189sec. Evidence is in the external
`atlas-pencil-old-rank-regression/result.json`.

## Fused arithmetic and interval logs

After that regression, the F25 row update was changed from two dependent
table lookups to one25KiB fused table. All15625 triples (multiplier, pivot
coefficient, old coefficient) were checked against Sage and independently
against the native coordinate formula. On the identical saved chart23 B4
matrix, native time fell from151.498sec to133.212sec (1.137x). Every pivot
payload, provenance byte, expanded weight, pure-b relation and operation
count was identical; only checkpoint elapsed time/checksum differed.
Evidence: external `atlas-pencil-fused-axpy/chart-23/benchmark.json`.

The native backend now optionally appends `operations.jsonl` approximately
every2sec or256 completed rows. `--no-interval-log` disables this output.
Each invocation has a UUID and explicit native_F25/degree2/first-oper context,
source/input hashes, resumed starting row and interval starting/ending rows.
Counter deltas describe work performed in that invocation, so resuming does
not count saved work again. The checkpoint's cumulative row-reduction counter
is kept separate from these per-invocation work counts.

Logs distinguish row subtractions, coefficient updates, zero-row costs,
normalization products, column probes, input bytes, checkpoint time/bytes,
and pivot-reuse histogram/max. Coefficient updates are counted once per row
subtraction, outside the coefficient loop. Zero-row costs are attributed when
that row finishes; other work counts are recorded as operations finish.
Consequently one short interval's zero-row-cost total can include earlier
intervals' work on the same row. Sum intervals for a complete invocation or
use the recorded completion context when comparing those categories.

On the chart28 stop/resume test, interval sums exactly matched independently
reconstructed DAG/checkpoint counts:12666 subtractions,439166 coefficient
updates,11802 normalization products and49860 column probes. Certificate
and provenance bytes remained identical. A separate synthetic zero-row test
verified the costs that a pivot-only DAG cannot retain. Evidence:
external `atlas-pencil-telemetry-tests-v2/`.

## Adopted development path: predecessor reuse

The canonical `macaulay_predecessor_reuse` theorem justifies replacing each
multiplied equation by the same variable times the already reduced parent
row. This is stronger than merely recognizing literal repeated rows after
constructing them. Polynomial-labelled provenance retains exact original
certificates. Forward-echelon coefficients may change; every prefix rowspace
and its canonical pivot-column set remain the same.

The first full chart23 test passed: same first unit row38710, same rank and
pivot-column set, independently checked original-equation identity. End-to-end
38.27sec including proof reconstruction, versus159.74sec original baseline;
native29.80sec,443MiB. Coefficient updates49.76billion versus219.70billion.
Evidence: external `atlas-predecessor-b4/chart-23/` and small exact rowspace
tests in `atlas-predecessor-tests/`.

The unchanged chart22 B4 baseline has now COMPLETED: all62205 rows are
independent and there are NO pure-b relations.821.765 native sec,2.29GiB;
1.3497trillion coefficient updates. Raising the bound with the improved
method is a new test, not resuming an unfinished baseline or assuming that
rank62205 establishes a solution.

The improved B5 run then EXCLUDED chart22:129161 independent rows,1485
pure-b relations, and an identity1 against all87 original equations, with
multiplier b-degree<=5. Total526.26sec including verification,native474.95sec,
peak3.38GiB. Evidence: external `atlas-predecessor-b5/chart-22/result.json`.
Both22/23 certificates are adopted by the live all18 queue as of15:00.

Do not extrapolate the first F25 speedup directly to all18. In particular,
storing66.9million pivotted field coefficients as dense degree7324 F25
vectors would use about490GB just for coefficient payload at one byte per
F25 entry. This is a limitation of that representation, not a mathematical
memory lower bound: structural compression or a different algorithm may
avoid it. The high-degree field backend is not yet implemented.

The distinct format2 stores source-row-to-pivot/zero and polynomial provenance.
A stop at row30000 followed by resume reproduced the uninterrupted
predecessor run's exact checkpoint pivots/source map, provenance, weights,
and pure-b relations (excluding elapsed time and checksum). The resumed
original-equation certificate was independently verified again. Evidence:
external `atlas-predecessor-b4-resume/chart-23/resume_test.json`.

Production verification at15:06: generalized F25 input also excluded chart23
for invariant_0 and invariant_1, in7.56sec and7.38sec respectively, each with
an independently checked original-equation unit identity. See their
`atlas-all18/REP/pencil/chart-23-b4/result.json`. This validates transfer to
two different F25 representatives, not to higher coefficient fields.
