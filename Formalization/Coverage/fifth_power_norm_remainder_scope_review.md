# Full Frobenius norm-remainder scope review

Status: complete for canonical Version2,3 October2026.
Statement SHA256:
`2bd7ec71cf848bc06eb09af672ba4b864a98c5bb446e6fdd47b933510f75942f`.
Proof SHA256:
`6a0615b6b470261bda3ec2b2748f4bc10685e74e07211b224dca8b39de183004`.

Root independently read the original source/proof, the exact proposed
Version2 correction, literal quantified specs, both full packages,
inseparable-factor/minimal-polynomial/remainder uniqueness, actual
split norm/base change/nonmonic normalization, and concrete rational
counterexample. The readback accepted the entire corrected scope.
Canonical provenance and correction are preserved in
`Research/audits/NORM_FROBENIUS_DEGREE_ZERO_AUDIT_2026_10_03.md`.

Focused trust audit `20261003T053824Z` built all three terminal roots
and audited 279 transitive theorem declarations: only `Classical.choice`,
`Quot.sound`, `propext`, zero forbidden dependencies and zero source changes.
Evidence is in
`../litt3-computation-data/formalization-20261003/verification/20261003T053824Z/report.json`.

| Canonical clause | Checked implementation |
| --- | --- |
| Any field K of prime characteristic p; f outside K^p | `inseparable_factor_irreducible`; no perfect constants or function-field premise |
| Actual degree-p inseparable root | `inseparable_root_minpoly`; actual minimal polynomial, no supplied basis |
| Actual nonzero norm condition forces constant remainder | `source_norm_frobenius_remainder`; determinant norm base change and actual split quotient are constructed |
| Both H and nonzero τ unique | `inseparable_remainder_presentation_unique`; evaluation and nonzero-factor cancellation |
| Converse norm condition | `source_frobenius_remainder_norm` |
| Positive degree implies N≥p | `frobenius_remainder_positive_degree_bound`; proves H≠0 and uses actual polynomial degrees |
| Original actual primitive field, actual norm/minpoly | `primitive_norm_frobenius_remainder_package`; literal generation constructs the power basis and source quotient equivalence |
| Nonmonic and reducible separable finite source algebra | `nonmonic_source_norm_frobenius_remainder_package`; actual norm-preserving quotient normalization, no irreducibility/connectedness premise |
| Constant-source equivalence and uniqueness retained | The nonmonic forward and converse permit every F≠0; the same uniqueness theorem has no positive-degree premise |
| Degree-zero lower-bound loophole | `zero_source_norm_degree_counterexample` and `rational_fifth_power_zero_source_counterexample`; actual zero algebra, determinant norm1, literal rational characteristic-five witness outside K^5 |

The full source and primitive-field specs are genuine quantified Props
in `Theorems.CartierAndSpin.NormFrobeniusRemainder`. The fixed admissible
primitive application invokes the original norm condition supplied by the
separate uniform-admissible-norm theorem; these proofs do not presume that
geometric theorem or transfer a norm through an index divisible by p.
The human proof retains that nonprimitive-index caveat. No source existence,
source exclusion, trace-zero decision or common-cover solution is asserted.

The proof uses no numerical roots, finite source-degree enumeration,
external arithmetic certificates or characteristic-specific identities.
All original source hashes remain invalidation keys for this completion.
