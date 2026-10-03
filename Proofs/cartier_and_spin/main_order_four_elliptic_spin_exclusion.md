# Proof: the order-four carrier has finite parameter support

[Statement](../../Theorems/cartier_and_spin/main_order_four_elliptic_spin_exclusion.md). [Independent whole-branch review: PASS](../../Research/audits/MAIN_ORDER_FOUR_ELLIPTIC_SPIN_AUDIT_2026_10_02.md). The carrier input is [the actual isogeny carrier](actual_elliptic_spin_isogeny_carrier.md), not an abstract replacement for either original étale map. Its a=4 profiles give an ACTUAL cyclic étale degree-four cover Y′→Y_t and a separating equivariant elliptic map f of degree m≤24. Write σ for its cyclic generator and β for the linear-order-four automorphism of E. Translate the elliptic origin so that β fixes it. Then fσ=βf, allowing a harmless constant translation of f.

## An actual elliptic reflection quotient

The hyperelliptic involution of Y lifts to an involution j on Y′ which inverts σ. Indeed the cover is defined by an exact order-four line N on Y; hyperelliptic pullback sends N to N⁻¹. At a Weierstrass point, a lift acts by inversion followed by translation on its cyclic four-point étale fiber. Such a permutation has square one. Thus a lift fixing one point has order two, and the actual composite Y′→P1 is a tame D8 Galois cover. Its six inertia generators are reflections. Both reflection conjugacy classes must occur to generate D8. Their counts are even: in the abelianization D8_ab=C2² their product is one. Hence their counts are four and two.

A reflection in the four-point class fixes two points over each of those four branch values, and no points over the other class. It has eight fixed points. Since g(Y′)=5, Hurwitz gives genus one for E0=Y′/⟨j⟩. This is an ACTUAL quotient, and no map from E0 to Y is assumed.

The differentials df and j*df have distinct σ-eigenvalues i and i⁻¹=−i. Both are nonzero because f separates. Therefore F=f+fj is nonconstant and separating, and is j-invariant. It descends to a separating map E0→E. The elliptic parallelogram identity gives deg(f+fj)+deg(f−fj)=4m. Consequently the descended map is an isogeny, after translating an origin, of degree at most2m≤48. An elliptic automorphism of order four in characteristic five forces j(E)=1728; that elliptic curve is ordinary (the x⁴ coefficient of (x³−x)² is −2, which is nonzero).

## Complete branch description of the reflection quotient

Let Z=Y′/⟨σ²⟩. This is an actual connected étale double of Y, corresponding to one of its fifteen nonzero two-torsion classes. Such a class is represented by an unordered pair {a,b} of distinct Weierstrass branch points. Choose a coordinate x on the hyperelliptic base taking a to0 and b to∞. The genus-three hyperelliptic model of Z has branch points
\[
\{+z_1,-z_1,\ldots,+z_4,-z_4\},\qquad z_l^2=x(w_l),
\]
where w_l are the four unpaired branch points of Y. The free deck involution of Z→Y is (z,v)↦(−z,−v).

The reflection j chosen above descends to the hyperelliptic involution of Z: it has eight fixed points downstairs, corresponding to the four-point reflection class. The central involution σ² therefore induces a degree-two map E0→P1_z. At each hyperelliptic branch point of Z, j on its two-point Y′-fiber either fixes both points or exchanges them. The latter four branch points are exactly the ramification points of E0→P1_z. Conjugation by σ replaces j by σ²j, interchanging the two alternatives, while z↦−z interchanges each pair. Thus the FOUR branch points of E0 select exactly ONE member of every pair {+z_l,−z_l}. This description covers every actual order-four cover and elliptic reflection; no arbitrary new source is introduced.

## Nonconstancy on every parameter component

There are three cases for the chosen pair among {0,1,2,3,t,∞}.

If the pair is fixed (it does not involve t), three of the square-root branch coordinates are constants and the fourth varies. On either sheet, let t approach an unpaired fixed finite point. Such a point always exists. One point above this parameter on the normalized square-root curve makes the moving selected root equal that fixed selected root. The other selected roots remain distinct. This is a nodal elliptic degeneration, so j(E0) has a pole. This also applies when one paired point is∞, using x=u−a.

