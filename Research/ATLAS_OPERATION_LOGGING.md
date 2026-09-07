# Granular operation logs — 2026-09-07

TEMPORARY DEVELOPMENT INSTRUMENTATION. User requires removing diagnostic
logging when the specialized solver is finalized. Retain exact solution
certificates and required resumable state. Target: ALL18 representatives
in a few hours or less, including large coefficient fields. That full-run
runtime goal is NOT achieved. The improvements below address measured
preparation bottlenecks, not a proved algebraic complexity bound.

At15:00 the user requested production instead of further standalone tests.
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
