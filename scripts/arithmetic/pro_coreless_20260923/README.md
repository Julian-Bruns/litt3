# Retained Pro certificate sources

These are unchanged mathematical source files from the three archives
returned on 23 September 2026. The original ZIPs, reports, manifests,
generated matrices and focused replay logs are retained outside this
workspace in `../../../../litt3-computation-data/`, under
`coreless_primitive_returns_20260923`.

Use `../replay_coreless_primitive_returns.py` with an external output
directory. The upstream runners generate files beside their sources;
the wrapper copies sources to the external directory before running.
Do not run the upstream runners in this source directory.

Recognition uses SymPy and a C++17 compiler; rank3 uses NumPy; plane
uses the Python standard library. On this Mac, `sage -python` supplies
the two Python dependencies. The wrapper provides the small portable
header needed to compile the unmodified C++ source with Apple Clang.

The scripts certify the finite calculations, not the unrestricted
recognition, finite-coefficient or admissible-line existence problems.
