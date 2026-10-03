# Proof: an invariant five-torsion line cannot come from the wild target

Version1,3 October2026. Root focused review **PASS**; see [audit](../../Research/audits/CANONICAL_TEN_NONISOTROPIC_PLUCKER_AUDIT_2026_10_03.md).

The higher-trace module gives an integral everywhere surjective evaluation V⊗L²→q*K. Taking its rank-TWO determinant gives a surjection ∧²V⊗L⁴→q*detK. Thus its Plücker coordinate sections have no common zero and generate the stated line A. Its degree is EIGHT d−FOUR d=FOUR d. The row is stable under G and its normalized image is therefore an actual equivariant projective target.

Since P is Weierstrass on a genus-TWO curve, K_Y∼TWO P. The given second-fundamental identity consequently yields FIVE(P_pair−P)∼ZERO. The line S=O_Y(P−P_pair) is nontrivial: two distinct points on a positive-genus curve cannot be linearly equivalent as degree-ONE divisors. In characteristicFIVE its pullback under ANY separable cover remains nontrivial. Indeed, a trivialization of a pulled FIVE-torsion line would supply a FIFTH root of a rational function representing its torsion relation; a separable function-field extension cannot add such a purely inseparable root. In particular q*S≠O_T.

The actual canonical different gives φ*ωΓ=O_T(qP), while étaleness gives q*ωY=ω_T=L16. Therefore, with B0=M12ωΓ⁻¹,
\[
A(\phi^*B_0)^{-1}
=q^*\det K\otimes L^{-16}\otimes O_T(qP)
=q^*O_Y(P-P_{\rm pair})=q^*S.
\]
This is an equality of underlying lines; no chosen linearization of its fifth roots is silently assumed.

Suppose the Plücker image field lies in k(Γ). Its basepoint-free morphism then factors through Γ, so A=φ*E for the pulled projective row line E on Γ. Put F=E B0⁻¹. The discrepancy gives φ*F=q*S, and hence φ*F5=O_T. Separable pullback is injective on FIVE-primary Picard torsion by the preceding purely inseparable-root argument; equivalently apply the norm first to see that F is torsion and then exclude its FIVE-primary kernel. More directly the primitive degree-TEN Picard-injectivity lemma in the [higher-row geometry proof](canonical_ten_higher_trace_row_geometry.md) gives F5=OΓ. Thus F is FIVE-torsion.

It is G-invariant in line-bundle class. For every g, pullback of g*F F⁻¹ is trivial because q*S has its genuine G-action. The SAME primitive Picard-injectivity lemma then gives g*F=F. The scalar obstruction of an invariant line is a class in H²(G,k×). Taking the FIFTH power shows FIVE times this obstruction is ZERO. Multiplication by FIVE is an automorphism of the coefficient G-module k× in characteristicFIVE, so it is also an automorphism of its group cohomology. The obstruction must therefore be ZERO. F admits a genuine G-linearization.

The accepted [two-point wild Picard presentation](../../Theorems/quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md) has degree-ZERO group cyclic of order gcd(FIVE,TWO)=ONE for this ACTUAL quotient. A genuinely G-linearized degree-ZERO line on Γ is therefore trivial. Thus F=OΓ, contradicting q*S≠O_T. The Plücker field is outside k(Γ); full S10 primitivity of the degree-TEN carrier now gives k(Γ)k(D_Pl)=k(T).

The argument retains the actual source and both original maps. It neither identifies the Plücker target as an étale Y-atlas nor turns its constant row dimension into a generic bundle rank.
