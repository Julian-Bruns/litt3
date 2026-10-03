# Proof: finite wild off-diagonal and special-diagonal cases

Version1, 3 October2026. [Fresh complete static scope audit PASS](../../Research/audits/OCT03_FINITE_UNIFORM_WILD_DIAGONAL_CONFINEMENT_WHOLE_AUDIT_2026_10_03.md), including the unit-z common-infinity exclusion and all six affine cases, with no required corrections. See the [statement](../../Theorems/cartier_and_spin/finite_uniform_wild_diagonal_confinement.md).

Let e5or10 be the actual local π-degree, with different δ≥8or13. Put z0=z(P), s=z0³ and k=ord_P(z−z0). Nonconstancy and separation make k finite, and exact local-index multiplication gives k=e·f, where f is the Q/z-index. Hence k≥5 and five divides k. The two original endpoint maps remain on C throughout; no endpoint map is transferred to Q.

## Unit-z infinity is excluded first

Finite nonzero z does not alone make the endpoint images affine. If one endpoint is O, the q-comparison forces both to be O. Étaleness then gives centered-coordinate poles of order three. Let ρ be their leading ratio. Cubing the original θ-comparison gives ρ¹⁷=κ³z0²⁴, while the q-comparison gives ρ²=z0³. Since κ³=1, these imply ρ=1 and z0³=1. Consequently
\[
\operatorname{ord}_P(X_2-X_1)=k-3\ge2,
\]
by subtracting the q-comparison: q(X2)−q(X1)=(X2+X1)(X2−X1), with orders of q(X1) and X2+X1 equal to−6 and−3. The accepted [common-infinity local congruence](../shared_tensors/common_infinity_index_congruence_five.md), which uses these original endpoint jets and needs no block or genus premise, forces k≡4 modulo five. This contradicts five dividing k. Thus both endpoint images are affine before the six affine cases below are applied.

## Ordinary frozen contact and the s1 anti-diagonal

On the finite open where Xi and P(x_i) are units, the [new contact-five gate](finite_uniform_five_ordinary_frozen_conic_exclusion.md) excludes e5 when s≠1, including q0-zero points. The accepted [contact-ten gate](finite_uniform_ten_ordinary_frozen_conic_exclusion.md) does the same for e10. Their underlying actual local necessity also gives frozen contact at least five when s1; only their fixed-degree norm certificates omitted this degree-drop parameter.

At s1, q(X2)(P)=q(X1)(P), so X2(P)=±X1(P). In the minus case the frozen branch is V=−X, and its numerator is
\[
-X^3\bigl[p(-X)^2+p(X)^2\bigr]
=-X^3\bigl[p(-X)+2p(X)\bigr]\bigl[p(-X)-2p(X)\bigr].
\]
Here2²=−1 in characteristic five. At the ordinary point X(P) is a unit, and the two bracket factors cannot vanish together because p(X(P)) and p(−X(P)) are units. Thus frozen contact at least five requires one bracket factor to have multiplicity at least five.

Normalize either factor to be monic. Its even coefficients equal those of p, and its odd coefficients are multiplied by c2or3. The fixed centered p coefficients are
\[
[8,3,21,23,22,12,22,21,1,22,1],
\]
so p3=d0, p4=p9=[22]≠0, and p8=1. For any monic degree-ten polynomial g in characteristic five, its Hasse derivatives of orders four and three are
\[
D^{[4]}g=g_9X^5+g_4,\qquad
D^{[3]}g=4g_9X^6+g_8X^5+4g_4X+g_3.
\]
A root of multiplicity at least five makes both zero. Eliminating X⁵ gives the necessary coefficient identity g3g9=g8g4. In either normalized bracket this would say c²d0=1. But c²4 and4d0=2+β≠1, for β²=β+3. Thus neither factor has a multiplicity-five root. This excludes the finite ordinary anti-diagonal at s1 by exact hand algebra, without a new numerical run.

Consequently any ordinary Xi/P-unit candidate has s1 and X2(P)=X1(P). This asserts x-coordinate equality only; its two y-values may differ by a cubic root of unity.

## Mixed endpoint branches

The new [P-root weight certificate](../shared_tensors/finite_p_branch_wild_diagonal_confinement.md) makes Xi and q(Xi) units at every finite P-root. If exactly one endpoint is a P-branch, its centered coordinate variation has source order three, hence its q-variation also has exact order three. The other endpoint is ordinary: its q-variation has order one if its centered coordinate value is nonzero, or order two at the center. Since q(X2)−s q(X1) has order at least k≥5, the unequal leading variation orders cannot cancel. Thus mixed P/ordinary endpoints are impossible.

If exactly one centered coordinate is zero, its endpoint is ordinary because p(0)=[8]≠0. After the mixed case is excluded the other endpoint is also ordinary. Its q-variation has order one, versus order two at the center, again impossible. Thus a centered zero would force both centered coordinates zero and s1; this residual case is excluded below.

