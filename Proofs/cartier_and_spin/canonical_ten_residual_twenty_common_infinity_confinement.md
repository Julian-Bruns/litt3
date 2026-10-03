# Proof: each of the three critical z-fibers holds at most five common points

Version1, 3 October 2026. [Independent whole-scope audit PASS](../../Research/audits/OCT03_RESIDUAL_TWENTY_COMMON_INFINITY_CONFINEMENT_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_residual_twenty_common_infinity_confinement.md).

## Actual fields and local inputs, without Hom vanishing

Use the actual quadratic-field construction and pure nonspecial local ledger in the [accepted low-quotient-genus proof](canonical_ten_residual_twenty_low_quotient_genus_exclusion.md). Its group and local steps apply to every joint degree d≥11, before the additional quotient-genus assumption is used. They retain BOTH original finite étale endpoint maps on the SAME T. Write C=C0 and h1,h2:C→X for the actual jointly generated degree d étale maps. Their reduced infinity divisors have common part J of degree c=d−10 and residual parts D1,D2 of degree ten. We have div(z)=2D1−2D2.

The actual nonsplit B′=C(t), t²=z, has its unique quadratic R⊂Γ∩B′, stable under the free deck σ:t→−t. Consequently Q=Rσ⊂C is quadratic over k(z), and the actual π:C→Q has degree ten and S10 monodromy. No simultaneous Galois closure of the endpoint maps is used.

Every point of J has z-value finite and nonzero, so it is in the nonspecial local ledger. The original individual infinity spin sections have simple zeros and avoid the simple φ-folds. The actual first-two-jet comparison gives z-index at least three at every common infinity point. The accepted third jet gives the sharper implication
\[
\operatorname{ord}_P(z-z(P))>3\quad\Longrightarrow\quad z(P)^3=1.
\]
This local conclusion needs only the actual two étale X-legs, their triple x-poles and original proportional tensors. It has no degree bound or cubic-root-index-three assumption; it is explicitly extracted in the low-quotient-genus proof.

At nonspecial values, the whole-bridge ledger descends through the unramified t²=z base change. A π-fiber is either unramified except for a single simple fold, or is uniform with all completed local fields the same finite Galois extension of index e dividing ten. The ramified uniform types are e2,5,10; they have respectively five, two, or one reduced source points. These local facts hold without any Jacobian norm-support classification. Fibers with no common infinity are not discarded.

## All common points are over z³=1

Let P∈J, A=π(P), and α=z(P). If π were unramified at P, its z-index would be the Q/z index, at most two, contrary to the common-infinity bound at least three. The only ramified point of a nonuniform fold fiber is excluded by the actual individual infinity-section condition. Thus A is a ramified uniform π-value of index e∈{2,5,10}.

Let f=e_A(Q/P1_z)∈{1,2}. Multiplicativity of the ACTUAL local indices gives source z-index ef. If e2, the lower bound at least three forces f2, hence ef4. If e5 or10, the index is at least five. In every case ef>3. The accepted third jet therefore forces
\[
\alpha^3=1.
\]
Every common point is confined to these three distinct finite nonzero z-values.

Fix one such α. If Q/z ramifies above α, there is a single Q-point A, with f2. Its π-fiber has at most five common points: the possible reduced uniform sizes are five, two, and one. If Q/z is unramified above α, there are two Q-points A and A′ with f1. Any π-fiber among them containing common infinity cannot have e2, because that would give source z-index two. Its type is e5 or10, so it holds at most two common points. The two fibers together hold at most four. In either case the entire z-fiber holds at most five common points. Summing over the three roots of z³=1 gives c≤15.

Equality c15 forces equality five in each critical z-fiber. None can be unramified on Q, whose capacity was four. Thus each contains a unique Weierstrass point A_i, and its π-fiber must be uniform e2 and contain all five common points. Writing the reduced fibers E_i,
\[
\pi^*A_i=2E_i,\quad\deg E_i=5,\quad
J=E_1+E_2+E_3,\quad h_{j*}\pi^*A_i=10O.
\]
All other nonspecial uniform fibers are finite for both endpoints: at a nonspecial z-value, endpoint infinity is precisely common infinity by div(z)=2D1−2D2.

## The exact finite-fiber list at equality

For c15, d25. The accepted quotient-genus theorem excludes g(Q)<9. The actual Γ→R genus bound and tame σ_R Hurwitz give
\[
g(R)=2g(Q)-1+a/2\le21,\quad a\in\{0,2,4\},
\quad W=220-20g(Q)-5a.
\]
Here W counts ALL nonspecial uniform π-different, including finite fibers. Its local costs are five for e2, 8(j+1) for e5, and9+4j for e10, with j≥1. The three full infinity quadratic fibers already consume fifteen.

| g(Q) | a | g(R) | W |
|---|---:|---:|---:|
| 9 | 0 | 17 | 40 |
| 9 | 2 | 18 | 30 |
| 9 | 4 | 19 | 20 |
| 10 | 0 | 19 | 20 |
| 10 | 2 | 20 | 10 |
| 10 | 4 | 21 | 0 |
| 11 | 0 | 21 | 0 |

The budgets zero and ten cannot contain the three known cost-five fibers. At W20, the remaining budget five gives one additional finite quadratic fiber. At W30, the remaining budget fifteen is only three finite quadratic fibers: it is below the least e5 cost16, and the only e10 cost at most fifteen is13, whose remainder two is impossible. At W40, the remaining budget25 is either five finite quadratic fibers or one finite e10 fiber of cost25. An e5 cost16 or24 leaves nine or one; e10 costs13,17,21 leave twelve,eight,four, none of which is a quadratic-cost sum; two wild costs already exceed25. Thus the complete retained list is

| g(Q) | a | Nonspecial uniform fibers, including the three infinity fibers |
|---|---:|---|
| 9 | 0 | Eight quadratic fibers; or three quadratic fibers and one e10 fiber of cost25 |
| 9 | 2 | Six quadratic fibers |
| 9 | 4 | Four quadratic fibers |
| 10 | 0 | Four quadratic fibers |

Every fiber beyond the first three is finite for both h_i. Special uniform fibers above z0 or z∞ when a>0 remain part of the accepted special ledger, contain no common infinity, and are not counted by W. No e5/e10 infinity obstruction using Hom vanishing was applied in these exceptional genera.

The bound excludes d≥26 since c=d−10. The [audited degree24 theorem](canonical_ten_residual_twenty_degree_twenty_four_exclusion.md) and its accepted antecedents handle d11…24. The equality case d25 remains unresolved: the actual norms of ratios of its three Weierstrass fibers are constants, and weighted trace vanishing is built into the original source. No replacement endpoint or unrestricted common-cover conclusion follows.
