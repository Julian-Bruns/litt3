# Fifth symmetric twists and first-Frobenius twists all vanish

Version3,3October2026. Let K be the actual rank-two degree-one
bundle of [the finite-coefficient problem](finite_coefficient_generation.md),
and let F denote absolute Frobenius. Under the natural subbundle map
F^*K -> Sym^5 K,
\[
H^0(X,F^*K\otimes L)
=H^0(X,\operatorname{Sym}^5K\otimes L)=0
\quad\text{for every }L\in\operatorname{Pic}^0(X).
\]
In particular F^*K has no line subbundle of nonnegative degree.

The exact untwisted input is
\[
h^0(X,\operatorname{Sym}^{15}K)=3,
\]
and every section belongs to F^*(Sym^3 K), the subbundle with binary
indices0,5,10,15 in an affine frame.

The first-Frobenius vanishing follows from the later
[shifted theorem](shifted_first_frobenius_vanishing.md),
which is proved independently by the general nonnegative-line norm
criterion. The separate unshifted invariant census is unnecessary.
The stronger geometric fact remains: no nonzero section in the
three-dimensional Sym3(F^*K) net has square discriminant in k[x],
including zero or a lower-degree square.

No irreducible rank-three finite étale coefficient possessing a nonzero
degree-five semi-invariant maps to K. Together with
[the lower-degree theorem](low_degree_twist_vanishing.md), any such
coefficient mapping to K has no semi-invariant of degree at most five.
An irreducible rank-five finite coefficient with five lines permuted by
monodromy cannot map to K either.
Primitive monodromy with higher minimal invariant degree, rank two and
unrestricted higher ranks remain open. Neither original unmarked
common-cover problem is decided.

The last exclusion uses a general geometric fact: for a rank-three
finite coefficient quotient onto a rank-two bundle E whose dual has no
sections on an étale trivializing cover, a degree-p semi-invariant
cannot restrict into F^*E unless the original representation has an
invariant line. Its proof applies in every positive characteristic.

[Proof and exact reconstruction](../../Proofs/cartier_and_spin/fifth_symmetric_twist_vanishing.md).
