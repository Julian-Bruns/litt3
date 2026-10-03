# Proof: a small all-phase coefficient locus and an exact resultant Bézout identity

Version1, 3 October2026. [Fresh independent seven-check changed arithmetic/application review PASS](../../Research/audits/OCT03_ALL_PHASE_ORDINARY_RESULTANT_AND_THREE_BLOCK_WILD_REDUCTION_WHOLE_AUDIT_2026_10_03.md), with no required mathematical correction. See the [statement](../../Theorems/shared_tensors/finite_all_phase_ordinary_noncritical_contact_five_exclusion.md).

## Audited exact static reduction

Use β²=β+3, [a+5b]=a+bβ, d=d0=[23], d²=2,d⁵=−d. The fixed centered p coefficients are[8,3,21,23,22,12,22,21,1,22,1]. The exact rank-one jet reduction in [the first static note](../../Research/notes/oct03_ten_hour/all_phase_unit_wild_logarithmic_jet_separation.md) passed [independent whole review](../../Research/audits/OCT03_ALL_PHASE_FROZEN_FIVE_RANK_ONE_JET_LOCUS_WHOLE_AUDIT_2026_10_03.md). Its subsequent [finite-locus reduction](../../Research/notes/oct03_ten_hour/all_phase_rank_one_locus_next.md) passed [fresh independent six-check whole review](../../Research/audits/OCT03_ALL_PHASE_RANK_ONE_FINITE_LOCUS_WHOLE_AUDIT_2026_10_03.md). We use their explicit formulas, not the earlier η=1 norm or PSC computations.

Put W=a⁵, Z=b⁵, Q(W)=W²−d, v=W+1, α=2+4d and
\[
c_2=W^2+(4+4d)W+4+d,\quad
c_3=(1+3d)W^2+4dW+1+2d,\quad
c_4=W^2+dW+3+2d.
\]
The audited exact rank-one characterization says that ordinary frozen contact five forces Q(Z)=s⁵Q(W) and k_j(Z)=s^{6-j}k_j(W), j2,3,4, where k_j=c_j/(W+1). Its complete inverse reconstruction gives the following necessary quadratic and quartics:
\[
E=s^2(s+1)c_2+\alpha s^2c_3+(s+1)v,
\]
\[
D=s^3c_3-s^4c_2+2ds^2c_4,
\qquad N=s^2c_4+(2-d)v-(d+3)D,
\]
\[
H=ND-2dv^2,\qquad
C=(N-v)^2-dv^2-s^5v^2Q(W).
\]
Thus E(W,s)=H(W,s)=C(W,s)=0. The reconstruction never inverts an s-dependent leading coefficient. The possible W-degree drop at s3, all k_j-zero strata and every ordinary geometric value are retained. The phase η has been eliminated from these necessary equations, rather than normalized to one.

## The one new small-resultant certificate

Form the two6×6 Sylvester determinants over F25[s]
\[
R_C(s)=\operatorname{Res}_W(E,C),\qquad
R_H(s)=\operatorname{Res}_W(E,H).
\]
A common geometric root W of E,H,C forces both determinants zero. This necessity remains valid at a degree drop: evaluation at the root annihilates the specialized coefficient map whose determinant is the Sylvester determinant. No sufficiency at a degree drop is used.

The [new source](../../scripts/oct03_all_phase_rank_one_small_resultant_gate.sage) emitted the full E,H,C coefficient arrays, both degree24 resultants, and exact polynomials bC,bH satisfying
\[
b_C R_C+b_H R_H=s^8(s-1)^2.
\]
The [complete new output](../../../litt3-computation-data/oct03_all_phase_rank_one_small_resultant_gate_20261003T1640/events.jsonl) contains every ascending encoded coefficient, including the degree13 Bézout multipliers. In particular the exact common factor is s⁸(s−1)², with encoded coefficients[0,0,0,0,0,0,0,0,1,3,1]. Since s≠0,1, the displayed identity contradicts simultaneous vanishing of the resultants. This excludes every geometric ordinary contact-five candidate in EVERY phase, without root sampling or a globalization assertion.

The [receipt](../../../litt3-computation-data/oct03_all_phase_rank_one_small_resultant_gate_20261003T1640/receipt.json) records source SHA2561867800a2c444e3faf80046c1db6ffb1503052296397e0736e9f03eb62e91fd6, eight numerical environment settings at one, and the hard external fifteen-second process-group timeout. Exactly ONE new approved process exited successfully without timeout in3.315 seconds, with mathematical completion at0.115 seconds and empty stderr. No old PSC, degree46 norm, group enumeration, Gröbner basis or adaptive follow-up was executed.

## Actual source application, with arbitrary κ

At the stated ordinary source point let k=e_P(z)≥5, z0=z(P), s=z0³≠1, and ℓ=ord_P(dz). Since z is separating, if5∤k then ℓ=k−1≥5, and if5|k then ℓ≥k≥5. Choose the actual source parameter A−a using the first étale endpoint map. Differentiating the ORIGINAL q/θ comparisons and clearing units gives
\[
K=B^3p(B)^2-\kappa^3z^{33}A^3p(A)^2,
\qquad\operatorname{ord}_P K\ge\ell\ge5.
\]
Here A,B,p(A),p(B),q(A),q(B) are units. Freeze q(V)=s q(A), V(P)=b. Since 2b is a unit, the exact conic identity gives ord_P(B−V)=k. Also ord_P(z³³−s¹¹)=k because33≠0 in characteristic five. Clearing these two corrections changes K only in order at least k≥5. Therefore the frozen numerator, with the EXACT η=κ³, has contact at least five in the actual parameter A−a, contradicting the certificate.

Both actual finite étale endpoint maps stay on their SAME source. The argument makes no π, normal-closure, uniformity, quotient-genus or Jacobian assumption. Finite q-zero and P-branch points are not smuggled into the ordinary chart; their separate results or remaining gaps must be retained.
