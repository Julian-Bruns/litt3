# Proof: triangular changes preserve the rowspace of every prefix

[Statement](../../../Theorems/atlases/finite_algebras/macaulay_predecessor_reuse.md).

Order signatures r=(t,i) as in the statement, and write S_<r for the
span of the earlier original rows. A nonzero stored predecessor p for
q=(t/z,i) satisfies

    p = c(t/z)f_i + h,    c∈K*, h∈S_<q.                       (1)

Multiplication by z sends S_<q into S_<r: multiplicativity preserves
the signature order, and the total-degree bound keeps every shifted
multiplier in T. Thus zp≡ctf_i modulo S_<r. If the predecessor reduced
to zero, the same argument gives tf_i∈S_<r.

Induction now proves equality of every prefix rowspace: each replacement
differs from a nonzero scalar times its original row by preceding rows.
Ranks, pivot columns, zero-row decisions and membership of1 depend only
on these spaces. Apply the same shifts and row operations to the
certificates; their multipliers remain in span(T). Forward-echelon tails
can differ because later pivots need not have been eliminated.

This is the reuse principle of [Faugère, §2.4, Lemma2.3](https://wstein.org/129-05/refs/faugere_f4.pdf)
in the author version of *A new efficient algorithm for computing Gröbner
bases (F4)*, J. Pure Appl. Algebra139(1999),61–88
([DOI](https://doi.org/10.1016/S0022-4049(99)00005-5)).
His `Simplify` replaces polynomial multiples by multiples of previously
reduced rows. The argument above supplies the particular prefix and
multiplier-bound guarantees needed here.

The atlas implementation orders b-monomials by total degree and then by
their sorted variable-index tuples. On each degree the first differing
exponent determines that tuple order, so multiplication preserves it.
More general multiplier sets also work when each chosen predecessor
satisfies z S_<q⊂S_<r; downward closure of T alone does not suffice.

[The implementation](../../../scripts/atlases/mixed_atlas_certificate.sage)
uses `--predecessor-reuse` over F25. The
[independent Sage checker](../../../scripts/atlases/native/verify_predecessor_prefixes.sage)
compares seven chart28 prefixes and all four zero-descendant prefixes
with their exact row spaces and pivot sets, using the retained
[input matrices](../../../../litt3-computation-data/atlas-predecessor-tests/).
The full
[chart23 comparison](../../../../litt3-computation-data/atlas-predecessor-b4/chart-23/comparison.json)
has the same first unit row38710, rank and pivot-column set, with an
independently verified original-equation identity of b-degree at most4.
The theorem does not bound the degree needed to prove an arbitrary system
empty or guarantee an efficiency gain.
