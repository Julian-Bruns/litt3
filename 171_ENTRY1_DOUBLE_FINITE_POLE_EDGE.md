# Entry-1 double finite pole edge

Date: 2026-06-05.

This note audits the entry-1 edge case where the two finite poles of `z`
lie in the same `x`-fiber:

```text
Q_0 != Q_infty,       x(Q_0)=x(Q_infty)=a.
```

In the notation of `165`, this is `c=d=a`.  It is not excluded by the current
entry-1 calculation.

## Why this edge needs separate treatment

The finite-pole calculation in `165` treats `c` and `d` as simple roots of

```text
b35(x)=[z^35]f=x^3(x-c)(x-d).
```

When `c=d=a`, the root `a` is double, so the simple-root tangent formula

```text
g'(a)(x-a)+C(a)w
```

does not apply.  One must instead impose the tangent quadratic at
`(x,w)=(a,0)`, where `w=1/z`.

## First coefficient

In the `c=d=a` edge,

```text
s=2a,     p=a^2,     N=(1-a)^2,     K=-a^2.
```

The `z^34` coefficient is

```text
b34(x)=x^2(x-1)(e+q x+3x^2),       e=3a^2.
```

For two branches over `(a,0)`, the linear term must vanish:

```text
b34(a)=0.
```

Since

```text
b34(a)=a^3(a-1)(q+a),
```

and `a notin {0,1}`, this gives

```text
q=4a.
```

Then also

```text
b34'(a)=0,
```

so there is no mixed linear contribution to the tangent cone.

This agrees with the formula `q=c+3d` from the distinct-root case after
specializing `c=d=a`, but the justification is different.

## Tangent quadratic

At `Q_0`, locally

```text
w/(x-a)=1/(a-1).
```

At `Q_infty`, locally

```text
w/(x-a)=-1/(a-1).
```

Thus the tangent quadratic of

```text
F(x,w)=w^35 f(x,1/w)
```

at `(a,0)` must have slopes

```text
w = ±(x-a)/(a-1).
```

Since the coefficient of `(x-a)^2` in `b35=x^3(x-a)^2` is `a^3`, this forces

```text
b33(a) = -a^3(a-1)^2.
```

Using the entry-1 high-`z` expansion from `165`, this condition is equivalent
to the linear equation

```text
l0 = a*alpha + a*u - a + 2.
```

The coefficient of `l0` is `a^3(a-1)`, nonzero on the open locus.  Therefore
the double finite pole edge remains compatible: this tangent condition solves
`l0`; it does not eliminate `c=d`.

## Sage check

Verified by:

```text
R.<a,al,u,l0,x>=PolynomialRing(GF(5))
s=2*a; p=a^2; N=1-s+p
b=2*p-N; q=4*a
f1=4*p*(al+u)+3*s+2*p+3*q+4
b33=-N*x + x*(x-1)*(b+x*f1+x^2*l0+3*x^3)
need=-a^3*(a-1)^2
(b33(x=a)-need).factor()
```

Output:

```text
(a - 1) * a^3 * (-a*al - a*u + a + l0 - 2)
```

