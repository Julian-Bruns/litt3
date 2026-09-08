# Granular operation logs — 2026-09-07

TEMPORARY DEVELOPMENT INSTRUMENTATION. User requires removing diagnostic
logging when the specialized solver is finalized. Retain exact solution
certificates and required resumable state. Target: ALL18 representatives
in a few hours or less, including large coefficient fields. That full-run
runtime goal is NOT achieved. The improvements below address measured
preparation bottlenecks, not a proved algebraic complexity bound.

CURRENT HANDOFF,2026-09-08 03:50CEST: the user requires at most ONE CPU
core TOTAL and asked agents to wind down. The run is STOPPED, not scheduled
to restart. See the final "Overnight pause and exact one-core handoff"
section for process census, saved frontier and the NOT-RUN resume command.
All intervening timings and worker counts below are historical snapshots.

Historical deployment: at15:00 the user requested production instead of further standalone tests.
The all18 HYBRID queue is now running: predecessor reuse for supported F25
tail charts, exact F4 for other fields/harder charts. Granular logs are enabled
only on the first representative. No timeout is counted as an exclusion.

## One log reader, all representative identities

`python3 scripts/atlas_telemetry.py PATH_TO_JSONL` summarizes each invocation
separately. It accepts the native pencil's `operations.jsonl` and the F4
backend's `rounds.jsonl`. Run context records representative, chart, input
and tensor hashes, arithmetic backend, and actual coefficient-field degree.
Interrupted final JSON lines are ignored until complete. Resuming does not
double-count cumulative counters.

The context schema was tested for all18 IDs and their field-degree bounds.
This tests logging coverage, not arithmetic in all18 fields. The existing
F4-encoded backend handles arbitrary exported coefficient fields; its
physical operation counts are F5 operations, NOT native extension-field
multiplications. The specialized native engine still supports F25 only.
Missing counters are unavailable, never invented as zero.

## Native pencil: intervals of about two seconds or256 rows

`scripts/mixed_atlas_certificate.sage` writes optional append-only interval
records: row subtractions, coefficient updates, zero rows and their exact
cost, normalization products, scanned columns, input bytes, checkpoint
bytes/time, reuse counts/histogram, rank, and pure-b relation degrees.
Logs include actual work on a subsequently discarded interrupted row;
this work is counted again if it is recomputed on resume. Mathematical
checkpoint counters describe committed rows separately.

Verification: stop after150 rows and resume to299; interval totals equal
independent checkpoint/DAG counts exactly:12,666 subtractions,439,166
coefficient updates,11,802 normalization products,49,860 column probes.
The certificate and saved mathematical data are unchanged. A synthetic
zero-row test verifies costs which the old pivot-only DAG could not retain.
Evidence: external `atlas-pencil-telemetry-tests-v2/`.

The saved-run profiler `scripts/profile_atlas_elimination.py` additionally
identifies exact monomial translations of earlier pivots. In first chart23,
15,906 such rows cost35.1billion updates to rediscover. Reusing a derivation
requires correct polynomial multipliers; these equations cannot simply
be removed. This profiler currently reads the first F25 A=0 checkpoint
format, unlike the field-independent live log reader.

## All18 F4 backend: measured counters at each completed round

Separate instrumented build:

    /Users/julian/Documents/litt3-computation-data/atlas-f4-telemetry/msolve/msolve

The previous binary and checkpoints are untouched. `scripts/atlas_f4.py`
now selects this build and sets `MSOLVE_F4_GRANULAR=1`. The additional
patch is `scripts/vendor/f4-telemetry.patch`, applied AFTER the existing
checkpoint patch. No checkpoint format or algebraic operation changed.

Records measure sparse pivot-subtraction calls and coefficient updates,
column probes, reducer returns zero, symbolic searches and short-mask/full
divisibility rejections, generated symbolic rows/terms, matrix dimensions
and nonzeros, zero target rows, existing GM/redundancy counters, basis
term count and checkpoint time. Cheap counters are updated outside inner
coefficient loops; thread-local slots are summed at round boundaries.

`ATLAS_GRANULAR_LOGGING=1` enables these F4 counters in production; the all18
controller sets it only for orbit_0000. `MSOLVE_F4_COEFF_VARIABLES` identifies
actual coefficient-generator columns.
The logs separately show their maximum degree and the genuine unknowns'
maximum degree. Thus a large minimal-polynomial degree is not silently
reported as equally complicated geometry. Without this metadata the
degree profile is explicitly unavailable.

Scope: sparse known-pivot kernel and symbolic reducer search during F4
rounds. Initialization/final reduction, machine instruction counts, and
full per-coefficient timing are not measured. Fingerprints/timing intervals
are not mathematical certificates. No ETA is inferred from raw counters.

`scripts/test_f4_granular.py` verifies byte-identical final bases with the
old build, new logging off and new logging on, for cyclic4, a quartic
extension encoding and actual first chart29. An old checkpoint also resumes
correctly with logging and a changed thread count. Extra degree counters
passed the final rebuild/retest.10 controller/schema tests pass.
These tiny tests do not measure hard-case logging overhead.

## Already implemented arithmetic improvement

Fused native F25 subtraction lookup avoids two dependent lookup operations.
All15,625 scalar cases and the entire chart23 checkpoint/provenance/weights
are checked against the original. Native time133.21sec versus151.50sec
on that run (~12% less). This is a measured first-case improvement, not a
forecast for large coefficient fields or the remaining common-cover proof.

## 21:33 restart: measured export bottleneck and deployed replacement

The user explicitly restarted the orbit agent on the ENTIRE18-representative
algorithm. Selected14 remains the production selection; deferred8..11 are
in optimization/preflight scope, not silently reenabled.

Read-only21:34 snapshot: controller34384, exporter shell56599/child56602,
over5hours on orbit0001 export; child99%CPU, about403MiB RSS. No native
solver was running. A3-second native sample and bounded cProfile of the
already-completed chart29 identified repeated generic polynomial evaluation,
not stalled I/O. The6,649-term chart caused28.8million quotient-field
comparisons and20.2million coefficient constructions; generic addition took
55.6 of64.7 profiled chart seconds. Both coefficient-specialization passes
recreated multivariate polynomials by repeated addition.

`export_rooted_atlas.sage` now uses sparse exponent maps for tensor assembly,
identity/coordinate projections and coefficient specialization. Every power
basis coefficient is reconstructed exactly, every written equation is read
back and specialized exactly, and all original low equations are verified
when forming the RREF matrix. No N/R equation, affine constraint, chart,
field defining relation, normalization or reconstruction is dropped.
An optional `--audit-generic` retains the old evaluation as a bounded test.

