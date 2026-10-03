# Root-owned canonical archive synchronization

The root reread the complete current canonical statements and human proofs
of all seven non-pending records in `root.json` on 3 October2026. The exact
statement versions, human-proof paths and SHA256 values, dependency IDs,
definition IDs and current library-record hashes are recorded there. A
first recorded proof baseline is distinguished from a historical change.

| Canonical result | Current version | Formal scope |
| --- | --- | --- |
| alternating_constant_kernel_elimination | 3 | Partial: field and unit-ring reconstruction preserve both kernels, actual residual and normalization; Pfaffians, rank-divisor/sampling and complete charts remain |
| finite_algebra_completion_certificates | 4 | Complete: exact ideal/border stopping, canonical reduced splitting, positive-power Frobenius plateau and full actual multiplicity/completeness certificates |
| cartesian_endpoint_refinement | 2 | Partial: actual Cartesian maps and general fixed-degree algebra; actual integral Picard descent, component/clump geometry, sharp norm index and every-height root equivalence remain |
| character_homogeneous_polynomial_factorization | 1 | Partial: full algebraic/Kähler factorization and actual minimal-polynomial degree bound; complete local sheets and their pushed pole-space compatibility remain |
| differential_ratio_joint_field | 2 | Partial: actual field recovery, intrinsic Cartier and true differential-sheaf H0 foundations; endpoint function degrees, Kummer restrictions, both-leg normalization and divisor/genus/spin applications remain |
| canonical_intersection | 8 | Partial: actual integral divisor-section multiplication, valuation-order sign and closed-fiber pushforward; actual canonical-line identification, primitive ring/clump weights and geometric degree statements remain |
| saturated_divisor_relations | 3 | Partial: integral saturation and extensive actual differential, divisor-sheaf and logarithmic foundations; actual invariant Picard/Jacobian, clump-count, cohomology and complete group-scheme clauses remain |

All seven current statement hashes match the existing coverage pins. The
finite-algebra Version4 human proof matches its previously reviewed hash;
its genuine positive Frobenius-power correction was already formalized
and independently accepted. The other six records lacked explicit proof
pins in the owner fragment. Their full current proofs were read before
recording the first baseline; this is not a claim of historical byte
equality. Earlier external inventories identify already integrated changes
to the alternating-chart and Cartesian-refinement proofs. No new mismatch
between the present proved Lean components and their stated partial scopes
was found. No partial result is promoted to whole-source completion.

The gap descriptions were refreshed where genuine original smooth DVR
stalks, finite rational pole support and the actual differential-sheaf H0
Cartier bridge are now proved. They retain the remaining application
hypotheses. The unit-ring chart is linked to its exact one-declaration
audit `20261003T102344Z`, which uses only `propext`; the field chart is
linked to `20261003T101119Z`. The original H0 Cartier component uses
`20261003T085410Z`. All older captured components retain the successful
1,455-root checkpoint `20261003T093716Z` or their recorded focused reports.
No settled Lean or numerical verification was replayed for this source
readback. Both actual finite étale legs from the same source remain in
the geometric statements and their explicit gaps.

The library's critical-translation record had `statement_version:1`
alongside the already accepted Version2 statement/hash and `version:2`.
The root corrected only the stale `statement_version` field. The Cartier
owner independently confirms that its whole Version2 scope remains covered.

`scripts/coverage.py` now checks reviewed proof paths/hashes and reviewed
dependency/definition ID lists. It preserves current inventory proof
hashes even if an older owner fragment contains a historical `proof_sha256`.
A changed human proof is flagged for renewed scope review; it does not
erase a kernel-checked proof of an unchanged statement. Missing baselines
are reported separately. This review does not establish completion of the
many pending source records or solve the unmarked common-cover problem.
