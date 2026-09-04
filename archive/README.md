# Archive policy

Files here are preserved but excluded from the active dependency graph.

- `status_snapshots/` contains dated or internally stale route summaries.
- `inconclusive/` contains computations whose proposed shortcut was shown to
  be compatible rather than contradictory.
- `redundant/` contains theorem-level special cases or independent endpoint
  checks already covered by stronger active files.
- `strategy_notes/` contains uncompleted plans superseded by sharper targets.
- `PROVENANCE.md` records the original workflow and has no proof content.

Open an archived file only when its exact historical calculation or warning
is relevant.  Do not cite an archive file as establishing an active gate.

## Cleanup log

- `145_SYMBOLIC_FINAL_LINE_SIMPLE_E50_CERTIFICATE.md` was archived because
  active file `148` supplies the missing layer reductions and includes its
  final-line obstruction.
- `160_E50_FINAL_LINE_SINGULAR_CHECKS.md` was archived because it only repeats
  the terminal no-common-root checks from active files `148`, `150`, and
  `156`.
- The original `open_theorem_prompts_2026_06_06.md` was deleted after its six
  prompt bodies were split into `tasks/01` through `tasks/06`.  The initial
  concatenated split was verified byte-for-byte with `cmp`; only the five
  obsolete inter-prompt dividers were then removed.  The omnibus remains
  recoverable from Git history.

No mathematical source file was hard-deleted: the missing provenance and
certificate artifacts make archival safer than irreversible removal.
