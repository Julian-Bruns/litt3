# Native F25 first-representative laboratory

2026-09-07. Implemented `scripts/run_native_f25_atlas.py`. This is an isolated
native coefficient backend for the first cached untwisted representative.
It does not modify the production queue, exported inputs, or F4 checkpoints.

```
sage -python scripts/run_native_f25_atlas.py --chart 23 \
  --output /absolute/path/to/empty/laboratory-directory \
  --seconds 300 --memory-gib 2
```

The backend changes the actual Singular coefficient domain to
F5[a]/(a^2-a+2), removes `a` from the polynomial variables, and removes its
defining equation from the ideal. Sage verifies every original polynomial
maps to the native polynomial and lifts back modulo the defining polynomial.
It then checks every polynomial printed by the actual Singular parser back
in Sage. These are exact polynomial checks, not random evaluations.

The completed input stage saves `native-input.sing`, `solve.sing`, and
`validated-input.json`. The latter reports the equation bidegrees and separates
the row-reduced mixture of N/chart-s equations from Frobenius compatibility
and admissibility equations. Individual N/s provenance remains in the original
`initial_rref.json`. The solver always receives all equations.

`singular.log` retains the full `option(prot)` degree/matrix progression.
`events.jsonl` records wall time, sampled RSS, CPU time/utilization, and protocol
tails every ten seconds. RSS is sampled every quarter second; short processes
may finish between samples. Time/memory limits stop the solver, and SIGINT or
SIGTERM requests save a `stopped` result. The memory threshold is a sampled
RSS threshold, not a strict address-space limit. Signal the `worker_pid`
reported in the first event: the installed `sage` executable is a shell
wrapper, and signaling that wrapper PID does not reliably stop the worker.

There is **no internal critical-pair checkpoint**. Interruption preserves the
verified input stage, but the native solver stage restarts from the beginning.
All finished bases are explicitly candidates; neither exit0 nor a unit basis
is automatically counted as an independently verified exclusion.

## Validation

- Chart29: both roundtrips PASS; unit-basis candidate,0.565sec total.
- Chart28: both roundtrips PASS; unit-basis candidate,0.826sec total.
  A subsequent metadata revision passed chart28 again in0.879sec.
- Both agree with the independently verified polynomial certificates already
  saved in `atlas-mixed-certificates/chart-29` and `chart-28`.
- Chart23: both roundtrips PASS in2.857sec;97 equations,88 low-incidence,
  eight Frobenius, one admissibility;23,873 native terms. Solver reached the
 300sec limit, still in protocol degree3, with peak sampled RSS522,829,824
  bytes (about499MiB), using one CPU core. **No result/exclusion**. Singular
  returned0 after termination; the adapter correctly recorded `time_limit`.
- Final worker-PID SIGTERM test PASS: stopped in3.946sec total, saved the
  completed input stage and `stopped` result, and terminated the native child.
- An earlier test signaling the Sage shell wrapper failed to produce a result
  artifact. No process remained afterward. This exposed the wrapper-PID caveat
  above; its evidence remains in `atlas-native-first-v3/chart-23-stop`.

Artifacts are external in
`/Users/julian/Documents/litt3-computation-data/atlas-native-first-v1/`;
the subsequent metadata test is in `atlas-native-first-v2/chart-28`; the final
safe-stop test is in `atlas-native-first-v4/chart-23-stop`.
No whole oper is excluded. The original common-cover problem remains unsolved.

## Why the existing F4 engine was not patched

Its 8-bit kernels use integer modular inverses and delayed integer
multiply-add reduction modulo the prime; ARM NEON kernels also multiply
integer bytes. A native extension-field port additionally changes basis
normalization, coefficient import/export, and checkpoint domain metadata.
Setting the prime to25 would be incorrect. This laboratory instead uses the
installed exact native Singular domain while preserving the existing F4 work.
