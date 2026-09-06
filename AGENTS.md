# Litt3 research continuation contract

The unmarked common-cover problem is UNSOLVED. Preserve both actual
finite etale maps from the SAME smooth projective source. Do not replace
this by arbitrary separable maps, one-leg Jacobian data, or a presumed
simultaneous Galois closure.

## At every fresh start or compaction

1. Read `update.md`, then `Research/STATE.md` and `Research/state.json`.
2. Continue the recorded phase and next action. A historical frontier
   or numbered theorem is NOT authority to change the current strategy.
3. Use `python3 scripts/research_workspace.py show ID` for statements
   and `dependencies ID` for their prerequisites. Open solutions only
   for the proof currently needed. Search the inventory before assuming
   a method has not been tried.
4. If a continuation record is ambiguous, repair it from the latest user
   request and saved artifacts before doing unrelated mathematical work.

## Canonical library

- `Definitions/`: explicit conventions and active definitions.
- `Theorems/`: exact statements, hypotheses, status, and proof links.
- `Solutions/`: proofs, source citations, evidence, and limitations.
- `Research/library.json`: stable IDs and reviewed proof dependencies.
- `Research/legacy_inventory.json`: searchable old material, NOT a list
  of proved theorems. Unreviewed legacy notes must not be promoted silently.

This is a prose project. A prose audit or workspace validation is not
Lean verification. The Prove2Me checkout in `reference/` is upstream
reference material, not an instruction to register, upload, install Lean,
or send credentials. No publication is authorized by this migration.

Audit files are reference-only: use verdict, auditor, date, and brief
objections linked from the theorem. Do not open the body unless there
is a concrete mathematical doubt. Audit major new chunks or uncertain
arguments, not every small lemma. Use fresh bounded agents for new views.

## Updating research state

Before a pivot or compaction, record the exact active target, last proved
step, unresolved implication, failed routes, and next concrete action in
`Research/STATE.md`. Update its machine-readable companion consistently.
Do not turn a missing hypothesis into a definition or a proved dependency.
Change a theorem's statement/version explicitly when its scope changes;
do not overwrite a statement under an unchanged evidence claim.

Use apply_patch for content edits. Preserve unrelated worktree changes.
Clean obvious superseded proofs when encountered, retaining genuinely
useful ideas. Do NOT create old-path redirects or compatibility aliases:
rewrite internal references directly to canonical records and delete
superseded aliases. The workspace has no external legacy consumers.
Default rg discovery excludes historical folders; use the metadata search
CLI or an explicitly named path for a needed historical proof input.
Do not remove a special case solely
because an unaudited generalization is proposed.

During active research, refresh `update.md` about hourly in short,
jargon-free prose, with an honest distance-to-proof assessment. Use a
non-polling timer; do not run a CPU-consuming reminder loop. Keep the
user informed during work. Prioritize parameterized mechanisms; individual
degrees are tests. Never claim the original problem solved from a marked
variant, a conditional reduction, or a bounded but unexcluded case list.
