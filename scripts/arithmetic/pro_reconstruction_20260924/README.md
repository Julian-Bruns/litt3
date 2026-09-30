# Retained source: reconstruction, strict returns and trace

The retained source files are unchanged copies from the replies received
on 24 September 2026. A reproduction entry point has been added to the
degree-six suite. Large inputs, generated arrays, replay copies and
the isolated environment live outside this repository in
`../litt3-computation-data/reconstruction_returns_trace_20260924/`.
This path is relative to the repository root.

- `degree6/`: C++ producer and independent standard-library Python
  verifier for the complete 70-by-64 degree-six exclusion.
- `strict_return/`: actual Hom tensor reconstruction, geometric pencil
  certificate, stability data, verification entry point, and an
  unexecuted generator of the full strict-return equations.
- `epsilon_audit/`: the original actual étale counterexample verifier
  and audit, including the degree-n-minus-one improvement.

To generate and independently check the complete degree-six
certificate from the published source, run from the repository root:

```sh
python3 scripts/arithmetic/pro_reconstruction_20260924/degree6/reproduce.py \
  --output ../litt3-computation-data/reproduced-degree6
```

The output directory must be new. The C++ producer enumerates all
70 layouts and 64 phase choices, writes unit witnesses, and the Python
verifier checks the complete census and every exact identity. Both
use only the C++ and Python standard libraries.

The original integration also replayed the returned suites on copies
of their evidence directories outside the repository. It executed
these commands in the corresponding external `runs/` subdirectories:

```text
python3 verify_certificate.py
replay_env/bin/python verify_all.py --reconstruct
python3 verify_audit.py
```

The middle interpreter path is relative to the external batch root;
use its absolute path from `runs/strict_return`. Its environment was
Python 3.14.7, NumPy 2.3.5, Numba 0.65.1 and llvmlite 0.47.0.
The epsilon suite uses the Python standard library. All three passed.
The full-return Sage generator was not run and is not a decision
certificate.

The external `provenance.json`, `manifest_checks.json`,
`source_retention.json` and `integration_receipt.json` record archive
hashes, identical source copies and local checks. See the
[focused integration](../../../Research/audits/RECONSTRUCTION_RETURNS_TRACE_FOCUSED_2026_09_24.md)
for conclusions and limits.
