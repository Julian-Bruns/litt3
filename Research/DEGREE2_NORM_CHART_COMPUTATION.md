# Degree-two norm-chart computation

2026-09-11. The complete dictionary is the audited theorem
`cyclic_trigonal_kummer_carriers`. These computations do not yet exclude
the degree-two case. The fixed genus-nine curve and both original
common-source maps remain unchanged.

## Complete pole-degree partition

Use the exact fixed polynomial F over F25 and

    P^3+FQ^3=R^2, deg(P)<=6, deg(Q)<=2, deg(R)<=9, Q!=0.

Normalize the leading coefficient of Q to1. This is legitimate over
the algebraic closure by the simultaneous scaling P,Q by c^2 and R
by c^3. There are three Q-degree charts. Comparison of highest degrees
partitions them further:

| deg(Q) | Possible deg(P) |
|---|---|
| 0 | 6; 4; or at most3 |
| 1 | 6 only |
| 2 | 6; or at most5 |

For example, degree5 for P gives the uniquely dominant odd degree15
when deg(Q)<=1, impossible for a square. When deg(Q)=1 and deg(P)<=4,
the dominant degree13 is likewise impossible. For deg(Q)=2 and
deg(P)<=5, R is monic of degree8 after identifying its harmless sign.
No claim about the etaleness of an arbitrary norm solution is implicit:
the odd part of gcd(P,Q) must divide F, as in the audited dictionary.

## Exact sparse square-part substitution

For an open even-degree P chart, write deg(P)=2l, l=2 or3. Choose the
polynomial part L of a square root of P, with sign matching R at
infinity. It exists uniquely with that sign: its coefficients are
obtained successively by division by twice its nonzero leading
coefficient. Then

    P=L^2+M, deg(M)<l; R=L^3+4LM+N.

In characteristic5 the norm identity becomes

    2L^2M^2+M^3+FQ^3-2L^3N-3LMN-N^2=0.              (1)

The highest terms of R and L^3 match. Thus R+L^3+4LM has degree3l.
Taking the difference of their squares shows

    deg(N)<=max(l-2,10+3deg(Q)-3l).

This proves completeness of the substitution, including cancellation
in the numerator. It is not an arbitrary approximation to a square
root. The new system keeps `leading(L)*lead_inv-1`, so the division
has a recorded open-chart meaning. Conversely every solution of (1)
with that inverse gives the original norm solution by substitution.
The script checks the polynomial identity before every export.

## Measured representations and results

Update04:15: the independently audited
[constant-Q criterion](../Theorems/Thm_trigonal_constant_norm_obstruction.md)
now excludes ALL Q0 charts, with no degree bounds on rational P,R.
Their solver results below are retained as independent implementation checks;
further Q0 multiplier extraction is unnecessary. Q1 and Q2 remain open.

All times are bounded single-worker experiments. The common external
root is `/Users/julian/Documents/litt3-computation-data/`.

| Chart/coordinates | Variables | Equations | Terms | Largest degree | Result |
|---|---:|---:|---:|---:|---|
| Original Q2 |19|19|249|3|Source constructed |
| Residue Q2 |12|22|83,794|6|Rejected as default: severe fill-in |
| Q0, P<=3, triangular R |4|5|343|30|Unit identity independently replayed |
| Q0, P4, triangular R |6|7|490|33|std and slimgb both120s, inconclusive |
| Q0, P6, triangular R |8|10|851|33|std120s, inconclusive |
| Q0, P6, square-part |10|12|150|4|slimgb unit candidate42.789s; multiplier extraction180s inconclusive |
| Q0, P4, square-part |11|12|130|4|slimgb120s, inconclusive |
| Q1, P6, square-part |14|15|291|4|slimgb120s, inconclusive |
| Q1, P6, partial2 N |12|13|346|10|slimgb300s running |
| Q1, P6, partial5 N |9|10|1,371|18|slimgb300s running |
| Q2, P<=5, triangular R |8|8|19,166|48|std and slimgb both120s, inconclusive |

The new square-part representation is the tested A18 lesson: reduce
the support and degree of substitutions, not simply the variable count.
It has two more variables than the full triangular P6 representation,
but far fewer terms and much lower degree.

The Q0,P<=3 certificate has7,819 multiplier terms and438,193 expanded
products. Both packed and slow independent arithmetic replayed it.
Source SHA256:
`fd1f08d2de387696f14710c51af06ca72022b9301988e06fcabd02efc3d7b734`.
Certificate SHA256:
`a85bdd245d3cb5be4cf2959b0cc5b05f050f4b4fc8dc67c7a08c1030745f7a8c`.
Files: `degree2-q0-lowP-solve-20260911/source.json` and `unit.json`.

The new P6 square-part source is
`degree2-squarepart-q0-P6-20260911/source.json`, SHA256
`aca7f3c9b6f78683ea7eaa972c87ed6e11407cceb9cb697de7b6f632c343e232`.
Its unit is a solver candidate until the multiplier identity is saved
and independently replayed. No candidate or timeout is promoted to a
geometric exclusion.

Degree3 multipliers on the Q0/P6 square-part source, preserving degree4,
give3432 rows and13714 monomials; peeling leaves213 rows/626 columns.
High-column elimination completed in0.074s (131 pivots,573 updates),
raising the low-degree rank77->81. The four consequences have3,5,10,20
terms. Their internal row-DAG checks pass; independent replay is next.
Data: degree2-squarepart-q0-P6-degree3-20260911/consequences.

## Remaining actual task

Constant-Q is finished by the structural theorem, not by promoting an
unchecked solver receipt. Continue Q1/Q2. Ultimately the
generic Q2 chart must enumerate actual carriers or support a direct
Prym-factor sieve against the fixed genus-two Jacobian. Even a complete
norm enumeration alone is not the original common-cover exclusion.
The 1,533-label orbit list is already verified; optimizing that tiny
enumeration further is not the bottleneck.

Code: `prepare_degree2_norm_system.py`,
`prepare_degree2_squarepart_system.py`, `certify_polynomial_unit.py`,
`verify_field_macaulay_certificate.py`.