## Both P-branches: weight separation and the special diagonal

If both endpoint images are P-branches, the [new wild P-branch theorem](../shared_tensors/finite_p_branch_wild_diagonal_confinement.md) gives X1(P)=X2(P)=a and s1. Its exact necessity uses the actual endpoint orders and forces equality of W(a),W(b), W(U)=U p′(U)²/q(U)⁹; the separately recorded squarefree multiplication characteristic polynomial separates all ten roots. Its source/certificate provenance is not replayed here.

Write A=X1=a+l u³+O(u⁴) and B=X2=A+w. Because a and q(a) are units, q(B)−q(A)=(2A+w)w shows ord(w)=k. Thus w=αu^k+O(u^{k+1}), with α≠0. If w vanished identically, the q-comparison would force constant z³1, contradicting the hypothesis. Since k≥5, the leading source coefficients at the two branch points agree. Let μ be the leading ratio y2/y1, so μ³1. Smoothness gives
\[
\frac{p(B)}{p(A)}=1+\frac{\alpha}{l}u^{k-3}+O(u^{k-2}).
\]
Taking cube roots and differentiating the actual coordinates yields
\[
\frac{\theta_1}{\theta_2}
=\mu^2\left(1+\frac{(2-k)\alpha}{3l}u^{k-3}
+O(u^{k-2})\right).
\]
The actual κz⁸ ratio has its first nonconstant term at order k. Leading constants agree by the original comparison. Therefore the coefficient at order k−3 must vanish, forcing k≡2 modulo five. This contradicts five dividing k. The formula remains valid when five divides k: the derivative contribution vanishes but the y-ratio term is nonzero. Thus both P-branches are entirely excluded, even at s1.

## Both centered zeros

Let A=X1=l u+O(u²), B=X2, with both centered values zero. Both P-values are units and s1. The q-comparison through order k≥5 forces the leading slope B/A to be ±1. Since y2/y1 has leading μ with μ³1, the cubed original θ-comparison forces the cube of dB/dA at P to be one. The slope−1 has cube−1 and is excluded. Thus the slope is+1 and w=B−A has order n≥2.

Since B+A has exact order one and q(A) is a unit,
\[
z^3-1=\frac{(2A+w)w}{A^2+d_0}
\]
has exact order n+1, so k=n+1. The ratio p(B)/p(A) changes only at order at least n, while dA/dB has first possible correction −nα/l at order n−1. The actual κz⁸ changes only at order n+1. Consequently n≡0 modulo five, hence k≡1 modulo five, again impossible. If five divides n, the displayed derivative term is zero and the reasoning remains valid; no division by n occurs. Thus shifted-coordinate zeros are excluded.

## q0-zero ordinary diagonal

The remaining finite case has Xi and P(x_i) units. If q(X1)=0, also q(X2)=0. The ordinary and anti-diagonal analysis already forces s1 and the common centered value a with a²=−d0, a≠0. Choose the ACTUAL source parameter u=X1−a, and write X2=X1+w, w=αu^n+O(u^{n+1}). The q-ratio shows
\[
z^3-1=\frac{(2X_1+w)w}{q(X_1)}
=\alpha u^{n-1}+O(u^n),
\]
because q(X1)=2au+u². Thus k=n−1 and n=k+1≥6. The p-ratio changes only at order at least n, whereas the differential ratio has correction −nα at order n−1. Cubic extraction and the eighth power give z⁸/z0⁸ correction (8/3)α=α at that same order. The original θ-comparison therefore forces −n=1 in k, or n≡4 modulo five and k≡3 modulo five, impossible. Thus q0-zero points are excluded too.

## The exact remaining local graph sector

Every finite uniform-wild point must now have Xi,q_i,P_i units, s1 and x1(P)=x2(P). Since y_i are nonzero with equal cubes, there is a UNIQUE j∈{0,1,2} with h2(P)=γ^j h1(P). Literal endpoint equality need not hold. No global composition or replacement of either original map is made.

At this ordinary point q′(X1)=2X1 is a unit, so q(X2)−q(X1)=(X2−X1)(X2+X1) shows ord(x2−x1)=k. The source index k=e f is a positive multiple of five. This finite high contact does not identify global maps or embedded fields. The original completed wild different remains available for a subsequent ordinary-diagonal analysis; it is not replaced by a ramification claim about a normalized tensor row.

The six new scope checks are ordinary contact/phase, anti-diagonal Hasse algebra, mixed and center variations, both-P diagonal congruence, q0-zero diagonal congruence, and actual graph conclusion. No additional calculation or replay is used. Both actual finite étale endpoint maps remain on the SAME source, and the unrestricted common-cover problem remains unresolved.
