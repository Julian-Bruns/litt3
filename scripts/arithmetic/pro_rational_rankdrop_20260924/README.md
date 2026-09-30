# Retained rational reconstruction and quotient-incidence sources

The retained source files are unchanged copies from the two Pro reply
archives received on 24 September 2026. A self-contained reproduction
entry point has been added. Complete data, original
archives, upstream reports, manifests and actual replay logs are outside
the prose workspace at
[the evidence root](../../../../litt3-computation-data/rational_rankdrop_20260924/).
Its source_retention.json records every source SHA-256.

The rational suite's independent complete verifier passed every degree
7 through 26: 1,324,308 affine-symmetry layouts and 84,755,712 phase
cases. It reconstructed the residue spaces by partial fractions,
independently of the producer's polynomial matrices. The additional
Python reference audit is explicitly bounded; the native verification
is exhaustive. All 203 upstream manifest entries passed.

The rank-drop suite passed both the independent Laurent verification
and the full tensor reconstruction, including all auxiliary solutions,
the geometric projective-line fiber, and the actual rank-one maps.
All 26 upstream manifest entries passed.

To regenerate the rational certificate from published source, run
from the repository root:

```sh
python3 scripts/arithmetic/pro_rational_rankdrop_20260924/rational/reproduce.py \
  --output ../litt3-computation-data/reproduced-rational --jobs 4
```

The output directory must be new. The default covers all degrees
7 through 26; `--n 7` runs one degree. The C++ producer creates each
compact witness file, and the independent C++ verifier reconstructs
its residue spaces by partial fractions. The wrapper checks orbit
coverage, case counts and full-range totals without the original
certificate archive or its manifest. It needs a C++17 compiler and
Python's standard library.

To verify the retained original archive instead, run
`python3 verify.py --jobs 4 --output verification-output` in the
complete external `runs/rational` directory. Run
`python verify_all.py --tensor` in `runs/rankdrop`, using Python
with NumPy and Numba. The retained logs record NumPy 2.3.5,
Numba 0.65.1, Python 3.14.7 and Apple Clang 21.0.0 on arm64.

The local continuation
[rank_drop_pencil_first_pullback.py](../rank_drop_pencil_first_pullback.py)
checks two exact first-Frobenius maps using the independent arithmetic
and retained fiber data. Semilinearity proves that every geometric
pencil member has a negative-degree line quotient after one pullback,
hence no positive strict Frobenius period. It is not a point scan.

The canonical conclusions are
[complete d=3 exclusion](../../../Theorems/cartier_and_spin/new_line_low_pole_reconstruction.md)
and [rank-three return geometry](../../../Theorems/cartier_and_spin/rank_three_extension_return_geometry.md).
The original common-cover problems remain unsolved.
