# Entry-one norm consequences

Status: `proved-text` necessary conditions for an actual entry-one pair; the
entry-one exclusion is `open`.

Continue with the representative `Q1=P0` and no further high-point
coincidence. Put `K=k(C)`, let `N_x` denote the field norm from `K` to
`k(x)`, and set

```text
partial=(x-1)d/dx.
```

Assume in this file that the logarithmic primitive has already been lifted to
the profile divisors

```text
div(r)  =31Q0+C+F-31Qinfty-B-E,                           (1)
div(r-1)=31P0+A+D+G-31Qinfty-B-E.                         (2)
```

These assumptions are stronger than the scalar Cartier equation. The precise
lifting obstruction is in `175_ENTRY1_LOGARITHMIC_EXACTNESS_TARGET.md`.

## Norm of `r` over `k(x)`

The relevant `x`-values are

```text
x(Q0)=c,       x(Qinfty)=d,
x(C)=x(E)=1,   x(B)=0,   x(F)=infty.
```

Pushing (1) forward along `x` gives

```text
x_* div(r)=31[c]-31[d]-3[0]+3[infty].
```

Consequently, up to a constant in `k^*`,

```text
N_x(r)=(x-c)^31/(x^3*(x-d)^31).                           (3)
```

Since `K/k(x)` is separable, logarithmic differentiation commutes with norm
and trace. The relation `partial(r)=z*r` therefore gives

```text
Tr_{K/k(x)}(z)=partial log N_x(r)
 =(x-1)*(1/(x-c)-1/(x-d)+2/x).                            (4)
```

Only the integer exponents have been reduced modulo `5` in (4). The
parameters `c,d in k` are unrestricted; no identity such as `c^5=c` is used.
In partial fractions, the right side is

```text
2 + 3/x + (c-1)/(x-c) + 4*(d-1)/(x-d).                   (5)
```

Thus the previously observed trace formula is forced by the norm of any
actual `r`; it is not an independent obstruction.

## Norm of `r-1` over `k(x)`

Pushing (2) along `x` gives

```text
x_* div(r-1)=29[0]+[1]+[infty]-31[d].
```

Hence, again up to a nonzero constant,

```text
N_x(r-1)=x^29*(x-1)/(x-d)^31.                             (6)
```

Its logarithmic derivative is

```text
partial log N_x(r-1)
 =(x-1)*(4/x+1/(x-1)-1/(x-d))
 =Tr_{K/k(x)}(z*r/(r-1)).                                 (7)
```

Unlike (4), the final trace in (7) depends on the unknown primitive `r` and
cannot be tested from the bidegree `(x,z)` equation alone.

## Norms over `k(z)`

The scalar Cartier equation also shows that `z` is separable: if `dz=0`, then
`partial(z)=0`, so `z^5=z` and the nonconstant function `z` would lie in
`F_5`, a contradiction. Pushing the same profile divisors along this
degree-five function gives, up to nonzero constants,

```text
N_{K/k(z)}(r)   =(z-1)*(z+1)^2,
N_{K/k(z)}(r-1)=(z-alpha)^31*(z-u)*z^3/(z+1).             (8)
```

These formulas use the values

```text
z=1 on C,       z=-1 on E+F,
z=0 on P1+Pinfty+D+G,
z=infty on Q0+Qinfty+B,
z(P0)=alpha,    z(A)=u.
```

They agree with the corresponding pushforwards for `x` and `x-1` in the
entry-one normal form.

## Logical role

For a bidegree `(5,35)` curve satisfying the scalar Cartier equation, (3)--(8)
are not extra equations in `x,z` alone. An actual profile solution requires a
primitive in the Cartier logarithmic class whose divisor is exactly (1), and
then requires the nonlinear condition (2). If those functions exist, all the
norm and trace formulas above follow automatically.
