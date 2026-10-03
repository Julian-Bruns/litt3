# Proof: global common values, exact local indices, and maximal saturation

Version2, 3 October 2026. Version1 [whole actual-field/local-capacity audit PASS](../../Research/audits/OCT03_WHOLE_TEN_BLOCK_COMMON_INFINITY_BOUNDS_WHOLE_AUDIT_2026_10_03.md); the source-local congruence [passed independent review](../../Research/audits/OCT03_COMMON_INFINITY_INDEX_CONGRUENCE_FIVE_AUDIT_2026_10_03.md), and the changed capacity/parity and odd-block genus scope [passed fresh focused review](../../Research/audits/OCT03_WHOLE_TEN_BLOCK_COMMON_INFINITY_BOUNDS_VERSION_TWO_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_whole_block_common_infinity_bounds.md).

## Actual block-field transfer and the scope of existence

Write E=k(B′), A=k(Γ), K=k(T), F=k(t), C=k(C0). Keep the original actual BACKUP Y-leg and both original finite étale endpoint maps on the SAME T. We assume an ACTUAL σ-stable field F⊂R⊂E∩A with [E:R]=10, K=AE, T/E étale and [K:A]=10 S10. Thus E⊗R A is the field K: its degree over A already equals [E:R]. This is a whole base change, not a selected component of a larger fiber product.

The original free deck σ of E/C sends t to−t. Its restriction to R is nontrivial, since t∈R. Put Q=Rσ⊂C. Because t∉C, we have CR=E, R∩C=Q, and R=Q(t). Hence the ACTUAL degree comparisons are
\[
[C:Q]=10,\qquad[Q:k(z)]=[R:F]=b.
\]
Since [E:F]=2r, r=5b. These are separating fields: div(z)=2D1−2D2 has valuations two, so in characteristic five z is not a fifth power. No X-map on R or Q and no simultaneous endpoint normal closure is asserted.

For completeness, existence and stability of R follow in a specified small-block sector. Take the SINGLE normal closure L/F of E/F, its transitive group M, and H=Gal(LA/A). The actual source has an H-orbit Δ of size ten with primitive S10 action. Suppose M has b<10 blocks of size ten. Its intersections with Δ form an H-invariant partition. The primitive possibilities are one piece or ten singletons; the latter would need at least ten blocks. Thus Δ is one entire block. Any such block system is then exactly its M-translates, hence unique. Its block field R contains both the E-sheet point-stabilizer field and the H-fixed-field inclusion, giving R⊂E∩A and [E:R]=10. All F-subfields of E of degree b correspond to size-ten block systems, so the same uniqueness makes σ(R)=R. This applies to b3 for every d and overlap c; it does not suppose that every imprimitive monodromy has this block system or extend the uniqueness claim to b≥10.

## The actual nonspecial local ledger and global leading value

At a common infinity point z is finite nonzero, by div(z)=2D1−2D2. At any such nonspecial Q-point, R/Q is unramified: a σ-fixed R-point would have t-value equal to its negative and hence t0 or t∞. The original E/C double is étale. Therefore the accepted [whole-bridge local ledger](canonical_ten_whole_bridge_ramification_ledger.md) transfers without change to π:C0→Q at these values. Its π-fiber is either unramified except possibly for one simple fold, or is uniform with every completion the same finite Galois extension of index e∈{1,2,5,10}. Uniform ramified reduced fiber sizes are5,2,1 for e2,5,10.

The original individual infinity sections avoid the fold point. This condition excludes a common point of π-index two in the nonuniform fold fiber, but does NOT exclude common unramified points in that fiber. Those points remain in all capacities below.

The original fixed tensor jet, explicitly extracted in the [low-quotient-genus proof](canonical_ten_residual_twenty_low_quotient_genus_exclusion.md), gives common source z-index at least three; it is EXACTLY three when the Laurent leading ratio ρ≠1, and at least four when ρ=1. This LOCAL statement uses the two actual étale X-legs, monic P with P9≠0 and original proportional tensors, not a quotient-degree-two assumption or Hom vanishing.

The global leading calculation in the [all-degree residual-twenty proof](canonical_ten_nonsplit_residual_twenty_all_degree_exclusion.md) also has no residual-degree dependence. To make it explicit, centered Xi=xi+1 have leading l_i u⁻³ at a common point, and monicity of P gives θ_i³ leading coefficient proportional to l_i^(-17). Thus the ORIGINAL comparison implies
\[
\rho^{17}=\kappa^3z(P)^{24},\quad z(P)^3=\rho^2,
\qquad\rho=\kappa^3.
\]
The same global κ occurs at every common point. Consequently all common z-values lie among the THREE roots of z³=ρ². No sign or finite ratio list is presumed from the conic alone.

## The ratio different from one gives the first bound

Suppose ρ≠1. At any common point, the source z-index is exactly three. Let f=e(Q/P1_z) at its Q-image and e=e(C0/Q) at the point. Exact local-index multiplication gives ef3. Since a common ramified π-point can only have uniform e2,5or10, no such ramified point is possible. Thus e1 and f3.

Above each of the three common z-values, the Q/z fiber of total degree b has at most floor(b/3) points of index three. Each π-fiber contains at most ten reduced common points, including a nonuniform fiber's unramified points if present. This gives
\[
c\le30\lfloor b/3\rfloor.
\]

## Ratio one: the exact index congruence improves the capacity

