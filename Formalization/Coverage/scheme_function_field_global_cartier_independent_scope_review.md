# Independent review of actual Scheme function fields and global Cartier

3 October2026. Cartier/spin owner reviewed the complete six new modules,
the actual smooth generic-chart/rank and affine finite-type dependencies,
and the precise Mathlib separating-basis and formally-étale differential
base-change statements. No root Lean file was edited or recompiled for
this mathematical readback. Kernel verification is a separate root audit.

The reviewed conclusions and hypotheses are accepted exactly as written.
The actual smooth integral source and its actual structure morphism are
retained throughout. No function-field finite generation, transcendence
degree, p-basis, DVR, coordinate or Cartier-stable lattice is supplied in
the terminal smooth-curve wrapper.

| Module | Mathematical readback |
| --- | --- |
| `FiniteTypeFractionFieldGeneration` | Finite algebra generators of an actual finite-type domain generate its actual fraction field as a field. Every fraction is in that intermediate field. This proves `IntermediateField.FG ⊤`, and does not claim finite type as an algebra for the fraction field. |
| `SeparatingTranscendenceDifferentials` | The actual algebraically independent family constructs its actual polynomial subalgebra equivalence and actual fraction field. Localization and the actual separable extension give genuine universal-differential base-change equivalences; the polynomial differential basis gives the true cardinal rank. Perfect constants and field finite generation construct a finite separating basis via Mathlib, so rank equals actual transcendence degree without a supplied basis. Characteristic zero is allowed for this rank theorem. |
| `SchemeFunctionFieldGeneration` | An affine neighborhood of the actual generic point is constructed. Its literal coefficient algebra is finite type by the actual locally finite-type structure morphism, and its true fraction field is the original Scheme function field. This proves field finite generation without quasi-compactness/properness of the entire Scheme. Actual smooth relative dimension n supplies the true generic differential rank n; the perfect-field rank theorem then proves actual transcendence degree n. |
| `Definitions.SchemeRegularDifferentials` | Local regular rational forms are the actual image of the original stalk universal differentials in the original function-field universal differentials, using the true structure-morphism maps and their compatibility. The global module is their literal intersection over actual closed points. Its k-submodule structure is appropriate for inverse-Frobenius semilinearity. No sheaf or H0 identification is smuggled into this definition. |
| `Solutions.SchemeRegularDifferentials` | Membership is the literal stalk-image condition. For positive prime characteristic and algebraically closed constants, the already reviewed smooth DVR/completion construction and original-DVR Cartier preservation prove local image preservation. Taking the actual closed-point intersection proves global preservation. The intermediate theorem's explicit field FG/trdeg hypotheses are removed by the terminal wrapper. |
| `SmoothCurveCartier` | On an actual integral smooth relative-dimension-one Scheme over perfect constants of positive prime characteristic, field FG/trdeg1 and the genuine full p-basis/intrinsic Cartier construction yield the actual rational operator. The standard intrinsic characterization is unique. With algebraically closed constants, the actual original local images and their global intersection are preserved, producing a true additive endomorphism of that module. Its p-th inverse semilinearity uses the actual constant-field action. Its zero kernel is exactly those regular rational forms that are the universal differential of an actual rational function; the primitive is not asserted to be regular. |

The original `RationalCartierOperator` properties are the standard actual
additive, p-th semilinear, exact-annihilating and logarithmic-fixed
characterization. The terminal constructor supplies them from the
previously proved intrinsic operator, rather than assuming operator
existence. Local/global preservation does not merely assume a stable
subspace. The global restriction asserts neither global surjectivity nor
an identification with H0 of the differential sheaf; those are distinct
remaining geometric tasks. No second cover map is introduced or discarded.

The new six-module frozen snapshots reviewed have SHA256:

- `Solutions/SharedTensors/FiniteTypeFractionFieldGeneration.lean`: `b4bbd9b9806bcb06917ceb933f43ef99bfa570fa87e39578b7673fc21fcb5dd4`.
- `Solutions/SharedTensors/SeparatingTranscendenceDifferentials.lean`: `5e13c6331068bca39c6851ddf12f2d2340ae6c9eda53b2fcde5db5885a6ae88e`.
- `Solutions/SharedTensors/SchemeFunctionFieldGeneration.lean`: `4bd01ac6f996659fb161c87069d2125cf5bc2b26dc2df35904a6ce59497e0d67`.
- `Definitions/SharedTensors/SchemeRegularDifferentials.lean`: `5bbb79cb73bb95c500d10124bcfde79a164c42e290f8bf22d4a3d7ba8f3bb0fa`.
- `Solutions/SharedTensors/SchemeRegularDifferentials.lean`: `b19fb2f57739c5ea5faef7f0ec548bb1897f5db8065c2a3ddd594096ac061596`.
- `Solutions/SharedTensors/SmoothCurveCartier.lean`: `625fecf982546c14824492fadafd1603bb54d8495ede5c68889ce9b6a93139e9`.

There are no numerical certificates or characteristic-specific root
enumerations in this new chain. This is a substantial checked foundation;
it does not complete the geometric theorem inventory or the original
unmarked common-cover problem.
