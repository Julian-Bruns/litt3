# Proof: contact three, two exact Bézout identities, and the finite special cases

Version1, 3 October2026. [Fresh independent five-check changed-arithmetic/application review PASS](../../Research/audits/OCT03_FINITE_TAME_FOUR_NEW_ARITHMETIC_APPLICATION_WHOLE_AUDIT_2026_10_03.md); its sole center-justification wording correction is applied and read back. See the [statement](../../Theorems/cartier_and_spin/finite_exact_phase_critical_tame_four_exclusion.md). The changed-contact derivation and source semantics already passed the [independent static preparation review](../../Research/audits/OCT03_FINITE_TAME_FOUR_TRIPLE_GATE_STATIC_SOURCE_REVIEW.md); the following application retains its complete scope.

## The one new exact arithmetic check

In the encoding β²=β+3, [a+5b]=a+bβ, the centered polynomial has ascending coefficients
\[
p=[8,3,21,23,22,12,22,21,1,22,1].
\]
Write p=p_even+p_odd and g_c=p_even+c p_odd for c=2,3. The [new source](../../scripts/oct03_phase_one_finite_tame_four_anti_triple_gate.sage) forms g_c, its ordinary derivative and its second Hasse derivative, and performs two extended-gcd steps. For BOTH c it emitted polynomials B0,B1,B2 with
\[
B0g_c+B1g_c'+B2D^{[2]}g_c=1.
\]
All coefficients and the two exact identities are in the [fresh complete output](../../../litt3-computation-data/oct03_phase_one_finite_tame_four_anti_triple_gate_20261003T1632/events.jsonl). In fact B2=0 in both identities; the result is stronger than the required absence of triple roots. The assertion used here is only that neither g_c has a geometric root of multiplicity at least three.

The [receipt](../../../litt3-computation-data/oct03_phase_one_finite_tame_four_anti_triple_gate_20261003T1632/receipt.json) records source SHA256 9748a9f1abe997bcc3ff19f8f1d4ff6b5c4e8c778273fb6eac98ba604081b339, eight numerical environment settings at one, and a hard external fifteen-second process-group timeout. Exactly ONE new process exited with code zero in2.063 seconds, without timeout or stderr; its mathematical completion was at0.069 seconds. No contact-five or logarithmic certificate was replayed.

## Ordinary nonzero centered coordinates

Let z0=z(P), z0³=1 and ord_P(z−z0)=4. The source map C→P1_z is tame at P, hence ord_P(dz)=3. Assume first that A,B,p(A),p(B) are units; q may vanish. Set v=ord_P q(A)∈{0,1}. Differentiating the original q-comparison and using the original θ-comparison gives the cleared numerator
\[
K=B^3p(B)^2-z^{33}A^3p(A)^2,
\qquad \operatorname{ord}_P K\ge3+v.
\]
No constant phase is discarded: this is exactly where κ³=1 enters. The q-comparison gives B(P)=±A(P). Freeze the corresponding conic branch V=±A. Since 2B(P) is a unit,
\[
\operatorname{ord}_P(B-V)\ge4+v,\qquad
\operatorname{ord}_P(z^{33}-1)\ge4.
\]
Thus V³p(V)²−A³p(A)² has order at least three. A is an actual source parameter after translation because the endpoint map is étale and p(A(P)) is a unit.

On the anti-diagonal V=−A its numerator is
\[
-A^3[p(-A)+2p(A)][p(-A)-2p(A)].
\]
Both factors cannot vanish together at a p-unit point. Normalizing each to monic gives g_2 or g_3. Frozen contact at least three would give a geometric triple root of one factor, contradicting the two new exact identities. This includes q-zero points.

On the diagonal with q(A(P))≠0, put u=A−A(P) and B=A+w. The q-comparison forces ord(w)=4. If w=αu⁴+O(u⁵), α≠0, the derivative ratio has a nonzero term −4αu³, while the p-ratio and original κz⁸ first vary only at order at least four. The θ-comparison is impossible.

