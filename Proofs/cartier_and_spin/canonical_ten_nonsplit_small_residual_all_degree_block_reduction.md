# Proof: all-degree half-genus reduction and exact cubic-block boundaries

Version1, 3 October2026. [Fresh independent whole audit PASS](../../Research/audits/OCT03_NONSPLIT_SMALL_RESIDUAL_ALL_DEGREE_BLOCK_REDUCTION_WHOLE_AUDIT_2026_10_03.md), with no required corrections. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_nonsplit_small_residual_all_degree_block_reduction.md).

## Upper joint degree is not used in the group/conductor steps

For r10 the accepted [all-degree residual-twenty exclusion](canonical_ten_nonsplit_residual_twenty_all_degree_exclusion.md) applies directly, so suppose11≤r≤19. Put E=k(B′), A=k(Γ), F=k(t), K=k(T), m=[T:B′]. The original source data give
\[
[E:F]=2r,\quad[A:F]=rm/5,
\quad g(E)=16d+1,\quad g(A)=4dm/5+1,
\]
and hence uE=16d/r≥16 and uA=8d/r=uE/2. The independently audited [larger-residual overlap proof](canonical_ten_nonsplit_residual_eleven_through_nineteen_overlap_exclusion.md), Sections Actual field data through Three-sheet blocks, uses exactly these inequalities and11≤r≤19. It does not use d≤19 in any of those steps. Its sole upper-d use is the final low-genus norm in the surviving cubic block field; that final argument is not imported into the all-degree group reduction.

For clarity the complete exhausted alternatives are recorded here. Only the normal closure of the SINGLE actual E/F extension is used; the actual K/A selects a ten-sheet orbit Δ with full S10 action.

- Primitive E/F monodromy in degrees22…38 is A_n or S_n by the accepted complete degree-specific catalog. The actual ten-subset resolvent inside A has faithful semiregular inertia and all-wild conductor factor η≥461/462. For base v=−2, its normalized genus exceeds uE/2 by at least(230uE−2)/462>0. This deletes the primitive sector in every d≥r.
- If a proper block contains Δ, its size s lies10≤s≤r≤19 and gives an ACTUAL R⊂A∩E with [E:R]=s. For s11…19, the accepted [arbitrary-base small-complement obstruction](canonical_ten_small_complement_arbitrary_base_exclusion.md) applies after scaling normalized genera by[R:F]. The exact half ratio is unchanged. For s10,2r is divisible by ten and the range11≤r≤19 forces r15 and exactly three blocks of ten.
- If Δ meets ten different blocks once, their common size is two or three. Size two is deleted by the accepted [pair-block half-genus theorem](canonical_ten_pair_blocks_small_complement_half_genus_exclusion.md), which is already all-degree and imposes no common-infinity hypothesis.
- Size three occurs only at2r30 or36. The accepted complete ternary-kernel group dichotomy has either a large kernel, deleted by the actual faithful partial-transversal conductor factor η≥80/81, or a second system of three large blocks. The half-genus gap is at least(79uE−4)/162>0, independently of d. All conjugate actual étale legs remove the possible hidden own-triple C2 inertia kernel before that comparison. For the second system the large block size is twelve at n36, deleted by the arbitrary-base complement theorem, or ten at n30, the same surviving r15 sector.

These are all proper block systems: their intersections with the primitive ten-orbit are either the full orbit or singleton intersections. No block size, small kernel or wild lower group is dropped. The group/catalog/normal-closure constructions are accepted inputs, not new enumerations, and their conductor comparisons retain the actual T/E étaleness.

## Actual unique cubic field and the global common ratio

