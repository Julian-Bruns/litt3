# Bounded F5 exact-sparse bitmap allocation patch

Validated local executable:
`/tmp/litt3-msolve-lowmem.bQGL6w/msolve-0.10.1/msolve`.
This directory preserves patches and test metadata, not a duplicate source
checkout. The build directory above must stay present while its jobs run.

Built 2026-09-06 from a separate copy of msolve 0.10.1. Original source,
binary, and pre-existing solver processes were not changed or signalled.

Run the wrapper at `msolve-0.10.1/msolve`, retaining its surrounding build
directory. The wrapper loads the copied `src/neogb/.libs` dylib. Set
`LITT3_MEMORY_REPORT=1` to print each avoided allocation on stderr.

The patches are `symbol.patch` and `la_ff_8.patch`. Both skip bitmap rows
only when field characteristic is 5, linear algebra option is 2, and trace
level is NO_TRACER. The pointer arrays remain allocated and zeroed, so
upstream free loops remain valid. Other modes retain bitmap allocation.
No polynomial, reduction, or pair-selection arithmetic was changed.

`symbol.c` savings per matrix are
`4*nrl*ceil(nru/32)` bytes. This is avoided allocation, not a measurement of
physical RAM saved: untouched calloc pages need not have been resident.
The `la_ff_8.c` interreduction savings are `4*ncols*ceil(ncols/32)`;
that older/saturation/signature code path was not exercised by the ordinary
F4 regression runs below. Current ordinary F4 final reduction uses the
symbolic preprocessing path, not that interreduction function.

Validation:

- Build completed with `make -j2`.
- Eight upstream finite-field scripts passed: groebner-g2, cyclic5-16,
  cyclic5-31, eco6-16, multy-16, nonradical-shape-31,
  nonradical-radicalshape-no-square-31, and nf-16. The full upstream suite
  was not rerun; in particular the slow linear1-qq test was not run.
- The invariant and c4-zero inputs were each solved with both binaries at
  `-t2 -l2 -m500 -g2`. Corresponding output files were byte-identical.
- Copied independent Sage export checked containment of original equations
  and F25 quotient dimensions 55 and 330. Checkpoints are under the local
  `Research/computations` directory, without overwriting workspace data.
- `c4_zero_oper_msolve.in` was absent in the workspace, so the existing
  generator was rerun with `--full --c4-zero --msolve-input` in this temp
  directory. No mathematical input was invented or modified.

The normalized pilot uses `-t2 -l2 -m500 -v2 -g2` and a 180-second alarm.
Its logs are `normalized-pilot.log` and `normalized-pilot-memory.log`.
An incomplete pilot output is not a basis certificate or a checkpoint.

Pilot result: stopped automatically at 180.06 seconds (exit 142, SIGALRM).
The owned pilot process is gone. It reached degree 7 and subsequent degree
falls, without completing the basis. Across 91 reported matrices the
largest avoided bitmap allocation was 3,150,000 bytes; total allocated
bytes avoided across those successive matrices were 74,802,280 (not a
simultaneous memory saving). `/usr/bin/time -l` reported maximum RSS
1,099,874,304 bytes and peak footprint 1,453,016,600 bytes. This is not a
controlled speed comparison, nor a guarantee of the eventual memory peak.

Binary SHA256 (`.libs/msolve`):
`733b88e446f96d994452fc9e5f97671650492993e4e8e6a0ee5318583775fd21`

Patched dylib SHA256 (`src/neogb/.libs/libneogb.3.dylib`):
`15f41bd85cbf379cd38b47bb010a5b542346fd3ee966a0712a201b17ca27869b`
