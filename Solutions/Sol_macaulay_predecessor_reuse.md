# Proof: a triangular change of the input rows

[Statement](../Theorems/Thm_macaulay_predecessor_reuse.md).

Let r=(t,i) denote the current signature. Write S_<r for the span of all
earlier ORIGINAL rows. Inductively, the stored pivots span this space.
For an earlier signature q=(t/z,i), its elimination outcome is either zero,
in which case its original row belongs to S_<q, or a pivot p satisfying

    p=c*(t/z)*f_i + h,       c in K^*, h in S_<q.          (1)

This assertion holds also when that earlier row was itself produced by
predecessor reuse: its input differs from a nonzero scalar times the
original row by earlier rows, and elimination only subtracts earlier
pivots and multiplies by a nonzero normalizing scalar.

Multiplication by z maps S_<q into S_<r. Indeed each earlier term u*f_j
has either u<t/z or u=t/z and j<i. Multiplicativity of the order gives
zu<t or zu=t and j<i. Also zu belongs to T: for the application T consists
of all monomials through a degree bound, so deg(zu)<=deg(t).

Multiplying(1) shows z*p=c*t*f_i modulo S_<r. Replacing the current input by z*p is
therefore a triangular invertible row change. If the predecessor was zero,
the current original row is already in S_<r and may be skipped.

Induction proves equality of every prefix rowspace. Its dimension and
its canonical pivot-column set depend only on the rowspace, not a chosen
echelon basis. Whether the next row increases dimension is likewise
unchanged. Thus the zero/nonzero outcomes coincide. Since the constant
column is last in the atlas implementation, detecting its pivot detects
1; more generally membership of1 is unchanged for any fixed column order.

For certificates, a degree-zero source row is the original f_i. A reused
source is z times an earlier pivot certificate. Subtracting existing
pivots and normalizing performs exactly the same operations on these
polynomial coefficients. The degree bound keeps every multiplier
inside span(T). This is a polynomial-labelled acyclic provenance graph,
not a graph whose edges are assumed to be only constant coefficients.

## Actual atlas order and possible extensions

More general sets T also work if, for every chosen predecessor t/z and
every u<t/z in T, zu belongs to T. Downward closure alone is insufficient;
the statement deliberately uses the total-degree bound instead.

The implemented A=0 atlas order is increasing total b-degree, then the
lexicographic order of the sorted variable-index tuple. On each fixed
degree this is the reverse of the usual exponent-vector lexicographic
comparison (earlier smaller-index variables come first). Multiplication
by the same variable preserves this order: the first unequal exponent
count remains the first unequal one. Thus the order is multiplicative.
The total-degree bound B satisfies the required closure condition.

The proof establishes equivalence, not efficiency. A translated predecessor
can have more terms than the raw input, and its unreduced tail can differ
from the baseline pivot by later-column pivots. Measure fill-in, arithmetic
counts and independently reconstructed certificates before deployment.

## Exact implementation evidence (2026-09-07)

The F25 implementation in `scripts/mixed_atlas_certificate.sage` uses
`--predecessor-reuse` and a distinct checkpoint/provenance format. Seven
prefixes of first chart28 (1,5,93,100,150,250,299 rows) have the same
independently computed Sage rowspaces and pivot columns as the original
rows. Its polynomial provenance verifies the original-equation unit
certificate; a separate zero-predecessor test verifies skipping descendants.

For first chart23, the full comparison found the same first unit row38710,
rank38710 and entire pivot-column set. Its independently verified identity
has all88 original-equation multipliers of b-degree at most4. Total time,
including reconstruction and verification, was38.27sec versus159.74sec
for the original run. Coefficient updates fell from219.70billion to49.76
billion; peak native memory was443MiB. The speedup is measured for this
one chart, not an all18 forecast. Evidence is external in
`litt3-computation-data/atlas-predecessor-tests/` and
`litt3-computation-data/atlas-predecessor-b4/chart-23/` beside the workspace.

The theorem is field-independent; the implemented arithmetic currently
supports only F25. It supplies neither a small sufficient multiplier bound
for every chart nor an efficient representation of the largest coefficient
fields. These remain necessary algorithmic work.
