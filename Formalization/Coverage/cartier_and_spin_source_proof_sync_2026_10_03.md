# Cartier/spin canonical statement and human-proof synchronization

Snapshot checked on 3 October 2026 at 10:32 UTC. This review covers the
twelve sources represented in `cartier_and_spin.json`, including all
seven whole-source acceptances and all five partial-source records.
Other family sources remain pending in the root inventory. It does not
claim an exhaustive formalization of the family.

All twelve current canonical statement files match their stored formal
coverage SHA256 and the current library statement SHA256. Their source
and proof paths agree with the library. No changed statement, hypothesis,
assumption or formal scope was detected in this owner fragment. The eight
human proofs with a prior recorded `proof_sha256` or
`reviewed_proof_sha256` match that baseline exactly. Four records had no
prior human-proof hash: pure-power finite algebra, quartic scalar graph,
section-span clearing and Hermite interpolation. Their full current
statements and human proofs were reread; their formal mappings and
remaining gaps still agree. A missing historical baseline is not evidence
that those proofs changed.

The current proof hashes and explicit canonical statement versions have
now been recorded in every owner record, together with literal reviewed
proof paths, the current definition-ID list and the current dependency-ID
list. These graph lists preserve the canonical scope metadata; they do
not assert that pending dependencies are formalized or import their
conclusions into Lean. The pure-power and quartic
whole-source records also receive the current fully reread proof hash as
`reviewed_proof_sha256`. Existing whole-source review cards and kernel
audit evidence remain in force. No status is promoted or demoted and no
settled numerical or Lean checks were replayed for this provenance edit.

| Canonical source | Version | Status | Proof synchronization |
| --- | --- | --- | --- |
| source_quadratic_calculus | 1 | complete | Existing hash unchanged |
| section_span_clearing_degree_bound | 1 | partial_component | Missing baseline filled after full reread |
| annihilator_critical_translation_invariance | 2 | complete | Existing reviewed hash unchanged |
| pure_power_pair_finite_algebra | 1 | complete | Missing baseline filled after full reread |
| hermite_endpoint_interpolation | 1 | partial_component | Missing baseline filled after full reread |
| quartic_scalar_graph_skew_recovery | 1 | complete | Missing baseline filled after full reread |
| trace_power_integrality_detection | 3 | complete | Existing reviewed hash unchanged |
| weighted_affine_square_plane_odd_degree_finiteness | 2 | partial_component | Existing hash unchanged |
| admissible_degree_ten_m9_critical_square_pencil_finite_support | 3 | partial_component | Existing hash unchanged |
| middle_finite_commutator_criterion | 1 | complete | Existing hash unchanged |
| fifth_power_norm_remainder | 2 | complete | Existing reviewed hash unchanged |
| admissible_critical_quadratic_incidence | 7 | partial_component | Existing reviewed hash unchanged |

The exact current statement and human-proof SHA256 values are in
`cartier_and_spin.json`, using `reviewed_proof_sha256` for the human-proof
baseline. The live inventory's separate `proof_sha256` stays computed
from the current archive, so an owner baseline cannot mask a future
proof-only change. Its `last_source_proof_sync_utc` and
`source_proof_sync_review` identify this review. The human-proof path for
each record is `Proofs/cartier_and_spin/<theorem_id>.md` in the research
workspace, and the source path is the literal path stored in the record.

## Scope readback for the four previously unanchored proofs

The pure-power theorem proves an actual finite polynomial quotient of
dimension at most m² from the independent two-by-two pure-power leading
forms and lower-degree remainders. It includes the full geometric point
count and the actual minimal embedded coefficient-field bound for
rational-function pairs. It asserts no solution existence or reducedness.
The checked formal aggregate and the accepted whole-source review cover
all of these clauses. Its complete status remains justified.

The quartic scalar-graph theorem treats arbitrary actual M with nonzero
skew part, derives the one-dimensional kernel, and retains all generator
and nonconstant-multiplier conditions. Its characteristic-five boundary
form includes vanishing coordinates and κ=0 without claiming boundary
emptiness or endpoint feasibility. The formal aggregate proves precisely
that algebraic scope, so its complete status remains justified.

The section-span theorem also asserts an actual scheme fiber-length bound
derived through H¹ vanishing and restriction, and geometric Gauss-content
denominator clearing away from the coefficient-rank-drop locus. It retains
separate higher-kernel incidence and concrete certificate applications.
The current general finite-span formal components do not cover those
geometric and certificate clauses. Its partial status remains necessary.

The Hermite theorem contains both Fourier-complementarity/minor inputs and
the characteristic-five μ29 certificate, followed by actual endpoint
orders, denominator-safe pairs, coupled totally isotropic difference
claims and lifting from the same absolute normalized jets. Quotient jets
alone are explicitly insufficient. The existing formal interpolation
components do not cover all those certificate and original endpoint
clauses. Its partial status remains necessary.

## Library metadata finding

The current canonical critical-translation source is Version 2 and its
stored statement hash is the accepted Version 2 hash. At the initial
review its library entry contained both `statement_version: 1` and
`version: 2`.
The owner record now explicitly uses `canonical_statement_version: 2`.
This redundant library-field mismatch was reported to the root owner,
who corrected `statement_version` to 2. No canonical statement, human
proof or library was edited by this child review.

The root's separate whole-inventory hash check identified fifty PENDING
Cartier/spin records with stale library statement hashes. Those are
concurrent research-metadata changes outside these twelve claimed scope
records. They remain explicitly pending and were not blindly repinned or
treated as reviewed formal conclusions. The twelve owner claims above
remain synchronized; no whole-family archive synchronization is claimed.
