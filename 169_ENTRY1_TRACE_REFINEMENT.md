# Entry-1 trace refinement

Date: 2026-06-05.

This records a small invariant for the representative entry-1 case

```text
Q_1=P_0,        z=(dr/r)/(dx/(x-1)).
```

It does not eliminate the case, but it packages the first high-`z` constraints
in a cleaner way.

## Trace over k(x)

In the bidegree `(5,35)` model of `165`, write

```text
f(x,z)=b35(x) z^35 + b34(x) z^34 + ...
```

Then

```text
T = Tr_{k(C)/k(x)}(z) = -b34/b35.
```

The first high-`z` and finite-pole constraints give

```text
b35 = x^3(x-c)(x-d),
b34 = x^2(x-1)(e+q x+3x^2),
e=3p, q=c+3d, p=cd.
```

Hence

```text
T = -(x-1)(3cd+(c+3d)x+3x^2)/(x(x-c)(x-d)).
```

Equivalently, in partial fractions,

```text
T =
  2
  + 2*(-1/x)
  + (c-1)/(x-c)
  + 4*(d-1)/(x-d).
```

Thus the normalized residues at the three poles `0,c,d` are fixed as

```text
(ell_0, ell_c, ell_d) = (2,1,4) in F_5^3.
```

This matches the local branch geometry:

```text
- the three B branches over x=0 have common slope w=x, so their z-pole
  contribution is 3/x = 2*(-1/x);
- at Q_0, w/(x-c)=1/(c-1), giving residue c-1;
- at Q_infty, w/(x-d)=-1/(d-1), giving residue -(d-1)=4(d-1).
```

## Scalar p-closed check

Because every conjugate of `z` satisfies

```text
partial^4 z = z-z^5,      partial=(x-1)d/dx,
```

the trace satisfies the scalar equation

```text
partial^4 T = T-T^5.
```

The displayed partial-fraction expression indeed satisfies this equation
identically for arbitrary `c,d` in the open locus.

Verified by Sage:

```text
R.<c,d,x>=PolynomialRing(GF(5))
K=FractionField(R)
T=-(x-1)*(3*c*d+(c+3*d)*x+3*x^2)/(x*(x-c)*(x-d))
D=lambda f:(x-1)*f.derivative(x)
D(D(D(D(T))))-(T-T^5) == 0
```

Output:

```text
True
```

## Consequence

The first trace equation is fully compatible.  It should not be used as an
obstruction.  Its main value is as a normalization check for future entry-1
coefficient work: any deeper p-curvature extraction should preserve the
fixed trace residues `(2,1,4)`.