Measured regression timings (seconds, not including Sage startup):

| Exact existing chart | Old | Sparse | Verified result |
|---|---:|---:|---|
| orbit0001,29, degree12/F5 tower |50.35|6.57|All four saved mathematical files byte-identical|
| orbit0001,11, same tower |2451.82|48.64|Input, RREF certificate and reconstruction byte-identical|
| first F25,0 |33.29|11.48|Input, RREF certificate and reconstruction byte-identical|
| invariant2,28..31,4 concurrent workers |mixed|1.01–4.06 each|Inputs/reconstructions or constant certificates identical|

The invariant test includes a genuine6-variable affine elimination chart,
two exact constant certificates and a retained polynomial-unit fallback.
Those tiny parallel charts are not individually faster; process overhead
dominates them. The large tower chart is the measured50.4× speedup.

With root's explicit deployment window, the controller stop command ended
34384/56599/56602. All79 files in completed orbit1 charts11..31 were hashed
before/after and remained byte-identical. The replacement exporter then
completed the11 missing charts10..0 in248.85seconds, including the single
unfinished chart10 replay. Parent10398 had10 workers10598..10607; a live
measurement after58seconds was900.9% aggregate workerCPU and about2.6GiB
summed workerRSS. This is measured concurrent execution, not a thread flag.

Workers share immutable decoded tensors by fork and write distinct chart
directories; only the parent publishes the manifest. Inputs are atomically
renamed only after roundtrip verification. Completed charts are validated
and reused on resume. `--max-charts` bounds a preparation batch; the queue
now solves available verified charts before demanding every chart export.
Partial queue completion never means whole-atlas completion. Per-chart
phase timings/progress and per-session worker counts are saved separately.
11 orchestration and16 watcher/telemetry/F4 unit tests passed.

Evidence remains external in `orbit11-structure/`: the live native sample,
`export-chart29-baseline.prof`, the baseline/sparse29, sparse11, first0 and
invariant2 regression directories. The production orbit1 `export_session.json`
and per-chart `export_progress.json` contain measured phase/worker timings.
The remaining bottleneck in the48.64-second chart is tracked RREF28.06s,
followed by text verification15.25s. Large-field/native algebra work remains
active; no full18 ETA improvement or whole-representative exclusion follows
from export speedup alone.

## Large-field coefficient guard and native RREF, 22:30 continuation

The first restarted controller14351 built invariant3 with ten direction
workers (measured800.2% aggregateCPU) and verified the full retained-R
implication before publishing its tensor. Orbit2 then exposed a230-second
generic Laurent-polynomial conversion cost. A native sample put164/164
samples inside that conversion. Direct transport of coefficient lists,
valuation and precision now avoids symbolic polynomial evaluation.

During this work the backup agent reported a separate Sage10.9 exact
monomial indexing bug: over native GF(5^15), `(t^-3)[-2]` incorrectly returns1.
We reproduced it over native degrees12,15,26. Finite-precision examples and
the actual earlier tower types tested correctly; no affected published
tensor or computational certificate was found. With root's authorization,
14351 and orbit2 shell17464/child17467/workers21253..21262 stopped and were
confirmed exited. Orbit2 had only preparation checkpoints, no direction or
canonical tensor. Nothing was deleted or promoted as an exclusion.

`atlas_series.py` now bounds exact scalar indexing by valuation and degree,
uses one valuation-relative coefficient list for vector extraction, rejects
unknown coefficients beyond precision, and transports series without generic
symbolic coercion. `test_atlas_series.sage` checks all18 actual intrinsic
census fields plus the orbit1 tower, including absolute degree14648.
Exact/finite-precision monomials, multi-monomials, products, derivatives,
transport and precision rejection pass. The guarded builder recomputed all32
invariant0 directions, every saved tensor/basis and the full coupled-R
implication, exactly matching the old validated result. Its safe schema2
cache format explicitly allows only the audited precursor's preparation
stages to migrate, and refuses migration if old direction/tensor files exist.
Shared fifth powers and residue projection factors are now computed once.
11 orchestration plus18 watcher/telemetry/F4 tests pass.

`atlas_native_rref.cpp` supplies native FLINT finite-field RREF, keeping
coefficients in the specified field rather than adding polynomial unknowns.
It augments with the identity and verifies the entire original identity
`C*M=A` natively. `atlas_native_rref.py` verifies coefficient roundtrips and
flattens small towers through a proved full-rank primitive power basis;
unsupported large towers explicitly retain the Sage fallback. Native fields
are supported without the small-tower degree bound. Optional Sage audit
compares the full augmented RREF, not just rank. The exporter now defaults
to this guarded automatic backend.

Actual orbit1 chart29 passes the full Sage RREF audit and all four output
files remain byte-identical. Its native94-by97 RREF takes0.034s and the
original-identity product0.006s. Actual chart11 now takes21.22s rather than
48.64s with sparse Sage RREF or2451.82s originally, again byte-identical
input, RREF certificate and reconstruction. This is a115-fold preprocessing
speedup on that chart, not a115-fold full-solve prediction. Text roundtrip
verification is now its largest remaining export cost.

All18 large-field algebra remains an active implementation target. The
32.5-year broad F4 heuristic is still not an acceptable runtime, and no whole
oper has been excluded. Native RREF, safe Laurent arithmetic and ten-worker
exports are real deployed/preflight gains, not a replacement for the missing
large-field factored solver. `CORED_COMPUTATION_STATUS.md` records the exact
current chart-certificate scope separately from timing claims.

## Independent matrix guard and exact fixed-curve projection

`test_atlas_matrix_guard.sage` is a deterministic minimal reproducer in a
fresh Sage10.9 process. With `k=GF(25,'a',modulus=z²+2z+4)` and the IMMUTABLE
matrix `M=[[1,a],[a,1]]`, optimized `Matrix_gfpn_dense` multiplication gives
diagonal `a+4`, while explicit scalar sums and `implementation='generic'`
give `3a+2=1+a²`. The input entries remain unchanged and the field parents
are identical by object identity. There is no random seed. The actual
production base modulus `z²+4z+2` passes this same test. Earlier production
orbit1 uses a generic cubic tower, not this unsafe dense-field implementation;
no affected published certificate was identified.

