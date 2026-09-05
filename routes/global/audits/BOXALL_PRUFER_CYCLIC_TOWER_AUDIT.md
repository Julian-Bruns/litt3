# Audit: Boxall-style torsion intersection and cyclic towers

Date: 2026-09-05. Auditor: `/root/gluing_cohomology_rigidity`.
Verdict: **PASS** for the mathematical claims in Sections 1--3, no
breaking gap found.

Theorem: [proof and source comparison](../BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md).

Hash after verdict/audit-link metadata, with mathematical text unchanged:
`2cec40cbc4bd1e97fdfd45d539e87f73f951a1c3f6e9355f3f260ca5dd24abae`.

## Checked points

- Quotienting by the full reduced translation stabilizer is valid,
  including disconnected stabilizers. The inverse-image identity is
  set-theoretic, which suffices. Infinitesimal stabilizers contain no
  nonzero geometric prime-to-characteristic torsion point.
- The Frobenius binomial argument is correct, including the two-primary
  case after trivializing the action modulo four.
- The Frobenius translate needs to stay in the subvariety, not in the
  chosen Pruefer subgroup. No Frobenius-stability of that subgroup is
  assumed or needed.
- In a simple ambient abelian variety every proper subvariety has finite
  reduced stabilizer. Quotienting preserves simplicity and the induction
  gives finiteness for the full primary torsion, not only rank one.
- Finitely many bad characters have bounded order. Frobenius permutes
  characters by p-th powers and preserves exact order, so each later
  new block has injective Frobenius and is ordinary. This controls the
  full nilpotent part, not merely the dimension of the first kernel.
- In the conditional maximal-abelian base-change result the pullback
  onto the simple image is an isogeny, so the bad set has finite preimage.
  Disconnected full fiber products are handled componentwise; component
  counts stabilize and components are conjugate under the deck group.

## Essential retained hypothesis and scope

The restricted theta locus must be proper. Simplicity of the base
Jacobian does not supply properness after a nontrivial initial cover.

The check covers the proofs and character-theoretic input. It is not a
blanket audit of Section 4's independent literature comparisons, nor of
the earlier Raynaud no-theta construction. The root agent also read the
self-contained proof and Voloch's primary presentation of the translation
lemma; no priority assertion is made.

Only verdict/audit-link metadata was added to the checked mathematical
text. This record preserves the delivered report, not private scratch
reasoning or an exported chat.
