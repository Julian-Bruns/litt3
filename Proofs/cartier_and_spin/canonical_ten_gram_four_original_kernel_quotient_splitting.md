# Proof: use the native unit after killing the actual relation image

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_ten_gram_four_original_kernel_quotient_splitting.md); [independent five-point static review: PASS](../../Research/audits/OCT03_GRAM_FOUR_ACTUAL_KERNEL_QUOTIENT_SPLITTING_STATIC_REVIEW.md). No computation or additional source construction is used.

## The two original maps have the same evaluated columns

Use the [proved original scalar calibration](actual_positive_source_relative_scalar_calibration.md). The original Frobenius presentation is the integral horizontal surjection
\[
\mathcal A:W_8\otimes L^{10}\twoheadrightarrow q^*E.
\]
Its composite with q*λY is the ORIGINAL adjoint row multiplied by L10. The accepted native lifted row j:W8 OΓ→M6 F6 has exactly those same columns before multiplication by L10; its evaluation after pulling by φ is the restriction of the counit φ*φ*OT→OT. It is not ordinary trace and is not an evaluation on F6/F4.

Tensor j by M10 and pull by φ. Its exact kernel becomes
\[
\phi^*(\mathcal R M^{10})
=\phi^*\omega_\Gamma^{-1}=q^*O_Y(-P),
\]
and its target is L16⊗φ*F6=q*ωY⊗φ*F6. Thus there is an exact sequence of genuinely equivariant bundles
\[
0\longrightarrow q^*O_Y(-P)
\longrightarrow W_8\otimes L^{10}
\xrightarrow{\widetilde j}q^*\omega_Y\otimes\phi^*F_6
\longrightarrow0.
\tag{1}
\]
The native comparisons and the paired original actions give the identities in (1); no M8=ωΓ identity or independently chosen Frobenius root is inserted.

## Kill the original relation image before using the unit

The previously proved [original nonhorizontal relation descent](canonical_ten_perfect_four_nonhorizontal_oper_line.md) identifies 𝒜 on the kernel in (1) with q*α. By definition its image lies in q*B. Saturation in E agrees with saturation in H because E/H=ωY is locally free. In particular H/B and E/B are bundles, and the original evaluation induces a surjection λbar:E/B→ωY.

The map 𝒜 followed by q*E→q*(E/B) annihilates the whole kernel of (1). Since j̃ is an integral bundle surjection, it factors regularly and uniquely through its cokernel:
\[
\Phi:q^*\omega_Y\otimes\phi^*F_6
\longrightarrow q^*(E/B).
\tag{2}
\]
The SAME original evaluated-column identity gives
\[
(q^*\bar\lambda)\Phi\widetilde j
=(\mathrm{id}_{q^*\omega_Y}\otimes\mathrm{ev})\widetilde j.
\]
Surjectivity of j̃ yields equality before composition with j̃.

The native integral unit F0=OΓ⊂F6 has counit evaluation ONE. Its twisted inclusion is
\[
\iota:q^*\omega_Y
=q^*\omega_Y\otimes\phi^*F_0
\hookrightarrow q^*\omega_Y\otimes\phi^*F_6.
\]
Consequently sT=Φι satisfies (q*λbar)sT=id. It is a regular splitting of the pulled quotient evaluation.

## Descend the splitting with its genuine action

All maps in (1) and the original 𝒜 retain their paired genuine action. The image, saturation B and quotient retain the original G-action. The counit and native unit are equivariant, and Φ is equivariant by uniqueness of its factorization through the equivariant surjection j̃. The twisted unit line is exactly q*ωY through the retained genuine M16=ωΓ² and φ*ωΓ²=ωT comparisons. Therefore sT is G-equivariant.

Faithfully flat descent through the actual free finite étale G-torsor q supplies a regular right inverse sY:ωY→E/B. This descent remains valid when 5 divides |G| and uses no averaging. The complementary kernel is H/B. Hence
\[
E/B=(H/B)\oplus\omega_Y.
\tag{3}
\]
No original endpoint map is descended by this bundle construction.

## The positive finite source supplies the sharper degree bound

The [accepted source descent](canonical_ten_eight_source_cartier_constraints.md) gives the integral surjection A8→K and strong stability of A8 of slope 1/4. Its first relative Frobenius pull is strongly stable of slope 5/4 and surjects E. Compose with E→E/B and the projection in (3). This is an integral line quotient F_Y*A8→H/B. Semistability gives
\[
\deg(H/B)\ge5/4.
\]
Since it is an integer, it is at least two. With degH=3 this proves degB≤1. The nonzero α:O(−P)→B has effective zero divisor Z and degB=−1+degZ. Thus degB≥−1 and degZ≤2. This reasoning applies to the ORIGINAL E even if K is not saturated in B1,Y.

The accepted linear saturated chart has Z=2P+S. The bound forces degS=0. The separately conditional quadratic formula Z=S likewise cannot have degS=3. Their particular zero-divisor formulas are used only on their own established charts; a saturation-loss branch is not assigned those formulas. The constant chart Z=2P reaches the bound and remains possible.

The final source-general observation uses only the exact same quotient construction and slope 5/4 after Frobenius, supplied by the [actual full-source strong semistability theorem](actual_finite_source_strong_semistability_and_cartier_surjectivity.md). It does not assert a relation-line quotient for an arbitrary larger source. The remaining original horizontal compatibility problem is unchanged except for the proved splitting and sharper bound.
