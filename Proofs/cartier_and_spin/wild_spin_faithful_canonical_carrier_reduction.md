# Proof: actual wild character covers and the exact profile transition table

Version7. [Statement](../../Theorems/cartier_and_spin/wild_spin_faithful_canonical_carrier_reduction.md). Corrected Version2 extraction and coverage passed [independent review](../../Research/audits/WILD_SPIN_FAITHFUL_CANONICAL_CARRIER_REDUCTION_AUDIT_2026_10_03.md). The final section adds the reviewed actual140-to10 lowering and whole canonical7000/21000 exclusion. The earlier degree-ten whole-profile dependency remains withdrawn; the exact character transition table is unaffected. Initial coefficient primitivity and the faithful cubic kernel character are explicit minimal-source hypotheses. Both original actual endpoint maps remain onT.

## Finite character order at the actual wild quotient

Use the accepted [eleven-profile classification](wild_ramified_spin_complete_inertia_profiles.md), [two-point Picard presentation](../quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md), and [wild Weierstrass reduction](wild_spin_weierstrass_different_reduction.md). Put k=|K|, H=G/K, n=degφ/k and S=[Γ/H]. With λ=N^k, the genuine degree-zero line
\[
\chi=\lambda\otimes\omega_S^{-k}
\]
has order E dividing g=gcd(e,m). Its actual pullback toY is trivial because P is Weierstrass. All eleven g values are prime to five and at most six; no wild stack is treated as a tame root stack.

The cyclic χ torsor C→S is therefore finite étale, connected and admits an actual liftY→C. Its coarse map to B=P¹ has degree E. The Picard torsion generator restricts faithfully with order g at BOTH local inertia groups: its reduced-divisor coefficients are e/g and m/g, and g is prime to five. Hence an exact-order E character ramifies its coarse cyclic cover fully at both branch values. This coarse tame two-point cyclic cover is rational. In particular C has coarse field a rational E-fold extension of B.

The actual equality ΓY=T/K and linear disjointness overB put Γ1=ΓC insideT with degree E overΓ. This is the connected étale pullback of C→S to the atlasΓ. G fixes C⊂Y, so the induced G action onΓ1 still has kernelK. The primitive coefficient is retained since oldΓ(a)=T. The different staysqP and all original M sections pull back.

## Exact transformation of actual inertia and different

Let e and Δ be the actual wild inertia order and different, and m the tame inertia order. The induced quotient Γ1/H has coarseC. Its inertia groups are the character kernels, of orders e/E and m/E. The wild subgroup is unchanged since E is prime to five. On completed fields, Γ1→Γ is étale while C→B has tame index E. The different tower formula gives
\[
\Delta=\Delta_1+(e/E)(E-1),
\qquad\Delta_1=\Delta-e+e/E.
\]
The effective source degree is n/E. This is a calculation for the actual extensions, not a fractional canonical-weight formula at a wild point.

If k=1, trivializing χ makes N1≅ωΓ1 genuinely, and the action is already faithful. If k=3, the same source-level argument in the accepted [carrier character theorem](actual_spin_carrier_character_reduction.md) uses ρ=N1ωΓ1^-1. Its cube is trivial and its faithful K action makes its geometric order exactly three. The canonical sections s and q*ηY/d have the same divisorqP; their ratio gives an ACTUAL connected cyclic étale Γc→Γ1 of degree THREE insideT. G then acts faithfully, N_c≅ωΓc, and the new canonical coefficient is primitive by the identity a=rv. No normalized-image assertion is made aboutΓc.

This cubic extraction does not change the effective profile just computed. Its map on completed curve rings is étale; the new faithful point stabilizer maps isomorphically onto the old H stabilizer because K acts freely on the three root sheets. Its coarse quotient is stillC. Hence the final canonical profile is
\[
(n_c,e_c,m_c,\Delta_c)
=(n/E,e/E,m/E,\Delta-e+e/E).
\]
The carrier-level parity and mixed-fiber statements remain applicable because their proofs use the retained actual maps, free G action, canonical different and original descending infinity sections. No tame small-degree theorem is applied.

## Complete transition table

Number the original profiles in the following order. The E=1 transition is the identical profile. Every permitted nontrivial exact character order and its resulting profile is listed:

|row|original(n,e,m,Δ)|g|nontrivialE and resulting canonical profile|
|---|---|---|---|
|1|(10,5,2,8)|1|none|
|2|(20,10,4,13)|2|E2→row1|
|3|(20,20,2,31)|2|E2→(10,10,1,21)|
|4|(40,20,8,23)|4|E2→row2; E4→row1|
|5|(60,20,3,27)|1|none|
|6|(140,20,7,23)|1|none|
|7|(30,30,3,41)|3|E3→(10,10,1,21)|
|8|(120,40,6,47)|2|E2→row5|
|9|(60,60,6,71)|6|E2→row7; E3→row3; E6→(10,10,1,21)|
|10|(7000,1000,7,1143)|1|none|
|11|(21000,3000,21,3143)|3|E3→row10|

For the repeated one-branch profile(10,10,1,21), the tame inertia is trivial. The ordinary endpoint exact-differential argument in the accepted [wild two-branch proof](wild_ramified_spin_two_branch_reduction.md) excludes it at carrier level: its proof uses only the actual free G atlas, quotient area, exact index-two qP and ordinary Y. It does not need projective-image normalization. Thus those transitions are impossible.

