# Proof: local wild exclusion, the original fold count, and discriminant étalization

Version1, 3 October2026. [Fresh independent whole audit PASS](../../Research/audits/OCT03_WHOLE_TEN_BLOCK_EXACT_PHASE_TAME_CONGRUENCE_DISCRIMINANT_WHOLE_AUDIT_2026_10_03.md), including the sign-cover refinement, with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_whole_block_exact_phase_tame_congruence.md).

## Actual field and all local types

Use the actual field/involution construction in the [accepted whole-block bounds](canonical_ten_whole_block_common_infinity_bounds.md). In particular Q⊂C0, [C0:Q]=10 and [Q:k(z)]=b are actual, and R=Q(t). They are not presumed simultaneously Galois closures of the endpoint maps. On finite nonzero z the two quadratic base changes B′/C0 and R/Q are unramified, so the [whole-bridge local ledger](canonical_ten_whole_bridge_ramification_ledger.md) transfers exactly to π. Its fibers are wholly unramified, a single fold (2,1⁸), or uniform finite Galois completions of degrees2,5,10.

The [complete exact-phase unit-z wild exclusion](finite_uniform_wild_exact_phase_exclusion.md) deletes every uniform degree-five or degree-ten completion. It explicitly covers both affine endpoint images and common infinity and retains the exact original κ³=1. Thus only unramified fibers, tame single folds and uniform quadratic fibers remain at unit z.

At z0 and infinity every source point belongs to D1 or D2 and has source z-index exactly two. Its π-index therefore divides two. More precisely, all t-zeros and t-poles on B′ are simple, so R/t and B′/R are unramified there. A σ-fixed R-point produces a ramified R/Q double and a uniform π-fiber2⁵; an exchanged pair produces Q/z-index two and an unramified π-fiber. The original individual infinity sections also exclude a folded infinity point. These special fibers are tame. Thus π is tame everywhere, with precisely the stated two nontrivial fiber profiles.

## The canonical number of folds

Put m=[k(T):k(B′)]. The étale B′/C0 double gives g(B′)=16d+1, and T/B′ is étale, so
\[
2g(T)-2=32dm.
\]
The original canonical identity ωT≅φ*ωΓ², with degφ10, gives
\[
2g(\Gamma)-2=8dm/5,
\qquad \deg\operatorname{Diff}(\varphi)=16dm.
\]
Since [B′:R]=[T:Γ]=10, the WHOLE base change gives [Γ:R]=m. At a fold R-value the local ledger says Γ/R is wholly unramified and B′/R has its unique tame quadratic point. That R-value contributes exactly one φ-fold above each of the m Γ-points and hence m to the different. Uniform R-values contribute no φ-different. There are therefore exactly16d B′/R fold values. They are at unit t, because all t-zeros/poles on B′ are simple. The involution σ has no fixed point at unit t, so its fold values occur in pairs and descend to exactly8d fold values for π:C0→Q. This is a count from the ACTUAL canonical carrier and whole one-fold ledger, not from the genus of π alone.

Let N count all remaining uniform quadratic π-fibers, including special fibers over z0 and infinity. Each single fold contributes one to the π-different; each uniform quadratic fiber has five points of tame different one and contributes five. Riemann–Hurwitz for the ACTUAL degree-ten π gives
\[
16d+20-20g(Q)=8d+5N.
\]
Reducing modulo five gives d≡0 modulo five. Solving for N gives N=8d/5+4−4g(Q). The actual degree of z is2r=10b, so r=5b and c=d−r is divisible by five too.

## One actual discriminant cover, not endpoint closures

Take only the normal closure L/Q of the actual π, whose monodromy is S10. Its degree-ten point stabilizer is S9. Let D be the smooth projective curve with field L^{A10}. The S9 stabilizer contains odd permutations, so D is not contained in C0. Consequently the normalized fiber product Ĉ=C0D is connected and has degree two over C0 and degree ten over D. Its degree-ten D-monodromy is A10 acting on A10/A9.

At a π-fold value the S10 inertia is a single transposition. At a uniform quadratic value it is a product of five disjoint transpositions: the uniform Galois completed fields identify the order-two inertia and its five orbits. Both inertia elements are odd. Since all ramification is now tame of index two, the inertia in L/D is their intersection with A10 and is trivial. Thus L/D is étale and so is its degree-ten quotient Ĉ→D. There is no ramification elsewhere, and no hidden wild normal-closure inertia is introduced: each local normal closure is precisely the trivial or quadratic Galois completion already present in π.

The discriminant double D/Q branches exactly at the8d+N π-branch values. Tame double-cover Hurwitz gives
\[
g(D)=2g(Q)-1+\frac{8d+N}{2}=24d/5+1.
\]
The connected étale degree-ten Ĉ/D then has genus48d+1. Equivalently, at each fold value, the original folded C0-point has quadratic completion and its base change to D splits without ramification, while the eight unramified C0-points acquire a quadratic completion. Every uniform quadratic completion splits without ramification over C0. Hence Ĉ/C0 is ramified at exactly64d points, and its double-cover genus is2(8d+1)−1+32d=48d+1, agreeing with the étale calculation.

The cover Ĉ/C0 is ramified, so composing it with either original étale C0→X leg does not create an étale endpoint map. Both original actual maps stay on their SAME original source throughout the deduction. The discriminant construction is auxiliary geometry of one actual π-normal closure and makes no common-cover existence or unrestricted exclusion claim.
