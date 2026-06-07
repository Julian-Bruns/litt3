# Simple x=0 u20 leading solve certificate

This note records the next simple-branch layer after the repeated
`x=0,u^15` fiberwise solve.  It is a local double-fiber layer result, not a
complete common-cover proof.

## Context

After the certified local layers through repeated `u^15`, the next simple
branch at `x=0` has tangent

```text
w=-u+O(u^2).
```

The next nonconstant ODE coefficient is `u^20`.  To compute it, the simple
branch must be continued to the coefficient `b26` in

```text
w=-u+...+b26*u^26+...
```

The new coefficient `U7(0)` appears in

```text
F28 = x*(x-1)*U7(x).
```

## Branch Response

Let `v=U7(0)`.  Its perturbation is

```text
delta F28 = x*(x-1)*v = (-u+u^2)*v.
```

On the simple branch,

```text
w^28=(-u)^28+O(u^29)=u^28+O(u^29).
```

Therefore the first contribution of `v` to the branch equation is

```text
delta F28*w^28 = -v*u^29+O(u^30)=4*v*u^29+O(u^30).
```

The coefficient `b26` is determined by the `u^29` branch equation.  The
leading branch-linear response is again

```text
G0'(-1)=2.
```

Thus

```text
2*delta b26 + 4*v = 0,
delta b26 = 3*v.
```

## ODE Response

The induced perturbation

```text
delta w = 3*v*u^26
```

changes

```text
z=1/w
```

by

```text
delta z = -w^(-2)*delta w = -3*v*u^24+O(u^25).
```

Only `D^4(delta z)` can contribute to the `u^20` coefficient of

```text
D^4 z - z + z^5,
```

because `-delta z` is still too high and `delta(z^5)=0` in characteristic
`5`.  For `D=(-1+u)d/du`, the lowering part gives

```text
[u^20]D^4(u^24)=24*23*22*21=4  in F_5.
```

Consequently

```text
[u^20] delta(D^4 z - z + z^5)
  = (-3*v)*4
  = 3*v.
```

## Consequence

The simple `x=0,u^20` equation has the form

```text
R + 3*U7(0) = 0,
```

where `R` depends on older solved chart variables and on other visible new
Taylor coefficients, but not on `U7(0)`.

Since `3` is a unit in `F_5`, this layer always solves `U7(0)` and imposes no
new residual equation on the older variables.  The next rank-like local
pressure point should therefore be repeated `x=0,u^20` after substituting this
simple solve.
