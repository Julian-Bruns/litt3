# Proof: native source degrees and the characteristic-five third diagonal grade

Version1, 3 October2026. [Independent bounded audit](../../Research/audits/OCT03_ZERO_TOP_DEGREE_ONE_SOURCE_KERNEL_AND_TAME_EXCLUSION_AUDIT.md): mathematical PASS allEIGHT checks. Ordinary minimum-slope terminology is explicit here; no geometric nefness is claimed. Use only the setup and classification in the [statement](../../Theorems/cartier_and_spin/canonical_ten_zero_gram_degree_one_source_kernel_and_tame_exclusion.md) and its named dependencies. The argument preserves the original positive source, both actual endpoint maps, native G-action and integral surjectivity.

## Every degree-one image has source kernel of nonnegative ordinary minimum slope

Let r=rankI∈{FOUR,FIVE} anddegI=δ. The kernelA=keru has rankR=FOURm−TWO−r and degree(m−TWO)δ; it is an ordinary subbundle ofS_n, whose slope isδ/FOUR. Suppose its last Harder–Narasimhan quotientQ has negative slope. Its rank is s≥ONE and its degree is an integer multiple ofδ because the HN quotient is genuine native by uniqueness. ThusdegQ≤−δ. Its kernelU⊂A⊂S_n would satisfy
\[
\deg U\ge(m-ONE)\delta,\qquad
\deg U\le(R-s)\delta/FOUR\le(FOURm-THREE-r)\delta/FOUR<(m-ONE)\delta.
\]
This contradiction provesμ_min(A)≥ZERO in everym≥TWO. A negative entire bundle is already excluded bydegA=(m−TWO)δ≥ZERO.

The actual lift's restriction toA lies inN₃, andHom(A,N₃)=ZERO sinceμ_min(A)≥ZERO andμ_max(N₃)≤−δ/TWO. Thus it factors through the specified integralI. The quotientI has ordinary minimum slope at leastZERO and also hasHom(I,N₃)=ZERO, proving uniqueness. The extension Hom boundary gives the exact gateι_I*e_τ=ZERO. Flat Frobenius pullback of the actual surjectionC′→I proves that the inherited adjointF*I→J_τ is integrally surjective. No geometric nefness, constancy or horizontal replacement ofC′ is used.

## A native diagonal summand appears precisely in characteristic five

Put V=F*F_*ω, with its canonical diagonal filtrationV_i, i=ZERO,…,FIVE and gradesV_i/V_{i+ONE}=ω^(i+ONE). Locally writeε=x_right−x_left and use dx_right forω on the second diagonal factor; ε⁵=ZERO. Under y=f(x),
\[
\epsilon_y=f'\epsilon+(f''/TWO)\epsilon^2+\cdots,\qquad
dy_{\rm right}=(f'+f''\epsilon+\cdots)dx_{\rm right}.
\]
The ε^(i+ONE) coefficient inε_y^i dy_right is(i/TWO+ONE)(f')^i f''. For i=THREE this coefficient isFIVE/TWO=ZERO in characteristicFIVE. There are no further terms belowε⁵. For i=FOUR there are no higher terms either. Consequently the local basesε³dx_right andε⁴dx_right transform diagonally by(f')⁴ and(f')⁵. They give an integral canonical splitting, compatible with every automorphism includingG:
\[
V_3=\omega^4\oplus\omega^5.
\]
This is not a choice of an ordinary connection.

## The lower two-jet quotient admits no map from the canonical square

Let P²ω=V/V₃ andP¹ω=V/V₂. The latter is0→ω²→P¹ω→ω→0. For a mapω²→P²ω, its composition toP¹ω lands inω², sinceHom(ω²,ω)=H⁰(ω⁻¹)=ZERO. The preimage of this kernel isV₁/V₃, fitting0→ω³→V₁/V₃→ω²→0.

This last native extension is nonsplit. At a weak-wild fixed point useσ_z(x)=x/(ONE+zx), withσ_z'(ZERO)=ONE andσ_z''(ZERO)=−TWOz. The transition onε dx_right andε²dx_right has off-diagonal coefficient(ONE/TWO+ONE)σ'_zσ''_z=−THREEz≠ZERO forz≠ZERO. Both line fibers are trivial underC₅, while the extension fiber isJ₂. A native splitting would give a split fiber, impossible. AsEnd_native(ω²)=k, a mapω²→V₁/V₃ with nonzero quotient would split the extension. One with zero quotient iszero becauseHom_native(ω²,ω³)=H⁰(ω)^G=ZERO. HenceHom_native(ω²,P²ω)=ZERO.

Every native mapω²→V therefore lands inV₃=ω⁴⊕ω⁵. The two components are invariant sections ofω² andω³, respectivelyk t₂ andZERO. Directly, an invariant degreeTHREE form isr(f)(df)³. It has no finite ordinary pole; tame regularity allows a pole ofr at zero of order at mostONE, whereas wild regularity requires order at leastTWO. No Laurent polynomial meets both inequalities. For degreeTWO the same computation gives the single direction(df)²/f=t₂, with divisor the reduced wild orbitW. This proves the exact Hom formula.

## The tame degree-one image contradicts saturated kernel integrality

The saturatedB_t⊂H has native determinantω₁. If a native adjointF*B_t→J_τ were surjective, its kernelL would be a genuine native line with
\[
\det L=\det(F^*B_t)\det(J_\tau)^{-1}=\omega^{FIVE}\omega^{-THREE}=\omega^2.
\]
BecauseB_t is saturated inH, F*B_t is saturated inV. Because the adjoint is integrally onto locally freeJ_τ, L is saturated inF*B_t and hence inV: V/L is an extension of two locally free quotients. Native Picard identifiesL withω² including its genuine action.

But every nonzero native mapω²→V is the t₂ map computed above. It has zero fiber alongW, so its image is not saturated inV. This contradicts the saturated inclusionL⊂V. The contradiction uses neitherτ nor a determinant mark forK, and excludes the actualB_t image in all dimensions after the source-kernel factorization.

The wild rankFIVE degreeδ modification remains a restricted-extension problem. This proof supplies no analogous saturated-kernel argument for its rankTWO adjoint kernel and no factorization in the higher-degree image cases. Both original finite étale maps stay on their shared source.