The corrected [small canonical wild theorem](canonical_small_wild_spin_carrier_exclusion.md) excludes row3 completely and only the nonsquare norm branch of row2. Its square branch lowers by an actual étale target double cover to row1. The corrected [degree-ten reduction](canonical_degree_ten_wild_spin_carrier_exclusion.md) excludes every distinguished position except the ordinary moving point(t,0), but does NOT exclude that point. The [canonical tame-inertia-three theorem](canonical_wild_tame_order_three_exclusion.md) excludes rows5and7 completely. Each retained assertion applies to the extracted carrier because its inherited spin data, canonical line and actual sections remain; no arbitrary separable source replacesT.

The independently reviewed [canonical degree-sixty exclusion](canonical_degree_sixty_wild_spin_carrier_exclusion.md) also excludes row9 with E1, by an actual étale cubic target extraction to the unaffected row3. Its retained spin data and primitivity have been checked explicitly in that statement.

The newly independently reviewed [whole canonical degree120 exclusion](canonical_degree_one_twenty_wild_spin_carrier_exclusion.md) excludes row8 with E1. Its E2 transition was already excluded by row5. Thus original rows3,5,7,8,9 are impossible for both k values and every E. Rows1and2 remain. On row4, E2or4 reaches a surviving small profile and is NOT deleted. All nontrivial row9 transitions also reach deleted rows7,3 or the one-branch profile. Rows6and10 have g1. Row11 permits E1or3, with E3 reaching row10. These are exactly the six remaining original profiles and character orders in the corrected statement.

## Further actual target reductions consolidate the small rows

On a surviving canonical row2 carrier, the accepted nonsquare proof in [small wild carriers](canonical_small_wild_spin_carrier_exclusion.md) forces its weight-four norm to be a square. Its ACTUAL target double cover gives row1, with canonical line, primitive coefficient, original M sections and both maps retained. This is a reduction and does not exclude row1.

On a canonical row4 carrier, the independently reviewed [degree-forty nonsquare gate](canonical_degree_forty_wild_spin_carrier_exclusion.md) forces its weight-eight norm to be a square. Its ACTUAL target double cover gives row2. The preceding row2 reduction gives a second target double cover and row1. Consequently row4 has an actual canonical target degree TEN after a degree-FOUR target tower. Neither step assumes simultaneous Galois closure.

For an original row2 the initial character extraction has E1 or2. IfE1, append the row2 double; ifE2, its target already has row1. Including the initial cubic kernel extraction when needed, the total target degree is2k. For original row4, E1 gives two additional doubles; E2 gives one; E4 gives none. The total target degree is4k in all cases.

The accepted Version1 [large canonical wild cubic reduction](large_wild_spin_frobenius_and_cubic_reduction.md) unconditionally lowers canonical row11 to row10 by an ACTUAL connected étale target cover of degree THREE inside the same T. Its genuine canonical line, primitive coefficient, original infinity sections and both original source maps are retained. Thus original row11 with E1 appends this cubic cover, while E3 already reaches row10. Including any original cubic kernel extraction, the total target degree is3k in either case. Row11 is reduced, NOT excluded. No pending deeper Frobenius packet from Version2 of that record is needed here.

Target étaleness makes the genuinely canonical line and original sections pull back; coefficient primitivity persists because Γc(a)=T implies Γf(a)=T. Thus the final canonical target list has exactly the THREE profiles in the theorem, although SIX original effective profile rows survive.

The complete original degree list κ=kn shows that degree90 occurs only in row7withk3, so it remains excluded. Degrees10,20and30 are NOT wholly excluded: they can occur in rows1or2. Original degree120 is likewise NOT wholly excluded: row4withk3 still reduces to the surviving canonical degree-ten carrier. The failed final substitution in the former degree-ten proof is preserved in the scope-retraction archive and corrected in its Version2. Further work must use the original X maps and actual source; the endpoint derivative gate alone has a genuine moving-origin survivor. Nothing here settles the separate étale or common-quotient atlas gap.

## Final actual consolidation to degree ten

The [reviewed whole large-wild exclusion](large_wild_canonical_spin_carrier_exclusion.md) excludes canonical7000 at every distinguished point and origin, and its retained actual cubic extraction excludes21000. Thus original rows10and11 are excluded for every initial character and projective-kernel choice. They are not merely lowered to an undecided target.

On original row6 the initial character has E=ONE, and the reviewed140 wild/tame position exclusions leave precisely its ordinary four-pair locus. The [actual coarse-factor theorem](wild140_actual_degree_ten_target_lowering.md) gives U=(y+v)²/w⁵ with degreeTEN and β=R(U) of degreeFOURTEEN. The target Γf=Γc k(U) lies insideT and is connected étale overΓc, by the reviewed common-completion argument. Both original endpoint maps, the primitive coefficient and all original spin sections are retained. Its final canonical profile is row1. Including the initial kernel-three extraction when present, the total target degree is14k.

The earlier square-carrier towers already lower original rows2and4 to row1, with target degrees2kand4k. Therefore the only original effective rows not excluded are1,2,4,6, and every one has an actual faithful canonical degree-ten carrier inside the same source. This final claim is a target reduction, not a degree-ten exclusion or an unmarked common-cover decision.
