# Original canonical tensor global sections independent review

3 October2026. Independent whole-source readback by `/root/jacobians_geometry` of the root-owned `Solutions/SharedTensors/OriginalCanonicalTensorSections.lean`, including the original coefficient maps, actual rational-function evaluation, divisor-section bounds and whole tensor-power definitions used by the new bridge. Mathematical readback accepts the file at its literal scope. Root reported the focused build passed and is running its transitive axiom audit.

Exact SHA-256 source snapshot: `fc922a518885808276d80bf0532c91ffec9573c99af90b266e97c0ce65d0fbe4`.

`actualOriginalModuleGlobalSectionsModule` equips the actual global sections of ANY original module sheaf with the coefficient-field action from the actual structure morphism. It restricts the existing original top-open section-ring action through `chartBaseFieldHom sX ⊤`. There is no substituted section-space model in this definition.

`actualOriginalDivisorGlobalSectionsEquiv` uses the genuine original divisor subsheaf and the genuine rational-function sheaf on the top open. Its forward map takes an actual divisor section to its actual function-field value. Every closed point belongs to the top open, so the actual local valuation bounds give precisely the stated global divisor-section bounds. Conversely, the actual rational-function open equivalence sends any bounded rational function back to a divisor-subsheaf section with those same bounds. The two inverse identities follow from this genuine open equivalence, not from an assumed identification of H0.

The coefficient comparison is explicit: the genuine rational-function open equivalence is linear over the actual ring `Γ(X, ⊤)`, and `chart_base_field_hom_generic_compatibility` proves that a coefficient from the structure morphism has exactly the same generic germ as `genericBaseFieldHom sX`. Thus restricting scalars gives the ORIGINAL k-linear equivalence. The general divisor-global-sections declaration assumes integrality, actual closed-point DVR stalks and finite principal support, together with the original structure morphism and divisor. It assumes no smoothness, properness or dimension bound.

`actualOriginalCanonicalTensorGlobalSectionsEquiv` evaluates the accepted whole-sheaf isomorphism `actualDifferentialTensorDivisorSheafIso` at the actual top open, then composes with the proved divisor-global-sections equivalence. Its source is the literal recursively defined original GLOBAL sheafified tensor power of `schemeDifferentialSheaf sX`, with the original structure module at weight zero. It does not tensor already computed global sections. Evaluation of a module-sheaf isomorphism supplies a linear equivalence over the actual section ring; restricting through the same actual coefficient map supplies the k-linear equivalence on the genuine whole-tensor H0. The target uses the actual divisor `n • actualRationalDifferentialDivisor sX omega h`, for each nonzero original rational differential and every natural weight, including zero.

Focused elaborated-signature readback confirms that the canonical declaration assumes only an integral original scheme, its structure morphism over an algebraically closed field, quasi-compactness and actual smooth relative dimension one, followed by the nonzero original rational differential and weight. It derives both actual DVR stalks and finite principal support internally; neither survives as an external supplied premise. The signature check completed with Lean exit code zero. Its generated source and output are stored outside the workspace at `../litt3-computation-data/formalization-20261003/canonical_tensor_sections_scope_readback.lean` and `../litt3-computation-data/formalization-20261003/canonical_tensor_sections_scope_readback.log`.

No finite-dimensionality, properness, degree, cohomological genus, Riemann--Roch formula, common tensor or common-cover existence is inferred. This evaluates an established whole-sheaf isomorphism and does not assert new strong monoidal pullback coherence or an actual triples-with-isomorphism quotient. The unmarked common-cover problem remains unsolved.

Final focused build and axiom evidence:
`../litt3-computation-data/formalization-20261003/verification/20261003T123013Z/report.json`.
The report audits1402 transitive theorem declarations. Root rehashed all291
captured local sources against it, with zero current mismatches. Only
the standard three logical axioms occur,
with zero forbidden dependencies or source changes.
