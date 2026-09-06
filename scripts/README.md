# Research workspace CLI

Run from any directory with Python 3.9 or later; only the standard library is used.
The repository containing the script is the default root. Every command accepts
`--root PATH` for another workspace.

```sh
python3 scripts/research_workspace.py validate
python3 scripts/research_workspace.py show THEOREM_ID
python3 scripts/research_workspace.py proof THEOREM_ID
python3 scripts/research_workspace.py dependencies THEOREM_ID
python3 scripts/research_workspace.py frontier
python3 scripts/research_workspace.py search WORDS
python3 scripts/research_workspace.py inventory
python3 scripts/research_workspace.py stamp
python3 -m unittest discover -s tests -v
```

`show` prints the statement preceded by compact registry metadata: status,
verification, optional evidence summary, and audit paths. It never reads solution
or audit bodies. Definitions display their original text without a metadata
prefix. `proof` explicitly prints the solution. `search` reads registry and inventory metadata only, returns up to 20
matches, and requires every search word to match. It never loads statement,
solution, or audit bodies. `dependencies` includes definitions and theorem
dependencies; shared nodes are expanded once. Optional `legacy_dependencies`
paths appear as unpromoted proof inputs, and validation checks that each exists
inside the repository. These paths do not imply reviewed theorem status.
`frontier` prints `Research/STATE.md`.

Only `inventory` and `stamp` write JSON. Inventory indexes Markdown in `routes`,
`archive`, `tasks`, and top-level notes, excluding administrative top-level files.
It stores path, first heading, SHA-256, byte count, and a conservative classification;
classifications are discovery hints, never mathematical verification. Inventory
generation reads source files to compute metadata but stores no bodies.

`stamp` adds missing statement hashes. If any existing hash differs, it fails
without writing. Intentional statement revisions require explicit review and
registry hash maintenance; running `stamp` cannot conceal drift. `validate` checks
registry structure, references, paths, dependency cycles and statuses, optional
hashes, unregistered canonical files, and proof headings in statement files.
It does not inspect solution bodies
or certify mathematical correctness. Its exit status is nonzero on errors.
