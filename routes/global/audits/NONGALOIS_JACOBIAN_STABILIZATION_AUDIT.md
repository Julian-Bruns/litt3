# Audit: non-Galois Jacobian orthogonality and etale-map stabilization

Date: 2026-09-05. Verdict: **PASS**, no breaking objections.

Theorem: [consolidated proof](../NONGALOIS_JACOBIAN_ORTHOGONALITY_AND_ETALE_MAP_STABILIZATION.md).

Auditors:

- `/root/x_elliptic_quotient_maps`: Sections 2, 4--6, 8 and comparison with
  the former Galois-only theorem; read the consolidated text completely.
- `/root/gluing_cohomology_rigidity`: whole-Jacobian descent, trivial
  Abel-curve translation stabilizer, ordinary-Prym corollary and uniform
  finiteness of target curves. Delivered proof-level check, rather than
  a separately hashed reading of the final consolidated document.
- Earlier independent checks: `/root/canonical_trace_algebra` on the
  dimension-at-least-two Galois case; `/root/gluing_cohomology_rigidity`
  on elliptic factors; `/root/x_elliptic_quotient_maps` on graph fields.

Reviewed consolidated hash before the suggested wording/metadata changes:
`810a2254dacf3e1d7c90f45d70373953ddfd6fb6aa456e0e4e55e8d2d4429127`.

Consolidated hash after precisely those nonbreaking wording changes and
the audit/status metadata:
`f8d62f278ee9adcafdfa35750005a25f62643a8c0858d68659a16987bc962c4d`.

## Principal checks

Clearing the norm-Hom denominator gives an identity `[N]ar=bq+c`.
Subtracting on the ACTUAL fiber product cancels the constants and places
the difference in the finite group scheme `A[N]`. Its connected proper
reduced components map to single geometric points, including when the
characteristic divides `N`. Translation stabilizers, or the fixed
nonempty branch-value set in the elliptic case, give the uniform joint-
image degree bound. Inverse Frobenius twisting preserves the isogeny
class and makes the elliptic map separable. Both joint-image maps remain
etale. Bounded covers must be counted as embedded fields, not merely
abstract curves. In the graph application include entire path fields.

For exact whole-Jacobian descent, a translation preserving a hyperbolic
Abel--Jacobi curve acts freely and induces the identity on its Jacobian.
The norm identity and etale Riemann--Hurwitz force the translation to be
trivial, including characteristic-divisible finite groups. Descent then
uses the actual equivalence relation. Ordinary Pryms are orthogonal to
Jacobians with no ordinary simple factor. Bounded outgoing etale degrees
and Galois-closure finiteness give finitely many varying target curves.

## Nonbreaking suggestions, incorporated

1. Theorem C says maps from sufficiently high levels descend; maps from
   earlier levels first pull up to the chosen common level.
2. Retain explicitly the warning that fixed prime support and bounded
   one-step monodromy do not bound total defect.
3. Distinct graph vertices directly give distinct maps; infinitely many
   distinct image fields additionally uses finite endpoint automorphisms.
4. Retain the denominator cancellation in the curve-map identity, not
   only an unpointed statement about induced Jacobian homomorphisms.

The auditor explicitly checked that the old Galois theorem, exact deck
invariance, elliptic bound, coreless amplification, defect corollary and
fixed genus-nine scope are subsumed. Deleting that special-case note
does not remove a mathematical result. This audit is not a solution of
the remaining core-tower boundedness problem or a claim of novelty.

This record preserves delivered verdicts and objections, not private
scratch reasoning or a complete conversation export.
