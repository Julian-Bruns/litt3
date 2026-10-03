# Proof: native degree, proper Cartier fiber, and exact-divisor torsion

Version1,3 October2026. Whole independent review **PASS** in the [audit](../../Research/audits/PROPER_CARTIER_ETALE_ATLAS_WILD_GENERALIZATION_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/proper_positive_cartier_etale_atlas_wild_exclusion.md). This proof isolates the rank-independent argument of the accepted [rankTHREE wild proof](rank_three_etale_row_depth_free_wild_reduction.md). No computation is used.

Write N=|R|, e=degρ and n=g(D)−ONE. Étale Hurwitz gives en=N. Faithfulness on D and Gal(C/Y)=R give the embedded field identity C=Y D. Thus Y→D/R is an actual degree-e uniform quotient-stack atlas, with the FULL completed Galois local extensions of D→D/R.

The native invariant image K_D has a genuine linearization, so its determinant of degree n does as well. Hilbert90 supplies an invariant rational determinant section. Every orbit has degree N/i_z, where i_z is its stabilizer order. Meanwhile each stabilizer acts freely on an e-point ρ-fiber, so i_z divides e. If ℓ is their lcm, the determinant degree gives N/ℓ dividing N/e. Thus ℓ=e. This is the [native determinant argument](rank_three_etale_row_native_determinant_constraints.md), which uses neither rankTHREE specifically nor a scalar splitting.

Suppose a wild inertia exists. Then e>ONE. The genus-two coarse Hurwitz argument gives D/R=P¹. Genus at leastTWO would force e=ONE. GenusONE would give total normalized different TWO/e, whereas any wild inertia i contributes at least ONE+THREE/i>ONE and e≥i≥FIVE; this is impossible. No small elliptic-map exclusion is required.

A wild different is at least its inertia order plusTHREE. The rational quotient area is TWO/e, so there are at mostTWO branch values and at mostONE wild value. First consider a sole wild value. By ℓ=e its order is i=e=wh. Its positive different sum is \mathcal D=wh+THREE. The general local tame constraint h|\mathcal D forces h dividingTHREE. All positive ramification groups are FIVE-groups, so FOUR divides \mathcal D. Since w is ONE moduloFOUR, this excludes h=THREE and forces h=ONE. The proper Cartier gate gives first break at leastTWO, hence \mathcal D≥TWO(w−ONE). If w≥TWENTY FIVE this contradicts \mathcal D=w+THREE. Thus w=FIVE, the sole break isTWO, and the original Y→P¹ map has one pole Q of indexFIVE and differentTWELVE. Its coordinate β has div(dβ)=TWO Q, a nonzero regular exact differential on ordinary Y. Contradiction. Hence precisely ONE wild and ONE tame value occur, without needing an odd-atlas theorem or an a priori evenness assumption.

Let the wild inertia order be w h, with w=|I₁| a FIVE-power, and let j be the tame inertia order. Put g=gcd(h,j). With \mathcal D=Σ_{a≥ONE}(|I_a|−ONE), the lcm and area equations give
\[
e=whj/g,\qquad j(\mathcal D-1)=wh+2g.
\]
Because \mathcal D is even, this identity forces h and j to have the same TWO-part. Write h=gH,j=gJ, with coprime ODD H,J. The accepted [local tame constraint](../../Theorems/quotient_geometry/local_actions/ramification_constraints.md) gives h|\mathcal D, hence H|J+TWO and
\[
J\mathcal D=wH+J+2.
\]
The [proper Cartier-image theorem](proper_cartier_image_excludes_first_wild_break_one.md) applies to EVERY rank at mostTHREE. Surjective adjunction therefore forces the first wild break b≥TWO, so \mathcal D≥TWO(w−ONE). Also FOUR divides \mathcal D, since every nontrivial positive ramification group is a FIVE-group.

If w≥TWENTY FIVE, then \mathcal D>w+THREE, so H>J. An odd divisor H of J+TWO greater than J must equal J+TWO. Consequently J\mathcal D=(w+ONE)(J+TWO), which is TWO moduloFOUR, whereas its left side is ZERO. Thus w=FIVE. Its sole break b has \mathcal D=FOUR b. If b≥THREE the same argument applies. Hence b=TWO. The equation SEVEN J=FIVE H+TWO forces H=J=ONE, and h divides b(w−ONE)=EIGHT. Here j is the inertia order of the ACTUAL second branch value, so j>ONE. Thus h=j∈{TWO,FOUR,EIGHT}, e=FIVE h and δ_wild=FIVE h+SEVEN; no prior even-atlas hypothesis is used.

Normalize the actual quotient coordinate β to have its pole at the wild value and its zero at the tame value. The original Y-map has one wild pole Q of index FIVE h and FIVE tame zeros R_ν of index h. Thus divβ=hΣR_ν−FIVE hQ. The connected normalization f:Y′→Y in k(Y)(β^(ONE/h)) is cyclic étale of degree d dividing h. Its separating root v has exact differential divisor
\[
\operatorname{div}(dv)=2f^*Q:
\]
at Q the order is SEVEN−FIVE h+FIVE(h−ONE)=TWO; at every R_ν it is h−ONE−(h−ONE)=ZERO; there is no other ramification or differential zero. Norm therefore gives TWO d[Q−O]=ZERO. As d divides EIGHT, SIXTEEN[Q−O]=ZERO.

The selected [MAIN thirty-two Abel theorem](../../Theorems/jacobians/torsion/family_thirty_two_torsion_specialization.md) and [BACKUP two-primary Abel theorem](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md) force Q to be Weierstrass. The [general exact-divisor torsion obstruction](../../Theorems/jacobians/ordinary_covers/etale_exact_differential_single_point_torsion_obstruction.md) now contradicts ordinarity of Y. This excludes every attempted wild target inertia, with no cyclic-cover ordinarity input, inertia-depth cutoff or constant-module dimension bound.

All fields and covers used here are actual. The proof does not change either original common-cover leg or infer a lower X-map.
