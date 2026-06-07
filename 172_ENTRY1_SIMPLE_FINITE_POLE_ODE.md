# Entry-1 simple finite pole ODE check

Date: 2026-06-05.

This note checks the first scalar p-closed equation at a simple finite pole of
`z` in the representative entry-1 case.

It applies to the distinct-root case `c != d`.  The double-root edge `c=d` is
handled separately in `171`.

## Local setup

Let `a` be one of `c,d`, and put `w=1/z`.  Locally write

```text
x = a + xi_1 w + xi_2 w^2 + xi_3 w^3 + xi_4 w^4
      + xi_5 w^5 + xi_6 w^6 + ...
z = 1/w.
```

The residue/tangent condition gives

```text
xi_1 =  a-1      at Q_0,
xi_1 = -(a-1)    at Q_infty.
```

Let

```text
partial=(x-1)d/dx.
```

## ODE expansion

Substitute the above expansion into

```text
partial^4 z = z-z^5.
```

After imposing `xi_1=±(a-1)`, the coefficients of

```text
w^-5, w^-4, w^-3, w^-2, w^-1
```

all vanish identically.  The constant coefficient is the first possible
condition.

For `xi_1=a-1`, the coefficient of `xi_6` in that constant term is

```text
-1/(a-1).
```

For `xi_1=-(a-1)`, the coefficient of `xi_6` is

```text
 1/(a-1).
```

Since `a notin {0,1}`, this coefficient is nonzero.  Thus the first ODE
condition solves `xi_6`; it imposes no condition on the earlier finite-pole
jet.

In the implicit bidegree model, this means the first scalar ODE equation at
the simple finite poles determines a later high-`z` coefficient rather than
contradicting the first tangent data.

## Sage check

The calculation was made in the fraction field of

```text
GF(5)[a,xi2,xi3,xi4,xi5,xi6,xi7].
```

Command shape:

```text
S.<w>=PowerSeriesRing(K, default_prec=14)
x=a+eps*(a-1)*w+xi2*w^2+...+xi7*w^7
z=1/w
D=lambda f: ((x-1)/x.derivative())*f.derivative()
ode=D(D(D(D(z))))-(z-z^5)
```

For `eps=1` and `eps=-1`, Sage prints zero for the coefficients
`w^-5` through `w^-1`; only the constant coefficient remains, with the
nonzero `xi_6` coefficient above.