In the surviving r15 sector the ten-orbit must fill one of the three size-ten blocks, since it cannot meet ten different blocks. The system is exactly the set of monodromy translates of Δ and is unique. Its common field R is therefore actual and unique, with R⊂E∩A and[R:F]=3. The free involution σ:t→−t of E/C0 preserves F and hence this unique R. The accepted [whole-block field/bounds proof](canonical_ten_whole_block_common_infinity_bounds.md) gives
\[
Q=R^\sigma\subset C_0,
\quad[Q:k(z)]=3,
\quad[C_0:Q]=10,
\quad R=Q(t),
\]
with the ACTUAL whole local ledger. Since its base change to Γ has S10 monodromy, π:C0→Q also has full S10 monodromy. No original X-map is supplied on Q.

The same accepted theorem fixes the global common leading ratio ρ=κ³, gives c≤30 and d≤45 forρ≠1, and c≤15 and d≤30 forρ1. The odd-block fixed-point/opposite-leg norm argument excludes d≤21. In particular c>0 in every remaining packet, so the common ratio is defined. We retain both original endpoint maps in every application.

## Both ratio branches at degrees twenty-two and twenty-three

The exact boundary ledger below is the conceptual calculation recorded in [the higher-overlap note](../../Research/notes/oct03_ten_hour/three_ten_blocks_higher_overlap.md), now stated explicitly for this synthesis.

The σ-fixed point count a on R is2,4or6: all t-zeros/poles are simple on B′, each R/t special fiber has three points, and σ has an odd number of fixed points in each. Thus gR=2gQ−1+a/2 and gR≤4d/5+1. Each fixed special fiber gives a uniform quadratic π-fiber of five residual infinity points, entirely finite for the opposite X-leg. If its actual norm correspondence JQ→JX vanished, calibration at the opposite special infinity fiber would give a finite degree-five E with2E∼10O. The accepted two-torsion/gap-five obstruction excludes this. Hence that correspondence is nonzero, and absolute simplicity of JX of dimension nine forces gQ≥9. This uses the actual two-leg correspondence, with no imaginary X-map on Q.

There are exactly8d unit-z single folds, by the original canonical fold count. Subtracting them and the5a special different gives the EXACT unit-z uniform budget
\[
W=8d+20-20gQ-5a.
\]
Its positive local costs are5 for e2,8(j+1)≥16 for e5, and9+4j≥13 for e10. Using these costs as an overapproximation is sufficient; no formal allowed cost is claimed realizable.

At d22 the genus/fixed-point constraints leave only(gQ,a)=(9,2), with W6. At d23 they leave(9,2)or(9,4), with W14or4. None of4,6,14 is a sum of the positive costs: below16 only5 and13 occur, whose sums give none of those integers. Both ratio branches are therefore impossible at d22 andd23. Combining with the preceding accepted range leaves24≤d≤45 in the ratio-not-one branch.

## Exact phase one leaves only two joint degrees

Whenρ1, the actual comparison has κ³1. The [whole-block exact-phase tame/congruence theorem](canonical_ten_whole_block_exact_phase_tame_congruence.md) removes every unit-z uniform wild completion and proves5|d from the ORIGINAL fold count and π-Hurwitz. With22≤d≤30 this leaves exactlyd25ord30. The source-local congruence already places every common point in a uniform quadratic π-fiber above a Q/z-index-two point over one of the three critical values z³=1.

The accepted [direct norm-pole gap](../shared_tensors/common_infinity_norm_pole_gap.md) excludes common count four over any critical value: Norm_h2(z−α) would have its unique pole of order30−4·4=14 at O, a gap in<3,10>. Each common count is consequently0,1,2,3or5. Their sum c=d−15 is ten atd25 and fifteen atd30. The complete partitions are(5,5,0)or(5,3,2) atd25, and(5,5,5) atd30. These remain genuine unexcluded necessary packets. In particular their finite critical companions must not be discarded to import the saturated parity proof from residual degree ten.

This completes the claimed all-degree reduction and only that reduction. It does not decide the two phase-one packets, the ratio-not-one range24…45, larger residual degrees, split/cubic-index-three packets, unrestricted comparison extraction, or the original unmarked common-cover problem.
