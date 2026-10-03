# Original differential presheaf and sheaf pullback: scoped review

Date: 3 October 2026. Owner: CartierAndSpin. This extends the accepted
[original differential order/divisor transport](original_differential_pullback_divisor_scope_review.md).
It proves actual original section and module-sheaf maps, rather than
replacing them by abstract maps whose compatibility is assumed.

## Exact declarations and scope

`Solutions.CartierAndSpin.SchemeDifferentialPresheafPullbacks` constructs
`actualSchemeDifferentialPresheafOpenPullback` on every original open,
including the empty open. Here k is any field and f is any scheme
morphism over k. Smoothness, etaleness and integrality are not required.
`actual_scheme_chart_base_field_over` derives the constant-field square
from the actual structure-sheaf map and the equality f ≫ sY = sX. The
map is the genuine `CommRingCat.KaehlerDifferential.map` of this square.
`actualSchemeDifferentialPresheafOpenPullback_derivative` proves its
literal d(r) → d(f.app(r)) action. For integral schemes and surjective f,
`actualSchemeDifferentialPresheafOpenPullback_rational` proves equality
on the entire original universal module with the generic original
rational pullback; every chart/field tower is derived from the actual f.

`Solutions.CartierAndSpin.SmoothEtaleDifferentialOpenPullbacks` assumes
integral smooth relative-dimension-one schemes over an algebraically
closed field, and an actual finite etale surjective f over that field.
There is no compactness or properness input.
`actual_smooth_etale_differential_regular_on_preimage_iff` reflects and
preserves original closed-stalk regularity on every inverse-image open.
`actual_smooth_etale_differential_sections_on_preimage_iff` uses the
original whole-open recovery theorem to characterize sections of the
pulled original rational form. It concerns descent of an original
target rational form, not descent of every source differential.
`actualSmoothEtaleDifferentialOpenPullback` constructs the unique
original section realizing the actual generic pullback on nonempty
opens, and the unique zero section on empty opens. Its `_restriction`
theorem proves every original restriction square. Its `_presheaf`
theorem proves agreement with the entire actual universal presheaf
map through both original sheafification units, on every open. Thus
the recovered section map has canonical original-map compatibility.

`Solutions.CartierAndSpin.SmoothEtaleDifferentialSheafPullbacks` proves
`actualSmoothEtaleDifferentialOpenPullback_smul` through the literal
actual section-ring map f.app. `actualSmoothEtaleDifferentialSheafPullbackMap`
packages these semilinear and restriction maps as the genuine morphism
Ω_Y → f_*Ω_X of original module sheaves.
`actualSmoothEtaleDifferentialSheafPullbackMap_presheaf` records its
whole original-presheaf agreement, and `_derivative` records its
original sheafified universal derivative action. It does not identify
f_*Ω_X with Ω_Y, or assert equality of their entire spaces of sections.

## Verification and freeze

Focused build and kernel dependency audit:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T121856Z/report.json`.
The checked terminals are `SmoothEtaleDifferentialSheafPullbacks` and
`SmoothEtaleSpanDifferentialDivisors`. The report checks 1,024 transitive
Litt3 theorem declarations using only Classical.choice, Quot.sound and
propext; zero forbidden dependencies and zero source changes during
the check. This is the first audit of the three new original sheaf
pullback modules, not a replay of the settled divisor-only audit.

| Module | SHA256 |
| --- | --- |
| SchemeDifferentialPresheafPullbacks | c49dd466703192a847a5dc2cf411143a557795109351bcc71ca87bbfb407a56e |
| SmoothEtaleDifferentialOpenPullbacks | 4431f11a3e82accd84a20b5a5ec5981892186ade338d25502b35eb83ec4c9115 |
| SmoothEtaleDifferentialSheafPullbacks | 77e1a0ed0d70c49d490ac1dfec57b2c0728db3db5509f1a6f5e9e9151d85cd5f |

The sources were read in full for this owner scope review. An independent
mathematical readback is recorded separately when completed.

## Remaining scope

These are exact foundations for original differential and canonical
line-sheaf naturality. They do not prove existence of any common cover,
the original canonical-power existence result, the degree/genus formula
for the canonical line, global H0 finiteness, Riemann–Roch, or the
unmarked common-cover problem. They introduce no project-result axiom,
separating-coordinate hypothesis, assumed divisor transport, or
enumerative computation. The actual categorical adjoint's IsIso
extension has a separate [exact scope and 1,273-declaration focused
audit](original_differential_categorical_pullback_scope_review.md).
