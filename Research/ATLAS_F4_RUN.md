# Rooted atlas computation: algorithm, ETA and exact scope

## Active selected14 hybrid queue — 2026-09-07,15:43 CEST

The complete pipeline is now `scripts/run_all_atlases.py`, with external
state in `/Users/julian/Documents/litt3-computation-data/atlas-all18/all18.json`.
The catalog retains all18 untwisted representatives, covering28,990 distinct
opers and multiplicity29,375. The user has DEFERRED orbit_0008..0011; only
the other14 are now scheduled. No whole representative is yet concluded.
Deferred jobs retain their status/data and are not mathematical exclusions.
The run does NOT include nontrivial3-torsion twists or settle Litt3.

    python3 /Users/julian/Documents/litt3/scripts/run_all_atlases.py watch

The restarted queue uses the exact predecessor-reuse pencil solver on F25
tail charts (B<=5,max300000rows), and the improved F4 backend on other fields
and harder charts. First chart22/23 certificates are adopted and skipped.
The specialized backend has NOT been ported to large coefficient fields.
The monitor now gives a numerical Fermi forecast, intermediate work counts,
and stage ETA. See [the explicit model](ATLAS_ETA_MODEL.md). Its current
~32.3year selected14 forecast is an uncertain current-code extrapolation, not a bound
or measured large-field runtime. `eta-json` exposes each chart budget and
all assumptions; `status` gives exact stages and selection. Watcher uses
448 charts, not576. Neither command wakes or launches an agent.

The15:42 restart(PID22802) used --defer orbit_0008 orbit_0009 orbit_0010
orbit_0011. Deferral persists on later launches; --resume-representatives
can restore selected cases when the user requests it. Existing checkpoints
and completed charts are retained.22 selection/controller/watcher tests pass.

The queue lazily builds each representative's exact tensor, exports all32
charts, and gives its solver a5minute slice (F4 uses10threads). It then
rotates to the next representative; saved internal work is resumed on its
next turn. Preparation is partly serial. Only one heavy algebra job runs
at once to respect the16GiB host. Existing first-case inputs and chart23
checkpoint are adopted in place, not regenerated. The two isolated code
paths have been replaced by generic loaders/builders/exporters.

    python3 scripts/run_all_atlases.py stop
    python3 scripts/run_all_atlases.py launch --threads 10 --pairs 1024 --slice-minutes 5

Stop waits for the active F4 round to finish and checkpoint. Builder stages
and individual tensor directions have restart files; an interrupted active
matrix or tensor direction itself cannot be resumed halfway. Failed or
memory-limited representatives are retained as `needs_attention`, not
repeated blindly or declared excluded; the other representatives continue.
To resume a particular F4 snapshot, stop the all18 queue and use the
single-directory command below with that representative's charts directory.
No automatic wake-up, Codex CLI invocation, or notification callback exists.

Validation: all18 loaded opers pass their original differential identities;
the first rebuilt tensor exactly equals the old cache; an exceptional
oper with h0(V)=3 passes the full construction. Generalized exporter cached
charts31/29/0 agree exactly, and a nontrivial coefficient tower roundtrip
passes. Eight orchestration/ETA tests pass. These are software checks, not
independent certificates of complete atlas exclusions. Valid-looking solver
output remains `basis_needs_verification`.

## Single-representative engine details and historical calibration

2026-09-07. No whole oper on the fixed genus-nine curve has been excluded.

## Run and watch

The inputs and large output live outside the repository:
`/Users/julian/Documents/litt3-computation-data/atlas-rooted-first`.
The manifest lists all32 exhaustive projective charts for the FIRST cached
untwisted oper. It is NOT a queue for all18 oper representatives or all twists.

    python3 scripts/atlas_f4.py watch

This displays only a time estimate or a terminal status. `eta` prints one
line. `stop` requests a safe completed-round checkpoint. To resume the queue:

    python3 scripts/atlas_f4.py run --threads 10 --pairs 512 --hours 2

To select a particular saved state, explicitly select its chart:

    python3 scripts/atlas_f4.py run --chart 24 --resume-from /absolute/path/state.cp --threads 10 --pairs 512

The queue defaults to descending charts (smaller cases first). `--min-chart`
selects an explicit complete trailing calibration range. The full queue
refuses to run against an incomplete export manifest. Re-running skips saved
completed jobs, but never equates their output with an independently verified
atlas exclusion. `run.json`, the active log and `rounds.jsonl` are live authority.

## What changed mathematically

[The proof](../Solutions/Sol_rooted_atlas_charts.md) replaces N(U,b^5)=0 by bilinear equations
n(v,b)=0 with coefficient roots and U=v^5. Write s for the rooted R tensor.
Then b=s(v,b)^5 and v.s=2 give the SAME finite reduced normalized scheme.
The proof uses reducedness; raw substitution would retain nilpotents.

