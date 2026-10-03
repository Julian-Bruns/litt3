# Actual field-endomorphism fixed-vector descent

This widening removes every characteristic and perfectness assumption from the general semilinear descent statement. Let sigma be ANY actual field endomorphism of k. Let C be ANY actual additive operator on a k-vector space V satisfying C(a v)=sigma(a) C(v). The scalar field in the theorem is the literal equalizer subfield sigma.eqLocusField(id), not a separately supplied field identified by a name. A family of C-fixed vectors independent over this actual equalizer is independent over k. The family and ambient vector space may be infinite. Neither sigma nor C is required to be surjective, and C is not required to be injective or nonzero.

For a finite family, the proof compares the coefficients of an actual span expression with those of its image under C. Independence of the tail forces sigma(c_i)=c_i, giving literal equalizer-subfield coefficients and contradicting the original fixed-field independence. Arbitrary families follow by finite restrictions. This proof uses no root extraction.

If the ambient k-space is finite dimensional, the proof derives finite dimension of the actual fixed space over the equalizer, with fixed-field dimension at most ambient k-dimension. An identity-on-vectors additive equivalence identifies that actual submodule with the literal ker(C-id). If the actual scalar equalizer field is finite of size q, the proof derives finiteness of the literal fixed group, its exact cardinality q^r and the bound q^dim_k(V). Finiteness of the fixed group is not an input.

The forward-Frobenius specialization proves the actual equalizer of x |-> x^p is exactly the literal prime subfield and hence has p elements. It gives arbitrary-family independence descent and the finite fixed-group bound p^dim over ANY characteristic-p field, including imperfect fields. This differs from the inverse-Frobenius specialization, where perfectness supplies actual inverse Frobenius. No false inverse-Frobenius theorem over imperfect scalars is asserted.

| New source | SHA256 |
| --- | --- |
| Solutions/CartierAndSpin/FieldEndomorphismFixedIndependence.lean | c7e345a9b98faf4977a4ffcc161b1178e9468b3376322a37cb81b12fd078a840 |
| Solutions/CartierAndSpin/FieldEndomorphismFixedDimension.lean | 792c25594c578c78713c4a4d5310257d7fcf35a4c225c0ba87b7fb4ed450ae5c |
| Solutions/CartierAndSpin/FrobeniusFixedDimension.lean | 944e6d21027060bce1d056908063b914fb653dfdde8cd324ab0ababa651785d2 |

The [focused report](../../../litt3-computation-data/formalization-20261003/verification/20261003T114436Z/report.json) checks the final root and the complete local import closure: 21 transitive Litt3 theorem declarations, only Classical.choice, Quot.sound and propext, zero forbidden dependencies and zero source changes. The module builds. Root's [independent full three-source readback](field_endomorphism_fixed_descent_independent_review.md) accepts the exact mathematical scopes and independently rechecks all four current captured hashes. No fixed-basis existence theorem is inferred. These are generic foundations and no canonical source completeness status is changed.
