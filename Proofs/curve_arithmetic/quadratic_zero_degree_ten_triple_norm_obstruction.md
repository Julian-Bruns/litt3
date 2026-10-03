# Proof: complete fixed six-point Riemann–Roch jet ranks

Version1, 3 October2026. [Fresh independent six-check whole certificate/application review PASS](../../Research/audits/OCT03_SIX_QUADRATIC_ZERO_DEGREE_TEN_TRIPLE_NORM_CERTIFICATE_WHOLE_AUDIT_2026_10_03.md), with no correction. See the [statement](../../Theorems/curve_arithmetic/quadratic_zero_degree_ten_triple_norm_obstruction.md).

## 1. Explicit geometric points and the exact pole space

Use β²=β+3, [a+5b]=a+bβ, d0=[23]=3−β, q(U)=U²+d0, and the centered polynomial p with ascending coefficients[8,3,21,23,22,12,22,21,1,22,1]. The independently reviewed [mixed-support proof](centered_quadratic_support_mixed_triple_norm_obstruction.md) shows that ALL six q-zero points are ordinary and F625-rational: if α²=−d0, then α⁴=2, α²⁵=−α, p(α)²⁶=2d0 and p(α)²⁰⁸=1, so p(α) is a cube in F625.

The NEW finite-field source uses K=F5[α]/(α⁴+3), β=3+α² and d0=−α². The quartic is irreducible, checked by the source, and these identities give exactly the fixed F25 embedding. The integer encoding Σci5^i represents Σciα^i,0≤i<4; it differs from the earlier degree-six centered field. Choose an exact y0³=p(α) and put ζ=3+3β. The SIX points, in the fixed output order, are
\[
(\alpha,\zeta^j y_0),\quad(-\alpha,\zeta^j y_0^{25}),\qquad j=0,1,2.
\]
The source checks each point equation and625-fixedness, so the root choice covers the full set rather than a subset.

The affine superelliptic ring is free over k[U] with basis1,y,y². Its pole orders ordO(U)=−3 and ordO(y)=−10 give the exact basis
\[
\mathcal B=\{U^i y^j:0\le j\le2,\ 3i+10j\le30\}
\]
of L(30O). There are11+7+4=22 distinct monomials. Their distinct pole orders prevent cancellation of omitted high-pole terms. This also agrees with genus-nine Riemann–Roch:30+1−9=22.

At each q-zero point P, t=U−U(P) is an étale parameter because y(P)≠0. The exact cube recurrence for y(t), with starting value y(P), computes coefficients through t29, dividing only by3y(P)². The repaired source explicitly adds O(t30) to both series before asserting y(t)³=p(U(P)+t) modulo t30. It then forms the SIX30×22 coefficient stacks for the ordered basis and emits them in FULL, with all y-series and the point/field encodings.

## 2. All3003 divisor matrices are injective

Every effective degree-ten divisor supported on these points has a UNIQUE vector(e0,…,e5) of nonnegative integers with sum10. The recursive composition iterator lists exactly binomial(15,5)=3003 such vectors, with no assumption on support size or repetitions.

For each vector, choose the first3ei rows of the ith point stack. The resulting matrix M_E has30 rows and22 columns. Its kernel is exactly the functions f∈L(30O) with ordPi(f)≥3ei at all six points. A function of divisor3E−30O lies in this kernel. Conversely a nonzero function in the kernel has at least30 zeros and at most pole30, so the degree of its principal divisor forces that exact divisor. Thus the matrix test decides precisely this fixed-divisor relation, without claiming an actual source from a rank loss.

The [one repaired source](../../scripts/oct03_quadratic_zero_degree_ten_triple_norm_gate.sage) selects pivot columns of M_E's transpose, giving22 independent rows. It computes and asserts the nonzero determinant of the corresponding22×22 minor, and emits the vector, ALL pivot indices and its encoded determinant. The [complete fresh JSONL output](../../../litt3-computation-data/oct03_quadratic_zero_degree_ten_triple_norm_gate_20261003T1723_repaired/events.jsonl) consists of the shared full setup, ALL3003 full-rank records, and the final PASS record with checked3003 and no failures. Each matrix/minor is reconstructed uniquely from the emitted shared stacks, weights and pivot rows. All determinants are nonzero in K and remain nonzero over the algebraic closure. Every jet map is therefore injective, proving the claimed obstruction for ALL geometric multiplicity patterns.

The [receipt](../../../litt3-computation-data/oct03_quadratic_zero_degree_ten_triple_norm_gate_20261003T1723_repaired/receipt.json) binds source SHA256855d21506734a8dff2ed80a5187e2ccd0b29beed8c59ddd42820cae7f8d36798 and input SHAbb402c5ec428386a41a91872a86db13e54a1b9b70b3d3a58f264db73dfb516f7. Its separately approved ONE process used eight numerical thread environments at one, a ten-second internal checkpoint and fifteen-second hard external process-group timeout. It exited zero in9.096 seconds, with mathematical completion at6.285 seconds, no timeout and empty stderr. No sampling, point count, Frobenius replay or source enumeration was performed.

The [failed first source/receipt](../../../litt3-computation-data/oct03_quadratic_zero_degree_ten_triple_norm_gate_20261003T1719/receipt.json) remains intact: it compared the finite y-series as an exact polynomial and stopped before producing ANY matrix. That failed process supplies no divisor decision. Root inspected the two explicit O(t30) repairs before leasing the fresh process, and the new receipt records the failed predecessor. No adaptive follow-up calculation or certificate replay has been executed.

## 3. The actual third cubic fiber

Retain BOTH actual degree25 finite étale maps h1,h2:C0→X, the actual degree-ten π:C0→Q and degree-three Q/z, phaseκ³=1, two full common values a,b and third criticalγ, γ³=1. If Q/z has fiber3R and π over R is wholly unramified, there are TEN source points of z-index THREE. The accepted [critical three/six classification](../../Theorems/cartier_and_spin/finite_exact_phase_critical_three_six_classification.md) places both endpoint images at ordinary diagonal q-zero points. The actual source divisor
\[
\operatorname{div}_{C_0}(z-\gamma)=3\sum_{i=1}^{10}P_i-2D_2
\]
has endpoint norm divisor3E−30O along h2, where E=Σh2(Pi) has degree ten and q-zero support, with repetitions retained. This contradicts §2. The other original map remains étale on the SAME C0; no X-map is descended to Q.

Over3R the accepted whole local ledger allows ONLY an unramified π-fiber, a single fold or a uniform quadratic fiber. The [mixed-support theorem](centered_quadratic_support_mixed_triple_norm_obstruction.md) excludes the single fold, and the [centered norm theorem](centered_sixfold_norm_obstruction.md) excludes the uniform quadratic case after the critical three/six classification. Hence ALL π-profiles over a third fiber3R are excluded. Other third Q/z profiles1+1+1 or2+1 and the remaining global companion/source conditions are not decided by this theorem.
