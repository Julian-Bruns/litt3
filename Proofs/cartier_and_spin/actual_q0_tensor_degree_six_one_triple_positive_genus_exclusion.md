# Proof: every positive-genus numerator type is covered

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_one_triple_positive_genus_exclusion.md). This coverage proof contains no new calculation. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

The [one-triple degree restriction](actual_q0_tensor_one_triple_infinity_degree_bound.md) gives exactly THREE ordinary shared simple poles and g(B)≤TWO in this degree-SIX alternative. It includes the complete Weierstrass deletion at genus TWO, rather than asserting ordinary poles by choice. It also separately proves B=Bx at degree SIX.

If two ordinary poles form a conjugate pair, their coordinate count is q=TWO and v=ONE. The [double-factor jet obstruction](actual_q0_tensor_conjugate_ordinary_double_factor.md) requires FIVE−TWO g≥FIVE, impossible at any g≥ONE. Thus every positive-genus alternative has THREE DISTINCT ordinary coordinates, J=z³−ρ².

For g=TWO the [whole quintic exclusion](actual_q0_tensor_degree_six_ordinary_quintic_exclusion.md) covers the entire stratum, including initially common odd factors. It remains to check ALL elliptic odd-factor possibilities.

Write the actual elliptic equation Y²=Φ(z), degree THREE, and the complete polar functions
\[
x_1=A_1/(zJ)+bY/(z^2J),\qquad x_2=A_2/J+cY/J.
\]
Here deg Ai≤FOUR,deg b,c≤THREE; c has degree exactly THREE because its odd term supplies the triple infinity pole at R2, which an even term cannot supply. Both odd polynomials are nonzero and are nonzero at each of the THREE ordinary pole coordinates. Put h=gcd(b,c),e=deg h, so e ranges from ZERO to THREE. Common factors at a pole coordinate are forbidden by the actual nonzero odd residue there; no such boundary is silently canceled.

If e=ZERO, the exact odd identity gives A1=cL,A2=bL,deg L≤ONE. Calibration makes M=zc²−b² vanish at all roots of J, so M=JN with N monic after scaling and degree FOUR. The exact even identity is
\[
M(\Phi-zL^2)=z(z^3-1)J^2.
\]
At any root a of J, actual cancellation on the other sheet gives Φ(a)=aL(a)². Comparing multiplicities therefore bounds multiplicityN(a) by that of z³−ONE, EVEN when a³=ONE. Outside J the same identity gives that bound immediately. Thus N divides z³−ONE, impossible for its degree FOUR. This argument retains every permitted pole/cube coincidence and does not assume c is linear or quadratic.

If e=ONE, absorb h into Y and replace b,c by their coprime quadratic quotients. The auxiliary equation has degree FIVE but its normalization is still the SAME elliptic B. This is precisely the singular shared-linear-root model retained in the complete four-quintic theorem and its second-jet gate. The [quintic exclusion](actual_q0_tensor_degree_six_ordinary_quintic_exclusion.md) uses NO quintic discriminant open and deletes this entire boundary.

If e=TWO, the residual b,c are linear, and the auxiliary Y=hY has a degree-SEVEN equation. Leading calibration at the THREE distinct coordinates forces z²c−ρb divisible by J, hence c=kz,b=kρ. Absorb k into Y. The odd identity gives A1=zL,A2=ρL,deg L≤THREE. The SAME finite part is ξ=Y/z². Its common exact first-jet value forces L=λJ+ρξ0, and the exact even identity gives Y²=z[L²+(z³−ONE)J]. The genuine automorphism z↦ωz,Y↦ω²Y of its ACTUAL normalization fixes BOTH xi, contradicting B=Bx. A singular auxiliary equation is not assigned genus THREE; only its actual normalization automorphism is used.

If e=THREE, the residual odd polynomials are nonzero constants. Their calibrated pole ratios would require a²c=ρb at THREE distinct a with a³=ρ², impossible. This also covers the proportional-cubic boundary.

Every elliptic odd-factor type is excluded. Together with the genus-two gate, the repeated-coordinate obstruction and the earlier high-genus/Weierstrass deletions, this proves the WHOLE positive-genus claim. Rational B is covered separately in the [whole one-triple profile](actual_q0_tensor_degree_six_one_triple_exclusion.md), and no auxiliary source replaces either original finite étale leg.
