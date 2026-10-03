# Independent review of arbitrary-series quadratic truncation

Root read the full new `Solutions/Deformations/PreparedQuadraticTruncation.lean`
and the direct proof inputs `PreparedQuadraticFrobenius`,
`TruncatedCoefficientWeierstrass`, `TruncatedMonomialFrobenius`,
`PreparedQuadraticConstantOrder`, `QuadraticIdealFrobenius` and
`QuadraticFrobeniusRedundancy`. The existing lower-variable quotient,
augmentation nilpotence, dimension and Weierstrass foundations remain
previously checked inputs; this review does not repeat their settled audits.

The new result is accepted in its precise scope: an arbitrary original
g in A[[X]], where A=K[y_i]/(y_i^(q_i)), q_i>0, char(K)=p prime,
2 is invertible, Q=p^n is odd and sum_i(q_i-1)<Q-1. With the literal
augmentation ideal J, the original conditions g_0 in J^2, g_1 in J,
g_2 outside J imply dim_K A[[X]]/(g,X^Q)=2 product_i(q_i).

The direct derivation checks the following points.

- The three unchanged coefficients imply residue order exactly two;
  only indices zero and one lie below two. The residue series is
  therefore nonzero. Neither conclusion is a supplied hypothesis in
  the coefficient-only version.
- The derived whole-ideal cutoff is J^(Q-1)=0. The original strict
  degree inequality has the correct one-step boundary and is retained.
- Weierstrass preparation yields a genuine monic quadratic polynomial
  and series unit. Multiplication by the inverse constant unit preserves
  the ORIGINAL J^2 constant condition, including zero divisors in A.
- Square completion puts the remainder in J^2 and the translation in J.
  Their actual powers vanish by the whole cutoff. The Frobenius
  translation fixes the original X^Q relation; hence X^Q belongs to
  the ORIGINAL ideal (g), rather than an unrelated normal-form ideal.
- The genuine Weierstrass quotient equivalence gives a free rank-two
  algebra over the SAME A. Its K-dimension is the proved original
  product of q_i. No enumeration or assumed length is used.
- The finite-coordinate wrapper constructs locality, completeness and
  invertibility of two. The explicit base-field input is invertible two.
  The n=0 boundary is not silently admitted: its degree inequality fails.

This is a component of `frobenius_truncated_hypersurfaces`, not a whole
source completion. The original multivariate-series quotient comparison
and coefficient transport are now complete in the separate Part1 bridge.
Subsequent balanced binary, rank-one and balanced formal-type proofs,
and the entire actual toric basis/formulas, are complete too; their exact
reviews are linked in
[the consolidated source card](frobenius_truncated_hypersurfaces_scope_review.md).
Only the unequal nondegenerate-plane actual compatible-change construction
remains a whole-source gap. This component's mathematical scope is unchanged.
The scoped owner review records the exact canonical statement and proof
hashes. Its useful stronger arbitrary-series special case is retained.

Focused report
`../../../litt3-computation-data/formalization-20261003/verification/20261003T120928Z/report.json`
audits 114 declarations, only `Classical.choice`, `Quot.sound`, `propext`,
with zero forbidden dependencies or changed sources. Root independently
rehashed all 32 captured local sources: zero mismatches. The new leaf SHA256
is `a1e0357fd57af9405b009654940e9bc6423d05159208551b292a137bae56a005`.
