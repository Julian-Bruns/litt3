# Unordered-pair secants recognize quartic comparison fields

Version1, 25 September2026. Let k be the algebraic closure of F5,
K=k(t), and L/K a separable extension of degree4. Require
L=K(u)=K(v), with separating u,v and epsilon in k*, and
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2,
\]
for the fixed polynomials P,A of
[the fixed curve](../../Definitions/fixed_pair.md).

Assume t=0 splits into four unramified places of L. At each, v has
pole order3 and u reduces to a root of A. No global Galois hypothesis
on L/K is required. In its normal closure M/K label the four
embeddings by a=1,2,3 and4, and put
\[
\rho_{ab}=\frac{v_a-v_b}{u_a-u_b}\qquad(a<b).
\]
Then all six functions rho_ab are pairwise distinct. For
G=Gal(M/K), their stabilizers are exactly the setwise stabilizers
of their unordered pairs. Consequently
\[
[K(\rho_{ab}):K]=|\operatorname{Orb}_G(\{a,b\})|.
\]

In particular, each secant generates the quadratic quotient in
the V4 case. For dihedral D4 monodromy the two diagonal secants
generate the quadratic fixed field, and the four edge secants
generate degree-four fixed fields. For S4 or A4 monodromy every
secant generates a degree-six fixed field. The C4 orbit sizes
are likewise2 and4, though that comparison case is separately
excluded in the existing argument.

The local theorem has no endpoint-degree bound and needs no
ramification assumption away from t=0. It does not assert that
the normal closure yields an etale common cover, or exclude
actual D4/S4 comparisons. The original unmarked problem remains open.

[Proof and evidence](../../Proofs/cartier_and_spin/quartic_comparison_secant_fields.md).
