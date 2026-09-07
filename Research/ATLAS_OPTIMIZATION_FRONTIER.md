# Atlas optimization frontier — 2026-09-07,13:25 CEST

User rejects the previous over30day forecast. After the bounded work below,
user explicitly requested a full restart to inspect the ETA. The queue is
restarted; only validated preparation improvements are deployed. No whole
oper is excluded, and no reasonable full-run finishing time is established.

## Deployed: fixed-curve arithmetic belongs over F25

`scripts/build_oper_atlas.sage` now computes Laurent expansions, S,D and
the monomial fifth-power matrix over the fixed curve's F25, then transports
using the explicit embedding a->data['a']. Full first and invariant_0
N/R/SU/Bc/Iproj equality passed; both coupled-R image checks passed.
Invariant_2 local computation now0.40sec instead of stalling for minutes.
Transport still13.59sec, coordinates complete23.44sec, individual tensor
directions about15sec. Its90sec validation saved directions00–03; this is
NOT a completed invariant_2 tensor. Data external atlas-builder-base25-v3.
Old tensor/checkpoint directories unchanged; source hashes reject mixing
incompatible builder stages. Base-field coefficient images are cached.

## Promising but NOT deployed: native coefficient fields

The exporter currently introduces coefficient generators as ordinary F5
variables. This is exact, but the largest defining polynomial has degree
14648 and enters the monomial ordering with that artificial degree. Native
coefficient arithmetic avoids that growth. Installed Singular supports it.

Actual chart28 slimgb solver candidates: nativeF25 0.048sec vs encoded0.661;
after exact F625 scalar extension native0.046 vs encoded5.413sec. These
easy cases do NOT forecast hard cases: chart26 and invariant_0 chart24
timed out10sec both ways; first chart23 native slimgb timed out60sec.
Singular has neither our internal F4 checkpoints nor demonstrated multicore
throughput here. Do not switch the production queue blindly.
Retained bounded comparison: scripts/benchmark_atlas_native_field.py.

For a normalized representative, native absolute base field plus an optional
ordinary cubic variable t (relation t^3-lambda) avoids flattening the cubic
tower. Native-field cost at degree14648 remains unmeasured. The current
whole-run ETA multiplies small-field forecasts by residue degree; this is
only a conditional extrapolation, not a measured or proved bound.

## Finished negative tests — do not repeat unchanged

1. Mixed polynomial multipliers deg_v<=1,deg_b<=1 for first chart23:
   all26136 rows,25245 columns, rank22227; NO certificate in that complete
   space.349sec total, peak466MiB. Prior120sec test was merely incomplete;
   the600sec retry finished. Scripts/mixed_atlas_certificate.sage includes
   exact F25 arithmetic, provenance and independent original-row identity
   checking. It gave verified chart29 and28 certificates in about1sec each.
   Artifacts external atlas-mixed-certificates. Failure of this ansatz is
   not atlas existence or proof the chart survives.
2. Two geometric pole charts: normalize either pole112 or pole111 leading
   coefficient of v=U^[1/5] to1. Known admissibility makes these exhaustive;
   their finite ambiguity is mu4, not the mu3 normalization. Actual first
   tensor tests eliminated ZERO variables (64/63 remained); native solver
   timed out30/10sec. Thus replacing32 chart labels by2 does not yet remove
   the hard algebra. Pilot code removed; data external atlas-pole-pilot.
3. Installed msolve -q1 signature backend refuses unchanged inhomogeneous
   inputs (CLI source check, exit1). Its result-export path is also
   unimplemented. No homogenization or source patch was made; no checkpoint
   compatibility. Logs external atlas-signature-installed.

## Structural lesson for the next attempt

Naively counting mixed Macaulay rows overestimates independent information:
for chart23 there are88 bilinear rows. At multiplier bidegree(1,1), their
pairwise Koszul relations already give dependencies. The actual complete
rank22227 is below25245. More rows than columns does NOT predict a unit
certificate without accounting for these relations.

At the hardest charts the low bilinear system can retain positive-dimensional
weak-section geometry; the Frobenius compatibility equations are essential.
Prioritize reducing that structured incidence or a genuinely native-field,
checkpointable solver. Neither fewer chart labels nor small-case speedups
alone establish feasible exclusion of all18. Preserve both actual etale legs
and the separate twisted, small-cored and coreless gaps in AFTER_ENUMERATION.
