# Proof: exact phase at the diagonal and an all-phase Hasse obstruction

Version2, 3 October2026. [Fresh independent whole review PASS](../../Research/audits/OCT03_ALL_PHASE_ORDINARY_CRITICAL_ONE_WILD_EXCLUSION_WHOLE_AUDIT_2026_10_03.md), including all special and infinity cases, with no required corrections. See the [statement](../../Theorems/cartier_and_spin/finite_uniform_wild_critical_value_exclusion.md).

Write A=X1, B=X2, η=κ³, s=z(P)³=1, and let e5or10 and δ≥8or13 be the actual local π-index and different. Set k=ord(z³−1)=ef≥5, with5|k, by the actual Q/z-index f. First treat affine A,B and p(A),p(B) units, with A(P),B(P) nonzero. A−A(P) is an ACTUAL source parameter because the first X-leg is étale. Put v=ord(q(A))∈{0,1}; q(B) has the same order. The exact q/θ differentiation and difference of cubes used in the accepted contact-five proof, now keeping the ORIGINAL η, give
\[
K=B^3p(B)^2-\eta z^{33}A^3p(A)^2,
\qquad\operatorname{ord}_P(K)\ge\delta+v>0.
\]
The unit multiplier contains η but no q denominator, so q0-zero points are included. Since s1, B(P)=±A(P).

If B(P)=A(P)=a, the nonzero ordinary value a³p(a)² gives K(P)=(1−η)a³p(a)². Thus η=1. The accepted [complete exact-phase wild exclusion](finite_uniform_wild_exact_phase_exclusion.md) applies, including q0-zero points, and contradicts the candidate. No arbitrary phase was normalized to one.

## Frozen anti-diagonal contact in the actual source parameter

Suppose B(P)=−A(P)=−a with a≠0 and p(a)p(−a)≠0. The unique frozen branch through B(P) is V=−A. Since z comes from the actual π, ord(z³−1)≥e. The exact conic gives
\[
(B-V)(B+V)=(z^3-1)q(A),
\qquad\operatorname{ord}(B-V)\ge e+v,
\]
because B+V has nonzero value−2a. Also ord(z33−1)≥e. Clearing the polynomial differences as in the accepted frozen argument yields source contact at least min(δ+v,e)≥5 for
\[
F=-A^3\bigl[p(-A)^2+\eta p(A)^2\bigr].
\]
All denominators used here are units; the nonzero q value is not assumed. Choose λ with λ²=−η. The bracket factors as[p(−A)+λp(A)][p(−A)−λp(A)]. They cannot vanish simultaneously at a because p(a) and p(−a) are units. Consequently one polynomial p(−U)+λ′p(U), with λ′∈k×, must have root a of multiplicity at least five.

## No such ordinary high-multiplicity root exists in any phase

Use β²=β+3, d=d0=3+4β=3−β, d²=2. The fixed centered coefficients are
\[
p=[8,3,21,23,22,12,22,21,1,22,1],
\quad p_3=d,\quad p_4=p_9=d-1\ne0,\quad p_8=1.
\]
First λ′=1 gives a pure-even polynomial whose fourth Hasse derivative is the nonzero constant2p4. The case λ′=−1 gives a pure-odd degree-nine polynomial whose fourth Hasse derivative is−2p9 U⁵, which cannot vanish at nonzero a. Thus neither case has the required root.

For λ′≠±1, normalize p(−U)+λ′p(U) by its leading coefficient1+λ′. Its even coefficients are those of p and its odd coefficients are multiplied by
\[
c=\frac{\lambda'-1}{\lambda'+1}\ne0.
\]
For this monic degree-ten g, the two exact Hasse derivatives are
\[
D^{[4]}g=g_9U^5+g_4,
\qquad D^{[3]}g=4g_9U^6+g_8U^5+4g_4U+g_3.
\]
A root of multiplicity at least five makes both zero, hence
\[
a^5=-1/c,
\qquad g_3g_9=g_8g_4,
\qquad c^2d=1.
\]
Squaring the first relation gives a10=1/c²=d. Since d lies in F25 and d⁵=−d, injectivity of the fifth-power map in k then forces a²=−d: the required root must be a q0-zero point.

At such a point the fixed polynomial reduces to the following four identities, obtained by substituting a²=−d and d²=2:
\[
p(a)=d+2-a(d+1),\qquad p(-a)=d+2+a(d+1),
\]
\[
p'(a)=3-d+a(1+2d),\qquad p'(-a)=3-d-a(1+2d).
\]
The ordinary hypotheses ensure p(a)p(−a)≠0. They give
\[
\left(\frac{p(-U)}{p(U)}\right)'_{U=a}
=-\frac{p'(-a)p(a)+p(-a)p'(a)}{p(a)^2}
=-\frac{2(d+3)}{p(a)^2}\ne0.
\]
Here d+3≠0 because β∉F5. Thus whenever p(−a)+λ′p(a)=0, its derivative is nonzero: it has a SIMPLE root at a. This contradicts the necessary multiplicity at least five. Every λ′ case has been covered by exact hand algebra, with no root sampling or numerical process.

