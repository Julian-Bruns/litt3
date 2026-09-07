# Exact native parallel prefix reduction — 2026-09-07

The selected14 production queue now passes --threads10 to BOTH native F25
and F4 solvers. Native code is C++17, compiled with -O3 -pthread. Persistent
workers wait on condition variables; no spin loop or per-coefficient task
launch is used. Python/Sage prepares and verifies; C++ does elimination.

## Why the parallel work is exact

Take a batch of upcoming source rows whose chosen predecessor rows all
precede the batch. Its seed rows and the existing pivot table are fixed.
Each worker reduces one seed against that immutable table, stopping at its
FIRST nonzero column without a pivot. Rows are then committed serially in
the original order, continuing reduction with any newly admitted pivots.

This gives exactly the serial row, not merely its rowspace: all columns
before the worker's stopping point have been made zero. A new pivot there
would have zero multiplier; pivots further right cannot affect earlier
columns. Therefore the worker operations are the identical initial segment
of the full serial reduction. Ordered continuation gives the same normalized
pivot and identical ordered provenance edges. Induction over committed rows
proves equality of every saved prefix. The predecessor translation theorem
continues to justify the seeds themselves.

Reading ahead records each row's input-end offset separately. Checkpoints
use the last COMMITTED offset, not the stream's read-ahead position. Pending
speculative rows may be discarded at a limit. Checkpoint v2 and polynomial
provenance formats are unchanged. Only the explicitly verified old engine
hash is permitted as a compatible checkpoint migration.

Batch size defaults to40 for10workers, decreases for predecessor dependencies
and memory limits, and uses at most a conservative256MiB speculative budget.
Pivot insertion, checkpoint writes, and certificate expansion remain serial;
constant1000% CPU or10x speedup is not claimed. Speculative arithmetic counts
may exceed committed-row arithmetic; only the latter enters saved reductions.

## Evidence

`scripts/test_native_pencil_parallel.py` compares the preserved serial engine
against new1/10worker runs: random sparse rows including zero rows, actual
chart28, and zero predecessor descendants. Mathematical checkpoint bytes,
entire DAG, and certificate bytes agree. Old-engine prefix checkpoints resumed
with10workers agree both at the intermediate39-row prefix and at completion.
Results: external atlas-parallel-prefix-tests/verification.json.

Full actual chart23B4: exact original-equation unit certificate,38710rows,
440 pure-b relations. Checkpoint mathematical bytes, DAG, weights, selected
relation and all pure-b rows match the old serial result exactly. Native
15.95sec versus29.80sec; end-to-end25.23sec versus38.27sec. Evidence external
atlas-parallel-b4/chart-23/result.json. This is not a new atlas exclusion.

Production restarted15:53 PID34384, selected14 only, from chart21B5 checkpoint
85463rows. At15:54 the native process reported10workers,advanced beyond85824
rows,and measured808.4% CPU. Monitor displays native-worker count.
No wake-up was armed. Large fields still use F4, not native F25 arithmetic.

The user-stop path was also fixed: a paused native job is not a failed
bounded ansatz. The one invariant_0/chart22 attempt affected by the old
stop handler was explicitly relabelled user_paused_checkpoint_retained;
its files were retained and it resumes rather than falling back spuriously.
