# Proper theta and degree-five obstruction removal for active genus-two pairs

Version1,2026-09-10. Pro-supplied characteristic-five reconstruction,
locally expanded and checked; focused medium audit PASS
/root/audit_genus_two_active_theta. Not Lean verified.

Work over k=bar(F5). Let C be a smooth projective genus-two curve.

1. A stable rank4 bundle B with det B=O and
   H0(B tensor A)!=0 for EVERY A in Pic1(C) becomes the direct sum of
   four copies of a degree-zero line on a finite etale cover. In
   particular B is strongly semistable.

2. For EVERY regular admissible active nilpotent projective connection
   r on C, the actual tangent bundle E_r of
   [tangent_bundle_cyclic_refinements](../connections/tangent_bundle_cyclic_refinements.md)
   has a proper generalized theta divisor D_r, numerically4Theta.
   This includes connected and split canonical doubles and does NOT
   require an ordinary Jacobian or a zero/one-dimensional tangent space.

3. Suppose additionally J(C) is ordinary, the canonical double is
   connected, and h0(E_r)=1. Then mult_0(D_r)<=4, and at least TWO
   of the six geometric connected cyclic5 etale covers h:T->C satisfy

       h0(E_(h*r))<5.

   Consequently every intrinsic higher Hodge obstruction epsilon(C,r)
   in its one-dimensional cokernel is killed on each of these covers,
   by [etale_p_witt_obstruction](../deformations/etale_p_witt_obstruction.md).
   This need not make the source ordinary. When epsilon(C,r)!=0,
   a repaired next Hodge lift cannot preserve the original C-leg.

These are bundle and one-source obstruction results. They supply no
matching connection or simultaneous lift on two specified endpoints,
and do not exclude an unmarked common cover. The genus-nine main
endpoint has NOT been replaced or covered by the genus-two hypothesis.

[Proof and source qualifications](../../Solutions/genus_two/genus_two_active_theta.md).
