# Proof: complete all-phase strata, the non-cubic error, and a pair-algebra identity

Version1, 3 October2026. [Fresh independent six-check MAJOR whole review PASS](../../Research/audits/OCT03_ALL_PHASE_UNIT_WILD_COMPLETE_EXCLUSION_MAJOR_WHOLE_AUDIT_2026_10_03.md), with no required mathematical correction. See the [statement](../../Theorems/cartier_and_spin/finite_uniform_wild_all_phase_exclusion.md).

## The already separated endpoint strata

Use the accepted BACKUP data, original centered coordinates and phase η=κ³. The [ordinary all-phase contact-five theorem](../shared_tensors/finite_all_phase_ordinary_noncritical_contact_five_exclusion.md) uses one new exact resultant identity to exclude ordinary noncritical centered-coordinate/p/q units when source z-index is at least five. The independently reviewed [q-zero all-phase theorem](../shared_tensors/finite_all_phase_noncritical_qzero_contact_five_exclusion.md) excludes the q-zero ordinary points under that same source bound. Their applications keep arbitrary κ and do not assume a quotient-degree bound.

At z³1 the [accepted complete all-phase critical-value theorem](finite_uniform_wild_critical_value_exclusion.md) removes every stated uniform wild completion, including special affine and infinity points. At noncritical unit z, mixed finite P/ordinary images have q-variation orders3and1or2, and unequal centered-zero/ordinary images have orders2and1or3. Such pairs cannot give source z-index at least five. Both centers would give z³1 and have already been removed.

Common infinity is excluded in ANY phase by the accepted source third jet: its index is exactly three when the leading ratio ρ differs from one; when ρ1 it is4 modulo5. Here ρ=κ³ by the original leading comparison. Every stated wild completion has source index divisible by five, contrary to either possibility. These source-local inputs are extracted in the [accepted whole-block proof](canonical_ten_whole_block_common_infinity_bounds.md) and the [standalone ratio-one congruence](../shared_tensors/common_infinity_index_congruence_five.md); they do not require that π supply a block field. A direct pole-frame readback is preserved in [the preceding reduction proof](canonical_ten_three_block_all_phase_unit_wild_reduction.md).

Thus only BOTH finite P-branch endpoint images at s=z(P)³≠1 remain. The accepted root-unit input makes a=A(P), b=B(P), q(a),q(b), p′(a),p′(b) nonzero. This is where the new higher-contact pair calculation is needed; the earlier η1 root-weight separation alone does not cover arbitrary phases.

## The local different argument has no base-degree bound

Let e=e_P(π)∈{5,10}, let f=e_{π(P)}(Q/P1_z) be arbitrary, and put k=e f. Separation of z on C makes Q/z separable too. Let δπ and δQ be the two local different exponents. Transitivity and the general separable inequality δQ≥f−1 give
\[
\delta_z=\delta_\pi+e\delta_Q,
\qquad\delta_z-k
=\delta_\pi-e+e(\delta_Q-f+1)\ge3.
\]
This is the strengthened scope of the degree-three calculation: Q/z may have any degree, genus and tame or wild local index. The source different δz is ord_P(dz) in an actual source parameter.

Choose u=y1, using the first ACTUAL étale X-leg at its branch point. Then A−a∈k[[u³]] with exact order three; p(A)=u³ and ord(dA)=2. At the second branch p(B) also has order three. The ORIGINAL differentiated q/θ comparison and difference of cubes, with η retained, give
\[
K=B^3p(B)^2-\eta z^{33}A^3p(A)^2,
\qquad\operatorname{ord}_P K\ge\delta_z+4\ge k+7.
\]
Freeze V²=sA²+d0(s−1), V(a)=b. The branch exists because2b is a unit. The exact conic gives ord_P(B−V)=k, with nonzero leading coefficient. Since V′(a)=sa/b is a unit, p(V) has order three with the same leading coefficient as p(B). Therefore
\[
B^3p(B)^2-V^3p(V)^2
=2b^3p(V)p'(b)(B-V)+\text{higher source orders}
\]
has order EXACTLY k+3. All leading factors are nonzero. The B³ correction starts at k+6, the quadratic p-Taylor correction at2k>k+3, and the z³³−s¹¹ correction multiplied by p(A)² at k+6. None can cancel this leading term.

With F(A)=V³p(V)²−ηs¹¹A³p(A)², it follows that K−F has exact order k+3. Since ord(K)≥k+7, ord(F)=k+3 exactly. But F is a formal series in A−a and hence in u³. Thus3|k. Since e5or10 is coprime to three,3|f. Its multiplicity in A−a is
\[
\frac{k+3}{3}=\frac{ef}{3}+1\ge e+1\ge6.
\]
No Galois assumption on Q/z was used, and no upper bound on f was used.

