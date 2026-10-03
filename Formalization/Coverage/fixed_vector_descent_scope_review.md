# Actual semilinear fixed-vector descent

The new proof concerns actual vector spaces, actual additive operators and the literal additive kernel of the operator minus the identity. It introduces no literature premise or computational certificate. These are general foundations; no canonical source theorem is promoted by this card.

For every perfect field k of characteristic p, every k-vector space V and every additive C satisfying C(a^p v)=a C(v), a family of C-fixed vectors independent over the literal prime subfield of k is independent over k. The family may be infinite; V need not be finite dimensional and C need not be injective, surjective or nonzero. The finite-family proof uses ordinary induction: an expression of the first vector in the span of the tail is compared with its image under C, after extracting actual p-th roots of its coefficients. Independence of the tail forces every coefficient to be Frobenius-fixed, hence to lie in the actual prime subfield. This contradicts the original prime-subfield independence. Finite restrictions give the arbitrary-family result.

If V is finite dimensional over k, a basis of the actual prime-subfield fixed space maps to a k-independent family. The proof derives finiteness of this basis, then derives finite dimension of the fixed space and its bound r<=dim_k(V). The underlying fixed space is identified by the identity on vectors with the literal additive kernel ker(C-id). The proof derives that this group is finite, proves its exact cardinality p^r and the bound p^r<=p^dim_k(V). No dimension or finiteness of the fixed group is supplied as a premise.

The original geometric specializations use the genuine associated differential sheaf's global sections and the actual intrinsic Cartier already constructed on them. The two-endpoint specialization uses the literal intersection of both endpoint H0 images in the SAME source of the original finite étale span. It does not require the endpoint constant-intersection or a rank-one hypothesis. Finite dimension of the actual H0 space, or of the actual shared H0 space, is an explicit hypothesis of these specializations. This card does not derive proper coherent-cohomology finiteness, identify the dimension with genus, or presume a global surjectivity theorem for Cartier.

The field must be perfect for the inverse-Frobenius argument. There is no claim that inverse-power semilinearity alone gives this result over an imperfect field. The source and endpoint smoothness, integral scheme and coefficient-field assumptions in the actual H0 specialization are inherited from the checked intrinsic Cartier construction, not replaced by abstract spaces assigned geometric names.

| New source | SHA256 |
| --- | --- |
| Solutions/CartierAndSpin/InverseFrobeniusFixedIndependence.lean | 707c19f2dcad549a4a94e892c6dd0889655da1de76caf49a54c1fa2844c33c87 |
| Solutions/CartierAndSpin/InverseFrobeniusFixedDimension.lean | e2058929dd7bd7534ef345483efae34bbd0f0dba39c27c3b95053e1b2c5197d0 |
| Solutions/CartierAndSpin/GlobalCartierFixedDimension.lean | 9d7e65ac6004da581a6d65bedff93ad3ad4e18ec87eeb4b45e73c3523b254f25 |

All three modules build. The [focused report](../../../litt3-computation-data/formalization-20261003/verification/20261003T113945Z/report.json) checks the final root together with IntrinsicConnectionInhomogeneousAlternatives: 1,070 transitive Litt3 theorem declarations, only Classical.choice, Quot.sound and propext, zero forbidden dependencies and zero source changes. The exact new source hashes above are in that report. An independent mathematical readback has not yet been recorded.
