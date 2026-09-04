# Entry-1 P_infty high-branch ODE

Date: 2026-06-05.

Status: `proved-text` local formal-series calculation. It prescribes one branch
coefficient but does not show that the global bidegree normal form can realize
that prescription simultaneously at all branches.

This note records the first scalar Cartier-equation recurrence on the high
branch at the entry-one low-`z` corner `(x,z)=(infty,0)`.

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

Thus the first high-branch ODE condition uniquely prescribes the later local
coefficient `a35`. At this formal-branch level it imposes no new condition on
`a31=-1/h21`; globally, `a35` need not be an independent parameter. In
particular, this calculation gives no entry-one contradiction.

## Exact replay

For the coefficient through `t^5`, the factor `(1-v)` in the derivation can
be omitted because `ord_t(v)=31`. The calculation is reproduced efficiently
by the following complete Sage input:

```text
R.<a31,a32,a33,a34,a35,a36,a37,a38> = PolynomialRing(GF(5))
K = R.fraction_field()
S.<t> = PowerSeriesRing(K, default_prec=12)
A = a31+a32*t+a33*t^2+a34*t^3+a35*t^4+a36*t^5+a37*t^6+a38*t^7
B = 31*a31+32*a32*t+33*a33*t^2+34*a34*t^3+35*a35*t^4 \
    +36*a36*t^5+37*a37*t^6+38*a38*t^7
D = lambda f: (-t*A/B)*f.derivative()
ode=D(D(D(D(t))))-(t-t^5)
print(ode.valuation())
print(ode[5].factor())
```

The output is:

```text
5
a31^-4 * (a31^4 + a32^4 + a31*a32^2*a33 + 2*a31^2*a33^2
           - a31^2*a32*a34 + a31^3*a35)
```

No later coefficient is used here.