The native backend now audits through GENERIC scalar-field matrices, not
the potentially unsafe optimized small-field matrix implementation. Exact
RREF (including the whole augmented matrix), original-row identities, general
products and fixed-F25 products pass for all18 intrinsic census fields plus
the actual orbit1 tower. The degree14648 fixture takes3.54s in total; its
native RREF is0.085s. These are deliberately tiny arithmetic fixtures, not
large atlas speed claims. Raw evidence: `native_field_fixtures.json` and
`sage_dense_matrix_guard.json` in the external orbit11-structure directory.

`atlas_residue_projection.py` constructs the fixed-F25 matrix
`T=I-X H^-1 S` for affine Laurent reduction on exponents−197..132 and
the composed original operator `rho*t^-85*T`. All330 basis monomials,
including BOTH Laurent remainders, are checked in2.26s; the resulting
operator has56rows and330columns. This proves its equality after every
coefficient-field extension, with no acyclicity, generic-corank or atlas
point assumption. Multiplication by U*t^(5e) is a coefficient-window shift,
so no Laurent product or repeated subtraction is needed.

Native FLINT fixed-F25 multiplication separates `A=A0+a*A1` overF5,
doing two prime-field sums and only ONE extension-field multiplication per
output entry. In the actual orbit3 degree102/F5 tower, the original56-row R
block and its compact32-row projection for directions0 and4 each take6.7s,
and all entries exactly match the checkpoints produced by the live older
builder. The setup takes6.9s. Full N+R native-direction implementation is
under exact comparison before deployment; the live worker's260–277s includes
N too and is not yet a like-for-like R-only timing comparison.

The FULL native direction comparison now passes: orbit3 directions0 and4
take20.86/21.80s (N12.56/13.43s, R6.75/6.90s, restoring exact old coordinates
1.55/1.47s), versus276/261s respectively in the live previous implementation.
All N64, compactR32 and originalR56 entries are identical. All32 invariant0
directions also agree (16.50s including setup), testing the exceptional
nonacyclic case, and the complete builder's original coupled-R image check
passes after checkpoint reload. Every final invariant0 tensor/basis key
matches the old validated tensor exactly. A generic-versus-optimized Sage
matrix-container mismatch on checkpoint reload was caught and corrected
without changing scalar coordinates.

All19 tiny coefficient-field fixtures pass again after optimizing native
power-basis transport. Guarded native exporter chart29 passes the complete
generic-Sage RREF audit and preserves all four mathematical files byte-for-
byte. The default native exporter is restored only after these checks.
The builder now uses the exact native-field/fixed-curve direction engine
where the coefficient-field model is supported, explicitly falling back on
unsupported large towers. Native fields have no tower-degree cutoff; removing
optional cubic towers by deck descent remains separate unfinished work.
The fork memory reservation now reserves one full parent-sized working set
per worker (at least512MiB) PLUS the parent, while the8GiB process-tree guard
remains enforced. This admits ten workers for the measured orbit3 memory
instead of the earlier over-conservative nine.30 orchestration/ETA/telemetry/
F4 tests pass. No existing checkpoint format or mathematical chart changes.

## Next all18 preflight: remove optional cubic towers and repeated inverse Frobenius

These two changes are NOT deployed and do not replace the current field/
coordinate conventions. They are specific exact implementation mechanisms,
not claims of an atlas exclusion or of an already acceptable full runtime.

For normalized oper t³=lambda, put z=t*y and T=x³/z. The descended curve
and scalar data must be

    F'=lambda F, delta'=t²delta,
    P'=lambda² Ahat+lambda(B+2x8)z+lambda Chat z²,
    kappa'=lambda^-5 T^-17.

The last factor is ESSENTIAL: blindly using kappa'=T^-17 changes the atlas.
Indeed T=u/t for the old uniformizer u, so kappa'=t² kappa. The exact
coordinate comparison after adjoining t is

    U'=t^14 U, eta'=t^-6 eta, T_aff'=t^-16 T_aff,
    theta'=t^-2 theta, Q'=t^6 Q.

It preserves Wronskian1, every N/R equation, and the residue normalization:
the R left side scales by t^(14-30+10)=t^-6, as eta does; the dual primitive
scales by t^8, so the residue scales by t^(-6+8-2)=1. This is an isomorphism
back to the ORIGINAL curve over the constant extension, not a new selected
pair. It avoids extracting t even when lambda is already a cube.

All local operators derive from the ORIGINAL fixed-F25 tables. If h,e are
Laurent output/input exponents and j the y-exponent of a monomial, then
each displayed nonzero entry has the stated exponent divisible by3:

* monomial expansion: X'_(e,m)=lambda^((e+j)/3) X_(e,m);
* residue pairing: S'_(e,m)=lambda^((j-e-2)/3) S_(e,m);
* derivative projection: D'_(h,e)=lambda^((h+2-e)/3) D_(h,e);
* single reduction: rho'_(h,e)=lambda^((h-e)/3) rho_(h,e);
* kappa-weighted double reduction: B'_(h,e)=lambda^((h+10-e)/3) B_(h,e);
* fifth-power monomial matrix: power'=power*diag(lambda^floor(5j/3)).

The first two factors depend only on the row wherever nonzero: respectively
lambda^ceil(e/3) and its inverse. The other matrices likewise factor into
lambda row/column scalings and the existing F25 matrix. Thus the fast
prime-field-sum products remain available without a new Laurent expansion.
Before deployment, check these identities in both cube and noncube finite
examples, transport ALL original equations, and keep new cache/source IDs.
Intrinsic normalized degrees overF25 remain1,2,13,17,40,124,205,220,403,
578,718,7324. The optional cubic factor disappears; intrinsic7324 does not.

A second exact mechanism avoids98,304 separate inverse-Frobenius coefficient
powers in a large-field export. Apply inverse Frobenius ONCE to the small
input oper-coordinate list and fixed-curve embedding, and run the entire
functorial coefficient construction there. Canonical kernel/RREF bases,
residues, field products and fifth powers commute with this automorphism;
the resulting N/R arrays are already the rooted coefficients. The original
arrays, if needed, are recovered by fifth powers. This requires a new tagged
rooted-artifact convention and checks that every input coordinate's fifth
power is the original one. It must not silently relabel an existing tensor.
The plan is to combine this with compact binary/factored coefficients; an
expanded string tensor at degree14648 is still an avoidable storage hazard.

## 23:16 CEST deployment and coefficient-root checkpoints

