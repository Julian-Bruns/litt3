# Litt Problem 3 research workspace

[Problem 3](https://www.problemsilike.com/3) asks whether every two smooth
projective curves of genus at least two over Fbar_5 have a common finite
etale cover. We seek a counterexample. **The problem remains unsolved.**

## Continue the investigation

Read [update.md](update.md), then [Research/STATE.md](Research/STATE.md).
That short continuation record, not a historical file number or route
index, specifies the active strategy, last result, missing implication,
and next action. [AGENTS.md](AGENTS.md) contains the continuation contract.
The [post-enumeration roadmap](Research/AFTER_ENUMERATION.md) distinguishes
the current finite calculation from the cored and coreless exclusions
still needed for an actual counterexample.

## The research library

The layout adapts [Prove2Me](https://github.com/prove2me/prove2me_workspace)
for mathematical prose. The upstream workspace is cloned locally at
`reference/prove2me_workspace`; [provenance and differences](Research/PROVE2ME_ADAPTATION.md)
record the revision. Nothing was uploaded or represented as Lean-verified.

- [Definitions/](Definitions/): explicit conventions and active objects.
- [Theorems/](Theorems/): exact statements, hypotheses, and limits.
- [Solutions/](Solutions/): retained proofs, citations, and certificates.
- [Research/library.json](Research/library.json): stable IDs, evidence,
  and reviewed dependencies. Older proof-local inputs may be unpromoted;
  this is not a claim that every dependency has been catalogued.
- [Research/legacy_inventory.json](Research/legacy_inventory.json):
  searchable metadata for historical sources, not an endorsement of them.

Read statements first and only the proof needed for the current target:

```sh
python3 scripts/research_workspace.py frontier
python3 scripts/research_workspace.py show canonical_marked_quotient
python3 scripts/research_workspace.py dependencies canonical_marked_quotient
python3 scripts/research_workspace.py search nonabelian
python3 scripts/research_workspace.py proof canonical_marked_quotient
python3 scripts/research_workspace.py validate
```

Search and statement display do not load proof or audit bodies.
The validator checks paths, statuses, dependencies, and statement drift;
it does NOT check mathematical truth. [CLI details](scripts/README.md).

## Evidence and scope

Audit records are reference-only. Use their verdict, auditor, date, and
brief observations in the theorem metadata. **Do not open audit bodies
unless there is a concrete mathematical doubt or objection to investigate.**
An author proof, audited prose, and computational transcript are different
evidence levels. Algebraic-closure claims require more than finite sampling.

The [canonical marked-quotient theorem](Theorems/Thm_canonical_marked_quotient.md)
classifies all correspondences
preserving a specified reduced canonical-size marking. Arbitrary common
covers are NOT known to preserve such a marking. The
[genus-nine atlas bound](Theorems/Thm_fixed_x_orbifold_bound.md) still leaves
bounded cored cases and the coreless case unexcluded. The current extension
is the [cored ring and marking theorem](Theorems/Thm_cored_ring_and_marking_spectrum.md)
and its [exact local-normality criterion](Theorems/Thm_unimodular_atlas_normality.md).
The completed [local classification](Theorems/Thm_hermitian_local_normality.md)
and [global identification](Theorems/Thm_completed_local_orbifold_rigidity.md)
now identify the two large cases with Hermitian quotient stacks; whether
our chosen curve covers them is still open.
Use the continuation record for the next action, not this overview.

Keep both actual etale maps from the SAME source. Do not assume a
simultaneous Galois closure before establishing a core or finite relation.
The [cofinal saturation boundary](Theorems/Thm_raynaud_cofinal_saturation.md)
and [universal tensor slopes](Theorems/Thm_all_tensor_cartier_hn.md) must
not be retried as unrestricted obstructions. Checked
[Tango](routes/global/IGUSA_TANGO_COUNTEREXAMPLE_AND_RETAINED_SECTION_BOUNDARY.md),
[singleton](routes/global/CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md),
and [higher-weight](routes/global/DEGREE_NINE_FREE_CHARACTER_QUOTIENT_COUNTEREXAMPLE.md)
counterexamples remain essential boundaries, not counterexamples to Litt.

## Historical sources and maintenance

Promoted old paths are deleted; references lead directly to the canonical
records. There are no compatibility aliases for the migrated library.
Unpromoted material remains in `routes/`, `archive/`, and `tasks/`, indexed
conservatively and excluded from default rg/file discovery by `.ignore`.
Retrieve a needed older input through metadata search or its explicit path.
[Selective review](Research/migration/LEGACY_REVIEW.md) records reusable
older bundles, superseded cases, and status hazards. `STRUCTURE.md`,
`MISSING_INPUTS.md`, old frontiers, and task indexes are historical maps,
not the current continuation queue.

When changing scope, update the statement version, evidence, dependencies,
and hash explicitly; never silently relabel a hypothesis as proved.
Shorten naturally encountered superseded proofs, preserving genuinely
distinct lemmas and updating references directly. Do not retain redirects.
Refresh the short plain-language update
about hourly during active research, using a non-polling reminder.
