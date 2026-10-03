# Litt3 formalization

This is the separate Lean 4 project for the mathematical results in
the parent `Theorems/` folder. It uses the
[prove2me workspace layout](https://github.com/prove2me/prove2me_workspace):
`Definitions/`, `Theorems/`, and `Solutions/`.

The project is in progress. A checked component is recorded separately
from a complete proof of its canonical source theorem. The unrestricted
same-source common-cover problem is open. No placeholder theorem or
assumed research conclusion is included in the checked proof library.

`Definitions/` contains actual mathematical structures and operations.
`Theorems/` contains precise proposition-valued specifications; these are
definitions, so unresolved targets introduce no proof axioms.
`Solutions/` contains kernel-checked proofs. Names are under `Litt3`.
`Coverage/` maps those declarations to exact source versions and records
remaining mathematical gaps. Purely numerical deductions retain that scope.

The first pass permits explicitly identified accepted literature inputs
where needed. None of the initial algebraic modules introduces a literature
axiom. The widening pass connects any remaining geometric inputs to actual
formal foundations; it is not complete merely because the algebraic cores
compile.

From this folder, run:

```sh
python3 scripts/verify.py
python3 scripts/coverage.py
```

The first command builds every solution and checks its transitive axiom
dependencies. Only Lean's ordinary `propext`, `Classical.choice`, and
`Quot.sound` are allowed. The second inventories all current source files
and checks coverage, ownership, statement/proof changes, reviewed dependency
lists, stale library hashes and remaining gaps.
Generated evidence is stored in `../../litt3-computation-data/formalization-20261003/`.
For a stable subset during concurrent work, use `--module` with a solution
name, repeating it as needed. Its imported local definitions and statements
are included in the source snapshot and change check.

The current whole-source acceptances are `marked_obstruction_torsors`,
`pure_power_pair_finite_algebra`, `quartic_scalar_graph_skew_recovery`, and
Version4 of `finite_algebra_completion_certificates`,
`trace_power_integrality_detection`, `source_quadratic_calculus`,
`cyclic_power_additive_norm`, `middle_finite_commutator_criterion`, and Version2
of `fifth_power_norm_remainder` and `annihilator_critical_translation_invariance`,
and Version1 of `weak_local_completed_extension_invariant`, and Version2 of
`etale_artin_schreier_carry_bound`, and current Version3 of
`elementary_weighted_carry`. Its arbitrary-prime full scope passed a
1217-declaration audit and independent97-source review, including every
prescribed leading coefficient and actual norm target.
Their exact clause
reviews and audited dependencies are linked in the owner coverage fragments.
The finite-algebra review corrected a missing q>1 hypothesis in the adaptive
Frobenius certificate; the old q=1 scope fails on actual dual numbers, now
verified in Lean and recorded in the canonical source audit. The norm review
also corrected its degree-zero finite-algebra boundary: the constant polynomial
1 has norm 1 but degree 0, so the degree bound requires positive degree.
The large remaining
inventory has explicit pending or partial status; the coverage report is the
current authority for source versions and counts.

The toolchain and dependencies are pinned in `lean-toolchain` and
`lake-manifest.json`: Lean `v4.27.0-rc1` and Mathlib revision
`32d24245c7a12ded17325299fd41d412022cd3fe`.
The local setup reuses that exact existing Mathlib build. Its `.lake`
directory is an external artifact directory, not tracked source. A fresh
machine can restore dependencies with `lake update` and `lake exe cache get`.
This is a local formalization project; no prove2me upload has been made.

Ownership and proof requirements are in [AGENTS.md](AGENTS.md). The user
requested at least twelve hours of continued work and a later focused
two-hour block; [RUN.md](RUN.md) records those intervals and checkpoints.

The [3 October archive sync review](Coverage/archive_sync_2026_10_03.md)
checks all51 source records claimed at its10:43UTC checkpoint against their human
proofs and exact scopes. All668 component references resolve to649 actual
Lean declarations through567 compiled imports. That checkpoint has12
complete and39 partial records; subsequent weighted-carry Version3 acceptance
raises those counts to13 complete and38 partial. The later original
hypersurface coverage adds one partial source: the latest snapshot has
1029 records,13 complete,39 partial and977 pending. All52 claimed source/proof
pins match; the103 stale library hash warnings remain confined to53 pending
records. The minimum twelve-hour interval is satisfied. The whole archive
remains incompletely formalized; these counts do not promote completed
clauses to whole-source acceptance.

The original differential sheaf is now proved to be the whole O(div omega),
with every actual canonical tensor power and its genuine H0. BOTH original
finite etale categorical differential adjoints are proved isomorphisms.
The entire honest two-map Picard-group kernel agrees with the original
divisor gluing presentation. Original arbitrary quadratic hypersurface
Part1 and its unique-largest addendum are also proved. These results passed
focused axiom audits and independent scope reviews; [RUN.md](RUN.md) links
their exact evidence and remaining gaps. Genuine cohomology/canonical degree,
full coherence and the actual finite Picard-scheme kernel are addressed by
the [three prepared manual requests](ResearchRequests/2026-10-03/INDEX.md).

The focused hypersurface block completes the ORIGINAL balanced binary and
rank-one plane clauses and the balanced actual formal-type clause, with
direct unequal binary and characteristic-five endpoints. It also constructs
the entire original toric polynomial/series basis, every displayed length
formula, true-inverse lower-unit coordinate transport, and actual finiteness
and rank bounds for every original positive-power quotient. The new scoped
audits cover 576 distinct transitive theorem declarations in 101 captured
files, only the standard three axioms and no forbidden dependencies.
All 29 new mappings compile; current 750 mapping rows resolve 730 declarations.
The [consolidated scope review](Coverage/frobenius_truncated_hypersurfaces_scope_review.md)
links direct proofs and evidence. That whole canonical source remains partial
only for [the actual compatible relative normal-form construction](Coverage/frobenius_truncated_hypersurfaces_remaining_normal_form.md).
