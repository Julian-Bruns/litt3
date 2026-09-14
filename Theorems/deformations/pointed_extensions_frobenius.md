# Pointed genus-two extensions under Frobenius

Let k be algebraically closed of characteristic5, let C have genus2,
and let 0→O→E→omega→0 be a nonsplit pointed extension.
Use the [dormant tangent bundles](../projective_connections/tangent_bundle_cyclic_refinements.md)
V_r, on the scalar Frobenius twist.

If h>=1 is the first index for which F^(h)*E is unstable, put
b=5^(h−1). At the final relative Frobenius step F:C0→C1 there are a
regular dormant connection r on C0 and tau1∈Pic(C1)[2] such that

    F^(h−1)*E ≅ V_r⊗omega_(C1)^((b−1)/2)⊗tau1.             (1)

The isomorphism is Cartier descent of an isomorphism of the actual flat
connections. Earlier scalar twists are retained, or transported through
the perfect constant field.

The extensions destabilized at the first step are exactly the bundles
V_r⊗tau1 with a nonzero section. That section is nowhere zero and unique
up to scalar, and its quotient is omega_(C1). Thus vanishing of all these
section spaces is equivalent to first-pullback semistability of every
nonsplit pointed extension.

For h>=2, the section space of the bundle in (1) has dimension

    2(5^(h−1)−1).

Its sections must still arise from the original pointed extension.
The dimensions eight at h=2 and48 at h=3 do not themselves exclude
instability.

For the family C_t:v²=u(u−1)(u−2)(u−3)(u−t), every nonsplit pointed
extension has semistable F^(2)*E whenever

    [F5(t):F5]>32760,   or   t=alpha with alpha³+alpha+1=0.  (2)

The specialization is checked by32 nonzero determinantal resultants:
one for each parity block of each of the sixteen two-torsion labels.
The transfer in (2) uses their polynomial degree bounds.

Consequently, for an actual coreless bi-étale span over bar(F5) with
such a genus-two endpoint, any nonzero
[joint curve tangent](pointed_bundle_instability.md) has first
Frobenius-instability index at least three. Semistability at all heights
and exclusion of the span remain open.

Version3,2026-09-14. The cohomology construction and precision retain the
original second-height audit; a bounded medium check covers the published
determinantal criterion and sharpened degree sum. The general quotient-jet
identification retains author-proof status.
[Proof and verifier](../../Proofs/deformations/pointed_extensions_frobenius.md).
