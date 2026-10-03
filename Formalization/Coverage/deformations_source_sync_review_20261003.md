# Deformations: canonical proof and Lean scope synchronization

Reviewed 3 October 2026 after the successful `20261003T093716Z` stable
checkpoint. The current family contains 95 canonical records: three
complete, ten with checked components, and 82 pending. Every current
statement path, version and SHA256 agrees with the family coverage and
library. No canonical statement or human proof was edited. One stale
`nodal_first_repair_slice` library proof-hash pin was repaired to the
unchanged current proof, preserving every other field.

The complete current statements were loaded with `research_workspace.py
show`; the current named human proofs were read in full for all 13 records
claiming a complete result or a partial component. Pending records receive
only path/version/hash provenance. Their new proof prose is not promoted
to a checked mathematical result.

The immutable checkpoint manifest records every current canonical
statement, human proof, supporting proof, library record and claimed Lean
module SHA256. It distinguishes a proof's explicit version label from the
version of the statement that it proves. `reviewed_proof_path` and
`reviewed_proof_sha256` in the family fragment pin this precise readback.
The manifest is
`../litt3-computation-data/formalization-20261003/source-sync/deformations-20261003T103324Z/manifest.json`.

All 204 previously registered components belong to 175 distinct Lean
solution modules. Every one of those module hashes matches the successful
[stable checkpoint](../../../litt3-computation-data/formalization-20261003/verification/20261003T093716Z/report.json).
That report built 1,455 roots and checked 9,086 transitive declarations,
using only `Classical.choice`, `Quot.sound` and `propext`, with zero
forbidden dependencies and zero changed source files. Thus the proof
cleanup does not require a repeat build or numerical replay of those
settled cores. A successful build of a new leaf is recorded separately
from a transitive axiom audit.

## Complete records retained

| Record | Current scope | Current human-proof synchronization |
| --- | --- | --- |
| `marked_obstruction_torsors` | Version1, whole abstract actual-point theorem | Statement and proof are unchanged. Full averaged obstruction value, arbitrary triangular tails, prefix-dependent delayed extension, stabilized compatible tower, arbitrary initial shift and marked uniqueness remain exact. |
| `cyclic_power_additive_norm` | Version3, whole original mixed-additive cyclic module theorem, including actual perfect-field truncated Witt application | Statement is unchanged. The tracked proof change relocates a historical receipt to the external data store; it changes no hypothesis or mathematical clause. |
| `etale_artin_schreier_carry_bound` | Version2, whole local original integral chart theorem | Statement and proof are unchanged. The exact terminal target and solution were reread at arbitrary prime/rank/base, including torsion and the zero ring. |

The preserved whole-source reviews are
[marked scope review](marked_obstruction_torsors_scope_review.md),
[cyclic norm scope review](cyclic_power_additive_norm_scope_review.md), and
[AS independent review](etale_artin_schreier_carry_bound_independent_review.md).
Their focused evidence remains respectively `20261002T225244Z` (137),
`20261003T050618Z` (799), and `20261003T084811Z` (341 declarations).
The newer stable report also retains their unchanged Lean source hashes.

For the AS theorem, the full original chart and its normal basis, closed
signed carry, multiplicative/pth-power bounds, unique root lift, actual
semilinear maps, actual derivation extension and fixed-digit existence
remain proved. The root equation needs its own unit coefficient; ambient
units are required only for derivation extension. Coefficient torsion
does not give unique digits. Neither proof cleanup nor completion of this
local theorem supplies an actual moving-source cover or a nonlinear
obstruction bound.

## Current weighted theorem is partial

`elementary_weighted_carry` is currently Version3, statement SHA256
`cda41fd6c6462a23892b6c351df16937e8802e6d4d26349bd592c60d168d9da6`.
This is a genuine mathematical enlargement of the independently accepted
Version1 SHA256
`7347a023b30530cf739bba7f3dccef018367aa3c786b9c6ff33a95e9345c5a33`.
Version1 proves the full characteristic-five quadratic theorem; its
[independent review](elementary_weighted_carry_independent_review.md) and
976-declaration `20261003T075706Z` evidence are historical accepted scope.
They do not prove every new Version3 clause.

