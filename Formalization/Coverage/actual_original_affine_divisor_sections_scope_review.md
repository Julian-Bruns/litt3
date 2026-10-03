# Original global divisor-sheaf sections and affine fractional ideals

The terminals `Solutions.Jacobians.SmoothCurveAffineDivisorSections` and `Solutions.Jacobians.AffineDivisorSectionValues` identify the ACTUAL affine sections of the ACTUAL global valuation-bounded divisor SHEAF with the true fractional ideal in the ORIGINAL generic-stalk function field. The identification preserves the entire original rational function and the original coordinate-ring scalar action. This is distinct from the earlier construction of an associated sheaf of a fractional ideal on Spec R: the new comparison starts from the original global scheme divisor SHEAF and its genuine open sections.

The smooth-curve terminal assumes only an original integral scheme X, an actual smooth relative-dimension-one structure morphism over algebraically closed k, and an original nonempty affine open U. Every characteristic is included. Quasi-compactness and properness are unnecessary for this affine comparison. Original closed DVR stalks, Jacobsonness, Dedekindness of the original coordinate ring, its non-field condition, its actual fraction-field structure, and the original point/prime correspondence are all derived.

`AffineChartClosedPointEquivalence` proves the actual original closed points in U are equivalent to the true height-one coordinate-ring prime ideals. Closedness transfers through the actual chart open immersion in the original Jacobson space. There is no point enumeration, residue-field parametrization or surrogate abstract point set.

`DedekindLocalValuationIntegers` proves that an actual localization at a true Dedekind prime is exactly the integer ring of its true prime valuation in the original field. The reverse direction constructs locally coprime original numerator/denominator representatives from genuine fractional ideals. No global PID, chosen prime generator, valuation-compatibility assumption or pole test is supplied. `NormalizedValuationUniqueness` proves equivalent actual integer valuations coincide when both have actual value-one uniformizers. `DedekindLocalValuationComparison` then derives the exact equality of the original DVR normalized valuation and original coordinate-prime normalized valuation on the ENTIRE original function field.

`AffineChartValuationComparison` supplies the literal chart/stalk localization and scalar tower from the true original scheme maps. The global divisor restricts through the proved original point equivalence to an actual finite-support divisor on the original coordinate ring. The ideal for O(D) is the actual prime ideal product with exponents −D. Its true membership condition is exactly v(f)≤exp(D) at every original prime, including f=0. Hence the honest global rational-function SHEAF evaluation gives a genuine linear equivalence of original O(D)(U) with that actual ideal. Its inverse proves full actual section-surjectivity; the entire original rational function is unchanged.

These actual affine section modules are invertible over the actual coordinate ring, by the constructed true invertible fractional-ideal module and the actual linear equivalence. This does NOT assert that global sections on a proper curve are invertible modules, that a proper global pointwise tensor-section presheaf is already a sheaf, or that geometric Picard/Jacobian classes are realized. Associated-sheaf comparison on every chart subopen, global sheaf-isomorphism/principal detection and classification of all line sheaves are later bridges.

The two terminal roots passed the focused transitive axiom audit [20261003T092312Z](../../../litt3-computation-data/formalization-20261003/verification/20261003T092312Z/report.json): 491 Litt3 theorem declarations, only Classical.choice, Quot.sound and propext, zero forbidden dependencies and zero changed sources. The exact report records every imported local source hash. The earlier global O(D) line-SHEAF terminal has independently accepted scope and a separate 415-declaration PASS report 20261003T090740Z. These are distinct verified checkpoints.

New source chain:

- AffineChartClosedPointEquivalence.
- NormalizedValuationUniqueness; DedekindLocalValuationIntegers; DedekindLocalValuationComparison.
- AffineChartValuationComparison; AffineChartDivisorRestriction.
- DedekindSectionFractionalIdeals; RationalFunctionOpenLinearEquivalence.
- AffineDivisorSectionMembership; AffineDivisorSectionsFractionalIdeals; AffineDivisorSectionValues.
- SmoothCurveAffineDivisorSections.

The parent independently read all twelve sources, checked their exact hashes against the 491-declaration capture, and accepted the stated mathematical scope. Its separate [independent review](actual_original_affine_divisor_sections_independent_review.md) records the normalized valuation argument, local coprime fractions, original point/prime correspondence, sign, full original field, scalar action and actual affine-section invertibility.
