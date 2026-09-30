# Proof: the tame case does not need the other endpoint

[Statement](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_tame_uniform_atlases.md).
This extracts the Y-only portion of the
[complete cored exclusion](backup_cored_span_exclusion.md), retaining
the individual geometric proofs and their existing audits.

Let n be the degree and $e_1,\ldots,e_r$ the uniform indices. Tame
Riemann--Hurwitz and completeness of the fibers give
\[
2=n\left(-2+\sum_{i=1}^r(1-e_i^{-1})\right),\qquad e_i\mid n.
\tag{1}
\]
The positive parenthesis is at least $1/42$. For three branch points,
order the indices and use the first positive triangle area, attained
by $(2,3,7)$. For four points the zero case is $(2,2,2,2)$ and the
first positive value is $1/6$. For five or more points the value is
at least $1/2$. Hence $n\le84$, with no hypothesis on a second
endpoint. Also $5\nmid n$: all denominators in (1) are prime to five.

The integer equation (1) with this bound is exactly the twenty-four
row tame table in Section2 of the cited proof. This is the same
enumeration as the already checked table, with its bound now obtained
from Y alone. The twenty-three rows of degree greater than two are
excluded there by arguments concerning only Y: its Weierstrass torsion,
automorphism group, ordinary cyclic covers, elliptic and real
multiplication obstructions, or the complete remaining triangle tests.
The table's only use of X is explicitly in its degree-two row.

Retain that degree-two row instead of applying its X-dependent Prym
sieve. It has six order-two fibers and is the unique degree-two pencil
on a genus-two curve. Thus a is the hyperelliptic quotient. All other
rows are excluded by the inherited, already verified Y-only results.

This consolidation does not assert that a quotient map in mixed
characteristic extends with tame uniform special fiber. That separate
reduction issue is not part of (1) or of the tame table.
