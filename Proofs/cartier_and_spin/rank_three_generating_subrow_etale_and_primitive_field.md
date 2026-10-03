# Proof: an unchanged Wronskian and original source counts make every generating subrow étale

Version1,3 October2026. Root whole-scope review **PASS**; see the [statement](../../Theorems/cartier_and_spin/rank_three_generating_subrow_etale_and_primitive_field.md) and [rankTHREE review](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md). No computation is used. The original X-leg remains on T.

## Integral generation and the exact cocycle

By [socle generation](rank_three_positive_trace_socle_generation.md), W⊗L²→q*K is integrally surjective. Choose the paired projective lifts on V used in that presentation. Each lift preserves W, and its restriction has EXACTLY the same scalar composition cocycle, not merely a divisor of its order. Frobenius adjunction gives W^[5]→H0(T,L⁶) with class FIVE times that cocycle. Since the original order isFOUR orEIGHT, the order remains unchanged. No irreducibility of W is needed.

On H_W, W is scalar. Absorb that action into the paired L² action. The native genuine action on q*K and the integral surjection force the resulting scalar-line action to be genuine. Thus L² descends to an actual P_W on C_W^(1), with P_W⊗W→q_C*K integrally surjective. Write N=|R_W|. Its basepoint-free adjoint row has line A_W=ω_C⊗(F*P_W)⁻¹, and
\[
g(C_W)-1=N,\qquad\deg P_W=N/4,\qquad\deg A_W=3N/4.
\]
This is a rankTHREE presentation by an arbitrarily large constant space; it is not a bundle splitting. Its nondegenerate row curve makes the induced finite R_W-action on D_W faithful.

## The Wronskian depends on K, not on the chosen generating module

The accepted [rankTHREE Wronskian calculation](canonical_ten_rank_three_adjoint_row_ramification_reduction.md) gives a nonzero section of ω_Y⁶(F*detK)⁻¹ with zero divisor W_K of degreeSEVEN. Every THREE-minor of the W-adjoint second-Wronskian is this determinant times a FIFTH-power presentation minor. Those presentation minors have no common zero because W generates K integrally. Therefore their common zero divisor is EXACTLY q_C*W_K. The nonzero Wronskian also makes the row separating. Neither assertion needs its joint field with Γ.

The normalized row has genus at leastTWO. In genusZERO the invariant row line on P¹ has projective obstruction of order at mostTWO, contradicting the retained class after pullback to G. In genusONE its action on an invariant differential would give a cyclic prime-to-FIVE quotient of G, hence is trivial. Its effective group is then an abelian translation quotient, and the absence of prime-to-FIVE quotients makes it a FIVE-group. Scalar cohomology of a finite FIVE-group with coefficients k× vanishes: the group order annihilates cohomology and that power map on k× is an automorphism. This again contradicts the retained class. These arguments use the entire effective action on the row, not any faithful X-action.

For a local row index j, different δ and target common Wronskian order w, the exact jet chain rule gives
\[
\operatorname{ord}_c(q_C^*W_K)=j w+3\delta\le7.
\]
Only tame indicesTWO orTHREE can ramify. The actual R_W-action on C_W is free. An indexTHREE orbit would contribute TWO N to the different, while Hurwitz and g(D_W)≥TWO give total different strictly less than TWO N. Thus it is impossible. At mostONE indexTWO orbit remains, of the form q_C*S for one ORIGINAL Y-point S. This argument has not excluded S=P₀ or used a product-genus comparison.

## The local branch loses one intrinsic Cartier direction

At a proposed indexTWO point, choose parameters z=t² and a horizontal regular scalar frame. The row coefficients have the form w(t)f_i(t²) for a common unit w. Modulo t⁵ their span lies in w·span(ONE,t²,t⁴). Local exactness cuts that THREE-dimensional space by the NONZERO t⁴-coefficient functional: wt⁴ has coefficient w(0)≠ZERO. Hence K's B-fiber image has rank at mostTWO. It omits the intrinsic F₄=span(t³dt), since dividing a coefficient of leading orderTHREE by a unit preserves that leading order, which cannot arise in span(ONE,t²,t⁴).

The saturated rankTHREE Cartier degree bound forces E=SatK to have degreeTWO, with precisely ONE loss at S and no other loss. Its B-fiber image from K has rankTWO. Write E=A^⊥, with degA=ZERO, detE=ω_Y⊗A and degreeTWO adjunction zero divisor. Away from those zeros E omits F₄.

If ℓ(q1)≠ZERO, [native nonzero-quotient saturation](canonical_ten_rank_three_nonzero_quotient_saturation.md) already forbids ANY such loss. That lemma uses the actual infinity kernel and determinant and applies even if S=P₀. Thus the proposed branch is impossible in this case.

Suppose ℓ(q1)=ZERO. The following is the accepted [zero-quotient source count](canonical_ten_rank_three_ramified_zero_quotient_exclusion.md), with its original labels retained on T. Its constant original plane span(q0,q1) gains THREE saturation units at infinity and has total saturation degree at mostFOUR; it consequently has at mostONE deficient finite cubic X-point. Its pulled exceptions number at most d. At a nonexceptional finite cubic branch the original I-image has rankTWO and contains F₄. It cannot fit into the rankTWO K-image at S omitting F₄. Outside D_J, the I-kernel is the J-kernel and is annihilated by the original quotient row ℓ, so all finite cubic source branches there are also exceptional.

At leastNINE d of the actual TEN d finite cubic source branches therefore lie over D_J away from S. Since degD_J=THREE and S∈D_J, two distinct reduced points Z₁,Z₂ are necessary: one q-fiber has only EIGHT d points. Thus D_J=S+Z₁+Z₂. At each Z_i, E=K and the simple J-defect has the same rankTHREE B-image. If A's adjunction were nonzero there, this image would omit F₄ and forbid all finite cubic branches. One other q-fiber could not contain NINE d branches. Thus its adjunction zeros are exactly Z₁+Z₂.

Native determinants give A=ω_Y(−Z₁−Z₂), while adjunction gives A⁵=ω_Y(−Z₁−Z₂). Hence A⁴=O_Y. It is nontrivial by ordinary Y. Its connected cyclic TWO/FOUR trivializer would have a nonzero Cartier-kernel section, contrary to the stipulated selected-cover ordinarity. This excludes the remaining branch. All these counts apply directly for ANY S, including S=P₀; no previously proved S≠P₀ clause has been borrowed.

## The original primitive field supplies the joint field

We have proved C_W→D_W étale. Since T→C_W is also étale, T→D_W is étale. If D_W⊂Γ, the original map would factor through the ramified separating T→Γ. Its indexTWO at q*P₀ contradicts multiplicativity of local indices in an étale composite. Therefore D_W is outside Γ. Original S10 primitivity now gives k(Γ)k(D_W)=k(T), as asserted on the SAME original source.

The quotient-square, nonidentity tame proof and native scalar calibration needed to identify C_W with D_W are deliberately NOT conclusions here. Their retained-data checklist is in the separate [author transfer note](../../Research/experiments/oct02_global_extraction/RANK_THREE_GENERATING_SUBROW_ETALE_AND_IDENTITY_TRANSFER.md). Neither the original individual labels nor an X-map have been put on D_W.
