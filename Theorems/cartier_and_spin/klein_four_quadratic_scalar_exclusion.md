# Quadratic scalar exclusion for the four Klein-four traces

Version1, 26 September2026. Use the finite coefficient fields and
canonical endpoint labels of
[the structural moments](klein_four_structural_moments.md):
K=F_(5^14), F=F_(5^56), sigma fixes K and cycles the four root types,
and L=Fix(sigma^2)=F_(5^28). Each endpoint is an arbitrary multiset
of four labels, with repetitions allowed.

The two old moment equations and both
[fourth endpoint trace equations](klein_four_fourth_endpoint_trace.md)
have no solution with x,y in K and epsilon in L minus K. This holds
before any restriction on integer pole weights or the covering degree.

More precisely, the two old equations and the first fourth trace
force both endpoint multisets to be invariant under the half-turn
(i,j) -> (i+2,j). The full four-equation exclusion of those pairs
then gives the contradiction.

The reusable endpoint lemma is as follows. Put
T_lam(R;m)=sum_(i,j in R) lam^i zeta^(mj), with lam in {2,3}.
For every four-label multiset R,
\[
[5]T_3(R;5)T_2(R;17)-[17]T_2(R;5)T_3(R;17)=0
\]
if and only if at least one of T_2(R;5),T_3(R;5) vanishes.
Here [a+5b]=a+b beta and beta^2=beta+3. The zero patterns are
exactly the half-turn-invariant multisets and the one-phase
three-plus-one multisets with adjacent types.

Combined with the prior scalar-in-K exclusion, every actual V4
comparison has epsilon outside L. The original unmarked common-cover
problems, general quartic scalars, and D4/S4 cases are not decided.

[Proof and certificates](../../Proofs/cartier_and_spin/klein_four_quadratic_scalar_exclusion.md).
