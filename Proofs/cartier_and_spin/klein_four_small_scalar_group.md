# Proof: a finite scalar group and exact Fourier reconstruction

[Statement](../../Theorems/cartier_and_spin/klein_four_small_scalar_group.md).
The [structural subfield theorem](../../Theorems/cartier_and_spin/klein_four_structural_moments.md)
forces balanced endpoints whenever epsilon is in K=F_(5^14).
The group F25* mu29 lies in K and is invariant under the permitted
coordinate changes. Normalize the first endpoint phase to1. Write
phi for the other phase, kappa=[17], and bar for5^7-Frobenius on K.
The necessary moment equations become
\[
\epsilon(1-\bar x)=\kappa\phi^5-\bar y,
\qquad \epsilon(\kappa-y)=\phi^8-x,
\]
where x=M2,y=M6. Write epsilon=e zeta^d, e in F25*, d modulo29,
and N=e e^5 in F5*. Conjugating the second equation and substituting
in the first gives
\[
(1-N)\bar y=\kappa\phi^5-\epsilon(1-\phi^{-8})-N\bar\kappa.
\]
If N!=1, this uniquely determines y and then
x=phi^8-epsilon kappa+epsilon y. No point search in K is needed.
Equivalently,
\[
x=\frac{\phi^8+\epsilon\bar\kappa\phi^{-5}-\epsilon\kappa-N}{1-N}.
\]
For N=1 retain the complete displayed compatibility equation before
division. None of its5046 phase/scalar choices satisfies it. For
N!=1 there are18*29^2=15138 uniquely determined moment pairs.

The two Frobenius exponent orbits of2 and6 partition all nonzero
exponents modulo29. Thus x,y and M0 in F5 determine all29 weight
residues uniquely. Every choice of M0 is retained. This gives75690
residue vectors, each with entries in{0,1,2,3,4}. The exact minimum
of their ordinary integer sums is28, with14 minimizers. Since the
only allowed integer lift beyond the residue representative is
1 to6, total integer mass is the residue mass plus5k, where k is
the number of upgraded entries. This proves the asserted coefficient
mass bound and retains all allowed lifts.

## Exact small computation and independent replay

The [generator](../../scripts/arithmetic/klein_four_small_scalar_group.py)
uses direct F5 polynomial arithmetic of degree14 with the embedded
beta from the independent balanced-mass verifier. It evaluates every
norm-one compatibility condition, then uses the displayed scalar
parametrization. Fourier inversion is computed from four exact
templates and their cyclic translates; no curve parameter is sampled.
It retains all15138 rows of five residue masses and every minimizer.

The [independent replay](../../scripts/arithmetic/verify_klein_four_small_scalar_group.py)
instead computes in F25[zeta]/f7. It builds and exactly inverts the
full29-by29 Fourier matrix over F5. It solves the original two
conjugate equations by direct field arithmetic, reconstructs all
75690 vectors, and compares every mass with the generator. It also
checks the common embedded field, both original moment equations,
all5046 norm-one boundaries, the minimum, and every minimizing vector.
The complete second implementation passed; it is not a sampled replay.

Data and executed output are
[the exact table](../../../litt3-computation-data/finite_loci_v4_replies_20260926/balanced_small_scalar_group.json)
and [the independent receipt](../../../litt3-computation-data/finite_loci_v4_replies_20260926/verify_balanced_small_scalar_group.log).
Run the two linked Python sources, passing `--output FILE` to the
generator and that file as the verifier's sole argument. Only the
standard library and the retained short F25 arithmetic source are used.

## The first compatible configuration

All14 minima have phi=1, five weight-two nodes and six weight-three
nodes, with no weight-one node. Thus no weight-six upgrade is possible
at this residue vector. The representative in the statement has
epsilon=[23]zeta^2. Its coefficient25-Frobenius orbit has seven members;
endpoint interchange sends epsilon to its inverse and node exponents
to their negatives, giving the other seven. The independent verifier
checks this exact orbit equality.

Restricting the table to scalar_phase0 gives2610 residue vectors.
Their minimum is29 with two reciprocal balanced profiles, exchanged
by endpoint interchange. The earlier
[reciprocal subcase generator](../../scripts/arithmetic/klein_four_reciprocal_f25.py)
and its [independent18-triple verifier](../../scripts/arithmetic/verify_klein_four_reciprocal_f25.py)
are retained as a useful smaller presentation. They agree with this
complete scalar-group calculation.
