# A universal linear square model with one explicit Frobenius carry

Version1, 27 September2026. Let R be ANY commutative ring of
characteristic five. Let alpha(T) have degree at most140 and alpha(0)=1,
and let B(T) have degree at most70 and B(0)=1. Put H=B alpha^62.
Then B^2=alpha is equivalent, scheme-theoretically over R, to
\[
[T^n]H=0\quad(1\le n\le140,\ n\ne125),\qquad
[T^{125}]H=3\alpha_1^{125}.
\]
These140 equations are affine-linear in B1,...,B70. The first70
are unit triangular; their unique solution is
B=alpha^63 modulo T^71. The remaining70 equations therefore define
the entire square scheme, including nonreduced bases. No coefficient
unit-ideal assumption, root-multiplicity exclusion or extra localization
is required.

This supplies a common exact model for the two open degree140 families.
It does NOT decide either ideal. The older147-row Hasse model remains
useful on its proved coefficient-unit locus and has better established
scale-degree bounds. Fewer equations alone do not prove a faster
elimination algorithm.

[Proof and implementation checks](../../Proofs/cartier_and_spin/universal_degree140_linear_square_model.md).
