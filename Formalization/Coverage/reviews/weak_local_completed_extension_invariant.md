# Weak completed-extension exact source review

Source: `Theorems/quotient_geometry/weak_local_completed_extension_invariant.md`, Version 1, 3 October 2026.
Status: complete at Version1 source scope. Independent reviewer `/root` read every clause,
then the broader rational-product and arbitrary-fiber constant modules, and accepted the
whole exact scope on 3 October 2026. The focused trust checkpoints below all passed.
The table records literal proved clauses; it does not decide the unmarked common-cover problem.

The original positive parameter is b=beta^(-1) in k[[t]]. Its actual order is p*h.
`positive_parameter_canonical_factor` extracts its coefficient unit and the zero constant term is derived.
`weakValuativeDifferentProfile` is the concrete proposition that the ORIGINAL fraction-field extension
induced by full substitution is separable and its genuine trace-defined different ideal is (t^(p*h+p-2)).
The downstairs ring is a universe-lifted copy of k[[b]], retaining a distinct actual algebra action.
This profile contains no root, normal form, Galois, action, scalar or isomorphism input.
The full actual ring power basis and fraction-field degree p*h are constructed.

| Exact original clause | Checked declaration or bridge |
| --- | --- |
| ANY h-th root has full expansion alpha*t^(-p)+gamma*t^(-1)+r with nonzero alpha,gamma | `weak_valuative_different_all_roots_normal_form` derives both orders, nonzero scalar and the entire power-series tail for EVERY root. Other roots' orders are derived from genuine constant root scaling |
| ENTIRE extension is automatically Galois | `weak_valuative_different_extension_galois` proves actual IsGalois for the original full Laurent embedding before normalization |
| Inertia C_p semidirect C_h; lower wild break one | `weak_valuative_different_full_ramification` gives the ENTIRE actual fixed-base automorphism group, original integral action, G0=G, cyclic G1 of cardinal p, Gi=1 for i>=2, and order preservation for ALL Laurent elements. `weak_affine_semidirect_cyclic_factors_and_card` proves both actual cyclic factor cardinalities |
| h-th-root independence | `weak_tame_root_scalar_independent`; the paired classification also holds for EVERY original root choice |
| Uniformizer independence | `weak_valuative_different_every_uniformizer_scalar_independent` starts with ANY order-one uniformizer, constructs the ENTIRE constant-preserving coordinate automorphism and proves scalar invariance for ANY original root. The full Laurent chain rule and automatic order transport derive the changed weak orders. Original DVR parameter changes are also constructed |
| TWO original extensions over the SAME fixed whole K are isomorphic iff scalars agree | `weak_two_valuative_different_profiles_equiv_iff` derives both weak roots and orders from the two genuine profiles, then classifies ENTIRE fixed-base fields for EVERY chosen root pair |
| Actual original curve completion is the full parameter map | `completedDVRLaurentMap_eq_actual_parameter_substitution` identifies the ENTIRE original completed fraction-field map with full substitution by the complete expansion of the original stalk parameter image. Continuity or truncation is not assumed |
| BOTH actual maps of the SAME global source force equality on the whole original fiber | `actual_galois_smooth_same_source_original_profile_scalars_equal` uses true finite etale surjective T->Y and true finite T->Gamma unramified over the WHOLE selected base fiber, plus actual finite Galois Gamma->B and the true commuting diagram. Original completed parameter expansions and field identifications are constructed; only literal valuation/separating trace-different profiles are local inputs. ANY chosen roots have equal scalars at EVERY endpoint fiber pair |
| Exact original differential scalar formula | `actual_galois_smooth_local_rational_differential_scalars_equal` starts with ONE original rational F,G,sigma identity, true simple-zero restrictions and unit G. Sigma need be regular/nonvanishing ONLY at the selected points. Original local universal-Omega identities and unit slopes are derived. `weak_laurent_power_root_differential_scalar` computes the exact general p,h,m formula |
| p=5,h=4,m=7 gives G(R)^2*sigma_R^5 constant | `actual_characteristic_five_galois_local_rational_fiber_constraint` proves the equality at EVERY true original closed endpoint fiber pair, using original residue evaluations |
| sigma=dz/y gives (y F_z)(R)^5/G(R)^2 constant | `actual_smooth_curve_rational_coordinate_differential_product` allows genuine rational y,z with only y nonzero, constructs actual FIELD d/dz, and derives an ORIGINAL unit W whose rational image is y*F_z, with sigma_R=eval(W)^(-1). Neither rational factor is individually evaluated. `rational_coordinate_derivation_unique` proves uniqueness. `actual_characteristic_five_galois_rational_coordinate_product_fiber_constraint` assembles the full original same-source corollary, including Weierstrass points. The broader roots pass the 1,127-declaration focused trust audit and independent full readback |
| ONE same nonzero constant at all seven wild points | `rational_product_residue_power_ratio_nonzero` derives the genuine residue quotient's nonvanishing from the actual original units. `rational_product_fiber_single_nonzero_constant` turns the proved pairwise comparison on ANY nonempty fiber into one nonzero constant throughout it. Seven is a special case; no point enumeration is used |

