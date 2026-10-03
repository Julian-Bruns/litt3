# Independent review: original differential sheaf injection and global recovery

Reviewer: Cartier/spin owner, independently of the shared-tensor implementation owner. Review performed 3 October 2026 against the five full Lean sources listed below. This is a mathematical scope review, not a substitute for the owner's transitive kernel audit. The earlier six-file review of the actual differential presheaf, associated sheaf, generic realization and local realization remains a separate settled input.

The five sources prove the required identification for the genuine associated differential sheaf of the original structure morphism. They do not define that sheaf or its global sections as a rational-image intersection. The injection and converse are conclusions. I accept the stated scopes and found no circular regularity, injection or gluing input.

| Source | SHA-256 at review |
| --- | --- |
| `Solutions/SharedTensors/SchemeDifferentialAffineInjectivity.lean` | `8420764e03dabf80cf836379108bb68d6a8046250d1d27da28de980d1c4fcf2b` |
| `Solutions/SharedTensors/SchemeDifferentialSheafInjectivity.lean` | `2ce34d1c952fc088999d8c13db99ddfef4c2b6bf2ad03e38bccd5f1d0d915608` |
| `Solutions/SharedTensors/SchemeDifferentialLocalLifts.lean` | `dc8d5eb0f5ab00463aec906b46c1e406994f2cd9429c9502abadb5a0344f29c8` |
| `Solutions/SharedTensors/SchemeDifferentialGlobalRecovery.lean` | `600e95e583bd9e522045a117fe3d18abbcb67aeb3278a81e3cbfa4c97b9b864b` |
| `Solutions/SharedTensors/SchemeDifferentialClosedRecovery.lean` | `64002975ee800a457e446fe11352458ec11ffec010859f43b8fe0d3e0c290ac5` |

## Actual affine and sheaf injection

`schemeDifferentialOpenToFunctionField_affine_injective` assumes an integral scheme smooth of actual relative dimension `n` over a field and an actual nonempty affine open. It proves injection of the entire original universal differential module on that open into the original rational module. For every actual maximal ideal it chooses the corresponding original affine point, uses the actual chart-to-stalk localization and universal-differential localization, and uses the established smooth-stalk injection. Equality at every localization implies equality in the original module. Global standard smoothness of the affine coordinate ring is not supplied.

`SchemeDifferentialSheafInjectivity` first establishes that nonempty affine opens form a basis and deduces injection on the actual presheaf stalks. The sheafification unit's stalk surjectivity is the genuine locally-surjective sheafification theorem. Actual unit representatives and the proved presheaf compatibility then establish injection on the associated sheaf stalks. The sheaf property gives injection on every original open. The actual rational skyscraper/open isomorphism gives injection of the literal open-to-function-field map on every nonempty open. None of these results has sheaf injection as a hypothesis; the empty open is handled by the sheaf argument rather than a false generic-point membership.

## Actual local lifting

`schemeLocalRegularDifferential_open_lift` needs only an integral scheme over a field and membership in the original universal point-stalk image. It selects an actual affine neighborhood, presents the entire stalk-module representative through the actual module localization, and obtains a denominator avoiding the actual point prime. On its genuine basic open that denominator is a unit. Its inverse multiplies the mapped affine-module numerator, giving an actual original differential-presheaf section whose rational image is the prescribed form. The coefficient identity and full universal-differential map composition prove the equality. No smoothness, finite generation, existence of an open lift, or finite support is assumed.

## Actual global recovery

`schemeDifferential_regular_everywhere_iff_global_section` is valid for an integral scheme smooth of any actual relative dimension `n` over any field. It chooses the proved local original presheaf representatives and sends them through the genuine sheafification unit. Nonempty opens of the integral scheme contain its actual generic point, so their pairwise intersections are nonempty. Equality of rational images and the proved associated-sheaf injection force actual equality of restrictions. The genuine sheaf gluing theorem constructs the global section. The restriction identity identifies its rational image with the original form. Conversely, the already proved actual sheaf-to-original-stalk realization sends each global section into every original universal stalk image. The exact range theorem records precisely this two-way statement.

## Closed-point recovery and generality

`schemeDifferential_regular_locus_isOpen` is proved on every integral scheme over a field, without smoothness, using the actual open lift and its genuine stalk germs. On an integral Jacobson scheme, a nonempty closed complement would contain an actual closed point; therefore membership at all original closed points is equivalent to membership at all points. Actual smoothness of any relative dimension over a field derives local finite type and hence the Jacobson property. The terminal `schemeDifferential_closed_regular_iff_global_section` and `schemeDifferentialGlobalSections_range_closed_stalks` combine those conclusions with genuine global recovery.

No algebraic closure, properness, projectivity, characteristic, perfectness, genus, coordinate, DVR, finite pole support, or supplied H0 identification occurs in the terminal hypotheses. The statement identifies actual global sections with their rational images; it does not establish their finite dimensionality or a cohomological comparison with an independently chosen model. The same original scheme and structure morphism are retained throughout.
