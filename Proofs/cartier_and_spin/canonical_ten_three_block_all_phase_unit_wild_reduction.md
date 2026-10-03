# Proof: all-phase stratum exclusions and the first non-cubic correction

Version1, 3 October2026. [Fresh independent seven-check whole review PASS](../../Research/audits/OCT03_ALL_PHASE_ORDINARY_RESULTANT_AND_THREE_BLOCK_WILD_REDUCTION_WHOLE_AUDIT_2026_10_03.md), with its conclusion-terminology correction applied. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_three_block_all_phase_unit_wild_reduction.md).

## All other endpoint strata are excluded

The [new ordinary all-phase contact-five exclusion](../shared_tensors/finite_all_phase_ordinary_noncritical_contact_five_exclusion.md) removes every finite ordinary noncritical point with Xi,p_i,q_i units, since a uniform wild π-index gives source z-index k≥5. The independently reviewed [q-zero all-phase extension](../shared_tensors/finite_all_phase_noncritical_qzero_contact_five_exclusion.md) removes the q-zero ordinary points too. If one centered coordinate is zero, either the other is nonzero, giving unequal q-variation orders2and1 (or3 at a branch), or both are zero and z³=1. Mixed P/ordinary endpoints have unequal q-variation orders3and1or2. Thus they cannot have source z-index at least five.

At z³1, the [accepted all-phase critical-value theorem](finite_uniform_wild_critical_value_exclusion.md) already deletes every uniform wild point, including special affine and infinity points. At common infinity with arbitrary unit z, the accepted source third jet gives source z-index exactly three when the global leading ratio ρ=κ³ differs from one; when ρ1 the [accepted local congruence](../shared_tensors/common_infinity_index_congruence_five.md) gives source index4 modulo5. Neither possibility is divisible by five. These are source-local inputs extracted in the [accepted whole-block proof](canonical_ten_whole_block_common_infinity_bounds.md), not an assumption that an endpoint map descends to Q.

For clarity a direct infinity readback agrees with those inputs: choose A=l u⁻³ and let B/A tend to ρ. If source index k≥5, the conic makes dB/dA=ρ+O(u⁵), while p(B)/p(A)=ρ¹⁰(1+p9(ρ⁻¹−1)u³/l+O(u⁴)); z varies only from order five. The original cubed θ identity first gives η=ρ and then forces ρ1 from its nonzero p9 coefficient. The ratio-one congruence then contradicts5|k. No pole-normalized numerator is substituted for the actual differential equation.

Consequently every surviving unit wild point has BOTH finite endpoint images at P-branches and s=z(P)³≠1. The accepted fixed-root input makes a,b,q(a),q(b) units. Because s≠1, a≠b automatically.

## Actual different tower and exact frozen error

Let e=e_P(π)∈{5,10}, f=e_{π(P)}(Q/z)≤3, and k=e f. The actual degree-three Q/z map is separable and tame locally, so
\[
\delta_z=\delta_\pi+e(f-1),\qquad
\delta_z-k=\delta_\pi-e\ge3.
\]
Here δ_z=ord_P(dz) is the source different, and δπ≥8or13 is the accepted Galois local different. Both original X-legs are étale. Choose the actual source parameter u=y1; then p(A)=u³ and A−a is a power series in u³ with exact order three. Likewise p(B) has order three and ord(dA)=2.

The original differentiated q/θ comparison, cubed with its EXACT η=κ³ and clearing p(A)², gives
\[
K=B^3p(B)^2-\eta z^{33}A^3p(A)^2,
\qquad\operatorname{ord}_P K\ge\delta_z+4\ge k+7.
\]
The bound is the branch form of the accepted original identity; it retains κ rather than setting it to one.

Freeze q(V)=s q(A), V(a)=b. Since2b,q(a) and z(P) are units, the exact conic identity gives ord_P(B−V)=k, with NONZERO leading coefficient. Since V′(a)=sa/b is a unit, p(V) has exact order three and the same leading coefficient as p(B). Taylor expansion at b gives
\[
B^3p(B)^2-V^3p(V)^2
=2b^3p(V)p'(b)(B-V)+\text{terms of higher source order}.
\]
Every displayed leading factor is nonzero, and its source order is EXACTLY k+3. The correction from B³ has order at least k+6; the quadratic Taylor correction has order at least2k>k+3, since k≥5. The phase correction z³³−s¹¹ times A³p(A)² has exact order k+6, so cannot cancel the order-k+3 term.

Therefore K=F(A)+E with ord(E)=k+3, whereas ord(K)≥k+7. This forces ord(F(A))=k+3 exactly. But F(A) is a formal series in A−a, hence in u³. Its order must be a multiple of three. Thus3|k. Since e5or10 is coprime to three and f≤3, necessarily f=3. Now k=3e and the exact multiplicity in A−a is (k+3)/3=e+1.

## The finite branch-pair condition

The constant and linear frozen coefficients vanish because p(a)=p(b)=0. The exact quadratic coefficient, with η retained, is
\[
s^2a^2\bigl[bp'(b)^2-\eta s^9ap'(a)^2\bigr].
\]
All clearing factors are units. Its vanishing gives W(b)=ηW(a) for the accepted nonzero root weight W(U)=Up′(U)²/q(U)⁹. Thus η is uniquely determined by each ordered root pair. Exact multiplicity6or11 additionally forces coefficients3,4,5 to vanish; these higher constraints have not yet been evaluated.

The ten fixed geometric branch roots yield only100 ordered pairs before the s≠1 restriction. This is a genuinely finite necessary locus, retaining the actual source phase and the original both-map problem. The previously accepted root-weight separation only handles η1 and must not be reused to assert that W(b)=ηW(a) forces a=b for arbitraryη. No remaining candidate is asserted to globalize, and no whole arbitrary-phase unit-wild exclusion follows from this reduction before those new higher coefficients are decided. That subsequent decision is recorded in the separate [complete all-phase proof](finite_uniform_wild_all_phase_exclusion.md).
