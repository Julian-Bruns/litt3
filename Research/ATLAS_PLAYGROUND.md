# Solved-chart runtime playground

## Sept9 13:56: full normalized low-degree generator comparison

Four one-core60-second Singular tests, external
`n-hybrid-comparison-20260909-EiVm0t`, all ended `time_limit` at degree3.
No new unit candidate or exclusion. `check_rooted_inverse_cup.sage` now
has controlled `--include-n` and `--compact-only` switches; all32
Frobenius equations and the correct projective scale/guard are retained.
This is a solver-order experiment on EXISTING equivalent criteria.

| Chart/system | Equations/variables | Input bytes | Build seconds |
|---|---:|---:|---:|
|23 inverse|105/41|5,869,533|5.68|
|23 compact|97/41|603,844|2.40|
|23 inverse plus N|169/41|6,161,950|6.18|
|21 inverse plus N|169/43|7,565,620|6.55|

Compact23 and hybrid23 elimination trajectories are almost identical;
hybrid adds72 pending pairs. No acceleration is demonstrated. Do not
extend these tests unchanged. Existing native coefficient-table kernels
can handle arbitrary polynomial Macaulay rows (not just weak linear-v
generators) provided their repeated-multiplier layout is respected; a
useful full-normalized multiplier design has NOT yet been implemented.

Updated 2026-09-09 02:29 CEST. User requested an unfinished medium
10min-1h run on10 cores. It is COMPLETE: external
`chart21-b5-lanczos-medium-20260909`, sibling.log,259259columns,
258258rows,66399333nonzeros. Input is saved orbit_0000 chart21b5;
old elimination stopped after210432rows without a result. Finished585.891s,
peak memory911.6MB, measured average2.646cores with10workers enabled.
EXACT DUAL, independently replayed6.70s: this b-only5 unit ansatz is
impossible, NOT an atlas existence result. Do not repeat the bounded run.
Do not confuse this with the completed chart21 mixed(1,2) dual.
No Pro or ordinary agents. Every accepted result needs exact scalar replay.

## Parallel scaling learned from the medium run

User correctly questioned2.7-core utilization. All10threads exist, on a
4performance+6efficiency-core Mac. Sampling shows serial BLAS calls and
OpenMP synchronization. No solver sleeps; logging every2000steps and
watcher refreshing5s do NOT set the step rate.

New `gram_team` keeps one OpenMP team across5stages, executes3independent
field-component GEMMs concurrently, and dynamically balances array loops.
On the SAME chart21 matrix, exact scalar comparisons passed. Typical
old Gram1.53--1.65ms; new1.24--1.31ms (rough20--25% time reduction).
New ten-thread CPU use4.6cores; four-thread new1.31ms/3.3cores.
Forcing ACTIVE waits5ms raised usage9.6cores but slowed Gram to2.4--2.5ms.
Do NOT enable busy waiting to inflate CPU usage. Use passive waits.
Replaying only the final saved checkpoint with the new kernel returned
the byte-identical exact dual in5.09s, `chart21-b5-team-tail-verification-20260909`.
Enable native solver via ATLAS_GRAM_TEAM=1 VECLIB_MAXIMUM_THREADS=1
OMP_WAIT_POLICY=PASSIVE; worker count remains its normal CLI argument.
Sources and profiles: `chart21-team-*-benchmark-20260909.log` externally.
These improvements alone do NOT make all18 feasible. Fermi same-chart
b-degree6~52min,b-degree7~4.7h, assuming column-count times multiplier-count
scaling from8min degree5. Larger fields and harder charts uncalibrated.
User given months-to-years literal all18 extrapolation, NOT completion ETA.

Test object: already-excluded first-oper chart23. A unit certificate from
its weak necessary equations excludes the chart, but failure of a bounded
ansatz does not decide the full atlas. No whole representative is excluded.

## Same-input completed comparisons

Matrix: 130680 by 92445, 25362315 nonzeros. Original 88 equations and
multiplier bidegree (1,2). All data under the external computation folder.

| Method | Complete solve | Gram applications | Exact certificate |
|---|---:|---:|---|
| Original sparse scalar Wiedemann | 1358.76 s | 275274 | PASS |
| Coefficient-table fused Wiedemann | 209.67 s | 275274 | Same bytes |
| Look-ahead Lanczos prototype | 88.98 s | 91737 | Same bytes |

Independent original-polynomial verification of the identical certificate
already passed in 11.91 s; scalar matrix replay of the fused output passed
again in 2.73 s. Equal files were compared, not merely matching statuses.
The 89-second run spends 64.0 s on Gram products, 15.2 s on projections,
3.74 s on small Gram matrices, 5.64 s updating the solution. Look-ahead
block sizes 1/2/3/4 occurred 84433/3448/128/6 times. No zero was inverted.

