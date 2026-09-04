# Shortest reduction, audit gates, and post-Sage route

Date: 2026-06-05.

This is the current shortest honest route from the displayed divisor problem
to the best remaining subproblems.  It separates proved local facts from gates
that still need a proof.

## Target level

There are two different theorem levels in the archive.

```text
Displayed curve-level problem:
  eliminate or construct the genus-11 pair (C,x,r) with the stated
  degree-35 divisors and incidence matrix.

Full common-cover problem:
  prove or disprove the required common-cover statement.  The current
  counterexample route still needs a global bridge, such as
  Comm_alg(P^1_{\bar F_5}(31,31,31)) = S3, or a proof that the displayed
  degree-35 problem is the only missing obstruction.
```

The live Sage computation belongs to the displayed curve-level route, not by
itself to the global commensurator theorem.

## Shortest curve-level spine

1. Start from the displayed divisors and incidence matrix

   ```text
   [[0,1,3],
    [1,2,1],
    [3,1,0]].
   ```

2. Use the logarithmic quotient lemma in
   `162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md`.

   If `Q_j=P_i`, then

   ```text
   Y_{i,j}=Omega_j(r)/Omega_i(x),     deg(Y_{i,j}) <= 6-M_ij.
   ```

   The residue table forces too many points in one finite fiber for

   ```text
   Q_infty=P_0,  Q_1=P_1,  Q_0=P_infty.
   ```

   Audit status: the divisor cancellation and residue counts check out.

3. The remaining profile-4 cases are exactly:

   ```text
   A. entry-0 high-point coincidence:
      represented by Q_0=P_0.  The edge Q_infty=P_infty is equivalent by
      simultaneous inversion x -> 1/x, r -> 1/r;

   B. entry-1 high-point coincidence:
      represented by Q_1=P_0;

   C. no high-point coincidence.
   ```

4. The paired entry-0 edge `Q_0=P_0, Q_infty=P_infty` is impossible by the
   bidegree `(5,5)` genus-drop argument in the standalone note.  Therefore,
   after `G1` excludes entry-1 coincidences, the existing double-fiber tower
   addresses the whole surviving entry-0 branch, namely

   ```text
   Q_0=P_0, no other high-point coincidences,
   x(Q_1)=x(Q_infty)=2, Q_1 != Q_infty.
   ```

   This is the corrected `c=d=2` double-fiber branch.

5. In the `c=d=2` double-fiber branch, the local tower has cleared the
   repeated/simple layers through `u25`.  The frontier is the tail-exhausted
   simple-`u30` all-zero plus base-zero/e30 locus.

6. If the live Sage run proves the basin-127 saturation equality, then the
   displayed high-nullity basin is closed over `k=\bar F_5` and its base
   residual cuts to `P129`, already killed by the e50 symbolic certificate.

7. Even after that success, one more local coverage theorem is needed:

   ```text
   Every point of the tail-exhausted simple-u30 all-zero plus
   base-zero/e30 locus lies in one of the already killed basins,
   or no such point exists.
   ```

## Gates still open

These gates are the current best subproblems.

```text
G1. Entry-1 theorem.
    No profile-4 solution has an entry-1 high-point coincidence.

G2. No-highpoint theorem.
    No profile-4 solution exists with all six high points distinct.
    The residual `(4,4)` route for this gate is isolated in `170`.

G3. Double-fiber tail coverage.
    The killed P129/rho4/basin-127 neighborhoods cover the entire
    tail-exhausted simple-u30 all-zero plus base-zero/e30 locus.
    The exact chart-wise ideal/saturation target is now isolated in
    `180_G4_DOUBLE_FIBER_TAIL_COVERAGE_TARGET.md`.

G4. Global bridge.
    Either prove Comm_alg(P^1_{\bar F_5}(31,31,31)) = S3, or prove a direct
    bridge showing that the displayed curve-level problem is sufficient for
    the intended common-cover counterexample.
```

The current computation can at most finish the basin-127 part of `G4`.

## Entry-1 audit

For the representative `Q_1=P_0`, the quotient

```text
z=(dr/r)/(dx/(x-1))
```

has

```text
div(z)=P_1+P_infty+D+G - Q_0-Q_infty-B,     deg(z)=5.
```

The separability check in `166_ENTRY1_DEGREE5_RH_BUDGET.md` is sound: the
p-closed equation `partial^4 z=z-z^5`, with
`partial=(x-1)d/dx`, rules out `dz=0` because then `z in F_5`, contrary to
`deg(z)=5`.

The obvious shortcuts do not work:

