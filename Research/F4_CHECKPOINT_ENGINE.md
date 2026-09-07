# Exact F4 round checkpoints

External development copy only; installed solver was not modified. Build:
`make -j2`. Invoke this directory's `./msolve` wrapper, which selects its
newly built library. Supported checkpoint mode: characteristic 5, exact
linear algebra `-l 2`, no signatures, no tracer. Use `-g 2` for basis output.

Environment:

- `MSOLVE_F4_CHECKPOINT=/absolute/path/state.cp`: save at completed rounds.
- `MSOLVE_F4_RESUME=/absolute/path/state.cp`: restore after input initialization.
- `MSOLVE_F4_CHECKPOINT_INTERVAL=N`: save every N invocation rounds; default 1;
  zero disables periodic saves. Completion and requested stops always save.
- `MSOLVE_F4_STOP_AFTER_ROUNDS=N`: stop after N additional rounds, requiring
  a checkpoint path. A completed computation still returns success.
- `MSOLVE_F4_TELEMETRY=/absolute/path/rounds.jsonl`: append pre-LA and end-round records.
- `SIGUSR1`: with a checkpoint output path, set a flag; finish the active round,
  save, then exit 75 if pairs remain. The handler performs no IO/allocation.

Exit 75 explicitly means INCOMPLETE. No final reduction or basis export occurs
on this path. Exit 74 means checkpoint validation or IO failure. SIGTERM and
SIGKILL are not safe-stop requests and can lose progress since the last saved
round. A stop cannot interrupt a large in-progress matrix safely.

Version 1 is an algorithmic native-endian binary format, not a memory dump.
Header checks magic/version, byte order, primitive widths, field, variables,
monomial and elimination order, coefficient width, exact LA option, and a
fingerprint of the actual input coefficients/exponents. It stores basis rows
and coefficient associations, redundancy and leading-monomial arrays, every
active hash-table exponent and hash entry, full hash map, random hash weights,
divisor maps, the exact remaining S-pair queue with all references, and scalar
progress metadata. Scratch matrices and scratch hash tables are empty at this
boundary and are recreated. Function pointers are initialized normally.
Thread counts and pair batch sizes can change on resume.

The trailing FNV-1a 64-bit checksum detects accidental corruption; an entire
verification pass runs before checkpoint dimensions are trusted. Input identity
also uses FNV-1a. These are not cryptographic authentication. The supervising
wrapper should record and verify SHA-256 for input, checkpoint and source/build
identity. Native ABI compatibility is checked but cross-architecture portability
is not promised, and arbitrary future solver changes are not automatically
compatible with this version.

Saving writes a separate temporary file, flushes and fsyncs it, hard-links the
last snapshot to `.prev`, atomically renames the new file, and fsyncs the parent
directory. An interrupted save leaves the old current snapshot usable. Resume
requires an explicit chosen path; corrupt current snapshots are rejected rather
than silently falling back. The previous snapshot can be chosen explicitly.

Telemetry includes round/degree, pending pair counts and degree histogram,
number of minimum-degree pairs before selection, selected pairs, symbolic matrix
rows/columns/nonzeros before elimination, new pivots, stored basis count,
and selection/symbolic/LA/update/whole-round times. Histogram counts are the
post-update queue. Basis count includes redundant stored elements. Timings are
per round, and snapshot IO is outside the reported round time.
Both events have `unix_seconds` wall timestamps. The `pre_la` event is flushed
after symbolic preprocessing, before column conversion and linear algebra; its
dimensions and nonzeros help a supervisor assess the upcoming matrix memory.

Validation: `python3 checkpoint_test.py`. Tests include cyclic3/4/5,
nonhomogeneous chains with redundant inputs in 2/6/10 variables, early stop,
changed threads and pair caps, completed and previous snapshot reloads,
wrong input, corruption, and SIGUSR1. Results/logs are in `checkpoint-tests/`.
These are solver engineering tests, not a certificate for an atlas candidate.

