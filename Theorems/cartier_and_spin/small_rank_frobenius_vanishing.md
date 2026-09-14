# Small stable factors exclude Frobenius and Cartier operators

Version2,2026-09-14. Corollary of Sun's Frobenius stability theorem.

Let D be a smooth projective connected curve of genus g>=2 over an
algebraically closed field of characteristic p>0, and F its absolute
Frobenius. Let A,B be semistable bundles of slope g−1, all of whose
stable Jordan–Hölder factors have rank below p. Total rank below p is
a sufficient condition. For degree-zero line bundles L,M and every e>=1,

    Hom_D(A tensor L,F^e_*(B tensor M))=0,
    Hom_D(F^e_*(A tensor L),B tensor M)=0.               (1)

The hypotheses and vanishing persist after any connected finite étale
pullback, allowing arbitrary new degree-zero twists on the cover.

This applies to Raynaud's B_{1,C} on D=C^(1) in every characteristic,
and in characteristic5 to the dormant tangent bundles V_r and admissible
active tangent bundles E_r of
[tangent_bundle_cyclic_refinements](../projective_connections/tangent_bundle_cyclic_refinements.md).
In particular every Frobenius or Cartier module operator on any such
twisted bundle, at any level, is zero.

If a:D→A0 is finite and birational onto its integral image in an abelian
variety, (1) also holds for a_*(A tensor L),a_*(B tensor M), using absolute
Frobenius on A0. This includes the two-leg Abel map of an actual jointly
minimal finite bi-étale span.

The associated Cartier crystal is therefore zero; its ordinary
cohomology need not vanish. The result does not control larger complexes
or the finite-level extension data.

[Proof and sources](../../Proofs/cartier_and_spin/small_rank_frobenius_vanishing.md).
