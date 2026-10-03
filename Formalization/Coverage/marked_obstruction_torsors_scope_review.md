# Exact clause mapping for marked obstruction torsors

The source is the version-one abstract theorem
`Theorems/deformations/marked_obstruction_torsors.md`; its proof is
`Proofs/deformations/marked_obstruction_torsors.md`. It contains no
unconditional geometric lift-existence conclusion. The full claim is an
abstract statement on actual point sets once the full obstruction and
marked-choice hypotheses have been established.

The target index is
`Theorems/Deformations/MarkedObstructionTorsors.lean`, importing the precise
clause specifications in `TameAveraging`, `FiniteTriangular`, and
`DelayedTowers`. The proof index is
`Solutions/Deformations/MarkedObstructionTorsors.lean`.

| Source clause | Checked declaration | Exact scope and hypotheses |
| --- | --- | --- |
| Tame fixed-point existence | `tame_torsor_has_fixed_point` | Arbitrary additive point group and nonempty actual torsor; finite affine group action; group-order multiplication bijective on the point group. |
| Arbitrary zero iff invariant zero | `invariant_zero_iff` | Complete affine additive response and equivariant obstruction; injective group-order multiplication on the obstruction group suffices, strengthening the source bijectivity hypothesis. |
| Full fixed-image residual iff | `averaged_residual_zero_iff` | The detector is an additive homomorphism on the actual invariant subgroup; both inclusions identifying its kernel with the full invariant response image are explicit. |
| Literal averaged obstruction value | `obstruction_average_value`, `obstruction_average_invariant_value` | Under the source bijectivity assumption on both groups, c at the averaged torsor point equals the uniquely divided orbit sum in the invariant obstruction group. Hence the checked residue is literally the source residue P(average(c(a))). |
| Independence of all original choices | `averaged_residual_independent` | Every original torsor point is allowed; only its actual averaged fixed point is evaluated. No identification of the full response kernel with its fixed kernel is asserted. |
| Characteristic-p sufficiency | `vector_group_order_bijective` | Over any characteristic-p field, p not dividing the finite group order gives bijective order multiplication on every vector group. The response and obstruction need only be additive, not field-linear. |
| Finite triangular elimination | `finite_triangular_bijective` | Every finite length, heterogeneous blocks, bijective diagonal point maps and arbitrary earlier-variable tails. Recursive formulas specify the actual coordinates, rather than assuming an invertible whole map. |
| Pointed free zero fiber | `pointed_triangular_free_fiber` | Each diagonal and tail sends zero to zero. The additional variable is absent from every block and remains literally arbitrary. No reducedness or scheme assertion follows. |
| Delayed local solvability | `delayed_tower_of_surjective_responses` | Response groups, torsors and maps depend on both height and reached prefix. A response zero must produce the actual complete next tuple retaining the earlier prefix. The complete source iff hypothesis implies this required direction. |
| Stabilized compatible tower | `compatible_tower_of_delayed_extension` | Recursive provisional objects retain level n when moving n+2 to n+3. Their double truncations form a compatible infinite tower. Unrelated finite objects alone are not assumed to give a tower. |
| Every initial level | `delayed_tower_from_arbitrary_initial_level` | Reindex by n mapped to m₀+n. Only the original m₀ prefix is retained; the initial last two provisional digits may change. |
| Allowed-level compatibility | `permitted_tower_of_delayed_extension` | Permittedness of every retained actual prefix is stated explicitly. The result is a compatible tower all of whose levels are permitted. |
| Intended extendability predicate | `two_step_permitted_tower_of_delayed_extension` | `HasAllowedTwoStepExtension n u` means an actual allowed level n+2 tuple truncates to u. Every stabilized level satisfies this predicate by its constructed provisional tuple, without an unproved lower-prefix closedness assertion. |
| Injective-response uniqueness | `permitted_tower_unique_of_injective_responses` | The actual marked next-level fiber is equivalent to the zero set of the COMPLETE affine obstruction; all lower structures and unique compatible identifications must be encoded in these actual level types. Injectivity is required only at reached permitted prefixes. |

All proofs use ordinary Lean kernel checking and standard logical axioms
for classical choice. They contain no admitted proof, project axiom,
external certificate, bounded calculation, numerical enumeration, or
`native_decide`. No algebraic-closure, perfectness, dimension bound,
constant response, or fixed secondary map is required.

The marked uniqueness condition is essential: an exact marked-fiber
equivalence is the formal expression of the source requirement that all
lower structures be included, or uniquely determined, and that compatible
marked identifications be unique. A statement about only a curve coordinate
or a scalar detector cannot instantiate that equivalence.

For the delayed source theorem, `L n` contains the actual full marked
level m₀+n structures. `HasAllowedTwoStepExtension` is the source phrase
"admitting W_(m+2)". The permitted next fiber consists of original marked
level m+1 choices still admitting m+3, exactly the COMPLETE obstruction
zero set. The unique-marking condition makes this a literal equivalence
of point sets. Arbitrary additional permitted predicates require the
explicit retained-prefix hypothesis; the construction never asserts
their closedness automatically.

Root's independent exact-source review accepted the complete version-one
abstract theorem on 2026-10-02, including the literal affine averaged
obstruction value, arbitrary finite tails, stabilized delayed tower,
arbitrary initial shift and actual full marked-fiber uniqueness. The source
SHA256 is `270a484e73fd2227e3d3f830d13c301ba5f86b6e9a047038908e3425e5f96804`.

The focused frozen-module verification report
`../litt3-computation-data/formalization-20261003/verification/20261002T225244Z/report.json`
built two stable solution indices and transitively audited 137 project
declarations. The only logical axioms were `Classical.choice`, `Quot.sound`
and `propext`; it found zero forbidden declarations and zero source changes.
The abstract canonical record is therefore complete. Applications to oper
or BT geometry remain separate formalization tasks.

## Current proof synchronization, 3 October2026

The current Version1 statement and full human proof are unchanged. The
proof explicitly identifies Version1 and has SHA256
`c5830c34467542d31e82d0ee10a9c6ca1c411a4609055f0f43f1c67c0f5d7770`.
The full current source/proof readback preserves every original allowed
point, complete obstruction, varying reached-prefix response and marked
identification hypothesis. Unchanged Lean source hashes remain in stable
report `20261003T093716Z`. The [family sync review](deformations_source_sync_review_20261003.md)
and its external manifest pin this exact current provenance. The abstract
whole-source status remains complete; geometric instantiation is separate.