At a diagonal q-zero, write a=A(P), a²=−d0 and u=A−a. The identity q(B)−q(A)=(2A+w)w gives ord(w)=5, so w=αu⁵+O(u⁶), α≠0. The p-ratio varies only at order at least five and the differential ratio has no term of order four, because the coefficient five vanishes. But
\[
z^3-1=\alpha u^4+O(u^5),\qquad
z^8/z0^8=1+\alpha u^4+O(u^5)
\]
has nonzero order-four coefficient. This again contradicts the original θ-comparison. These are the accepted diagonal jet arguments with the changed tame index substituted, not an inference from a formal contact graph to global field equality.

## Centered zeros and mixed finite branches

The accepted [P-root unit certificate](../shared_tensors/finite_p_branch_wild_diagonal_confinement.md) makes both U and q(U) units at every p-root. If exactly one endpoint is a P-branch, its centered-coordinate and q variations have exact order three. The other endpoint is ordinary, with q variation of order one away from the center, or two at the center. They cannot cancel to order four in q(B)−q(A). Thus mixed P/ordinary pairs are excluded.

If exactly one centered coordinate vanishes, both endpoints are ordinary after that exclusion, and their q variations have orders two and one, again impossible. If both vanish, write A=l u+O(u²), B=λl u+O(u²). Their leading y-value ratio has cube one because p(A(P))=p(B(P))=p(0)≠0. The cubed θ-comparison therefore forces λ³=1. A nontrivial λ would make q(B)−q(A) have exact order two; therefore λ=1. Put w=B−A, ord(w)=n≥2. The q identity gives source z-index n+1, so n=3. The differential ratio then has a nonzero correction at order two, whereas the p-ratio varies only from order three and z⁸ from order four. The center is impossible.

## Both finite P-branches

At both branch points, ord(y_i)=1, ord(A−a)=ord(B−b)=3 and ord(dA)=2. The exact differentiated numerator bound is now ord(K)≥3+4=7. Freeze V²=A² with V(P)=b, where a,b and q(a),q(b) are units. The conic correction B−V has order at least four, and p(B),p(V) have order three. Hence their squared-p difference has order at least seven; the other cleared corrections have order at least ten. The frozen numerator therefore has source order at least seven. Since it is a power series in A−a, whose source order is three, its multiplicity in A−a is at least three.

Its quadratic coefficient is the SAME one in the [accepted branch-weight proof](../shared_tensors/finite_p_branch_wild_diagonal_confinement.md), with s=1. Its vanishing gives W(a)=W(b) for W(U)=U p'(U)²/q(U)⁹. The already proved geometric separation of the ten root weights gives a=b. No new root computation or opposite-root premise is required.

For this diagonal branch put A=a+l u³+O(u⁴), B=A+w. The q-comparison forces ord(w)=4, with leading coefficient α≠0. The accepted exact branch expansion gives
\[
\theta_1/\theta_2
=\mu^2\left(1+\frac{(2-4)\alpha}{3l}u+O(u^2)\right),
\qquad\mu^3=1.
\]
The displayed coefficient is nonzero, while the original κz⁸ has first variation at order four. This is a contradiction. All possible affine endpoint pairs have now been covered.

## The actual three-block application

Use the [accepted whole-block construction and common-index bounds](canonical_ten_whole_block_common_infinity_bounds.md), not a presumed block field for another sector. In its b=3,ρ=κ³=1 sector, every common point has source z-index four, π-index two and Q/z-index two. There is at most one such Q-point above each of the three values z³=1. The whole local ledger makes its π-fiber uniform quadratic with five reduced points, all with source z-index four. A finite endpoint point anywhere in that fiber is excluded by the theorem just proved. Unit z makes either endpoint infinity equivalent to both endpoints infinity. Thus the entire fiber consists of five common points.

Consequently every nonzero common count at a critical value equals five. At d25,c=d−15=10, precisely two of the three counts are five: the partition is (5,5,0). At d30,c15, all three counts are five. The theorem does not remove the finite degree-ten companions of these full fibers and does not assert that their remaining global source constraints are inconsistent. Both actual étale endpoint maps remain on their SAME original C0 throughout.
