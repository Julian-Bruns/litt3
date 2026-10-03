# Proof: double Pryms and the two faithful cyclic-four character lines

Version1,3 October2026. Author proof, whole-scope review PASS. See the [statement](../../../Theorems/jacobians/ordinary_covers/selected_cyclic_two_four_ordinarity.md). The geometric dependencies retain their established proofs and certificates; no calculations are rerun. [Root whole-scope audit](../../../Research/audits/CANONICAL_TEN_RANK_THREE_RAMIFIED_ROWS_AUDIT_2026_10_03.md).

## Every actual double Prym is an elliptic four-point cover

A nonzero TWO-torsion class on a genus-two hyperelliptic curve is uniquely represented by an unordered pair of distinct Weierstrass points. Its connected étale double Y₂→Y is the familiar fiber-product model r²=F₂(u),s²=F₄(u), including the usual degree-one model if the paired set contains infinity. The genus-three Y₂ is hyperelliptic, and its alternate sign quotient E₂ is elliptic, branched at the FOUR complementary Weierstrass values. The actual norm/pullback maps give
\[
\operatorname{Jac}(Y_2)\sim\operatorname{Jac}(Y)\times E_2.
\]
One can check the isogeny directly on regular differentials: the σ-invariant subspace is pulled from Y and has dimension TWO, while the anti-invariant subspace has dimension ONE and is pulled from E₂. The group order TWO is invertible in characteristic FIVE.

There are FIFTEEN complementary four-subsets of {0,1,2,3,t,∞}. If infinity belongs to a subset, use the monic cubic with the other THREE finite roots. Otherwise use its monic quartic. In either case its coefficients have degree at mostONE in t. In characteristic FIVE the elliptic Hasse invariant is the coefficient of u⁴ in the SQUARE of that polynomial, hence a polynomial H(t) of degree at mostTWO, over F₅.

None of these FIFTEEN polynomials is identically zero: at the accepted BACKUP parameter α, every connected étale double is ordinary by maximal exponent-FOUR ordinarity, so its elliptic Prym is ordinary. Thus H(α)≠ZERO for every complementary set. Their combined exceptional support has at mostTHIRTY parameters. If Y_t itself is ordinary and none of these polynomials vanishes, all connected étale doubles are ordinary.

## The Jacobian of a cyclic-FOUR cover

Let Y₄→Y be any connected cyclic degree-FOUR étale cover, with generator σ; its genus is FIVE. Let Y₂=Y₄/⟨σ²⟩ and E₂ be the preceding Prym. The accepted complete order-FOUR construction gives a genuine dihedral D₈ action above the hyperelliptic base. Choose a reflection j in the FOUR-value class, whose quotient E₀=Y₄/⟨j⟩ has genus ONE. Its pullback regular differential lies in the TWO faithful σ-character lines, with eigenvalues i and−i.

Here is the exact decomposition, independent of an assumed elliptic carrier map. For an étale cyclic FOUR-cover of a genus-two curve, the invariant differential space has dimension TWO, and each nontrivial character has dimension ONE: this is Riemann–Roch for its nontrivial degree-zero torsion line, together with Serre duality. The characters ONE and−ONE together form the pullback from Y₂. The reflection j descends to the hyperelliptic involution of Y₂, so acts as−ONE on that entire THREE-dimensional space. Thus the ONE-dimensional j-invariant space pulled from E₀ lies entirely in the two faithful character lines. Since j interchanges those lines, its invariant vector has nonzero components in BOTH. Its σ-translate is independent and spans their TWO-dimensional sum.

Actual quotient maps to Y, E₂, E₀ and its σ-translate consequently pull back regular differentials to FIVE independent lines/directions filling H⁰(Y₄,ω). Their product norm homomorphism on Jacobians has invertible differential and equal source/target dimension, hence is an isogeny. In particular
\[
\operatorname{Jac}(Y_4)\sim\operatorname{Jac}(Y)\times E_2\times E_0^2.
\tag{1}
\]
Ordinarity is invariant under isogeny and products. Thus, once Y and E₂ are ordinary, a NONordinary Y₄ forces E₀ supersingular. Over bar(F₅) an elliptic curve is supersingular exactly when j=ZERO, as follows equally from its elliptic Hasse invariant.

## Complete parameter support of the possible nonordinary reflection

The accepted order-FOUR reflection proof describes EVERY such E₀ by choosing one of the FIFTEEN paired Weierstrass choices and ONE square-root point from each of the FOUR remaining ± pairs. It proves its j-invariant is nonconstant on EVERY relevant normalized parameter component, including moving-paired points and {t,∞}. These claims do not use the additional elliptic carrier map: they are intrinsic to each actual cyclic-FOUR cover.

That proof also bounds the parameters with a specified reflection j-value by972 per paired choice. Its four square-root equations have total degrees at mostTHREE; the fixed-j equation has degreeTWELVE. Nonconstancy makes all points on the smooth distinct-root open isolated, and affine Bézout gives TWELVE·THREE⁴=972. Specialize the target value to ZERO. Over all FIFTEEN paired choices the exceptional support has size at most15·972. It covers every actual cyclic-FOUR cover by the already established complete branch recipe; no cover labels or root choices are omitted.

Together with the double-Prym support, all nonordinary cyclic TWO/FOUR covers above ordinary Y_t occur at at most14610 parameters. The sets are F₅-Frobenius stable: all fixed branch labels, complementary subsets, root equations and j=ZERO are stable. Therefore an algebraic parameter in their support has F₅-degree at most14610.

MAIN's already selected parameter degree exceeds this bound and its Y is ordinary, so all these connected covers are ordinary. The BACKUP assertion follows directly from its accepted maximal exponent-FOUR cover theorem. The arguments concern actual finite étale covers and their Jacobians; they do not assert ordinarity of arbitrary further étale refinements, cyclic EIGHT-covers, or a second common-cover leg.
