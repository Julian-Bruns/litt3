# Entry-1 degree-5 fiber partition audit

Date: 2026-06-05.

This note checks whether the degree-5 map

```text
z=(dr/r)/(dx/(x-1))
```

in the representative entry-1 case `Q_1=P_0` can be eliminated just from
local p-closed order restrictions on the fibers `z=1` and `z=-1`.

It cannot.

## Local order restrictions

The p-closed equation is

```text
partial^4 z = z-z^5,        partial=(x-1)d/dx.
```

At an ordinary point for `partial`, use the local normal form

```text
partial=(1+u)d/du.
```

For a finite value `lambda in F_5`, the allowed local orders of
`z-lambda`, up to degree `5`, are

```text
1,2,3,5      (order 4 is forbidden).
```

At a simple zero of `partial`, use

```text
partial=rho^{-1}u d/du,        rho in F_5^*.
```

For `lambda in F_5`, the allowed local orders up to degree `5` are

```text
1,2,3,4      (order 5 is forbidden).
```

The high point `P_0=Q_1` is a pole of `partial`; the old local recurrence
gives the same finite-order list relevant here:

```text
1,2,3,5      (order 4 is forbidden).
```

## The simple zeros of partial

The divisor of `partial` has simple zeros at

```text
P_1, P_infty, E_1, E_infty.
```

In entry-1 these ten points are already distributed as:

```text
z=0:   P_1 + P_infty + D + G        degree 5
z=1:   C                            degree 1
z=-1:  E + F                        degree 4
```

Thus the known `partial`-zero points exactly fill the known `F_5` fibers
`0,1,-1`.

## Fiber z=1

Let

```text
alpha=z(P_0).
```

If `alpha != 1`, then the forced point `C` may have multiplicity
`m_C in {1,2,3,4}` and the remaining degree is filled by ordinary points
with parts in `{1,2,3,5}`.  The possible shapes are:

```text
m_C=1: ordinary residual 1+1+1+1, 1+1+2, 1+3, 2+2
m_C=2: ordinary residual 1+1+1, 1+2, 3
m_C=3: ordinary residual 1+1, 2
m_C=4: ordinary residual 1
```

If `alpha=1`, then `P_0` is also in the fiber, with multiplicity
`m_0 in {1,2,3,5}`.  The legal possibilities include:

```text
m_C=1,m_0=1: ordinary residual 1+1+1, 1+2, 3
m_C=1,m_0=2: ordinary residual 1+1, 2
m_C=1,m_0=3: ordinary residual 1
m_C=2,m_0=1: ordinary residual 1+1, 2
m_C=2,m_0=2: ordinary residual 1
m_C=2,m_0=3: ordinary residual empty
m_C=3,m_0=1: ordinary residual 1
m_C=3,m_0=2: ordinary residual empty
m_C=4,m_0=1: ordinary residual empty
```

So `z=1` gives no contradiction.

## Fiber z=-1

If `alpha != -1`, the four forced `partial`-zero points in `E+F` already
use degree `4`.  The only legal shapes are:

```text
all four forced points simple, plus one ordinary simple point;
or exactly one of the four forced points double, and no extra point.
```

If `alpha=-1`, then degree `5` forces:

```text
all four forced points simple, and P_0 simple.
```

Again there is no contradiction.

## Outcome

The fiber partition/Riemann-Hurwitz shortcut does not eliminate entry-1.
The forced `F_5` fibers are compatible with the p-closed local order lists,
including the special cases `alpha=1` and `alpha=-1`.

Future entry-1 work should use deeper bidegree/p-curvature coefficients,
the existence of the solution `r` to `partial(r)=zr`, or a global interaction
between several fibers.  Plain degree-5 fiber partition bookkeeping is too
weak.

The exactness version of the `r`-existence target is isolated in
`175_ENTRY1_LOGARITHMIC_EXACTNESS_TARGET.md`.
