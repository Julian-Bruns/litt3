# Source and proof coverage

Run `python3 scripts/coverage.py` from this folder to inventory every
current Markdown theorem file, including uncatalogued results. The report
is saved outside the repository in
`../../litt3-computation-data/formalization-20261003/coverage.json`.
It records exact source and proof hashes, source status, dependencies,
ownership, checked components, and remaining gaps.
Every current source has a designated family owner, including newly arriving
records; reviewed owner fragments are counted separately from assignments.

Each owner writes a reviewed JSON coverage fragment in this directory.
Statuses have distinct meanings:

- `pending`: no reviewed formal coverage of the original result.
- `partial_component`: identified checked mathematical component(s), with
  an explicit gap to the full original statement.
- `complete`: the full canonical statement, with its original scope,
  has a formal proof and an exact statement review.

The open common-cover problem stays open. Source Markdown snapshots and
metadata do not count as formal statements or proofs. Compilation of a
numerical consequence does not complete its geometric theorem. Changes to
a reviewed source invalidate its coverage until the changed scope is checked.