```text
- Riemann-Hurwitz for z has ramification budget 30 and no forced
  contradiction from z=0,infinity.
- The norm/trace identity for N_z(x-1) and N_z(r) is tautological.
- The first high-z triple-tangent constraints at B remain compatible.
- The first local p-closed ODE coefficient on a B branch solves a later
  branch coefficient and does not constrain the residual cubic C_B.
- The first scalar trace equation is exactly compatible; it fixes
  `Tr(z)=2+2*(-1/x)+(c-1)/(x-c)+4*(d-1)/(x-d)`, as recorded in `169`.
- The first simple finite-pole ODE condition is also compatible; see `172`.
- The degree-5 fiber partition shortcut for `z=1,-1`, including
  `alpha=±1`, is compatible; see `173`.
- The low-z corner `(x,z)=(infty,0)` gives only the open `h21 != 0` and the
  high-branch normalization `v=-(1/h21)z^31+...`; see `174`.
- The first ODE recurrence on that high branch solves the later coefficient
  `a35`; see `177`.
- The remaining global input from the actual function `r` is logarithmic
  exactness/principality, not merely p-curvature; see `175`.
- The `x`-norm of `r` explains the trace formula, while the `x`-norm of
  `r-1` is still extra data involving the unknown `r`; see `176`.
```

Thus `G1` probably needs a deeper p-curvature coefficient in the bidegree
`(5,35)` model, or a global argument using several fibers of `z` at once.

Near `(x,z)=(infty,0)`, the first tangent condition is also only an open
condition: the `G` branch has a free slope, while the `P_infty` branch has
high tangent `v=0` for `v=1/x`.  This corner is worth recording, but it is
unlikely to be a first-order contradiction.

## Audit warnings

Use these as hard guardrails in a final proof.

```text
1. Work over k=\bar F_5.  Prime-field scans are diagnostics only.

2. Do not impose c != d in the entry-1 bidegree-(5,35) model unless it is
   separately proved.  The edge `c=d` is separately audited in `171`: it is
   compatible and solves a later high-z coefficient.

3. Do not use the old bidegree-(6,35) Delta != 0 tangent cone in the
   c=d=2 double-fiber survivor.

4. Track every saturation open.  The basin-127 equality is a statement on
   the declared rho3 chart and Delta-open locus.

5. The e50 final-line checks prove the last no-root step only after the
   e35/e40/e45 symbolic layer reductions.

6. The global self-correspondence-to-over-orbifold bridge is still
   needs-referee.  It cannot be silently replaced by the displayed
   degree-35 computation.
```

## If Sage succeeds

Assuming the live Sage run proves the original low-data ideal saturates to the
displayed basin-127 quotient, update the local status as follows:

```text
basin-127 saturation equality: locked
displayed quotient and base residual: already CAS-checked
P129 final obstruction: already killed at e50
```

The next proof obligation is not another point check.  It is `G4`: a coverage
theorem for the whole double-fiber tail-exhausted locus.  After `G4`, the
curve-level problem still needs `G1`, `G2`, and the clean `G3` reduction.
After the curve-level problem, the full common-cover theorem still needs `G5`.

## Conditional completion lemma

Assume the Sage basin-127 saturation succeeds.

If `G1`, `G2`, and `G3` are proved, then the displayed profile-4
curve-level problem has no solution.

Proof.  The high-point quotient lemma leaves only the entry-0, entry-1, and
no-highpoint cases.  Gate `G1` removes entry-1.  Gate `G2` removes
no-highpoint.  The entry-0 inversion, paired-edge genus drop, and
norm-constant comparison reduce every remaining entry-0 survivor to the
corrected `Q_0=P_0, c=d=2` double-fiber branch.  In that branch, the audited
local tower reaches the tail-exhausted simple-`u30` all-zero plus base-zero/e30
locus.  Gate `G3`, using the Sage-success basin-127 closure together with the
existing P129/rho4/e50 kills, removes that locus.  Hence no profile-4
solution remains.

If, in addition, `G4` is proved, then the common-cover counterexample route is
complete.  In the commensurator version of `G5`, this is exactly the archived
conditional theorem: once

```text
Comm_alg(P^1_{\bar F_5}(31,31,31)) = S3
```

is locked, the existing genus-three canonical-degree obstruction gives the
negative common-cover conclusion.  In the direct-bridge version of `G5`, the
bridge identifies the displayed profile-4 nonexistence with the remaining
obstruction, so the same conclusion follows without separately proving the
full commensurator theorem.

My current numerical estimate after this audit:

```text
Displayed profile-4 curve-level proof:
  45-55% now, 50-60% if Sage succeeds.

Double-fiber c=d=2 subcase alone:
  65-75% now, 75-85% if Sage succeeds and its log is clean.

Full common-cover counterexample proof:
  40-55%, dominated by G5 unless the direct bridge becomes much sharper.
```
