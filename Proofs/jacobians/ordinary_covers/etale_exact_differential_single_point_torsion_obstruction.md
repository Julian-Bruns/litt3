# Proof: norm the canonical discrepancy, then descend the differential

Version1,3 October2026. [Root whole-scope review PASS](../../../Research/audits/RANK_THREE_SCALAR_TARGET_AND_TAME_IDENTITY_AUDIT_2026_10_03.md); see the [statement](../../../Theorems/jacobians/ordinary_covers/etale_exact_differential_single_point_torsion_obstruction.md). No computation is used.

Étaleness gives ω_Z=f*ω_Y. The prescribed exact differential divisor therefore trivializes f*(ω_Y(-TWO Q)). Taking norm and using the projection formula for a finite flat map of degree h yields
\[
(\omega_Y(-2Q))^h=O_Y.
\]
Because O is Weierstrass on the genus-TWO curve, ω_Y=O_Y(TWO O). Thus TWO h[Q−O]=ZERO. This norm identity uses the actual finite étale map and holds even when the characteristic divides h.

If Q were Weierstrass, take a nonzero regular η_Q on Y with divisor TWO Q. Its pullback and dv have identical divisors on the proper connected Z, so their quotient is a nonzero constant. Cartier kills dv and commutes with étale pullback. Its semilinear action on that nonzero constant leaves vanishing unchanged. Pullback of rational differentials is injective along the finite separating map f. Hence Cartier kills η_Q, contrary to ordinarity of Y. Therefore Q is non-Weierstrass, and the stated Abel-torsion condition excludes the differential entirely.

No Galois closure or cyclic character is used, and no second endpoint map is inferred.
