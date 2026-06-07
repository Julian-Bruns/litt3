# Entry-1 low-z corner at x=infinity

Date: 2026-06-05.

This note records the remaining low-`z` boundary corner in the representative
entry-1 bidegree `(5,35)` model:

```text
(x,z)=(infty,0).
```

It does not eliminate the case, but it gives a useful open condition and a
normalization check for future coefficient work.

## Local setup

Put

```text
v=1/x.
```

The fiber `z=0` is

```text
P_1 + P_infty + D + G.
```

The corner `(x,z)=(1,0)` contains `P_1+D` and is treated in `165`.  The corner
`(infty,0)` contains:

```text
P_infty  with v=t^31, z~t,
G        with v~t,    z~t.
```

Thus the tangent cone must have one vertical branch `v=0` and one ordinary
branch.

## Expansion

Use the low-`z` notation from `165`:

```text
K Phi = A + Phi1 z + Phi2 z^2 + ...
h0 = 2A + h01 z + h02 z^2 + ...
h1 = 4A + h11 z + h12 z^2 + ...
h2 = h21 z + h22 z^2 + ...
```

Multiply the affine equation by `v^5` after substituting `x=1/v`.
To total degree `4` in `(v,z)`, Sage gives

```text
v^5 f(1/v,z) =
  -A v^2 + h21 v z
  -2A v^3 + (h11-h21)v^2 z + h22 v z^2
  +2A v^4 + (h01-h11)v^3 z + (h12-h22)v^2 z^2
  + higher terms.
```

The tangent cone is therefore

```text
v(h21 z - A v).
```

Since `A=K alpha^31 u` is nonzero, the required two branches force

```text
h21 != 0.
```

This is an open condition, not a contradiction.

## High branch leading term

The `x^5` coefficient of the bidegree model is

```text
Gamma(z)=z^32(z+1)^3.
```

For the vertical high branch at `P_infty`, write

```text
v = a z^31 + higher terms.
```

The degree-32 terms in `v^5 f(1/v,z)` are

```text
h21*a*z^32 + z^32.
```

Therefore

```text
a = -1/h21.
```

This is exactly the expected high ramification shape `v~z^31`.  It gives a
normalization check for later low-`z` expansions: any entry-1 coefficient
normal form must keep `h21` invertible and must recover the leading high-branch
coefficient `-1/h21`.

## Sage check

The displayed expansion was computed by:

```text
R.<A,Phi1,Phi2,h01,h02,h11,h12,h21,h22>=PolynomialRing(GF(5))
T.<v,Z>=PolynomialRing(R)
KPhi=A+Phi1*Z+Phi2*Z^2
h0=2*A+h01*Z+h02*Z^2
h1=4*A+h11*Z+h12*Z^2
h2=h21*Z+h22*Z^2
x=1/v
f=(1-x)*KPhi + x*(x-1)*(h0+x*h1+x^2*h2)
truncate(v^5*f, total_degree<=4)
```

