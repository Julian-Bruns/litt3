# Entry-one logarithmic lifting target

Status: `proved-text` necessary-condition analysis, using the standard
field-level Cartier logarithmic criterion; entry-one exclusion is `open`.

Consider the representative `Q1=P0` with no further high-point coincidence,
and put

```text
z=(dr/r)/(dx/(x-1)),
omega=z*dx/(x-1).
```

The global differential relation for an actual profile pair is

```text
omega=dlog(r).                                             (1)
```

The point of this note is to distinguish three conditions that had
previously been conflated:

1. the Cartier (or scalar ODE) condition on `omega`;
2. lifting its logarithmic primitive to the prescribed divisor of `r`;
3. imposing the prescribed divisor of `r-1`.

## Divisor and residues of the differential

In this branch,

```text
div(z)=P1+Pinfty+D+G-Q0-Qinfty-B,
div(dx/(x-1))
 =30P0-P1-Pinfty-C-D-E-F-G.
```

Therefore

```text
div(omega)=30P0-Q0-Qinfty-B-C-E-F.                        (2)
```

For the desired function `r`, the residues of `omega=dlog(r)` are

```text
+1 at Q0, C, F,
-1 at Qinfty, B, E.
```

Here `31=1` in characteristic `5`; no variable point or coefficient is being
treated as `F_5`-rational.

## What the Cartier equation actually gives

For a one-variable function field `K/k` in characteristic `5`, Cartier's
logarithmic-differential criterion is

```text
K^*/K^{*5}  --dlog-->  {eta in Omega^1_K : C(eta)=eta}
```

and this map is an isomorphism. Equivalently, `C(eta)=eta` if and only if
`eta=dlog(f)` for some `f in K^*`.

Moreover, all primitives of `eta` are `c*f*s^5`, with `c in k^*` and
`s in K^*` (the constant can be absorbed into a fifth power because `k` is
algebraically closed). Applied to `omega`, this corrects a possible
misreading of the scalar equation: a global solution of

```text
C(omega)=omega,
```

equivalently

```text
partial^4(z)=z-z^5,   partial=(x-1)d/dx,                  (3)
```

does produce a rational logarithmic primitive. It does **not** yet show that
one of those primitives has the divisor required by the profile.

## The precise divisor-lifting obstruction

Let

```text
R=31Q0+C+F-31Qinfty-B-E.                                  (4)
```

Choose one primitive `r0` with `dlog(r0)=omega`. At every point `T`,

```text
res_T(dlog(r0))=ord_T(r0) mod 5.
```

The residues above and regularity away from their support imply that

```text
L_R=(R-div(r0))/5                                         (5)
```

is an integral degree-zero divisor. Replacing `r0` by `c*r0*s^5` changes
`L_R` by `-div(s)`. Hence its divisor class

```text
[L_R] in Pic^0(C)                                         (6)
```

is well defined. There is a logarithmic primitive `r` satisfying
`div(r)=R` if and only if `[L_R]=0`: indeed this is exactly the
condition that (5) equal `div(s)` for some `s`, after which
`r=r0*s^5` has divisor `R`.

The weaker condition `[R]=0` is necessary but is not equivalent to (6).
Taking divisor classes in (5) gives

```text
5*[L_R]=[R].                                               (7)
```

Thus principality of \(R\) says only that \([L_R]\) is \(5\)-torsion. It
need not vanish when \(\operatorname{Pic}^0(C)[5](k)\) is nontrivial. In
particular, neither the Cartier equation alone nor the bare condition
\([R]=0\) is the complete lifting condition.

Even if (6) vanishes, the profile also requires, after scaling the primitive,

```text
div(r-1)=31P0+A+D+G-31Qinfty-B-E.                         (8)
```

Scaling can normalize the value at `P0`, but it does not force order `31`
there: lower terms whose exponents are divisible by `5` are invisible to the
differential. Nor does it force the other zeros in (8). Thus (8) is a
separate global condition.

## Consequences if the required `r` exists

Assume now that a primitive satisfies (4), so this subsection is conditional
on the missing lift rather than a consequence of (3) alone. Since
`dr=r*omega`, (2) and (4) give

```text
div(dr)=30P0+30Q0-32Qinfty-2B-2E.                         (9)
```

For comparison,

```text
div(dx)=30P0+30P1-32Pinfty-2F-2G,
```

and hence

```text
div(dr/dx)
 =30(Q0-P1)-32(Qinfty-Pinfty)+2(F+G-B-E).                 (10)
```

Taking the coefficientwise floors after division by `5` gives

```text
T_r=6P0+6Q0-7Qinfty-B-E,
T_x=6P0+6P1-7Pinfty-F-G,

T_r-T_x
 =6(Q0-P1)-7(Qinfty-Pinfty)+(F+G-B-E).                   (11)
```

Equations (9)--(11) are identities for an actual lifted function, not an
obstruction by themselves.

## Honest open targets

Any successful entry-one argument must also cover the lower-degree strata
created by additional high-point coincidences. For the degree-five stratum,
useful precise targets include:

```text
E1. Prove [L_R] != 0 for every integral bidegree-(5,35)
    candidate satisfying the boundary data and (3), or show that (8) fails
    whenever [L_R]=0.

E2. Derive a contradiction from the divisor identities (9)--(11) and the
    genus-11 linear systems forced by x.

E3. Show that the full Cartier equation together with [L_R]=0 and
    (8) forces an excluded high-point coincidence.
```

No such contradiction is proved here. The norm consequences of (4) and (8)
are recorded in `176_ENTRY1_X_NORM_SHADOW.md`.
