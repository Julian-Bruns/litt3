# Entry-1 x-norm shadow of exactness

Date: 2026-06-05.

This note sharpens the logarithmic exactness target in `175` by pushing the
required divisor of `r` along the map `x:C -> P^1`.

It does not eliminate entry-1.  It explains why the trace formula in `169` is
automatically compatible if the prescribed `r` exists.

## Norm of r over k(x)

In the representative entry-1 case,

```text
div(r)=31Q_0 + C + F - 31Q_infty - B - E.
```

The `x`-values are:

```text
x(Q_0)=c,
x(Q_infty)=d,
x(C)=x(E)=1,
x(B)=0,
x(F)=infty.
```

Therefore the pushforward divisor is

```text
x_* div(r)
 = 31[c] + [1] + 3[infty]
   -31[d] -3[0] -[1]
 = 31[c] -31[d] -3[0] +3[infty].
```

In characteristic `5`, this gives, up to a nonzero constant,

```text
N_x(r) = (x-c)^31 / (x^3 (x-d)^31).
```

Taking the logarithmic derivative with

```text
partial=(x-1)d/dx
```

gives

```text
partial log N_x(r)
 = (x-1)(31/(x-c)-31/(x-d)-3/x)
 = (x-1)(1/(x-c)-1/(x-d)+2/x).
```

In partial fractions this is

```text
2 + 2*(-1/x) + (c-1)/(x-c) + 4*(d-1)/(x-d).
```

This is exactly the trace formula recorded in
`169_ENTRY1_TRACE_REFINEMENT.md`:

```text
Tr_{k(C)/k(x)}(z) = partial log N_x(r).
```

So the trace equation is the `x`-norm shadow of the exactness condition; it is
not an independent obstruction.

## Norm of r-1 over k(x)

Similarly,

```text
div(r-1)=31P_0 + A + D + G - 31Q_infty - B - E.
```

Pushing along `x` gives

```text
x_* div(r-1)
 = 31[0]+[0]+2[1]+[infty] -31[d]-3[0]-[1]
 = 29[0]+[1]+[infty]-31[d].
```

Thus, up to a nonzero constant,

```text
N_x(r-1)=x^29(x-1)/(x-d)^31.
```

The logarithmic derivative is

```text
partial log N_x(r-1)
 = (x-1)(29/x + 1/(x-1) -31/(x-d))
 = (x-1)(4/x + 1/(x-1) -1/(x-d)).
```

This equals

```text
Tr_{k(C)/k(x)}( z*r/(r-1) ),
```

which depends on the unknown function `r`; unlike the first norm identity, it
cannot be checked from the bidegree `(x,z)` model alone.

## Updated exactness target

A bidegree `(5,35)` p-curvature solution is an actual entry-1 solution only if
there exists `r in k(C)` satisfying all of:

```text
partial(r)=z*r,
N_x(r)     = const * (x-c)^31/(x^3*(x-d)^31),
N_x(r-1)   = const * x^29*(x-1)/(x-d)^31,
N_z(r)     = const * (z-1)*(z+1)^2,
N_z(r-1)   = const * (z-alpha)^31*(z-u)*z^3/(z+1),
div(r)     = 31Q_0+C+F-31Q_infty-B-E.
```

The first norm identity is already equivalent to the trace compatibility in
`169`; the real missing data are the existence of `r` itself and the
simultaneous `r-1` norm/principal-divisor condition.

