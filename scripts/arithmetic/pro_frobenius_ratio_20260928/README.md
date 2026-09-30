# Retained exact source: complete root-nine ramification exclusion

Byte-identical source from `frobenius_ratio_complete.zip`, received
28 September2026. The original archive manifest and provenance are in
`../../../../litt3-computation-data/frobenius_ratio_complete_reply_20260928/`.
The source directory structure is retained. Runtime data, compiled
libraries, arrays, checks and restart chunks belong outside this repository.

The complete executable package is in the external `frobenius_ratio/`
directory. From there, on this Mac:

```sh
CPATH=/opt/homebrew/opt/gmp/include \
LIBRARY_PATH=/opt/homebrew/opt/gmp/lib WORKERS=4 bash verify.sh
PYTHONPATH=src python3 src/check_bezout_hasse.py
```

This rebuilds from the retained source, replays all required boundaries,
regenerates the global model and all missing resultant cosets, reconstructs
the exact polynomials and checks the unit identity. Reusing cosets is valid
only with identical source and inputs. The local integration replay used
a fresh directory with no model, cosets or reconstructed polynomial cache.

No GMP gcd discovery is needed to verify the retained Bezout witness.
The additional Hasse checker uses no GMP polynomial multiplication.
See the canonical theorem and its audit for the precise scope; this
closes the ordinary-double-root stratum, not the entire root-nine family.