Controller77326 continues selected14 unchanged; no liveJSON edits or further
restart were needed. The five missing orbit3 native direction blocks took
22.63s together; all27 pre-existing block hashes matched the saved manifest.
The separate original56-row coupled-R witness passed in82.52s, versus about
214s for the previous two-rank verification. Invariant4 then built all32
native blocks by36.35s and verified its full original-R witness in17.19s.

The remaining serial exporter bottleneck was inverse Frobenius in the
generic coefficient tower: actual invariant4 degree38/F5 took347.617s
before starting its charts. The new native-field rooting process verifies
EVERY rooted coefficient by its fifth-power identity, stores32 independently
hashed source-bound blocks, and shares them through a bounded fork pool.
The SAME invariant4 input took11.553s with nine rooting workers while the
one-core old exporter remained live. Its audited chart31 certificate passed.
Orbit1 chart29's input.ms, initial_rref.json and reconstruction.json are
byte-identical to the old exports; metadata changes are paths, timings and
backend telemetry only. The complete generic-Sage RREF identity audit passes.

The following production exporter picked up the new code automatically:
invariant5 degree46/F5, ten rooting workers, coefficient loading12.630s,
then all ten charts31..22 in40.846s. Invariant4's old process had finished
naturally, retaining all ten exports. No completed mathematical output was
overwritten to adopt the upgrade. Rooting caches are additional restart
artifacts, not new certificates for the whole atlas.

Read-only production monitoring now confirms ten orbit4 direction workers
33472..33481 under builder24110/controller77326: aggregate CPU samples
904.5%,882.1%,905.6%; RSS1.29–2.36GiB at those samples. This phase still
uses the slow Laurent fallback because its optional cubic tower has absolute
degree240, beyond the former128-degree generic flattening bound. Replacing
that field-model limitation is the next immediate optimization. The current
global F4 forecast is still32.5years (factor-ten heuristic scenarios), and
there are still ZERO whole-oper exclusions. These preprocessing speedups
must not be described as an acceptable full-algorithm finish estimate.

## Exact Kummer field bridge and original-coordinate check

For a genuine cubic coefficient extension k[t]/(t³-lambda), with k/F5 of
degree n and lambda generating k, form the n-by-n matrix whose columns
are1,lambda,...,lambda^(n-1) in the OLD k basis. Its invertibility and the
computed relation m(lambda)=0 prove that m(z³) presents the full cubic
field. Each old component c0+c1*t+c2*t² is transported by the SAME n-square
basis conversion, interleaving the three coefficient lists. The inverse
de-interleaves and applies the inverse basis change. No scalar-coordinate
convention, atlas equation or optional extension degree changes. This is
distinct from the undeployed intrinsic deck descent described above.

`atlas_native_rref.py` now implements this exact map; it rejects a
non-generating lambda explicitly rather than guessing a separator. The
preflight bound n<=2048 includes every optional cubic base in the18-case
census; the degree14648/F5 orbit11 field is already native. Actual per-field
preflight is still required before claiming all these cases supported.

In orbit4 (n80, absolute degree240) construction takes0.114s. Tiny dense
scalar/generic-Sage matrix identities pass. The independent original-
coordinate regression `test_atlas_native_fresh.sage --rep orbit_0004`
passes in54.615s: native FULL direction27.370s; N rows0,19,63 agree in
all32columns; R columns0,11,31 agree in all56original rows and compact32.
The native direction checks every Wronskian fifth-power identity, and
the fixed residue operator separately passes the exhaustive330-monomial
test. This finite regression is not a second full tensor comparison.
Field modulus, Sage10.9 version, immutable input hashes and exact tested
indices are saved in external `orbit11-structure/native_fresh_orbit_0004.json`.

Controller77326 and all its descendants were stopped by the normal stop
command before this test. All five orbit4 preparation caches are hashed in
`orbit4-preserved-before-kummer-20260907.json`; none was modified. No old
direction had completed before stopping. The backup's bounded10-core
window follows, then selected14 restarts without re-enabling deferred8..11.

## September8 continuation: complete native directions and bounded native charts

All ten actual noninvariant field fixtures1..10 now pass, including the
optional cubic models of absolute degrees12,102,240,744,1320,2418,3468,4308
and native degrees26,410. Together with the earlier native/invariant
fixtures this supports every field model in the18-case inventory. The
largest new fixture took9.197s. Artifacts are in external
`orbit11-structure/kummer-field-fixtures/`. This does NOT eliminate optional
extensions or construct the deferred orbit8..11 tensors.

Controller1189 resumed selected14 at23:39:50. Orbit5's degree744 direction
stage used only FOUR workers because its Sage/PARI polynomial arithmetic
had about1.5GiB of live allocations per worker. Explicit GC/allocator
trimming did not solve that problem: `native_memory_orbit_0005.json`
records setup853.95MB→855.70MB, not a memory reduction. The sampled CPU
peak of that phase was399.6%, so it must not be described as a ten-core run.

The new `atlas_direction_kernel.cpp` performs one ENTIRE direction in a
single FLINT field context, including polynomial Wronskians, the complete
fifth-power expansion identity, fixed-curve remainders and all56 raw R
rows. `atlas_complete_directions.py` returns the same old coordinates and
retains hash-bound native bytes for subsequent verification. Measurements:

| Exact regression | Previous direction | Complete C++ | Including decode |
| --- | ---: | ---: | ---: |
| orbit4, absolute field degree240 |27.370s|1.527s|4.615s|
| orbit5, absolute field degree744 |136.655s|6.643s|17.878s|

Every64×32 N,32×32 compactR and56×32 rawR coefficient of the tested
direction matches its immutable predecessor. The degree744 setup/final
RSS is435.6/408.8MB. Both complete32-direction invariant0 and invariant1
tensors and all their saved bases match the original tensors exactly.
The invariant0 raw56-row blocks were also compared individually for all32
directions. Reports are `complete_native_orbit_0004/report.json`,
`complete_native_orbit_0005/report.json` and the two
`complete-native-builder-invariant*` directories under `orbit11-structure`.

Orbit5's old serial full-R witness finally completed in720.855s, and its
whole tensor completed in2024.10s. A one-second native stack sample of
PID1197 shows substantial PARI scalar construction/copying; physical
footprint was5.2GiB. At the approved checkpoint-safe stop, controller1189
and exporter50691/50694 plus50897..50903 exited. All39 completed orbit5
tensor/checkpoint files (304,355,110bytes, including all32 directions,
full-R witness and231MiB JSON tensor) are unchanged under
`orbit5-preserved-complete-20260908.json`. No selected/deferred choice changed.