## The new finite pair-algebra certificate

Let p(U) have the fixed ascending encoded coefficients[8,3,21,23,22,12,22,21,1,22,1], in F25 with β²=β+3. Work in
\[
\mathcal B=\mathbf F_{25}[a,b]/(p(a),p(b)),
\]
which is a100-dimensional finite étale algebra because p is squarefree. Its basis is a^i b^j,0≤i,j<10, with index i+10j. Over k it splits into one copy of k for each of the100 ordered geometric root pairs. The source uses nested MONIC univariate quotients to retain this exact free basis; it does not sample roots or compute a Gröbner basis.

At the branch pair the constant and linear frozen coefficients vanish. Its quadratic coefficient is
\[
s^2a^2\bigl[bp'(b)^2-\eta s^9ap'(a)^2\bigr].
\]
Thus contact six forces η=W(b)/W(a), where W(U)=Up′(U)²/q(U)⁹ and s=q(b)/q(a). All these are defined units in the pair algebra by the accepted fixed-root facts; the new source also records exact unit-inverse calibrations. It defines those s,η and recursively expands V(a+h) through h5, dividing only by2b. It forms F through h5, asserts coefficients0,1,2 vanish identically, and names its coefficients3,4,5 as J3,J4,J5.

The [ONE new source](../../scripts/oct03_all_phase_p_branch_contact_six_root_algebra_gate.sage) then solves a100×300 finite-field linear system and emits the complete100-coordinate vectors for J3,J4,J5 and M3,M4,M5 satisfying
\[
M_3J_3+M_4J_4+M_5J_5=a-b\quad\text{in }\mathcal B.
\]
It asserts BOTH the matrix identity and the direct identity in the nested quotient algebra before emitting PASS. Every coefficient is preserved in the [new complete output](../../../litt3-computation-data/oct03_all_phase_p_branch_contact_six_root_algebra_gate_20261003T1645/events.jsonl). Evaluating at any geometric contact-six root pair makes all Jj zero, hence a=b. This forces s=1 and η=1, contradicting the already retained noncritical condition s≠1. Every remaining P-branch case is removed.

The [fresh receipt](../../../litt3-computation-data/oct03_all_phase_p_branch_contact_six_root_algebra_gate_20261003T1645/receipt.json) records source SHA256fab7ca4bc8657d479f16e6539d5bc326fb1d4b95c840a3cfbfd48c38ca50250d and input SHA2562a0a960e48905531d7c44c9537ffd445b7bfb2e7e349ab814387270f5be9f906, all eight numerical thread environments at one, and the hard external fifteen-second process-group limit. Exactly ONE new approved process exited zero in4.162 seconds, without timeout or stderr; the mathematical decision was at1.456 seconds. No earlier root-weight characteristic-polynomial separation, fixed-phase PSC, root generation or adaptive follow-up was replayed. The new arithmetic concerns the previously unevaluated higher frozen coefficients with arbitraryη.

## Whole-block tame congruence in every phase

Use ONLY an actual whole block as in the [accepted whole-block theorem](canonical_ten_whole_block_common_infinity_bounds.md). At unit z the whole one-fold ledger permits unramified fibers, one fold(2,1⁸), or uniform Galois indices2,5,10. The preceding all-phase theorem removes the last two wild indices. At z0and infinity the exact residual divisor gives source index two and the original individual infinity sections avoid folded points; these fibers are unramified or uniform quadratic. Thus π is tame everywhere in ANY original phase.

The accepted canonical fold calculation in [the earlier exact-phase application](canonical_ten_whole_block_exact_phase_tame_congruence.md) uses only the original carrier, whole one-fold ledger and absence of wild π-fibers. Its arithmetic and actual-source count therefore apply unchanged: there are exactly8d π-fold values. Each uniform quadratic fiber contributes five to the different. Degree-ten Riemann–Hurwitz gives
\[
16d+20-20g(Q)=8d+5N,
\qquad N=8d/5+4-4g(Q),\qquad5\mid d.
\]
The actual block relation r=5b makes c=d−r divisible by five as well. For b3,r15, the accepted common bounds and lower-degree exclusions leave ratio-one d25or30, and ratio-not-one24≤d≤45; the new divisibility leaves25,30,35,40,45 in the latter range. Finite companions, nontrivial global endpoint norm correspondences and reconstruction of the SAME source remain open. The sign-cover refinement, if used, has ramified X-legs and is not a replacement original étale witness.