The anti-diagonal is therefore excluded in every original phase. Combined with the diagonal argument, this settles all ordinary nonzero centered coordinates, including q0 zeros.

## Centered zeros in every phase

If either centered affine coordinate is zero, q(B)(P)=q(A)(P) forces both zero. Both endpoint P-values equal p(0)=[8]≠0. Choose the ACTUAL source parameter u=A. Étaleness makes B have order one. Since B²−A²=(z³−1)q(A) has order k≥5, its leading slope λ=B/A is±1. The original cubed θ-comparison forces λ³=η⁻¹, so η is one or minus one. The plus slope has η1 and is excluded by the accepted exact-phase wild theorem.

For slope minus, η=−1. Write B=−A+w. The conic shows ord(w)=k−1≥4, since B−A has order one and q(A) is a unit. Thus B′=−1+O(u³) and (B′)³=−1+O(u³). But p1=3 and p0=[8] are nonzero, and
\[
\frac{p(B)}{p(A)}=\frac{p(-A)}{p(A)}+O(u^4)
=1-2\frac{p_1}{p_0}u+O(u^2).
\]
The original cubed θ equation has right side−(p(B)/p(A))²(1+O(u⁵)), with a NONZERO linear coefficient, contradicting the left side's absence of a linear term. Thus centers are impossible in every phase.

## The fixed branch roots have no opposite centered pair

The accepted branch-root input used in the [strong additive Sidon proof](../curve_arithmetic/fixed_x_branch_strong_sidon.md) is the [single recorded root receipt](../../../litt3-computation-data/abelian_rigidity_20260922/branch_stabilizer.json). It identifies the fixed P coefficients and lists all ten roots in the F5 power basis of F5⁸, with field modulus ascending[2,4,3,0,1,0,0,0,1]. The first three coordinates in the receipt's order are

|i|first three coordinates|
|---|---|
|0|(0,1,0)|
|1|(0,1,0)|
|2|(0,1,3)|
|3|(0,2,0)|
|4|(0,2,1)|
|5|(2,1,3)|
|6|(2,2,4)|
|7|(4,0,1)|
|8|(4,0,1)|
|9|(4,1,0)|

Two centered p-roots could be opposite only if their original P-roots summed to−2, whose power-basis coordinates begin(3,0,0). First-coordinate sum three forces both roots to have first coordinate four. Second-coordinate sum zero then forces both from indices7and8, allowing repetition. But their third-coordinate sum is two, not zero. Therefore no such pair exists. This is a new hand inspection of a different condition on the accepted roots; no root generation,55-sum check, field computation or numerical replay was performed.

## Finite branch and mixed cases

If exactly one finite endpoint is a P-branch, s1 gives B(P)=±A(P). The plus sign would make both P-values zero, so only the minus sign remains. All P-roots have centered A≠0 because p0≠0; the ordinary opposite endpoint is therefore noncentered. Its q-variation has exact source order one, while the étale branch endpoint's x-variation and q-variation have exact order three. Consequently q(B)−q(A), and hence z³−1, has order one. This contradicts k≥5.

If both finite endpoints are P-branches, the preceding no-opposite-pair fact forces B(P)=A(P)=a. The accepted q-unit root certificate, or simply the settled disjointness of P and q roots, gives q(a)≠0. The conic yields ord(B−A)=k≥5. In a branch source parameter, A−a has order three, so the leading x-coefficients agree, the p(B)/p(A) leading ratio is one, and dB/dA has leading ratio one. The original cubed θ-comparison therefore forces η1. This is excluded by the accepted exact-phase wild theorem. No P-branch case remains.

## Common infinity in every phase

If either endpoint is infinity, both are, since z is a unit and q(B)=z³q(A). Let ρ be the leading B/A ratio of their triple poles. The q-comparison gives ρ²=1, and the original cubed θ-comparison gives ρ=η. If ρ1, subtracting the conic gives ord(B−A)=k−3≥2. The accepted [common-infinity source-local congruence](../shared_tensors/common_infinity_index_congruence_five.md) applies and contradicts5|k.

If ρ−1, η=−1. Write B=−A+w. The same conic gives ord(w)=k−3≥2. Choose an infinity parameter u with A=l u⁻³. Then dB/dA=−1+O(u^k), and the fixed nonzero coefficient p9=d−1 gives
\[
\frac{p(B)}{p(A)}=\frac{p(-A)}{p(A)}+O(u^k)
=1-2\frac{p_9}{l}u^3+O(u^4).
\]
In the original cubed θ-comparison, its square and η⁻¹=−1 produce a NONZERO order-three term, whereas z24 changes only at order k≥5. The left side(dB/dA)³ is−1+O(u^k) and has no order-three term. This is a contradiction. No accepted third-jet or quotient-genus premise is needed for this minus case.

All affine and infinity cases have now been exhausted. Both actual endpoint maps remain on the SAME C throughout. The all-phase conclusion excludes only the stated Galois wild completions over z³1; other z-values, nonuniform/simple-fold extensions, arbitrary comparison extraction and the unmarked common-cover problem remain outside its scope.
