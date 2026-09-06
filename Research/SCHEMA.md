# Local research-library format

This is prose research, not a Lean-verified project. Prove2Me supplies
the separation of Definitions, Theorems, and Solutions; no platform API
is used. Paths below are relative to the repository root.

`Research/library.json` has `schema_version: 1`, `definitions: []`, and
`theorems: []`. A definition record has `id`, `title`, and `path`.
A theorem record has:

```json
{
  "id": "stable_snake_case_id",
  "title": "Exact scope, not a progress slogan",
  "statement": "Theorems/Thm_stable_snake_case_id.md",
  "solution": "Solutions/Sol_stable_snake_case_id.md",
  "status": "proved",
  "verification": "audited_prose",
  "definitions": ["correspondences"],
  "dependencies": ["other_theorem_id"],
  "audits": ["routes/global/audits/example.md"],
  "source": "routes/global/ORIGINAL_FILENAME.md",
  "scope": "Short limitation / applicability note",
  "statement_version": 1
}
```

`solution` may be null for open targets. Status is one of `proved`,
`conditional`, `open`, `refuted`, `superseded`. Verification is one of
`audited_prose`, `author_prose`, `primary_source`, `computation`,
`not_proved`. Neither a prose audit nor a successful workspace validator
is machine verification of mathematics. Do not invent an audit.

Optional `evidence_summary` records verdict, auditor, date, and brief
observations without loading audit bodies. Optional `legacy_dependencies`
lists repository-relative proof-input paths not yet promoted to theorem
IDs. These are explicit unpromoted dependencies, not verified DAG nodes.

Canonical definitions planned for this migration: `base_conventions`,
`correspondences`, `orbifolds`, `canonical_tensors`, `fixed_pair`,
`theta_cartier`, `wild_ramification`.

Statements contain explicit hypotheses and conclusions but NO proof.
Solutions contain the retained proof and cite the statement. Dependencies
are mathematical proof dependencies, not every document hyperlink.
Do not infer dependency edges by scanning links: forward consequence
links are not assumptions. External standard results stay cited in the
solution rather than becoming invented local theorem IDs.

The migration batches have been merged into the canonical registry and
their temporary fragments removed. Old source paths and compatibility
redirects are deleted; references point directly to canonical records.
The optional source path is now the retained proof record, not a required
historical filename. Unpromoted historical
notes remain indexed, with status `legacy_unreviewed`, and are not
silently treated as current theorems.

`Research/state.json` records `phase`, `active_target_ids`, `next_action`,
and `resume_after_migration`. `Research/STATE.md` is the short human/agent
continuation record. Validation must check that its target IDs exist.