`atlas_factored_R_witness.py` now determines a candidate56×64 row witness
from a few blocks and verifies its identity on ALL32 blocks, including
each compact-projection identity and all56 raw R rows. If determining
rank is below64, failed blocks are added and the finite system is refined;
no generic-rank hypothesis is assumed. Every check is independently
checkpointed by input/witness hashes. The small-field test returns exactly
the old full-matrix witness. The large-field regression is ongoing at
this note's snapshot; do not claim it finished from the candidate alone.

That regression exposed an operational guard: PARI-using Sage workers
must NOT use `maxtasksperchild=1` with a fork Pool. Replacement workers
fork from its management thread and crashed during field unpickling.
The nine completed checks and candidate were retained; no final witness
was promoted. The isolated test was stopped and resumed with original
non-recycled workers. C++ subprocesses remain fresh per direction, without
this PARI thread-local-state problem. Worker SignalErrors are converted
into explicit parent failures rather than an indefinitely missing result.
The existing serial witness/certificates were not invalidated.

The new native-coefficient solver keeps all97 ORIGINAL rooted rows over
their verified finite field, without extra field-generator unknowns.
`atlas_affine_precondition.py` uses only constant-row operations and
constant-coefficient affine substitutions, with exact telescoping lifts
back to the original rows. `native_original_atlas.sage` uses Singular
`liftstd` for the remaining search and checks the resulting original-row
identity. `verify_native_original_atlas.sage` independently reconstructs
and replays it without any Groebner search.

Measured affine reductions: invariant2 chart28 fell from25.881s raw native
search to0.323s; orbit1 chart29 fell from a60s raw timeout to0.848s. Fresh
no-solver replays took0.111s and0.295s. A bounded ten-chart invariant2 test
produced replayed original identities for charts31,30,29,28; the six
harder charts reached their60s limits and remain UNRESOLVED. A completed
resume launched no workers. Fifteen selection/scheduler/replay-guard tests
pass. The batch implementation preserves terminal failures and does not
automatically retry them; unfinished native searches leave F4 checkpoints
untouched. Its active Singular critical pairs are not checkpointable.

At this predeployment snapshot the authoritative production count remains
22 certified charts,43 calculated charts and ZERO whole representatives.
The new external identities are not yet all adopted. The old F4 fallback
forecast is32.55years, with factor-ten heuristic scenarios; it is NOT an
ETA validated for the new native solver. Several easy-tail speedups do
not establish a reasonable all18 completion time. The selected14/deferred4
boundary, nontrivial cubic twists and all other common-cover gaps remain.

The repaired degree744 full-R regression subsequently PASSed: all32 raw
block identities and compact projections hold, and its returned witness
equals the existing serial witness EXACTLY. The second run reused the
nine completed checks and the saved candidate, verified the remaining23
blocks on ten non-recycled workers, and finished in137.881s. The first
candidate construction had taken139.033s; thus this is not a137.881s
from-scratch benchmark. New native-built tensors also retain hash-bound
binary blocks, avoiding legacy quotient-field unpickling/conversion in
this stage. The complete invariant1 pipeline including that binary path
and factored witness took4.87s and matches its predecessor tensor exactly.

### Deployment57786 and native-queue cleanup regression

Selected14 controller57786 adopted only the narrowly verified invariant2
telemetry recovery. Orbit6 (absolute field degree410) completed all32
directions by97.20s and the full56-row coupled-R verification by220.66s;
the tensor finished in479.46s. A recorded35 samples exceeded850% CPU,
with a954.5% peak during ten-worker full-R checking. The original final
PARI checkpoint decode/JSON stage cost another259s. The next builder
uses hash-bound retained native blocks for this decode, and refreshes
its arithmetic process after immutable preparation to release old PARI
allocation caches. A complete degree18 regression, including the refresh,
matches all original tensor/basis coefficients exactly (53.51s one core).

Orbit6's seven-worker native chart batch63634 then encountered an
OPERATIONAL failure at113.88s. After a memory stop, the old cleanup called
killpg again on an exited wrapper group and received EPERM. Its exception
cleanup aborted at the same call, leaving three Sage descendants running;
they were subsequently identified by exact PID/group/command and stopped:
63653/group63645,63657/group63648,63658/group63642. Independent process
census confirms none remains. Controller57786 and the next orbit7 builder
71046/71049 were never signalled. Failure logs, partial inputs and completed
tensor/checkpoint data are preserved. No blanket retry was performed.

The repaired queue resolves LIVE members of each exact new-session group,
signals those owned PIDs only, escalates after the grace interval even when
the wrapper already exited, and attempts every cleanup despite one error.
Four targeted tests PASS, including a real reparented SIGTERM-ignoring child,
an already-reaped empty group, resource accounting after reparenting and
continuation after a simulated denial. All15 scheduler tests still PASS.
These are operational tests, not mathematical certificate verification.

Three orbit6 original-row identities (charts31/30/29) survived the failed
batch, at101.85/199.61/416.80s respectively; their independent replays are
not complete and they are NOT adopted as new exclusions. Input conversion
alone took82s for chart31 and259s for chart29. Production at this snapshot
therefore remains23 certified charts,44 calculated charts, ZERO whole
representatives. Orbit7's refreshed process does use ten direction workers,
with roughly900--945% sampled aggregate CPU; its preparation took389.09s.
The next optimization is shared/fast exact coefficient conversion, not
another unguarded retry of an unfinished native search.

### Deployment25961: shared roots, original-row replay and remaining memory wall

Snapshot2026-09-08 02:13CEST. Controller25961 is live on the SAME selected14;
orbits8--11 remain deferred. There are47 adopted chart certificates,
58 completed chart calculations,14 completed tensors and ZERO whole
representatives. These numbers are distinct from the completed oper census.
The legacy F4 fallback forecast is still32.5years; this is NOT a calibrated
finish estimate for the new native algorithm. Hard low-index charts remain
unresolved and no reasonable whole-run completion date is established.

Orbit7's previous full tensor took2181.66s: all32 directions by610.58s,
full coupled-R verification by1441.44s, then about740s final old-coordinate
serialization. Its JSON is415MiB. The new native56-row checker passes all32
actual invariant1 blocks (0.423s including packing) and individual ACTUAL
degree410/1320 blocks in0.259/2.534 native seconds, with all56 raw rows and
the compact projection retained. Incorrect raw-block/projection fixtures
are rejected. Old degree1320 block checks took63--74s. The resumed orbit4
builder used this native stage on ten workers and completed its full-R
witness in20.55s; this is a RESUMED preparation benchmark, not from scratch.