If the pair is {a,t}, with a finite fixed point, take x=(u−a)/(u−t). The unpaired point∞ gives z=1 after choosing its sign. The other three square classes have distinct simple poles at the three unpaired finite branch values. They are independent in k(t)*/k(t)*². Therefore their multiquadratic curve is connected and its sign monodromy reaches every selection of the other three signs. As t approaches a all four squared branch coordinates tend to1. Choose a selection with two plus signs and two minus signs. The resulting two pairs collide separately at+1 and−1; their internal differences have first order in t−a and their cross differences are units. The elliptic cross-ratio tends to0,1 or∞, and j has a pole. Hence j is nonconstant on this connected parameter component, regardless of the original sign selection.

If the pair is {t,∞}, take x=u−t. The four square classes w_l−t have distinct simple zeros and are independent. Their sign monodromy is transitive. At t=∞ rescale z by a common square root of−t. A selection with two plus and two minus signs again gives two separate pair collisions, with internal differences of first order in1/t. Thus j has a pole and is nonconstant.

These cases prove nonconstancy for EVERY relevant component. A common sign change does not alter an elliptic branch configuration. All arguments are in characteristic five; the first-order coefficients are differences of distinct fixed branch values and remain nonzero.

## An explicit finite bound

For a fixed unordered pair, introduce t and four root coordinates z_l. On the smooth parameter open their equations have total degree at most three: they are z_l²(u_l−t)=u_l−a in the moving-paired case, z_l²=u_l−t for {t,∞}, and the analogous constant or one-moving equations in the fixed-paired case. A root at∞ has the equation z_l²=1. Clearing denominators removes only a boundary which we exclude.

For four distinct selected roots, let A=(z1−z3)(z2−z4) and C=(z1−z4)(z2−z3). The equation j(E0)=c is
\[
256(A^2-AC+C^2)^3-c A^2C^2(A-C)^2=0.
\]
It has total degree twelve. Nonconstancy makes its intersection with every parameter curve finite on the open. The isolated-point form of affine/projective Bézout therefore bounds all such root-parameter solutions by12·3⁴=972, including multiplicities. Positive-dimensional components created on a cleared-denominator boundary do not change the bound for isolated points on this open.

The set of elliptic j-values admitting a separating isogeny of degree≤48 to j=1728 has size≤48⁵. To see finiteness and this crude bound, dualize such an isogeny of degree n. Its source is the fixed j1728 curve, and its kernel is a finite flat subgroup of E[n]. For n=5^a n0, (n0,5)=1, the prime-to-five part has at most n0⁴ subgroups, since every subgroup of (Z/n0)² is generated by two elements. The ordinary five-primary part μ_(5^a)×Z/5^a has at most(a+1)²≤5^(2a) subgroup schemes, each the product of its unique connected and étale parts. Thus the total is at most n⁴. Summing n≤48 is at most48⁵. This finite set is F5-Frobenius stable.

Taking all fifteen paired two-torsion choices, the exceptional parameter set has size≤15·972·48⁵=B. It is Frobenius stable: the six branch labels, their unordered pairs, the square-root equations and the bounded isogeny condition are all invariant under F5-Frobenius. Consequently an exceptional algebraic t has F5-degree at most B. The selected MAIN prime degree is larger than B by its already accepted factorial lower bound. This excludes its ENTIRE a=4 elliptic carrier branch. Both original actual endpoint maps remain those retained by the actual carrier extraction throughout the contradiction.

## The accepted BACKUP order-three and order-six consequence

The [maximal exponent-six backup abelian cover](../../Theorems/jacobians/ordinary_covers/backup_small_abelian_ordinarity.md) is ordinary. Every connected cyclic degree-three or degree-six quotient cover Y′→BACKUP is therefore ordinary: pullback of regular differentials under an étale map is injective and commutes with Cartier. For a=3 or6 the elliptic target E′ has an automorphism of linear order divisible by three, hence j(E′)=0. In characteristic five its invariant differential is Cartier-zero, since the x⁴ coefficient of (x³+1)² is zero. The actual separating f:Y′→E′ pulls it to a NONZERO Cartier-zero regular differential, contradicting ordinarity of Y′. No arithmetic certificate is rerun.

The BACKUP order-four branch is untouched. MAIN characters a=1,3,6 remain subject to the preceding bounded profiles. This proof does not solve either unmarked common-cover problem.
