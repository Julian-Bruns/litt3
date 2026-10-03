# Proof: the first positive difference coefficient and the original tensor

Version1, 3 October 2026. [Fresh independent local audit PASS](../../Research/audits/OCT03_COMMON_INFINITY_INDEX_CONGRUENCE_FIVE_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/shared_tensors/common_infinity_index_congruence_five.md).

Choose a local parameter u at the common infinity point. Actual étaleness of both h_i gives triple poles for A=X1 and B=X2 and order−4 for dA. Their equal leading ratio and the stipulated accepted third-jet conclusion give
\[
A=l u^{-3}+O(u^{-2}),\quad B=A+w,\quad
w=\alpha u^n+O(u^{n+1}),\qquad n\ge1,
\]
where l and α are nonzero. The rational function w is nonzero: if B=A identically, the q-comparison would force z³=1, contradicting nonconstancy of z. Thus n is a finite positive integer. The proof does not replace either actual endpoint map by a sign-calibrated map.

Write \(\widetilde P(U)=P(U-1)\), still monic of degree ten. In characteristic five,
\[
(A+w)^{10}-A^{10}=2A^5w^5+w^{10}.
\]
For every lower-degree monomial of \(\widetilde P\), its difference at A+w and A has order at least n−24. Since \(\widetilde P(A)\) has order−30, while the two monic-degree-ten differences have relative orders at least5n+15 and10n+30, we obtain
\[
\frac{\widetilde P(B)}{\widetilde P(A)}=1+O(u^{n+6}).
\]
Let μ be the leading ratio y2/y1; then μ³=1. Taking the unique formal cube root with leading term one yields
\[
\frac{y_2}{\mu y_1}=1+O(u^{n+6}).
\]

The q-comparison gives the exact first nonconstant term
\[
\frac{B^2+d_0}{A^2+d_0}
=1+\frac{2\alpha}{l}u^{n+3}+O(u^{n+4}).
\]
Put z0=z(P), so z0³=1. Since three is invertible,
\[
\left(\frac z{z_0}\right)^8
=1+\frac{16\alpha}{3l}u^{n+3}+O(u^{n+4}).
\]
Its nonzero coefficient shows that the actual local source index of z equals n+3.

Differentiating the two Laurent series, including the case n divisible by five, gives
\[
\frac{dB}{dA}
=1-\frac{n\alpha}{3l}u^{n+3}+O(u^{n+4}).
\]
If five divides n, the displayed coefficient is zero; the formula remains valid. The original differential ratio therefore satisfies
\[
\frac{\theta_1}{\theta_2}
=\frac{y_2^2}{y_1^2}\frac{dA}{dB}
=\mu^2\left(1+\frac{n\alpha}{3l}u^{n+3}
+O(u^{n+4})\right),
\]
because n+6 is strictly larger than n+3. Leading terms in the ACTUAL comparison θ1=κz⁸θ2 give μ²=κz0⁸. Its next coefficient then gives
\[
\frac{n\alpha}{3l}=\frac{16\alpha}{3l},
\qquad n=16=1\quad\text{in }k.
\]
Thus n≡1 modulo five and e_C(z)=n+3≡4 modulo five. No division by n or differentiation of a fictitious descended endpoint map occurs.

For the stated whole-ten-sheet consequence, the actual local indices multiply as e_C(z)=e(C/Q)e(Q/z). The accepted [whole-bridge local ledger](../cartier_and_spin/canonical_ten_whole_bridge_ramification_ledger.md) allows common π-index1,2,5or10, and excludes the simple nonuniform folded point by the original infinity sections. The congruence removes both wild indices five and ten. For index two, multiplication gives e(Q/z)≡2 modulo five; for index one, e(Q/z)≡4 modulo five.

In a degree-three Q/z map, e(Q/z)≤3. Thus only index two with π-index two is possible. Such a ramified common point lies in a uniform quadratic π-fiber with five reduced points. The original global leading identity ρ=κ³ and q-ratio put every ratio-one common point above one of the three values z³=1. A degree-three Q/z fiber has at most one index-two point. Hence there are at most three eligible uniform π-fibers and c≤15. The [actual field-transfer theorem](../cartier_and_spin/canonical_ten_whole_block_common_infinity_bounds.md) supplies the degree-three field in the specified three-ten-block sector; this local calculation does not presume it for any other imprimitive monodromy.

Both actual étale endpoint maps stay on the SAME source throughout. No computation is used, and no unrestricted common-cover conclusion is asserted.