All original smooth stalk DVRs, coefficient residues, uniformizers, completion charts, affine
normality/Dedekind rings, true finite normalization in the ORIGINAL generic-stalk fields, source
point lifts and entire stalk/map squares are derived from the true Scheme morphisms.
No model, source lifts, valuation charts, simultaneous Galois closure or endpoint-only surrogate
is assumed. The original global-to-stalk Omega map is genuinely injective; each smooth-curve
stalk's ENTIRE universal differential module has its true uniformizer frame. Residue-fiber
nonvanishing consequently forces an original unit coefficient.

The canonical statement does not require non-Weierstrass points or original unit y.
The earlier separate-factor evaluation theorem was consequently narrower than the source.
The new rational-product theorem removes that extra premise: y and F_z may have
zeros or poles separately, while their PRODUCT is derived to be an original unit.
The expression in the source is interpreted as the residue of this literal product.
The original unit-y theorem is retained as a useful special case. Properness
and the number seven are unnecessary for the stronger pairwise conclusion. The retained
globally regular form specialization uses the literal intersection of original local Omega
images, without an H0 sheaf cohomology identification.

The independent readback accepted the source's completed-field/different-exponent convention
as precisely the actual finite separating trace-different profile used in the formalization.
No component adds mathematical axioms, finite coefficient cutoffs or an unmarked-cover exclusion.

Pinned canonical statement SHA256:
`066b75c8f6226b5f09f4d523c4f9a43fffc2bfc16529fa79435da7f850cc7eb2`.
The source statement is unchanged. The final human-proof coordinate sentence now explains
the rational PRODUCT unit at Weierstrass points; its SHA256 is
`1a8f46e7b6e05c8ebf5a73a0e426062ad176383a8326af101f5c87039db46ccb`.

Transitive trust evidence, always only Classical.choice/Quot.sound/propext, zero forbidden
dependencies and zero source changes:

- `verification/20261003T060159Z/report.json`: 703 declarations, actual Galois smooth-curve completions; independent review in `../galois_smooth_curve_completed_fields_independent_scope_review.md`.
- `verification/20261003T060953Z/report.json`: 749 declarations, entire original same-source fiber comparison and true finite generic field degree.
- `verification/20261003T061753Z/report.json`: 97 declarations, original smooth-stalk Omega injectivity in every relative dimension.
- `verification/20261003T063227Z/report.json`: 1,331 declarations, original global scalar/different pipeline; independent review in `../original_global_galois_scalars_different_independent_scope_review.md`.
- `verification/20261003T064231Z/report.json`: 512 declarations, full Laurent coordinate derivative/order transport, uniformizer scalar independence and different-profile classification.
- `verification/20261003T070411Z/report.json`: 544 declarations, ANY actual order-one uniformizer constructs the entire coordinate automorphism and preserves every original root scalar.
- `verification/20261003T065842Z/report.json`: 1,386 declarations, the FOUR-root aggregate of actual valuation/profile/all-root/two-field classification, whole ramification group, automatic uniformizer transport, original true same-source profile scalars and exact original F_z characteristic-five corollary. All passed.
- `verification/20261003T071634Z/report.json`: 1,127 declarations, the broader rational-field coordinate derivative and ORIGINAL unit PRODUCT y*F_z at arbitrary original wild points, its intrinsic uniqueness and actual characteristic-five same-source fiber equality. No unit-y/non-Weierstrass or separate-factor residue hypotheses remain.
- `verification/20261003T071938Z/report.json`: 743 declarations, genuine original-product residue nonvanishing and ONE nonzero constant over any nonempty complete fiber; also actual proper Dedekind finite-normalization realization foundations.
