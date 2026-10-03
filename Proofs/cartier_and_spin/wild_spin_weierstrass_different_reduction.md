# Proof: a wild degree-zero discrepancy still has exponent at most six

Version1. [Statement](../../Theorems/cartier_and_spin/wild_spin_weierstrass_different_reduction.md). [Independent whole-scope review: PASS](../../Research/audits/WILD_SPIN_WEIERSTRASS_DIFFERENT_AUDIT_2026_10_03.md).

The accepted unrestricted wild classification gives the following actual inertia pairs(e,m):
\[
(5,2),(10,4),(20,2),(20,8),(20,3),(20,7),(30,3),(40,6),(60,6),(1000,7),(3000,21).
\]
The actual quotient S=[Γ/H] has coarse P¹ with these two branch values. By the [two-point wild Picard theorem](../quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md), its degree-zero Picard group has exponent g=gcd(e,m), respectively
\[
1,2,2,4,1,1,3,2,6,1,3.
\]
In particular g divides4 or6 in every case.

The genuine line λ=N^k descends to S after killing the actual projective kernel action, exactly as in the accepted [tame different-point reduction](tame_spin_weierstrass_different_reduction.md). That descent and the canonical Hurwitz inclusion use the actual free H-action on T/K and do not use tameness. Their pullbacks to Y are
\[
λ|_Y=O_Y(kP),\qquad K_S|_Y=ω_Y(-P).
\]
Set χ=λK_S^−k. It has degree zero, because degλ=k/n and degK_S=1/n follow from the actual quotient area identity. Hence χ^g is trivial. If W is any Weierstrass origin, its actual pullback is
\[
χ|_Y=O_Y(2kP)\otimes ω_Y^{-k}=O_Y(2k(P-W)).
\]
Thus 2kg[P-W]=0. Since k is1or3 and g divides4or6, this integer divides24or36. The accepted selected-endpoint W1[24] and W1[36] exclusions force P to be Weierstrass on both endpoints. No claim that a wild orbifold is a root stack is used.