In chart j, earlier b and s coordinates are zero, b_j=s_j=1, and the
remaining b_h equal s_h^5. An inverse variable enforces v.s !=0. These
disjoint charts remove the three redundant normalizations and omit no
direction. There are q=31-j remaining b variables and initially32 v
variables. The low-degree part has96-q affine bilinear equations. Exact
row reduction and affine elimination use only constant divisions. Fifth
powers are expanded sparsely by Frobenius, not general binomial expansion.
The exported F5 inputs add a satisfying a^2+4a+2; specialization back to
F25 and text readback were checked for every input. This is a coefficient
field encoding, not enumeration of F25-rational solutions.

Charts30/31 have explicit constant-combination certificates of1. Chart29
has a separately verified degree-one polynomial multiplier certificate of1.
These are only coordinate strata of ONE candidate. Positive test: all33
normalized genus-two solutions survive as11 projective directions.

## Computation and restart semantics

The exact F5 LA2 F4 engine uses up to all10 cores for parallel elimination.
Symbolic preprocessing and basis updates are partly serial; the process
is not expected to consume1000% CPU continuously. All arithmetic determining
solutions is exact. Floating point is used only for timing forecasts.

[The engine record](F4_CHECKPOINT_ENGINE.md) describes full basis/hash/
pending-S-pair serialization and its tests. Threads and pair caps can change
on resume. SIGUSR1 finishes the current round, writes a durable checkpoint,
and exits75 if incomplete. The previous checkpoint survives an interrupted
write. A very large active matrix cannot be checkpointed halfway through;
an emergency memory kill retains the last COMPLETED round. This limitation
is explicit, unlike the retired polynomial-only snapshots.

The source patch is `scripts/vendor/f4-checkpoint.patch`; tests passed against
the unmodified proven solver on six systems, including changed thread/batch
counts, corruption rejection, and signal-driven stop/restart. Tests are not
a certificate of any atlas exclusion. Completed basis files are labeled
`basis_needs_verification`; an exit0 without valid output is a failure.

The first64-pair calibration repeatedly built matrices with thousands of
old reducer rows for only64 new pairs. Profiling showed symbolic construction
dominating arithmetic. A512-pair resumption amortizes that repeated work;
the8GiB sampled RSS limit plus emergency threshold protects the16GiB host.

## What the ETA does and does not estimate

The forecast uses completed nontrivial cases, their free-coordinate counts,
Macaulay monomial counts binomial(n+d,d) for d=3..6, and measured pending-pair
growth/drain. It also fits observed exponential growth per added coordinate.
It does NOT cap the fitted growth at dense matrix multiplication's exponent:
that would hide rising solving degree and repeated matrices. A superseded
forecast is expanded, never held at an almost-finished percentage.

The band is a HEURISTIC SCENARIO RANGE, not a proved upper bound or calibrated
confidence interval. At first, with no solved nontrivial case, it explicitly
says calibration. Fixed-degree stages and first degree falls are NOT proof
of completion. Exact linear exclusions are not fitted as timings for hard
algebraic solves. The initial small-case times around2sec include process
polling overhead; once available, cases taking at least5sec are used instead.

Why increasing dimension matters: at65 variables there are864,501 monomials
through degree4,143,218,999 through degree6, and828,931,106,355 through
degree10. F4 exploits sparsity, so it need not construct all of them, but
replacing degree by a linear progress percentage has no mathematical basis.
Observed consecutive nontrivial tail cases initially took12,53,164sec.
The resulting3.7x growth per added coordinate is a WARNING against a cheap
all-chart extrapolation, not a theorem that this growth continues forever.

Generic bilinear-system analysis likewise uses degree growth and structured
Macaulay matrices, not raw equation count. Its genericity assumptions do
not hold automatically for these geometric tensors. In particular, known
weak-section geometry can have positive dimension, while the full Frobenius
system is finite. No generic bilinear regularity theorem is being applied
as a bound here. See [Baena–Cabarcas–Verbel](https://www.aimsciences.org/article/doi/10.3934/amc.2021047).

Finally, the12 new untwisted closed representatives have F25 residue degrees
1,2,13,17,40,124,205,220,403,578,718,7324, summing9645. They are NOT12 equal
cost jobs. Even an optimistic linear-in-field-degree scenario gives9645
first-field work units: one minute per unit means6.7days; one hour means
402days. These are explicit conditional workloads, not measured lower
bounds. They exclude tensor construction, six exceptional representatives,
and the387,420,489 torsion classes (which need structural/orbit treatment).
Thus this first-oper monitor is deliberately not sold as an ETA for
excluding all28,990 opers, let alone proving the common-cover counterexample.