Files: `chart23-playground-fused-20260909` and
`chart23-playground-lanczos-20260909`, with sibling `.log` files.
Sources: `atlas_wiedemann_native.cpp`, `atlas_lanczos_native.cpp`,
`atlas_macaulay_factor.hpp` under scripts.

IMPORTANT comparison boundary: an older predecessor-reuse solver used a
different multiplier space (b-degree 4, no v multipliers) and finished
chart23 in 38.27 s. The table is a genuine 15.3x same-input improvement,
not a claim to have beaten every older method on this chart. Compare that
different certificate space too before choosing a production backend.

## Recorded experiments (completed; current queue is in STATE)

1. Block-width test DONE. Fused-table per-direction times at widths
   1/2/4/8/16: .692/.659/.707/.772/.697 milliseconds. No material gain.
   Sparse SIMD16: .433 ms per direction, a possible1.6x kernel gain only.
   Full block-Lanczos not implemented on this weak evidence.
2. Thread test on b-only degree4 matrix: 1/2/4/10-thread fused Gram times
   .469/.325/.244/.356 ms. Full4-thread solve26.13s overlapped four Sage
   exports: NOT a clean single-run comparison. Do not claim it faster.
3. b-only degree4 Lanczos DONE18.24s native versus old29.80s native
   (old38.27s included setup). Original-polynomial replay4.07s PASS.
   New weights SHA137df2522172598a446ac71c7d2c4ef70cc7ec098bfbcef0f0494a55f71e01de.
4. Ten STRONG projective-chart layout/order tests DONE, all45-CPU-second
   limits (about48s elapsed), no returned unit. Plain / six-chain / graph
   lift / factor lift; full, reordered, and fixed-Frobenius-only subsets.
   External `chart23-projective-layout-tests-20260909/results.json`.
   Earlier `chart23-strong-*` tests mistakenly ALSO fixed v.s=2 and thus
   tested a smaller slice; discard those timings as chart comparisons.
   Correct projective inverse is B Gamma=(v.s/2)I plus w(v.s)=1.
   In chain coordinates b_new=C b_old, s_new=C^[5]s_old; impose the SAME
   ORIGINAL b chart. Corrected exporter records projective_inverse_scale.
5. Ten ONE-thread Lanczos tests DONE on same b-only4 matrix, modes
   0=random diagonal,1=identity,2=equation-only,3=multiplier-only,
   4=product of equation and multiplier weights; two seeds. External
   `chart23-structured-MODE-SEED-20260909(.log)`,60-second limits.
   ALL returned checked units in57.8--59.2s while ten jobs overlapped;
   ALL used41679steps. Retaining the tested symmetries did NOT lower
   Krylov degree. Identity mode's two seeds give the same trajectory;
   their repeated timings are noise controls, not distinct mathematical tests.
   All results require original scalar primal/dual checks, not a presumed
   Gram-rank identity. No all18 or unfinished-chart run.
6. DONE: clean sequential1/4/10-thread b-only4 Lanczos runs, external
   `chart23-clean-thread-N-20260909(.log)`. Previous4-thread full run
   overlapped exports and is unsuitable as a standalone benchmark.
   Clean timings26.15/14.96/17.90s. The OLD parallel predecessor method
   already had15.95s native on this smaller matrix, so the large15x gain
   applies only to the mixed-matrix comparison above, not to every method.
7. Ten term-first module orders45s each all timed out with growing bases;
   external `chart23-module-term-first-20260909`. No measured speedup.
8. Constant-block Schur prototype: rank33 block removed16335variables,
   reducing41679to25344. Exact pivot and adjoint tests passed, but each
   Gram product rose from.249to.679ms, giving an estimated1.66x SLOWDOWN
   overall. External `chart23-schur-kernel-20260909.log`. Discarded code;
   idea retained only here. No complete solver/proof was built for it.

Look-ahead Lanczos now has atomic20s checkpoints with input/configuration
fingerprints and payload checksums, plus SIGINT/SIGTERM checkpoint exit.
A forced2s stop/resume on chart23b4 produced the byte-identical previously
verified certificate. External `lanczos-resume-test-20260909`.
It accepts ONLY a separately scalar-replayed original matrix primal/dual. An
unfinished/degenerate Krylov search has no negative geometric meaning.
The scalar Wiedemann backend remains resumable and has primal/dual checks.
All new native kernels currently support F25, not all 18 coefficient fields.

The inverse-free Q frame now has an exact all12 census-algebra certificate,
but it has not yet been integrated into the atlas solver. The six exceptional
opers, full Frobenius conditions and higher normal coranks remain in scope.

## Sept9 overnight: column congruence and exact support components

Column scaling changes the candidate operator to E M^t D M E, E_last=1.
Every certificate is converted back and independently checked against M.
100 small rank-deficient F25 cases gave91 certificates unscaled and96
scaled (7 repaired,2 regressions); neither mode is a guaranteed solver.
The original inv0chart21 ending had Mw=0 but w_last=0. Its fresh scaled
run finished538.125s onONEcore with an exact bounded dual, independently
replayed2.233s. This is NOT an atlas existence certificate.
External lanczos-invariant0-column-test-20260909.

