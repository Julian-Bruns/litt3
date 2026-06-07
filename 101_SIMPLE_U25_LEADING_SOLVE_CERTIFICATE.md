# Simple x=0 u25 leading solve certificate

This note records the next simple-branch layer after the repeated
`x=0,u^20` fiberwise solve.  It is a local double-fiber layer result, not a
complete common-cover proof.

## Context

After the certified local layers through repeated `u^20`, the next simple
branch at `x=0` has tangent

```text
w=-u+O(u^2).
```

The next nonconstant ODE coefficient is `u^25`.  To compute it, the simple
branch must be continued to the coefficient `b31` in

```text
w=-u+...+b31*u^31+...
```

The new coefficient `U2(0)` appears in

```text
F33 = x*(x-1)*U2(x).
```

## Branch Response

Let `v=U2(0)`.  Its perturbation is

```text
delta F33 = x*(x-1)*v = (-u+u^2)*v.
```

On the simple branch,

```text
w^33=(-u)^33+O(u^34)=-u^33+O(u^34).
```

Therefore the first contribution of `v` to the branch equation is

```text
delta F33*w^33 = v*u^34+O(u^35).
```

The coefficient `b31` is determined by the `u^34` branch equation.  The
leading branch-linear response is again

```text
G0'(-1)=2.
```

Thus

```text
2*delta b31 + v = 0,
delta b31 = 2*v.
```

## ODE Response

The induced perturbation

```text
delta w = 2*v*u^31
```

changes

```text
z=1/w
```

by

```text
delta z = -w^(-2)*delta w = -2*v*u^29+O(u^30).
```

Only `D^4(delta z)` can contribute to the `u^25` coefficient of

```text
D^4 z - z + z^5,
```

because `-delta z` is still too high and `delta(z^5)=0` in characteristic
`5`.  For `D=(-1+u)d/du`, the lowering part gives

```text
[u^25]D^4(u^29)=29*28*27*26=4  in F_5.
```

Consequently

```text
[u^25] delta(D^4 z - z + z^5)
  = (-2*v)*4
  = 2*v.
```

## Consequence

The simple `x=0,u^25` equation has the form

```text
R + 2*U2(0) = 0,
```

where `R` depends on older solved chart variables and on other visible new
Taylor coefficients, but not on `U2(0)`.

Since `2` is a unit in `F_5`, this layer always solves `U2(0)` and imposes no
new residual equation on the older variables.  The next rank-like local
pressure point should therefore be repeated `x=0,u^25` after substituting
this simple solve.
