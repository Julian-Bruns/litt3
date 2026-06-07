# Simple x=0 u10 charted solve certificate

This note proves the local theorem suggested by
`double_fiber_x0_simple_u10_charted_probe.py`: after the certified
repeated-`x=0,u^5` atlas, the next simple-branch coefficient at `x=0,u^10`
solves `U17(0)` with unit coefficient `3`.  It is a local double-fiber layer
result, not a complete common-cover proof.

## Setup

Work at `x=0`, write `u=x`, and use the simple branch

```text
w = -u + b2*u^2 + ... + b16*u^16 + ...
```

with

```text
z = 1/w,
D = (-1+u)d/du,
E = D^4 z - z + z^5.
```

The simple `u^5` equation has already solved

```text
l00 = U22(0) = Lc + Li*i00 + Lj*j00.
```

The repeated `u^5` layer is already charted by

```text
det(I,L,P) != 0  or  det(I,M,P) != 0,
P = l02 + m01 + n00,
```

and thus fixes the older visible variables chartwise, leaving the appropriate
free chart parameters.

Now add

```text
F16 = x*(x-1)*U19(x),
F17 = x*(x-1)*U18(x),
F18 = x*(x-1)*U17(x).
```

Only `U17(0)` is relevant for the coefficient response proved here.

## Branch Response To U17(0)

Let `v=U17(0)`.  The perturbation from `v` is

```text
delta F = x*(x-1)*v*w^18.
```

At `x=u` and `w=-u+O(u^2)`,

```text
x*(x-1) = -u + u^2,
w^18 = u^18 + O(u^19),
```

so the coefficient of `u^19` in `delta F` is

```text
-v = 4v.
```

The coefficient of `b16` in the same branch equation is the simple-root
derivative.  In quotient notation `q=w/u`, the leading factor is

```text
G0(q) = (q-1)^3*(q+1).
```

At the simple root `q=-1`,

```text
G0'(-1) = (-2)^3 = 2       in F_5.
```

Thus the `u^19` branch equation has linear response

```text
2*delta b16 + 4*v = 0,
```

and therefore

```text
delta b16 = 3*v.
```

## ODE Response

A perturbation `delta w = delta b16*u^16` changes

```text
z = 1/w
```

by

```text
delta z = -w^(-2)*delta w = -delta b16*u^14 + O(u^15).
```

Only `D^4(delta z)` can contribute to the coefficient of `u^10`; the term
`-delta z` is still too high, and `delta(z^5)=0` in characteristic `5`.

For the lowering part of `D=(-1+u)d/du`,

```text
[u^10] D^4(u^14) = 14*13*12*11 = 4       in F_5.
```

Therefore

```text
[u^10] delta E
 = -4*delta b16
 = delta b16
 = 3*v.
```

So the simple `x=0,u^10` equation has the form

```text
R + 3*U17(0) = 0,
```

where `R` depends on older chart variables and on `U19(0),U18(0)`, but not on
`U17(0)`.

Since `3` is a unit in `F_5`, the equation always solves `U17(0)` and imposes
no new residual equation on the older variables.

## Finite Verification

The charted finite extractor is

```text
double_fiber_x0_simple_u10_charted_probe.py
```

The broad basis scan

```text
python3 double_fiber_x0_simple_u10_charted_probe.py --limit 100 --stop-on-failure
```

returned

```text
samples checked: 100
chart counts: [('rho3_i00_l01_p', 78), ('rho4_i00_m00_p', 22)]
u17 coefficient counts: [(3, 100)]
basis issues: []
```

One full graph in each certified chart was checked:

```text
rho3 full graph: 15625 assignments, success
rho4 full graph: 15625 assignments, success
```

These finite checks agree with the leading-term proof above.