Suppose ρ=1. The independently reviewed [source-local congruence](../shared_tensors/common_infinity_index_congruence_five.md) refines the third-jet bound to
\[
e_{C_0}(z)=4\pmod5
\]
at EVERY common point. Its proof uses the original two étale endpoint maps: writing X2−X1=αuⁿ with n≥1, the coefficient of the actual θ-comparison at order n+3 gives n≡1 modulo five. No quotient assumption or Hom vanishing enters.

For each Q-point A above one of the three values z³=1, put f=e_A(Q/z) and let N_A count common points in its π-fiber. Exact index multiplication and the whole local ledger leave only these contributing types:

| Common π-index | Required f | Capacity N_A |
|---|---|---:|
| Uniform2 | f≡2 modulo5, hence f≥2 | At most5 |
| Unramified1 | f≡4 modulo5, hence f≥4 | At most10 |

Uniform wild indices five and ten are impossible because their source index would be divisible by five. A simple nonuniform folded point is still excluded by the original infinity sections. Its unramified points remain eligible in the second row.

For either row, and also when N_A=0,
\[
N_A\le5\lfloor f/2\rfloor.
\]
Since Σf=b, each critical Q/z fiber contains at most5floor(b/2) common points. Summing over the three values proves c≤15floor(b/2).

## The even-block maximal fiber is saturated and has even common degree

Suppose b is even and c=15b/2. Every critical fiber reaches5b/2. The nonnegative deficits5f−2N_A sum to zero, so each point of that Q/z fiber has zero deficit. This forces precisely f2 with a uniform e2 fiber entirely comprising five common points, or f4 with an entirely unramified π-fiber comprising ten common points. Indeed a larger allowed f has strictly positive deficit; a zero-common point also has positive deficit. At f4 ten common points exclude a nonuniform fold, which has only eight eligible unramified points.

Every common source z-index is therefore exactly four. Its total multiplicity over each critical value is4(5b/2)=10b, the entire degree of C0→P1_z. Thus z³−1 has no zeros away from J and its poles are6D2. The original common leading ratio is ONE, so the [accepted saturated critical conic parity obstruction](../shared_tensors/saturated_critical_conic_odd_overlap_obstruction.md) gives even c.

The even-b maximum15b/2 is odd exactly when b≡2 modulo4. Equality is then impossible, giving ε_b=1 in that class. For odd b the improved maximum need not saturate the critical divisor, so no parity subtraction is asserted. The weaker Version1 odd-b saturation mechanism required a common C5 fiber, now excluded by the new local congruence; its proof and audit remain as provenance, not as a needed argument here.

## An odd block degree excludes every joint degree at most twenty-one

Suppose b is odd. All t-zeros and t-poles on E are simple, so R/F is unramified at t0 and t∞ and each of these fibers consists of b distinct points. The involution σ_R permutes each odd-cardinality fiber and fixes at least one point in each. Its fixed points lie only in those two fibers. Let a be their total number; then a≥2. Tame Hurwitz and the actual Γ→R of degree m give
\[
g(R)=2g(Q)-1+a/2,\qquad
g(R)\le4d/5+1,\qquad
g(Q)\le2d/5+1-a/4\le2d/5+1/2.
\]
Thus d≤21 implies g(Q)<9.

Choose a σ_R-fixed point over t0, with image A0 on Q. Its R/F index is one, its R/Q index two, and F/z index two, so Q/z is unramified at A0. Every point of C0 above z0 is in D1 and has z-index two. Hence π*A0=2E0, with E0 a reduced degree-five divisor supported in D1. Choose any Q-point A∞ over z∞; its entire π-fiber is supported on D2, where h2 maps to O, so (h2)_*π*A∞=10O.

The fixed J(X) is absolutely simple of dimension nine. Since g(Q)<9, the actual correspondence (h2)_*π*:J(Q)→J(X) vanishes. Therefore, writing E_X=(h2)_*E0, we have2E_X∼10O. The residual divisors D1 and D2 are disjoint, so E_X is a finite effective divisor of degree five even when the two original infinity divisors have common part J.

The accepted [fixed-X two-torsion norm obstruction](../../Theorems/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md) makes O_X(E_X−5O) trivial: it is two-torsion and has a section after twisting by5O, hence by7O. Then E_X∼5O would give a function of exact pole order five at O, contradicting the semigroup ⟨3,10⟩. This excludes odd-b whole blocks for d≤21. It is the existing opposite ACTUAL endpoint argument with its genus range extended, not a one-leg substitute for the common-cover problem.

## The three-ten-block application and the retained gap

In the actual three-ten-block sector b3, r15. The preceding actual unique-block-field argument supplies R and its σ-stability for every d. The first bound gives c≤30 and d≤45 when ρ≠1. For ρ1, the exact source congruence leaves only f2 and uniform e2, so c≤15 and d≤30.

The existing [larger-overlap exclusion](canonical_ten_nonsplit_residual_eleven_through_nineteen_overlap_exclusion.md) removes d≤19 in this sector, and the preceding odd-block genus argument additionally removes20and21. The new bounds do not decide the remaining finite ranges22…45 or22…30. Their quotient Jacobians can have nonzero maps to J(X), so the low-genus opposite-leg norm argument must not be imported outside its proved genus range. A parallel conceptual task studies these remaining actual correspondences.

Both original finite étale maps remain on the SAME T. This is a conditional whole-block confinement theorem, not a general imprimitive-monodromy reduction or unrestricted common-cover decision. No computation is used.
