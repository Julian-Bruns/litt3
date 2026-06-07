# G4 double-fiber tail coverage target

Date: 2026-06-05.

This note isolates the proof obligation that remains after the basin-127
certificate.  It is the current `G4` gate from
`167_SHORTEST_REDUCTION_AUDIT_GATES.md`.

## The target theorem

Work over

```text
k = \bar F_5.
```

In the corrected `Q_0=P_0`, `c=d=2` double-fiber branch, after the repeated
layers `u5,u10,u15,u20,u25` and the simple layer `u30`, prove:

```text
Every tail-exhausted simple-u30 point satisfying
  low-data all-zero equations,
  simple-u30 base residual = 0,
  post-u25 repeated e30 consistency,
on the rho3/rho4 pivot opens
lies in one of the already killed local basins.
```

Equivalently, after adding the later symbolic e35/e40/e45/e50 obstructions,
the localized solution scheme is empty over `k`.

This is not the same as proving the coefficient-only all-zero locus is empty:
that statement is false on both rho3 and rho4 charts.

## Known killed pieces

The following pieces are locally killed over `k=\bar F_5`.

```text
P129 tangent basin:
  `150_TANGENT_CANDIDATE_FIELD_AND_E50_AUDIT.md`
  Exact tangent-neighborhood census around P129 found four
  base-zero/e30-consistent hits.  The generalized symbolic checker kills all
  four through e50.

rho4 tangent basin:
  `156_RHO4_ALLZERO_POINT_AND_E50_KILL.md`
  Exact rho4 tangent-basin enumeration found six coefficient-all-zero hits.
  The unique base-zero/e30-consistent hit is killed through e50.

e50 one-variable endings:
  `160_E50_FINAL_LINE_SINGULAR_CHECKS.md`
  Singular checks the final one-parameter ideals for P129, the three P129
  companions, and the rho4 base-zero hit are unit ideals.
```

The basin-127 piece is pending the active Sage/Singular certificate:

```text
basin-127 affine Newton family:
  `159_BASIN127_CAS_SETUP_AND_DISPLAYED_BASIS_CHECK.md`
  verifies the displayed quotient, radical length 5, Delta-open condition,
  and base-residual cut to P129.

  `178_BASIN127_THEORETICAL_REDUCTION_PLAN.md`
  and `179_BASIN127_TAIL_DEPTH_REDUCTION.md`
  reduce the intended certificate to radical containment on the open chart.

  If the Sage certificate proves the original low-data ideal is contained in
  the displayed quotient, then the base residual cuts basin-127 to P129, which
  is already killed.
```

## What finite searches currently prove

They prove tactical facts only, not `G4`.

```text
127 near-miss finite affine census:
  Full F_5 census of the six-dimensional affine Newton family has five
  coefficient-all-zero hits, but only one base-zero/e30-consistent hit:
  P129.

P129 tangent finite census:
  Full F_5 tangent affine space has 17 coefficient-all-zero hits and four
  base-zero/e30-consistent hits, all killed at e50.

rho4 tangent finite census:
  Full F_5 tangent affine space has six coefficient-all-zero hits and a unique
  base-zero/e30-consistent hit, killed at e50.

bounded high-nullity scout:
  Random low-support rho3 near-miss basins with nullity <= 4 produced no
  coefficient-all-zero hit.
```

These are finite-field diagnostics.  A final proof needs ideal containment,
saturation, or explicit algebraic stratification over `k`.

## Algebraic form of the missing coverage

The cleanest exact target is an ideal-containment statement.  Introduce the
remaining post-`u25` free variables used by the repeated `e30` affine system,
rather than treating "e30 consistency" as a Python predicate.  Then form, on
each chart:

```text
I_chart =
  <3 phi equations,
   chart non-pivot simple-u30 Schur equations,
   simple-u30 base residual,
   repeated e30 equations with post-u25 free variables>
  : (Delta * chart_pivot_product)^infinity.
```

The desired coverage statement is:

```text
V(I_rho3) union V(I_rho4)
  is contained in the union of the killed basin ideals.
```

After adjoining the corresponding e35/e40/e45/e50 layer equations on those
basin ideals, the localized ideal should become the unit ideal.

This formulation avoids the two main mistakes in earlier local targets:

```text
1. It does not ask for coefficient-only all-zero emptiness.
2. It does not replace k-valued coverage by an F_5 enumeration.
```

## Suggested proof strategy

The most realistic route is a stratified saturation proof.

```text
Step 1. Close basin-127.
  Finish either the full Sage certificate or the reduced d<=2 certificate.

Step 2. Make repeated e30 algebraic.
  Extract the post-u25 repeated e30 affine equations as polynomials in the
  19 local variables plus the remaining post-u25 tail variables.

Step 3. Split by chart and rank/nullity strata.
  Use minors of the low-data Jacobian or of the e30 affine matrix to isolate
  high-nullity components.  The finite evidence suggests only nullity 6/7
  strata are productive.

Step 4. On each high-nullity stratum, prove containment in one of:
  P129 tangent basin,
  basin-127 affine family,
  rho4 tangent basin.

Step 5. On the complement, prove the localized ideal is empty or has nonzero
  base/e30 obstruction.
```

The immediate local coding target after basin-127 is therefore not another
random search.  It is an exact generator for the repeated-e30 consistency
ideal with free variables, suitable for Sage/Singular saturation.

## Current practical implication

If the active Sage run reaches `w7`, the reduced basin-127 run should be tried
first, because it may close one known high-nullity component cheaply.  But even
a successful basin-127 certificate only proves one component of `G4`; the
project still needs the chart-wise coverage statement above.