The current source permits every prime p>=5 and principal degree
2<=a<=p-2, and adds integral norm equations at precisions r and r+1,
full augmentation zero, a divisible-coefficient improvement and every
prescribed final norm-line leading coefficient. Its human proof now uses
the genuine graded norm kernel and original projective character spaces.
No numerical replay is part of this enlargement.

The generalized literal Witt quotient grading, derived scalar action,
original p/Ei maps, multiplication, full operator leading action and
kernel thresholds are captured by `20261003T093716Z`. New postcapture
solutions compile for full high absorption, exact projective coefficient
extraction and inverse Frobenius after the whole signed sum, the actual
critical repair/image equivalence, both exact critical dimensions,
integral norm source weights and augmentation zero, final solubility iff
the coefficient has zero residue, and realization of every prescribed
leading norm coefficient. Those new roots still need focused transitive
trust evidence and independent current-source acceptance.

The literal augmentation-power/annihilator and Witt-reduction bridge, an
exact single current-Version3 clause bundle, and independent whole-source
review remain. The draft degree-ideal/annihilator files are not counted as
proved components. Current whole-source status therefore remains partial.
The 60 old component mappings are explicitly pinned to the accepted
Version1 scope; separately registered generic-prime components state their
actual wider claims and verification status.

## Partial records after current proof cleanup

| Record | Current source/proof change and exact retained gap |
| --- | --- |
| `augmentation_width_defect`, V2 | Jennings replaces a separate prose radical computation. General actual matrix/radical widths and literal one/two-factor group algebra cores are checked; the dimension-subgroup theorem, three-factor/Frattini consequences and actual Hodge/intermediate-cover realization remain. |
| `cyclic_symplectic_blocks`, V2 | Generic first-socle growth, quadratic characters and actual deck constraints are consolidated. Actual Hermitian decomposition/parity and literal deck representation are checked. The genuine curve paired-complex realization, first-socle sheaf/Serre duality, quotient geometry and section-character identifications remain. |
| `symplectic_p_cover_section_growth`, V8 | Generic growth/parity is imported once; exact abelian flags give every selected cyclic direction. Cup-form rank and genuine p-group invariant cores remain checked. Actual tangent sections, all tower operator powers, family classification and trace transfer preserving both maps remain. |
| `prime_to_five_bt_extension_descent`, V2 | The source now covers arbitrary primes and characteristic-p schemes/BT heights, with a supplied compatible determinant target at odd p. The actual additive boundary-square core remains conditional; finite-flat Ext/corestriction, the BT boundary criterion and determinant realization remain. |
| `cartier_defect_bt_descent`, V2 | Absolute existence is followed by full prescribed Cartier correction, exact surjectivity/every-extension equivalence, full towers and the arbitrary-degree zero-source case. Additive retraction/full residue cores remain checked; actual marked BT fibers, Cartier trace realization, effective descent and the original two-map lift remain. |
| `common_bt_tower_rigidity`, V2 | Coherent field base change replaces an affine-coordinate argument for geometric same-field existence. Finite vector-torsor counts and cofinal unique-level assembly remain checked. The older affine-Frobenius theorem is only an auxiliary; the actual coherent torsor, class identification and effective arithmetic/full-group descent remain. |
| `versal_bt_extension_torsor`, V2 | The ordinary full tower is obtained without a global next reference; the norm/freeness lemma is reused by the later descent proof. Full coefficient-module and actual affine kernel-torsor connecting cores remain checked. The actual small-etale BT sheaf, local/global Cartier realization, coherent cohomology, ordinary vanishings and effective gluing remain. |
| `bt_p_cover_cartier_obstruction`, V3 | The intrinsic absolute class and actual tangent-bundle isomorphism replace repeated comparisons by dimension. The complete p-group/H1/norm criteria, distinct-twist semilinear square, actual torsor representative and cyclic blocks are checked. Actual geometric realization, coherent trace surjectivity, absolute-class identification and the tangent paired complex remain; no actual nonzero proper-curve class is evaluated. |
| `joint_frobenius_obstruction_line`, V2 | The universal ample criterion replaces the special-endpoint route. Arbitrary-height kernel propagation remains checked with every distinct twist retained. Actual two-map coherent rows, ample/Cartier/FL dictionaries, first nonzero line and geometric dimension formulas remain. |

Changing a human proof's preferred route does not remove the geometric
hypotheses from a conditional Lean component. Neither the claimed partial
cores nor the three complete abstract/local module records solve the
unmarked common-cover problem.
