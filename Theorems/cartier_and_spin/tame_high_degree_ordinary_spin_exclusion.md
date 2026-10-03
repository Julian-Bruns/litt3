# Ordinary distinguished fibers force small Abel torsion in degrees18,24,42

Version2,3 October2026. The Version1 scope passed [independent whole-implication review](../../Research/audits/TAME_HIGH_DEGREE_ORDINARY_SPIN_AUDIT_2026_10_03.md): all three Weierstrass reductions, the first degree18 and noncanonical degree24 deletions, and both degree12 signatures. Version2 adds the middle degree18 weight(1,1,2), which passed the [whole ordinary degree18 audit](../../Research/audits/ORDINARY_DEGREE_EIGHTEEN_SPIN_EXCLUSION_AUDIT_2026_10_03.md).

Retain BOTH actual finite étale maps from the SAME source, the actual minimal Galois spin source q:T→Y, its normalized separating spin map φ:T→Γ, and the canonical different section with divisor q*P and index two there. Assume the projective action kernel is trivial, the distinguished Γ stabilizer has order ONE, and the actual degree κ is18,24 or42. The distinguished point P must be WEIERSTRASS on BOTH selected endpoints. Both noncanonical degree18 weights and the noncanonical degree24 weight are impossible.

The canonical degree18 weight is excluded by the subsequent [whole ordinary(2,3,9) theorem](canonical_nonic_triangle_ordinary_spin_exclusion.md), accepted in the same whole degree18 audit. Thus ALL ordinary degree18 weights are excluded on BOTH endpoints.

The canonical degree24 weight is excluded by the subsequent [whole ordinary(2,3,8) theorem](canonical_octavic_triangle_ordinary_spin_exclusion.md), which passed its [independent audit](../../Research/audits/CANONICAL_OCTAVIC_TRIANGLE_ORDINARY_SPIN_AUDIT_2026_10_03.md). Thus ALL ordinary degree24 weights are excluded on BOTH endpoints.

Forκ12 with signature(2,3,12), ALL ordinary distinguished-fiber weights are excluded on BOTH endpoints. The remaining non-Weierstrass weight forces12[P−O]=0, contradicted by the computation-free [twelve-torsion specialization bound](../jacobians/torsion/family_twelve_torsion_abel_exclusion.md).

Forκ12 with signature(2,4,6), ALL ordinary distinguished-fiber weights are also excluded on BOTH endpoints. Its norm pole-ten condition removes a possible lower odd term from the pole-six invariant generator; hyperelliptic parity then forces the forbidden even primitive polynomial.

The direct proof uses the accepted tame signature classification, different primitivity, primitive-even-polynomial obstruction, selected non-Weierstrass Abel torsion exclusions for orders SIX and FOUR, and the accepted twelve-torsion lemma for degree12. The first degree18 weight is excluded by a complete order-three fiber and a reflected cube identity; the middle weight uses an actual differential and exact divisor identities. These direct arguments require no computation. The linked canonical degree18 and degree24 theorems use their separately recorded finite Cartier checks and specialization bounds.

More generally, in the ordinary distinguished-fiber setting the triangle line N=M¹⁶ωΓ^-1 satisfies
\[
\mathcal O_Y(2P)\otimes\omega_Y^{-1}=f^*(N\otimes\omega_{\mathcal B}^{-1}),\qquad \mathcal B=[\Gamma/G].
\]
For signature(2,3,9), this class has order dividing THREE; for(2,3,8), order dividing TWO; for(2,3,7), it is trivial. Thus P is Weierstrass on the selected endpoints. A conditional hyperelliptic parity criterion remains for degree42, but polynomiality of its even-pole generators is UNPROVED and is not part of this statement.

The degree42 weight remains open. The subsequent accepted [canonical degree42 reduction](canonical_septic_triangle_ordinary_spin_reduction.md) excludes its invariant pole-six generator case, so every surviving ordinary degree42 candidate has F=U3+v y with v≠0. Distinguished cone fibers and projective-kernel-three cases are also outside this statement. No unmarked common-cover decision follows.

[Proof](../../Proofs/cartier_and_spin/tame_high_degree_ordinary_spin_exclusion.md).
