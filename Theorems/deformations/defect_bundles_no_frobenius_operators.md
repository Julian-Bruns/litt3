# One-step defect bundles admit no Frobenius or Cartier operators

Version1,2026-09-09. Elementary author proof; no novelty claim,
independent audit, or common-cover exclusion.

Let C be a smooth projective connected curve of genus at least2 over
an algebraically closed field of characteristic p. Put D=C^(1) and let
F denote ABSOLUTE Frobenius on D. Consider the following bundles on D:

- Raynaud's B_C, in every characteristic p;
- in characteristic5, the dormant tangent bundles V_r and admissible
  active tangent bundles E_r of tangent_bundle_cyclic_refinements.

Let A,B be any two bundles from this list, and let L,M be arbitrary
degree-zero line bundles on D. Then for EVERY integer e>=1,

    Hom_D(A tensor L, F^e_*(B tensor M))=0,
    Hom_D(F^e_*(A tensor L), B tensor M)=0.               (1)

In particular no such twisted defect bundle admits a nonzero Frobenius
module structure or Cartier module structure at ANY level. This excludes
arbitrary proposed operators, not only the natural zero operator.
The assertion persists on every actual connected finite étale cover.

If a:D→A0 is finite and birational onto its integral image in an abelian
variety, (1) also holds for the pushed-forward bundles on A0, with
absolute Frobenius F_(A0). In particular this applies to the two-leg Abel
map of an ACTUAL jointly minimal finite bi-étale span. Singularities of
its image do not provide extra operators.

The proof uses a general criterion: a bundle has no maps from positive
canonical powers, no maps to nonpositive canonical powers (all with
degree-zero twists), and its first Frobenius pullback has, after some
finite étale cover, a filtration with quotients omega^a tensor T where
1<=a<=p-1 and deg T=0. Any two such bundles satisfy (1).

Scope: this explains why Cartier-crystal generic-vanishing theorems do
not DIRECTLY control these one-step defects: the only available module
structure is zero and its crystal is zero. It does not rule out using
larger complexes or retaining the finite-level extension data. It proves
neither restricted-theta properness nor ordinary common-source pullback.

[Proof](../../Solutions/deformations/defect_bundles_no_frobenius_operators.md).