Three exact coefficient conversions are now explicit in
`atlas_field_maps.py`: verified PARI finite-field embeddings, one inverse
Frobenius map (instead of Sage's cache of all intermediate powers), and
degree-length coordinate vectors. Sage PARI treats a SHORT list as a
polynomial and evaluates it by Horner; a full-degree list uses its vector
constructor. Zero padding therefore matters for Kummer/subfield elements.
Actual tower fixtures at degrees12,240,744,1320 agree with independent
Sage evaluation, including scalar fifth-power identities. At degree1320,
six dense tower coefficients decode in0.0154s versus1.081s previously.
These are conversion timings, not atlas exclusions or overall speedups.

`prepare_native_atlas_input.sage` builds a786432-byte offset index into
the retained, hash-bound ORIGINAL native direction blocks. Searches may
read this cache; `verify_native_original_atlas.sage` ALWAYS reconstructs
all97 equations from original JSON. The field model, source tensor and
every binary/checkpoint binding are checked. Per-chart memory reservations
now reflect actual chart width, and memory-limited mathematical attempts
are not silently retried. Small/degree410/degree1320 original97-row
comparisons pass exactly, including the full chart0 small-field system.

Profiling degree1320 chart31 found18.84s of26.87s row construction in
3075 inverse-Frobenius applications. `atlas_frobenius_roots.cpp` now uses
shared modular-composition precomputation and checks EACH answer's fifth
power against its original coefficient. One actual3072-coefficient block
took4.131s and5.47MB RSS; a fresh Sage process independently checked every
fifth-power identity in4.097s. The complete32-block cache verified all98304
coefficients in21.988s on ten native workers, observed near902% aggregate
CPU, with only about5.4MB per native worker. Every completed block persists
and resumes by hashes. Original/indexed chart31 reconstruction then matched
ALL97 rows exactly in25.277/7.144s, respectively. The same cache preserves
all97 original rows on the full small-field chart0 test. No corank condition
is used anywhere in this optimization.

The approved stop retired controller57786 and all owned descendants after
orbit4 published its completed tensor. All812 inventoried tensor, direction
and proof artifacts (1856864993bytes) remained hash-identical under
`orbit11-structure/preserved-before-root-cache-restart-20260908.json`.
Orbit2 and orbit6 cleanup failures were recovered only after exact named
log, batch and tensor hashes matched and charts31/30/29 all had fresh
original97-row replays. Orbit6 replay times were14.55/23.84/64.73s. Failed
search/time/memory records were retained; the controller only resumes
previously unattempted work. A separate narrowly checked resume archives
explicit USER stops made before any native search/input artifact, such as
the approved orbit4 preparation stop. Three recovery tests, five cleanup
tests and sixteen scheduling tests pass. Foreign-UID members of a dying or
reused group are recorded and NEVER signalled; they cannot prevent cleanup
of the remaining owned PIDs. No foreign process is treated as our worker.

The first restarted degree744 batch genuinely ran ten workers, with974.9%
sampled CPU. Its OLDER tensor lacks retained native binary bindings, so
that batch still uses legacy JSON and encounters preparation memory limits.
Extending the cache to those legacy tensors remains work in progress. The
degree1320 wider-chart batch uses the checked cache, but is memory-reserved
to five workers (about500% CPU,6.6GB RSS). Thus the task is not yet solved
merely by requesting ten workers: coefficient storage and harder symbolic
elimination remain substantive limits.

A bounded degree1320 chart31 search obtained an original97-row unit identity
in59.51s;49.19s was affine preprocessing. Its independent original-JSON
replay passed in36.04s. It remains an EXTERNAL, not yet adopted, certificate:
`orbit11-structure/native-root-cache-orbit7-chart31/{result,replay}.json`.
The source hash is32f4bed4816c53a49259dbb0535d62e59a2981547d0ef15fec8924f7f6bdeb9d.

The next exact reduction now has a complete coefficient test, not just an
abstract applicability statement. `check_atlas_tensor_grading.py` checked
ALL98304 rooted N/R coefficients of orbit7 in3.139s (83232 nonzero), finding
shared weightsw_i forv_i andbeta_i and row weightsn_r modulo3. In the native
Kummer fieldt³=lambda, they satisfygrade(N_rih)+w_i+w_h=n_r and
grade(R_rih)+w_i+w_h=2w_r. This descends coefficients1320->440 overF5.
On chartj put a_i=w_i-w_j and substitute v_i=t^a_i V_i,
beta_i=t^a_i B_i. All N rows are rescaled by nonzero constants; R graph
rows become lambda^(3a_i)*s_i^5-B_i and normalization becomes
w*sum(lambda^a_i V_i s_i)-1. The lower R rows and every nongeneric/rank
stratum remain. An exporter with exact original-row certificate lifts is
being implemented; the coefficient test alone is NOT an exclusion and
does not reduce orbit11's intrinsic absolute degree14648.

### Deployment46381: checked deck descent and exact term reuse

Snapshot2026-09-08 03:18CEST. Controller46381 is live on the SAME selected14;
orbits8--11 remain deferred. There are51 adopted original-equation chart
certificates,62 completed chart calculations,14 full tensors and ZERO
whole representatives. The remaining external first-oper28 identity adds
one unique known chart, not a whole-oper exclusion. The current native
attempt sweep has78 unfinished/unattempted charts and319 terminal
noncertificate attempts. Its nominal memory-reserved sweep estimate is
3355s (about56min), NOT an all-chart completion ETA; it excludes replay,
unmeasured preparation and later hard searches. The old32.5year F4 forecast
remains a labelled historical model, not a calibrated new-method forecast.

The tested `CubicDescendedChart` implementation retains every original
rooted row. On orbit7, all97 diagonal change-of-variable/row identities
pass on chart28, including negative integer weights and the inverse norm;
that complete comparison took316.398s. Exact units on charts31/30 then
lifted from degree440 to the ORIGINAL degree1320 field. Fresh no-solver
original-JSON replays passed in31.455s and62.047s. Certificate hashes:

- chart31: d9fb62395d7c57a32a1b9ab8a42980f8b04277a9a2eedf696a0191cb1a572a70;
- chart30: 4baf91f74ddd98fa9a8a1dbddbba413809c976e6a29be9303648f4c949f6ee52.

Search results retain the ORIGINAL field model and source hash; the smaller
search model is separately labelled. `search-unit.json` checkpoints the
complete search-row multiplier identity before original-field conversion.
Resuming it rechecks that identity without another Groebner search. The
independent verifier still reconstructs ALL original97 rows from JSON,
not the search cache or grading. No generic-corank condition enters.

The dominant measured degree1320 chart30 cost was not native elimination:
affine preprocessing took46.801s, including36.913s in Sage polynomial
coefficient extraction and2.292s in native FLINT elimination. Exact low-row
dictionaries already existed before polynomial construction. Retaining
them and passing them explicitly to `AffinePrecondition` removes that
repeated conversion. The actual chart30 regression checks all95 retained
row dictionaries against the original polynomials, rejects a wrong-constant
control, and produces BYTE-IDENTICAL search-unit multipliers. Extraction
then takes0.0000564s and total affine preprocessing12.830s (3.65x faster
under the recorded load). This is a specific stage speedup, not an overall
all18 completion claim. The reusable field-native coefficient bridge still
performs the same verified arithmetic and original-row lift.

Four production-adapter regression charts were independently replayed:
orbit4 charts31/30 over degree240->80, complete batch13.958s; invariant3
charts31/30 over its intrinsic degree18, complete batch5.194s. The latter
is a deliberate negative descent control: its modulus is NOT f(t^3), so
the guarded batch uses the original model. Degree divisibility alone is
never treated as a valid Kummer presentation.

The legacy packing implementation had previously exposed six OPERATIONAL
metadata-write errors before its JSON Integer conversion was fixed. Each
had already saved32 native binaries; none was a mathematical failure.
The opt-in repaired path uses a fresh Sage subprocess per direction,
retains stdout/stderr, and checks every original coefficient roundtrip.
All six cases (orbit1/3/5,invariant3/4/5) passed off-controller in149.545s
total with six workers. All192 original direction files and192 old native
binaries remained hash-identical, with all32 bindings checked per case.
The fixed approved recovery report has SHA256
6d0c49b87667a96c1a54519e4e3e3e18c545c371260fb2d375c6ce7ab2c2f18c.
Recovery checks the exact six targets, report/source/log/binary hashes
BEFORE changing any job status. It does not reset mathematical search
limits, old attempts or certificates. Sixteen scheduler, four recovery,
thirteen ETA and five owned-process-cleanup tests pass.

The old controller25961 was stopped using its own stop command; its
active invariant2 batch22619 and groups22621/22622/Sage22626/22627 were
confirmed exited. The restart preserved all1008 inventoried tensor,
direction and proof artifacts (1,857,303,568 bytes), under
`orbit11-structure/preserved-before-deck-restart-20260908.json`.
The separate six-case report covers its192 legacy binaries. This is not
a claim that the manifest hashes every unrelated F4 scratch file.

New controller46381 launched with ten workers/threads,300s bounded slices,
8GiB batch budget, and explicit `--legacy-native-cache --deck-descended
--native-term-cache --recover-legacy-packing --recover-native-cleanup
--resume-unstarted-native`. Only the approved operational holds and
never-attempted work were requeued. Orbit7 charts31/30 were adopted only
after their fresh original-row replays. The first new orbit2 ten-worker
batch measured963.4% aggregate CPU and4.60GiB peak RSS. Its bounded jobs
hit memory limits and did NOT give new exclusions. Orbit6 later used a
five-worker tail when only five independent charts remained. At this
snapshot the controller is resuming first-oper chart21's native bilinear
checkpoint with ten threads; no backup heavy pool overlaps it.

The new coefficient caches/descent remove repeated field conversions,
but low-index symbolic elimination still produces resource-limited
attempts. Their evidence is preserved, not repeatedly retried under
unchanged limits. The new shared-root algorithm has actual degree1320
all-coefficient verification; the all18 arithmetic fixtures for the older
native field backend do NOT yet count as tests of this newer root cache
at degree14648 or the optional degree4308 field. Those bounded fresh-
process fixtures remain the next all18 preflight task, without exporting
the four deferred tensors or altering the selection.

### All18 NEW root-cache preflight PASS; checkpoint I/O diagnosis

The just-mentioned missing arithmetic coverage is now CLOSED,2026-09-08
03:35CEST. `test_atlas_native_roots_fields.sage`, launched by
`run_atlas_native_roots_field_tests.py`, checked all18 intrinsic fields
and the eight GENUINELY larger chosen coefficient fields (orbits1/3/4/5/
7/8/9/10). It uses the actual census moduli and verified Kummer conversion,
not fields selected only by degree. Each real3072-slot native direction
fixture has24 selected coefficient positions and zeros elsewhere, with
dense, sparse, graded, monomial, product and fifth-power values. Every
slot's returned fifth power is replayed independently in Sage; the24
selected positions also match its independent inverse-Frobenius map.
Hash-bound completed cache reuse passes. A native wrong-generator input
and a wrong source hash are rejected by separate negative controls.

All26 cases PASS in31.130s wall. A genuinely ten-process phase sampled
887% aggregate CPU; peak aggregate RSS2.62GiB. The later single-worker
tail is the largest field, not a missing worker configuration. Intrinsic
degree14648 takes25.827s algebra:0.694s fixture/field setup,9.604s root-map
and native stage,15.529s independent scalar replay. Its native worker
itself takes0.818s/39.3MiB for this SPARSE fixture. Chosen degree4308 takes
9.243s algebra, including6.985s verified Kummer-field preparation; native
root work is0.155s. These timings do not estimate dense full tensors.
Sage10.9, exact element types, seed, source hashes, modulus, selected slots
and all native bytes are retained per case.

External summary:
`orbit11-structure/all18-new-root-fixtures/batch-1788831327678514000.json`,
SHA256 f317e584648b1775080fde0124d5aea16fd64b21af540422fcdbeee6b6fa13db.
The degree14648 report SHA256 is
13a791f2aed669db9fe6d04451e2d2bf787f76e89ccddae4af8766370dd9c775.
Launcher16919 and every fresh worker group exited; an independent census
confirms no remaining descendants. No tensor for a deferred representative,
new oper enumeration, atlas certificate or whole-oper exclusion was made.

The approved checkpoint-safe pause retired46381 after invariant1's bounded
slice completed. The controller had just entered invariant2's next F4
attempt; wrapper15707 and solver15775 also exited through its own stop
path. All1008 inventoried artifacts were rehashed unchanged in0.879s.
The completed invariant1 checkpoint and invariant2's available round
checkpoints remain. Root's reserved one-core120s symbolic test and backup's
30s no-solver replay follow the field window; the same selected14 resumes
after those bounded slots, with no changed mathematical limits.

A new measured performance issue is FULL CHECKPOINT SERIALIZATION:
first-oper chart21's latest slice spent97.439s of320.478s in four saves,
writing34,154,398,506 bytes. Invariant0 chart21 spent45.488s of297.711s in
five saves, writing17,632,783,935 bytes. First-oper state.cp alone is8.1GiB.
Saved rows/pivots are immutable after insertion, and the provenance DAG
already appends. Therefore an exact incremental pivot log plus a small
atomic committed-prefix manifest is a plausible next design. It must
retain checksum/truncation checks, the last committed input and DAG offsets,
fallback to the previous complete prefix, and validated old-format resume.
No new checkpoint format or interval change is currently deployed. A
checkpoint I/O saving is not a proof that the remaining bilinear ideal is
finite or that the full R equations have no solution.

### Overnight pause and exact one-core handoff —2026-09-08 03:50CEST

The NEW user resource policy supersedes every ten-worker command above:
at most ONE CPU core TOTAL while the user sleeps. Do not run a background
solver concurrently with a root/backup diagnostic. No automatic resume,
new test, new research branch or new agent is authorized by this handoff.

Controller26046 was safely stopped using `run_all_atlases.py stop`.
Its active export was orbit6, wrapper49270/Sage49273, with owned workers
49467,49594,49595,49596,49597. Every named PID and the whole owned group
are gone; a separate command census finds no atlas builder, exporter,
solver or new-root-fixture process. The authority says `status: stopped`,
`active: null`, orbit6 `paused`, and no representative needs_attention.
Selected14 and deferred orbit0008--0011 are UNCHANGED. No file was deleted.

Exact final counts:51 adopted original-equation chart certificates,
64 completed chart calculations,14 full tensors, ZERO whole representatives.
The13 unverified basis records are not certificates. One additional unique
external first-oper28 certificate is not adopted, so52 distinct chart
exclusions are known. All26 NEW root-cache arithmetic fixtures passed as
recorded above; no deferred tensor or atlas exclusion was produced by them.
The last restarted ten-chart orbit1 batch measured926.1% peak CPU but
yielded no new certificate. Its resource-limited attempts remain preserved.
The saved watcher has6 unfinished/unattempted native charts and391 terminal
noncertificate attempts; its OLD ten-worker sweep estimate is not valid
under the new resource policy and is never a completion estimate.

IMMEDIATE OPERATIONAL ISSUE, found during the final log read: orbit6's
fallback exporter did not spend the whole256.32s on useful algebra.
`multiprocessing.Pool`'s `_handle_results` thread segfaulted while unpickling
a PARI finite-field element returned by `_rooted_block`. The parent then
waited with idle workers. This is the same prohibited PARI-on-background-
thread boundary, not an atlas failure. Evidence:

    atlas-all18/orbit_0006/logs/exporting-1788831920807299000.log

The source tensor hash is
2205623fed2ecace5c33c9702e5f8d1d76f6e543e27f10cd1207d1e587a47012.
Five completed, hash-bound rooted blocks0--4 remain in
`atlas-all18/orbit_0006/charts/rooted_coefficients/`, with their `.sobj`
and `.json` files. There is no newly exported chart or chart manifest;
the earlier original-row chart certificates29/30/31 are untouched.
No coefficient corruption or affected completed certificate was identified.

`export_rooted_atlas.sage` has an explicit `root_workers==1` serial branch,
which bypasses this result-thread unpickle. It was inspected, NOT newly
regression-tested tonight. Before any future multiworker export, return
only plain metadata/path values from workers and load/verify field objects
on the main Sage thread, or consume the already checked native root cache.
Do not simply restart the same PARI-returning pool. The new cache itself
has already passed every all18 field fixture; this old exporter has not
yet been connected to it.

Only after root coordinates use of the SINGLE global core, the exact
one-worker resume command is below. It was NOT run. The stored selection,
limits, terminal attempts and checkpoints are reused; no recovery/retry
flags or new selection flags are added.

```sh
cd /Users/julian/Documents/litt3
env OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 \
  VECLIB_MAXIMUM_THREADS=1 BLIS_NUM_THREADS=1 NUMEXPR_NUM_THREADS=1 \
  python3 scripts/run_all_atlases.py launch \
  --threads 1 --pairs 1024 --slice-minutes 5 --rss-gib 8 \
  --export-batch 1 --native-batch 1 \
  --legacy-native-cache --deck-descended --native-term-cache
```

Safe read-only status command: `python3 scripts/run_all_atlases.py status`.
The authoritative state is external `atlas-all18/all18.json`; do not edit
it manually. Exact checkpoint/log paths and each representative's original
certificate adoption are recorded there and in its per-chart `run.json`.
The previously verified1008-file preservation inventory and six-case
192-binary report are unchanged. Current native chart21 checkpoints in
orbit0/invariant0/invariant1 also retain their last completed row prefixes.

UNVALIDATED NEXT CODE, not deployed or executed: the newly prepared
`scripts/test_native_checkpoint_bulk_io.py` generates a separate same-format
bulk-I/O candidate from `CPP_GENERAL`. Only Python syntax was checked.
Its native compilation, exact old-prefix/weight/DAG comparisons, corrupted-
checkpoint fallback and synthetic I/O benchmark have NOT run. As currently
written the regression includes ten-thread cases, so DO NOT invoke it
under the overnight policy; first parameterize it to a one-thread limit
if root later authorizes that test. Neither `mixed_atlas_certificate.sage`
nor its deployed checkpoint format/interval was changed. A delta checkpoint
design remains only a proposal, with the measured serialization evidence
above. No pending test process or timer belongs to this agent.

Mathematical next action, independently of profiling: the exact remaining
Wronskian obstruction is nonzero proportionality of the two56-coordinate
vectors on the nonempty admissible P31 open. All R/normalization conditions
and higher-corank strata must remain. See `ORBIT11_STRUCTURE.md`, and
`CORED_COMPUTATION_STATUS.md` for what a completed untwisted calculation
would and would NOT prove. No credible whole18 finish date is established.
