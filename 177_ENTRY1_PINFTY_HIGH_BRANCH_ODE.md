# Entry-1 P_infty high-branch ODE

Date: 2026-06-05.

This note records the first scalar p-closed recurrence on the high branch at
the entry-1 low-`z` corner `(x,z)=(infty,0)`.

It complements `174_ENTRY1_LOWZ_INFINITY_CORNER.md`.

## Setup

Put

```text
v=1/x,      z=t.
```

At `P_infty`, the corner analysis gives

```text
v = a31*t^31 + a32*t^32 + a33*t^33 + ...
```

with

```text
a31 = -1/h21,
```

so `a31 != 0`.

Since

```text
partial=(x-1)d/dx = -v(1-v)d/dv,
```

along the branch

```text
partial = -v(1-v)/v'(t) * d/dt.
```

The scalar equation is

```text
partial^4(t) = t - t^5.
```

## First coefficient

Substitute

```text
v = a31*t^31+a32*t^32+a33*t^33+a34*t^34
    +a35*t^35+a36*t^36+a37*t^37+a38*t^38+...
```

into

```text
partial^4(t)-(t-t^5).
```

The valuation is `5`: all coefficients through `t^4` vanish.  The coefficient
of `t^5` is

```text
(a31^4 + a32^4 + a31*a32^2*a33
 + 2*a31^2*a33^2 - a31^2*a32*a34 + a31^3*a35) / a31^4.
```

Because `a31 != 0`, the equation at this layer is equivalent to

```text
a35 =
 -(a31^4 + a32^4 + a31*a32^2*a33
   + 2*a31^2*a33^2 - a31^2*a32*a34) / a31^3.
```

Thus the first high-branch ODE condition solves the later coefficient `a35`.
It imposes no condition on `h21` beyond the already known open `h21 != 0`,
and gives no entry-1 contradiction.

## Sage check

The calculation was run in the fraction field of

```text
GF(5)[a31,a32,a33,a34,a35,a36,a37,a38].
```

Command shape:

```text
v=sum(a_n*t^n for n=31..38)
D=lambda f: (-v*(1-v)/v.derivative())*f.derivative()
ode=D(D(D(D(t))))-(t-t^5)
```

Sage output began:

```text
valuation 5
5 (a31^4 + a32^4 + a31*a32^2*a33 + 2*a31^2*a33^2
   - a31^2*a32*a34 + a31^3*a35)/a31^4
```

The next printed nonzero coefficient was at `t^10`; it was not used here,
because the `t^5` equation already shows the first layer is a solve rather
than an obstruction.

