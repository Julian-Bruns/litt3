# Independent fixed-vector descent review

3 October2026. Root read the ENTIRE three new implementation files:
`FieldEndomorphismFixedIndependence`, `FieldEndomorphismFixedDimension` and
`FrobeniusFixedDimension`, including every quantified hypothesis and proof.
The stated [scope](field_endomorphism_fixed_descent_scope_review.md) is accepted.

For ANY field endomorphism sigma and genuine additive sigma-semilinear
operator C, independence of actual fixed vectors over the LITERAL scalar
equalizer subfield implies independence over the ambient field. This holds
for arbitrary, including infinite, families, with neither scalar
surjectivity nor C invertibility. The finite-family proof normalizes a
putative dependence, uses independent tail coefficients, applies C to the
same dependence and deduces that each coefficient belongs to the actual
equalizer. It does not assume a fixed basis or invoke descent as an input.

With finite ambient dimension, the actual fixed subspace has finite
fixed-field dimension bounded by ambient dimension. If the literal scalar
fixed field is finite, the actual additive fixed kernel is finite, with
the exact cardinal formula and the stated bound. The subtype equivalence
is identity on original vectors. Basis finiteness and dimension are
derived from the proved independence implication. No rational-points
group is confused with a scheme-theoretic kernel.

The forward-Frobenius specialization identifies the scalar equalizer
with the true prime subfield and proves the p^dimension bound even for
IMPERFECT fields. Inverse-Frobenius Cartier specializations still require
perfectness; no existence of a full fixed basis or equality with the
upper bound is claimed.

Root independently checked all four current local hashes against the
[21-declaration focused report](../../../litt3-computation-data/formalization-20261003/verification/20261003T114436Z/report.json).
All match; build/audit return zero, only the three standard logical axioms,
no forbidden dependency and no changed captured source.
