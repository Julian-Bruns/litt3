# Simple x=0 u15 leading solve certificate

This note records the next simple-branch layer after the repeated
`x=0,u^10` rank certificate.  It is a local double-fiber layer result, not a
complete common-cover proof.

## Context

After the certified layers

```text
83_REPEATED_U5_REPAIRED_ATLAS_CERTIFICATE.md
86_SIMPLE_U10_CHARTED_SOLVE_CERTIFICATE.md
92_REPEATED_U10_TWO_MINOR_CERTIFICATE.md
```

the next simple branch at `x=0` has tangent

```text
w=-u+O(u^2).
```

The next nonconstant ODE coefficient is `u^15`.  To compute it, the simple
branch must be continued to the coefficient `b21` in

```text
w=-u+...+b21*u^21+...
```

The new coefficient `U12(0)` appears in

```text
F23 = x*(x-1)*U12(x).
```

## Branch Response

Let `v=U12(0)`.  Its perturbation is

```text
delta F23 = x*(x-1)*v = (-u+u^2)*v.
```

On the simple branch,

```text
w^23=(-u)^23+O(u^24)=-u^23+O(u^24).
```

Therefore the first contribution of `v` to the branch equation is

```text
delta F23*w^23 = v*u^24+O(u^25).
```

The coefficient `b21` is determined by the `u^24` branch equation.  As in the
simple-`u^10` certificate, the leading branch-linear response is

```text
G0'(-1)=2.
```

Thus

```text
2*delta b21 + v = 0,
delta b21 = 2*v.
```

## ODE Response

The induced perturbation

```text
delta w = 2*v*u^21
```

changes

```text
z=1/w
```

by

```text
delta z = -w^(-2)*delta w = -2*v*u^19 + O(u^20).
```

Only `D^4(delta z)` can contribute to the `u^15` coefficient of

```text
D^4 z - z + z^5,
```

because `-delta z` is still too high and `delta(z^5)=0` in characteristic
`5`.  For `D=(-1+u)d/du`, the lowering part gives

```text
[u^15]D^4(u^19)=19*18*17*16=4  in F_5.
```

Consequently

```text
[u^15] delta(D^4 z - z + z^5)
  = (-2*v)*4
  = 2*v.
```

## Consequence

The simple `x=0,u^15` equation has the form

```text
R + 2*U12(0) = 0,
```

where `R` depends on older solved chart variables and on other visible new
Taylor coefficients, but not on `U12(0)`.

Since `2` is a unit in `F_5`, this layer always solves `U12(0)` and imposes no
new residual equation on the older variables.  The next genuinely rank-like
local pressure point should therefore be the repeated `x=0,u^15` layer after
substituting this simple solve.
