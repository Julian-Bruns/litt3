# Read-only operation-based ETA — updated 2026-09-08

## Current native algorithm: attempts are not completion

The watcher now identifies `native_original_solving`, the actual live chart
phases, sampled aggregate CPU/RSS, and the current bounded batch's remaining
slice time. It separately estimates a sweep of the still-unattempted charts
using the explicit slice cap, worker limit and per-chart memory reservation.
At02:40 CEST this was about2.7hours for198 pending/unattempted charts;
201 bounded attempts had no certificate. Cache preparation, independent
replay and repair of held operational failures are additional. A finished
bounded attempt need not exclude its chart. The estimate is therefore NOT
a forecast that the14 representatives, let alone the18, will be finished.

The former32.5year extrapolation remains visible, explicitly labelled
**legacy F4 fallback scenario**, not calibrated to the new native algorithm.
No measured credible whole-run completion date has yet been established.
The exact chart/certificate counts continue to come from the owning
controller's adopted records; no timeout, candidate basis or external
unadopted identity is counted as an adopted certificate.

## Historical work model

User explicitly requests a numerical guess and intermediate progress rather
than an unavailable-ETA message. The live solver is NOT changed or restarted.
Run from any folder:

    python3 /Users/julian/Documents/litt3/scripts/run_all_atlases.py watch

The panel refreshes every2seconds. It gives full-run ETA, modeled work spent
versus modeled total, current-stage counts and ETA, and completed/certified
chart counts. `eta-json` exposes the numerical budgets and all assumptions.
No notification, agent wake-up, automatic retry or stopping rule is attached.

Current selection as of15:43: user deferred orbit_0008 through orbit_0011.
Only the other14 jobs contribute to ETA/work/counts (448 chart calculations).
Their rough forecast is32.3years. Deferrals persist across restarts, preserve
all files and mathematical statuses, and are never counted as exclusions.
The full18 forecast and workload shares below are historical comparisons.

## Fermi assumptions (not bounds)

- Native F25 work:49.758billion*(columns/41679)^1.982 coefficient updates.
  This reproduces the measured chart23/22 operation counts. Reference
  throughput1.35billion updates/sec includes end-to-end overhead.
- Full-system F4 work: square of the degree-six monomial-space size ratio,
  anchored to the last completed nontrivial first-representative F4 chart.
  This is a separate budget, not an assumption that a bounded bilinear
  certificate exists. Charts0..7 receive another factor10 for the required
  Frobenius equations. Effective degree6 and quadratic growth are guesses.
- Unmeasured coefficient fields: linear cost in actual field degree when
  exported, otherwise in the manifest's F25 degree. This may underestimate
  the encoded-field backend, especially a still-unconstructed cubic tower.
- Display a factor-ten smaller/larger scenario around the point forecast.
  This is deliberately NOT a statistical confidence interval or guarantee.

Work units across the pipeline are native-F25-update-equivalents: measured
native updates plus time-based estimates for other phases, not a claim
that every physical operation has the same cost. Already completed native
certificates are read once and cached without retaining their coefficients.
During native work, actual row and coefficient-update counters are displayed.
During F4, recent completed-round equation-pair counts and the pending queue
update the local estimate. During input preparation/export, saved block and
equation-set counts update the estimate. No diagnostic logging was added.

An overrun expands the work budget rather than producing100%. Exhausting a
bounded native space WITHOUT a certificate leaves a full-system F4 budget.
Success remains an independent mathematical verification question. A paused
or failed representative is named; its work is not silently omitted.

The first live forecast is about460years (rough46–4600year scenarios), not
hours. This is what these stated current-code assumptions produce, largely
because field degrees across18 sum to9700 and the harder charts dominate.
It is NOT a lower bound on computation time or problem difficulty. Better
algorithms or new mathematical reductions invalidate this extrapolation.

## Work concentration in the current model

The unmeasured orbit_0011 (F25 degree7324) accounts for75.5% of projected
remaining chart work. orbit_0010(degree718),orbit_0009(degree578),and
orbit_0008(degree403) account for7.4%,6.0%,and4.2%, respectively. These are
MODEL shares, largely reflecting the assumed linear field cost, NOT measured
runtime shares. None of these four representatives has started as of15:35.
Similar equation dimensions do not imply comparable coefficient costs.
Even omitting the largest would leave about24.5% of the present forecast;
that would not by itself make this a few-hour computation.
