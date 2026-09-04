# Entry-1 simple finite pole ODE check

Date: 2026-06-05.

Status: `proved-text` local Laurent-series calculation. It shows only that the first
Cartier-equation coefficient is compatible with a formal branch; global
normal-form coefficients can still couple this jet to other branches.

This note checks the first scalar Cartier equation at a simple finite pole of
`z` in the representative entry-one case.

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

Since `a notin {0,1}`, this coefficient is nonzero. Thus, at the level of one
formal branch, the first ODE condition uniquely prescribes `xi_6` from the
earlier jet. It gives no local contradiction. This does not assert that
`xi_6` is a free global coefficient of the bidegree model.

## Exact replay

The calculation is reproduced by the following complete Sage input:

```text
R.<a,xi2,xi3,xi4,xi5,xi6,xi7> = PolynomialRing(GF(5))
K = R.fraction_field()
S.<w>=PowerSeriesRing(K, default_prec=14)

for eps in [1,-1]:
    x = (a+eps*(a-1)*w+xi2*w^2+xi3*w^3+xi4*w^4
         +xi5*w^5+xi6*w^6+xi7*w^7)
    z = 1/w
    D = lambda f: ((x-1)/x.derivative())*f.derivative()
    ode = D(D(D(D(z))))-(z-z^5)
    print([ode[i] for i in range(-5,0)])
    print(ode[0].derivative(xi6).factor())
```

For `eps=1` and `eps=-1`, the first line is a list of five zeros; the second
line is respectively `-1/(a-1)` and `1/(a-1)`.