## Primary hash garbage collection — 2026-09-07

The supported checkpoint engine now compacts the primary monomial hash table
after resume and at completed round boundaries when sufficient new hash entries
have accumulated. It retains ALL stored basis rows and ALL pending S-pairs.
Only monomial IDs change: every basis term and pending LCM is remapped, live
exponents and hash metadata are copied exactly, and the lookup map is rebuilt
with the existing triangular probing rule. The primary hash-object address and
shared random weights/divisor maps remain unchanged. Signatures and tracing
remain unsupported. Scratch matrices/hash tables are empty at these boundaries.

The first default scan starts at 1,048,576 hash entries. After collection the
next scan waits for twice the retained live count, with the same minimum.
A scan only rebuilds if at least one quarter of entries are dead or capacity
can fall by more than half. The new power-of-two capacity has at least 25%
headroom when shrinking. Thus the entire stored polynomial payload is not
rescanned for every small F4 batch. `MSOLVE_F4_HASH_COMPACT=0` disables this
optimization; `force` scans and compacts at every boundary for regression tests.
It does not change the native version-1 checkpoint format or input identity.
Existing `-u` does NOT invoke hash reset on this `core_f4` path; upstream's
reset routine also keeps its old capacity and temporarily duplicates exponents.

Telemetry adds `event: hash_compact`, round, degree, wall timestamp, old/new
entry counts and capacities, live count and collection seconds. Other event
types must be ignored when interpreting per-round matrix statistics.
`MSOLVE_F4_COMPACT_ONLY=1` requires explicit resume and checkpoint-output paths;
it loads, compacts and saves with no F4 round. It returns 75 if pending work
remains, zero only if the saved computation is already complete. Use a separate
output path when retaining the original snapshot for comparison.

The actual chart23 round48 snapshot shrank from 6,702,243,294 to 2,000,712,446
bytes. Retained hash entries: 374,053 of 41,245,173; capacity: 524,288 instead
of 67,108,864. Primary hash-array allocation falls by 7,856,979,968 bytes;
this is not a measured total process-RSS saving. Collection took 1.078 seconds.
No basis row could be dropped: all nine redundant rows still appear in pending
S-pairs. Measurements are saved in
`computations/f4_hash_compaction.json`.

Validation: `MSOLVE_F4_HASH_COMPACT=force python3 checkpoint_test.py` passed
all existing cases including six final-basis comparisons to the prior unmodified
engine. `hash_compact_compare.py OLD NEW` independently checks every stored
term reference, coefficient byte, polynomial header, pending pair field and
queue order, every retained exponent/hash record, leading-monomial arrays,
redundancy flags, shared hash data, and unchanged scalar progress. This passed
for all 386,499,599 terms and 623,614 pairs of the real round48 snapshot.
The engine also exactly validates every unique live exponent/hash record and
its new hash lookup before mutating any reference. These are structural exact
comparisons, not merely hash digests or sampled evaluations.

`hash_compact_test.py` reproduces the small regression suite. Optional
`--input INPUT --checkpoint OLD` adds sequential maintenance and one-round
disabled-versus-forced comparisons, leaving OLD untouched. The latter ignores
only the four elapsed-time counters, which naturally differ between executions.

The actual round49 differential also passed: starting from compacted round48,
two separate one-round runs used 10 threads and pair cap64, collection disabled
versus forced. All 388,231,520 terms and 625,837 queued pairs agree exactly
under the hash renaming, as do all compared state fields. This extra round's
compact checkpoint is `checkpoint-tests/chart23-differential-forced.cp`
(2,009,554,008 bytes); the unchanged maintenance snapshot remains
`checkpoint-tests/chart23-compact.cp`. Original `chart-23/state.cp` was never
overwritten. Full results and source/library/resume SHA-256 digests accompany
the repository measurement JSON. The updated vendor patch contains the engine,
collector and reproduction/comparison scripts and passed reverse dry-run.
