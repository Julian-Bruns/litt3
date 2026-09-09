# First Frobenius instability has an exact dormant-bundle model

Version2,2026-09-09. Author proof; NEW second-height family exclusion
passed a focused independent medium audit. Earlier Sections1--4 were
inputs to that audit, not re-audited.
Use the dormant tangent bundles V_r from
[projective connections](../Definitions/Def_projective_connections.md).

Let C have genus2 in characteristic5 and let

    0 -> O -> E -> omega -> 0

be a nonsplit pointed extension. If n>=1 is the first index for which
F^(n)*E is unstable, put b=5^(n-1). At the final relative Frobenius step
F:C0->C1 there exist a regular dormant connection r on C0 and
tau1 in Pic(C1)[2] such that

    F^(n-1)*E ≅ V_r tensor omega_(C1)^((b-1)/2) tensor tau1.       (1)

All earlier Frobenius twists are retained in F^(n-1)*E; alternatively
one may transport them by the perfect constant field. The isomorphism
comes from an isomorphism of the ACTUAL flat connections after the final
pullback, not just equal degrees or projective bundles.

In particular the pointed extensions destabilized at the FIRST step are
exactly the bundles V_r tensor tau1 that have a nonzero section. Such a
section is automatically nowhere zero, is unique up to a scalar, and
gives the required nonsplit extension with quotient omega_(C1).

Consequently, if H0(V_r tensor tau1)=0 for every dormant r and every
tau1 in Pic(C1)[2], then EVERY such pointed extension is semistable after
its first Frobenius pullback. This applies to the CURRENT high-degree
genus-two Y_t, by genus_two_active_critical_quartics, and to all its
constant-field Frobenius conjugates.

For a common nonzero curve tangent in joint_tangent_clump_dormancy this
initially strengthens n>=1 to n>=2. At n=2 the distinguished section instead lies
in H0(V_r tensor omega^2 tensor tau1), of dimension8. For n>=2 the space
in(1) has dimension2(5^(n-1)-1). The endpoint tangent vanishings do NOT
exclude these positive twists. No all-index strong-semistability assertion
or common-cover exclusion follows from this identification alone.

## Second-height exclusion for the family

For C_t: v²=u(u-1)(u-2)(u-3)(u-t), EVERY nonsplit pointed extension
0->O->E->omega has semistable F^(2)*E if

* [F5(t):F5]>600000; or
* t=alpha with alpha³+alpha+1=0.

The complete specialized test checks all16 two-torsion labels and all3
projective extension charts, with exact Bezout identities and both parity
blocks. It replays in22.252 seconds on one core. The transfer to high
parameter degree uses a nonzero polynomial of degree<=597246 whose
existence follows from an explicit cohomology matrix and a Koszul degree
bound. No experimental generalization from one specialization is made.

Thus on the CURRENT high-degree Y_t, and on the backup C_alpha, a nonzero
shared curve tangent has first instability index n>=3. At n3 the model
has a48-dimensional positively twisted section space, not an automatic
contradiction. No ALL-height strong-semistability or common-cover claim.

[Proof](../Solutions/Sol_pointed_frobenius_dormant_model.md) ·
[Complete exact run](../Research/computations/pointed_frobenius_height2_verified.jsonl).