The support graph of inv0chart21 has3components. Only the component of
the target column matters:86717cols/86233rows/7195853terms instead of
259259/258258/21507486. Grouping multipliers by their surviving equation
mask retains three small coefficient-table products, not dense elimination.
inv0chart20 has the same3-way split; orbit0chart20 hasONEcomponent.
The new backend automatically falls back to the original persistent-team
operator when nothing is pruned.

100small independent tests passed with component pruning. A real saved
inv0chart21 tail produced a BYTE-IDENTICAL dual in9.792s vs17.761s,
with2.53x measured Gram-kernel speedup. External
lanczos-component-tail-u7VUtS. After adding the full-component fallback,
20additional tiny independent replays passed; no new large test was run.

DEPLOYED in quiet queue with atlas_lanczos_components_v2_native,
--components --column-scaling auto, FOURworkers. Existing checkpoints
retain their exact column mode (v1=0,v2=1); only fresh jobs use scaling.
Resumed orbit0chart19 at148053steps, initial scalar comparison PASS,
about3.05actualcores. One-component fallback active on this chart.
Then-controllerPID94832/session86555. All original matrix AND polynomial
certificate checks remain. No whole representative excluded.

## Sept9 04:50: global recurrence guard and weak-point skip

orbit0chart19 ended inconclusively after600237steps, exceeding its
519792rows. The saved previous/last A*v vectors have last coordinates
18,2: a violated GLOBAL orthogonality invariant, although adjacent-block
checks still pass. Independently computing BOTH original scalar M^t D M
products reproduces the saved vectors exactly. The cause of the earlier
loss is NOT identified; no accepted certificate is withdrawn. Full-history
small tests pass. A fresh850step real-chart diagnostic passes too.

Guarded v3 checks (A*w)_last=0 after the initial block, plus the rank
bound min(active rows,active columns). These are search guards, NOT
negative certificates.20small cases/two column modes produced39/40
independently passing certificates. Test receipt outside repo:
lanczos-guarded-v3-tests-20260909/summary.json.
SHA0a04233365544de0f920ceca7d784336ab418e825ff4a99831c06225e868c3d8.
DeployedPID14670/session64007, chart21degree6 resumed37633steps with
FOURworkers. inv0/1chart19 both completed with exact bounded duals.

Exact positive WEAK points on orbit0charts0,4 are now replayed at queue
startup and skipped, not marked excluded. The chart4 point even satisfies
ALL N/R, but U.beta=0. Neither is an atlas. See atlas_weak_points.json and
verify_atlas_weak_points.py. Weak-only unit searches cannot help there at
ANY degree. ATLAS_NORMALIZED_PENCIL.md retains the missing normalization
in an exact98-row/33-linear-unknown formulation; speed remains untested.

## Sept9 06:45: five more impossible weak-only searches removed

One/two-coordinate positive searches took0.14/0.11/0.11s on orbit0,
invariant0,invariant1, respectively. They found witnesses on orbit0charts
0,1,4 and both invariant charts0,2. ALL seven satisfy all N/R but have
normalization0, so NONE is an atlas. Original-tensor standard-library
replay passed for all seven; receipts are in atlas_weak_points.json.
The checker now accepts multiple separately hash-bound original sources.
Negative sparse trials have no geometric meaning and are not retained as
exclusions. Temporary discovery source: /tmp/litt3-weak-sparse-points-6cGEnP.

The five new skip certificates were loaded by a checkpoint-preserving
controller restart at06:45. orbit0chart3 stopped exactly at27168steps;
the same binary/input/congruence resumes that checkpoint. Earlier capped
and inconclusive jobs were NOT reset. New controller keeps fourworkers
and a5.75h remaining budget, preserving the approximate original deadline.
This avoids five searches that cannot succeed at ANY multiplier degree;
it does not exclude those full charts or any entire representative.

Meanwhile inv0chart18 and inv1chart18 finished with independently replayed
bounded duals,237025 and237024steps, about900s each. Neither is an exclusion.

## Sept9 07:50: bounded three-support positive search

A native positive-witness search, not an exclusion algorithm, tried
465236/549286/550860 three-supported beta values on orbit0/invariant0/
invariant1. Runtimes were7.0/7.35/7.35seconds. It found no additional
weak points. This gives NO assertion about missing geometric solutions.
The main controller and exact child were STOPped for this single-core
diagnostic and restored by a shell trap; production then continued.
Source and empty logs: /tmp/litt3-weak-three-support-2BEVMo.
Do not repeat this unchanged search. The useful seven whole weak fibers
are already preserved in verify_atlas_weak_points.py and its receipt.
