# Proof: scalar calibration from the original positive inclusions

Version1, 3 October2026. See the [statement](../../Theorems/cartier_and_spin/actual_positive_source_relative_scalar_calibration.md) and its [independent source audit](../../Research/audits/OCT03_ORIGINAL_SOURCE_SCALAR_LINE_IDENTIFICATION_AUDIT_2026_10_03.md). No computation is used.

## The domain is fixed before Frobenius pullback

The actual Cartier conventions put B_{1,X} on X₁. The original positive line is A_X=O_{X₁}(2O₁), as established in the [positive-line construction](actual_positive_single_section_trace.md). The original primitive has order eleven at O, giving two target factors; its ordinary order-two zeros give no target factor. The actual étale Frobenius square for h_i gives
\[
A_i=(h_i^{(1)})^*A_X=O_{T_1}(2H_i^{(1)}).
\]
The actual section u_i^(1) has divisor H_i^(1). There is a unique isomorphism γ_i:(L^(1))²→A_i sending (u_i^(1))² to the specified canonical section of A_i. Thus it retains the original column's phase, rather than choosing a new scalar normalization.

Let j_i:A_i→q₁*K be the actual conjugate inclusion. By definition of the COMPLETE integral trace and flat étale base change,
\[
\sum_i j_i(A_i)=q_1^*K.
\]
Consequently the constant span V_orig of v_i=j_iγ_i in Hom((L^(1))²,q₁*K) evaluates integrally onto q₁*K. This is precisely the original presentation in the [section-module construction](canonical_ten_higher_trace_section_module.md), with its relative twists written explicitly. No independence over k(T₁), saturation replacement or new coefficient space is asserted. Any specified original subspace is restricted inside this same presentation.

The source domain is already (L^(1))². Define its scalar line as Λ_orig=L^(1). Scalar twisting of the specified carrier comparison gives Λ_orig=φ^(1)*M^(1). This is a construction from the actual columns, not uniqueness of a root deduced after pullback.

## The paired datum and the original maps are transported together

The action on q₁*K is genuine. The scalar line has the twist of the specified projective L-action; the Hom action on V_orig has the inverse cocycle, so evaluation on V_orig⊗Λ_orig² is genuinely equivariant. Actual deck permutation of the j_i and the given u_i phases supply this action. No unrelated linearization or determinant normalization is chosen.

Pull this exact evaluation by F_T. The source becomes L¹⁰ and the étale Frobenius square identifies the target with q*F_Y*K. Under the packet's specified absolute/coefficient calibration its constant module is the retained W=V_orig^[5]. This notation records that supplied calibration: a relative k-morphism by itself is k-linear on its own constants.

Compose with the adjunction λ_T:q*F_Y*K→ω_T of the original Cartier inclusion. On the specified pulled raw section u_i¹⁰ its value is exactly h_i*(q₀θ). If the retained phase is θ_i=ε_i u_i¹⁶, the scalar adjoint is ε_i q₀(x_i)u_i⁶; when the packet has ε_i=1 this is its original b_i=q₀(x_i)u_i⁶. The constants have been transported, not reset.

Untwisting by L⁻¹⁰ therefore gives the SAME original map a and the SAME λa. The pulled evaluation is horizontal for the canonical Cartier connections because it is the relative Frobenius pull of the specified map on T₁. In a local L-frame t the source connection is
\[
\nabla(f t^{10})=t^{10}\,df.
\]
It glues since differentials of fifth powers vanish. Its dual connection on L⁻¹⁰ is the scalar adjustment in a. Thus the intrinsic jets also use the original connection.

## The scope of the root identification

For this original construction, Λ_orig=L^(1) is fixed before restriction to any specified original submodule. It introduces no alternative presentation. If instead a target datum independently chooses Λ with F_T*Λ=L⁵, then Δ=Λ⊗(L^(1))⁻¹ satisfies only F_T*Δ=O. The pull equation alone neither trivializes Δ nor identifies its connection or projective action. Applying the construction to that datum requires an isomorphism identifying its original column maps, phase choices, paired action and Frobenius comparison. The distinction is explicit in the audit; the broader abstract-root statements are not strengthened by this lemma.

Both actual finite étale endpoint maps remain on T throughout.
