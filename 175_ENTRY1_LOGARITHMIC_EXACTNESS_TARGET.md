# Entry-1 logarithmic exactness target

Date: 2026-06-05.

This note records what the existence of the actual function `r` adds in the
entry-1 bidegree `(5,35)` route.

The scalar p-curvature equation is necessary, but it is not the same thing as
constructing `r`.

## The logarithmic form

In the representative entry-1 case

```text
Q_1=P_0,        z=(dr/r)/(dx/(x-1)),
```

put

```text
omega = z * dx/(x-1).
```

The bidegree p-curvature condition says, equivalently,

```text
Cartier(omega)=omega.
```

Using

```text
div(z)=P_1+P_infty+D+G - Q_0-Q_infty-B
```

and

```text
div(dx/(x-1))=
  30P_0 - P_1 - P_infty - C - D - E - F - G,
```

one gets

```text
div(omega)=30P_0 - Q_0 - Q_infty - B - C - E - F.
```

If `omega=dlog(r)`, then the residues are:

```text
+1 at Q_0, C, F,
-1 at Q_infty, B, E.
```

This is consistent with the divisor above.

## What p-curvature does not prove

The condition `Cartier(omega)=omega` is only the dormant/logarithmic
connection condition.  It does not by itself prove that `omega=dlog(r)` for a
rational function `r` with the required divisor.

The missing exactness/principal-divisor condition is:

```text
div(r)=31Q_0 + C + F - 31Q_infty - B - E.
```

Equivalently, the degree-zero divisor

```text
R_entry1 = 31Q_0 + C + F - 31Q_infty - B - E
```

must be principal.  Modulo fifth powers, `omega` only sees the residue divisor

```text
Q_0 + C + F - Q_infty - B - E.
```

The difference between this residue condition and the displayed divisor of
`r` is a genuine Picard/global exactness issue.

This is why the bidegree p-curvature equation can have formal or local
solutions that do not automatically give the original pair `(x,r)`.

## Exact differential divisor

If the required `r` exists, then

```text
dr = r * omega.
```

Adding divisors gives

```text
div(dr)
 = div(r)+div(omega)
 = 30P_0 + 30Q_0 - 32Q_infty - 2B - 2E.
```

For comparison,

```text
div(dx)=30P_0 + 30P_1 - 32P_infty - 2F - 2G.
```

Thus

```text
div(dr/dx)
 =
 30(Q_0-P_1) - 32(Q_infty-P_infty) + 2(F+G-B-E).
```

The associated floor/Tango divisors are

```text
T_r = 6P_0 + 6Q_0 - 7Q_infty - B - E,
T_x = 6P_0 + 6P_1 - 7P_infty - F - G,
```

so

```text
T_r-T_x =
 6(Q_0-P_1) - 7(Q_infty-P_infty) + (F+G-B-E).
```

This is the entry-1 analogue of the Cartier/Tango signpost in
`55_DOUBLE_FIBER_C2_AUDIT.md`.

## Useful next target

A strong entry-1 theorem could aim to prove one of:

```text
E1. no bidegree-(5,35) p-curvature solution satisfies the principal-divisor
    condition R_entry1 ~ 0;

E2. the Tango divisor comparison above contradicts the genus-11 linear
    systems forced by x;

E3. the full p-curvature system plus the exactness condition forces a
    forbidden high-point coincidence or one of the eliminated incidence cells.
```

At present this note is only a target.  No contradiction is known from this
exactness comparison alone.

The `x`-norm shadow of this exactness condition is recorded in
`176_ENTRY1_X_NORM_SHADOW.md`.  It explains why the trace formula in `169`
is compatible and isolates `N_x(r-1)` as genuinely depending on the unknown
function `r`.
