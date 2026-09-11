# Runtime estimation for the current backup equation search

2026-09-11,04:15 CEST. This answers the user's request for a reliable
finishing estimate. The original problem and both backup rows remain open.

## Requested one-percent pilot

Actual result: the remaining high-column loop finished in243.037seconds,
versus the302.29second projection below. Low-row reduction then found63
new independent consequences (rank439->502), not a unit. All63 witnesses
are now exported and independently replayed. Linear-multiplier reuse
stabilized at rank502 in11.220seconds; a larger multiplier pass is separate.

New optional DAG low provenance avoids expanding the row history for every
dependent low row. A20certificate raw/echelon regression was byte-identical
to expanded provenance (2.948s versus4.641s). On the large checkpoint,
all63 certificates and low reduction took182.46s after431.717s reload.
Those are not the same task as the earlier344s spent producing only8 with
expanded provenance, but show why this stage deserves its own measurement.

At the saved late checkpoint, 3043 high columns remained. A deterministic
31-pivot sample removed exactly31 columns (1.0187%) in3.079536seconds of
row-loop time. Direct scaling gives

    3.079536 * 3043 / 31 = about302.29seconds, or5.04minutes.

Measured separately:251.078seconds of source/checkpoint loading and index
rebuilding,1.444seconds of kernel import, and11.451seconds of checkpoint
saving. None of these fixed costs is multiplied by the sample factor.
This is the simple local-rate estimate the user requested, not a confidence
interval. It concerns the remaining high-column pass at that checkpoint.
The following continuation records every31 pivots and is allowed900seconds
of row work; it will test the estimate against actual completion or a cap.
Data: degree84-cython-sparse64-20260911/round0/sample_1pct_a/result.json
and sample_to_finish/progress.jsonl under the external computation root.

## Two different stopping conditions

1. A finite high-column elimination pass completes. This is a precisely
   specified linear-algebra task on a saved matrix.
2. The equations are cleared: a unit identity is found and independently
   replayed, with its geometric chart dictionary. A completed pass need
   not do this. It can instead produce useful relations, or no new ones.

The present sparse-reuse algorithm is a bounded-degree consequence
method, not a guarantee that an inconsistent ideal will be detected at
the selected degrees. A wall-time projection for(1) is not an ETA for(2).

## Actual back-test, not a guessed percentage

The compiled row kernel now records high rows, high columns, nonzero
entries, coefficient updates and wall time every approximately5seconds.
Its exact certificates are unchanged. Two previously completed passes
were replayed with this instrumentation. Their operation totals matched:
30,201,794 and59,503,107 updates. Under the concurrent diagnostic load,
their high-column loops took87.109 and168.007seconds after initial setup.

Forecasts at each prefix were tested against the actual remaining time.
For the second pass, at84.70seconds,94.83% of high columns were removed.
The percentage-based projection said4.46seconds remained. The actual
remaining time was86.33seconds: a19.37-fold underestimate. A recent-rate
projection at that same prefix said20.88seconds, still4.13-fold too low.
At a later prefix the stationary-sparsity model overestimated by5.28-fold.

This is why an apparently advanced percentage is not a finishing estimate.
The cheap singleton stage consumes many columns but little work; later
cancellations increase density and can make one pivot far more expensive.
Separate coefficient-update throughput from remaining arithmetic work:
other simultaneous jobs change the former without changing the latter.

The current enlarged matrix exceeds every density seen in these two
calibration runs: approximately3.3million nonzeros versus1.62million.
The estimator explicitly abstains from treating its extrapolation as a
calibrated interval. The observed envelopes from only two completed
passes are not statistical confidence intervals or worst-case bounds.

Scripts: `extract_macaulay_low_degree.py`, `macaulay_sparse_kernel.pyx`,
`estimate_macaulay_completion.py`. Profile files and exact source hashes
are stored with each external computation directory.

## Reliable milestones available now

- Every partial high-column pass now saves a trusted local checkpoint,
  including the exact row coefficients and provenance DAG. Resuming after
  two nontrivial pivots reproduced the uninterrupted unit certificate
  byte-for-byte in the regression test. No externally supplied pickle
  is loaded by the workflow.
- A full pass with zero new low-degree rank proves that repeating that
  same pass cannot improve it. A partial pass with zero new rank does NOT.
- Without changing variables or degree, the low-degree space here has
  dimension595. Its current original low rank is439. Thus there is room
  for at most156 further independent quadratic-or-lower relations.
  An exact strict-growth iteration consumes at least one of those
  dimensions. This bounds the number of productive iterations, not
  their runtime, and does not ensure a unit before stabilization.
- An independently replayed dual can rule out a unit in a fixed finite
  multiplier span. This was established for three older spans. The
  newly enlarged span's120second direct test was inconclusive; its
  old-span certificates must not be reused as if they covered it.

There is also a conservative arithmetic-work bound for this exact pivot
rule. If a pivot column has d incident rows and the selected shortest
row has length l, then d*l is at most the current total number N of
nonzeros. Its update count is(d-1)(l-1)<=N. At most H high columns
remain to be pivoted; no new column outside the current support can
appear. With the enforced NNZ ceiling M, at most H*M coefficient
updates can occur before completion OR the NNZ stop. This is an actual
work bound, but not a wall-time guarantee and not an assurance the NNZ
stop will allow completion. At H=3671,M=5million it is18.355billion
updates, far too loose to justify a short finishing promise. It does
not include the separate low-row reduction and certificate replay.

## Current assessment

There is not yet a defensible end-to-end estimate for clearing the full
degree84 system. The useful next measurement is completion or a saved
late-stage checkpoint of the current enlarged pass, followed by its
actual low-degree rank gain. A new estimate must state explicitly whether
it concerns this pass, another finite multiplier space, or the whole
geometric exclusion. Do not replace this distinction by a long arbitrary
run or promise that more cores will resolve it.

Degree2 is tracked separately: a unit basis for the new Q0/P6 square-part
chart took42.789seconds, but multiplier-certificate extraction exceeded
180seconds. That is another concrete reason solver termination alone
does not estimate time to a fully checked exclusion. Low-degree certified
extraction is now being tested for that branch.
