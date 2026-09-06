# Quadratic Cartier eigenforms on y² = x⁵ − x in characteristic five

Date: 2026-09-05. This is an exact finite classification on one curve, including
the geometry of its quadratic-root covers. It does not construct a second
étale leg or prove the Litt conjecture.

Let k = F̄₅, let X be the smooth projective curve y² = h(x) = x⁵ − x,
and put η = dx/y. Then div(η) = 2∞ and
H⁰(X, ω²) = ⟨η², xη², x²η²⟩. Write s = fη², where
f = A + Bx + Cx², and put Q = AC + B².

## Exact Cartier calculation

Use the twisted Cartier operator C₁ : H⁰(ω⁶) → H⁰(ω²), characterized
in a rational frame by C₁(η⁵α) = η C(α). Thus

    C₁(s³) = η C(f³η).

Since y⁴ = h², f³η = y⁻⁵ f³h² dx. Ordinary Cartier extracts the
coefficients at exponents 4, 9, and 14 of f³h², takes their fifth roots,
and places them at exponents 0, 1, and 2. Direct expansion gives

    [x⁴](f³h²) = 3A(AC+B²),
    [x⁹](f³h²) = 3B(AC+B²),
    [x¹⁴](f³h²) = 3C(AC+B²).

Consequently C₁(s³) = s is equivalent to

    A⁵ = 3AQ,   B⁵ = 3BQ,   C⁵ = 3CQ.                 (1)

This calculation uses inverse Frobenius on coefficients; omitting that
semilinearity would give a different normalization equation.

## All solutions, including the origin's multiplicity

A nonzero solution has Q ≠ 0. Dividing two nonzero-coordinate equations
shows that every coordinate ratio has fifth power equal to itself.
Its projective class therefore belongs to P²(F₅). Conversely, for any
representative v = (a,b,c) in F₅³ with q = ac+b² ≠ 0, the solutions on
its line are λv, where

    λ² = 3q.

There are exactly two such lifts. The excluded conic Q = 0 is smooth and
has six F₅-points, so there are 31−6 = 25 admissible projective lines and
50 nonzero normalized eigenforms. All are defined over F₂₅. In fact the
20 nonsplit lifts are defined over F₅ and the 30 split lifts are not.

The three polynomials in (1) form a Gröbner basis for any graded monomial
order: their leading monomials are A⁵, B⁵, C⁵, which are pairwise coprime.
The scheme has length 5³ = 125, with basis AⁱBʲCᵏ for 0 ≤ i,j,k < 5.
At a nonzero solution v, its Jacobian matrix is

    −3 (Q I₃ + v (∇Q)ᵗ).

Euler's identity gives (∇Q)ᵗv = 2Q, so its determinant is
(−3)³ · 3Q³ ≠ 0. Thus all 50 nonzero points are reduced and the local
scheme supported at the origin has length 125−50 = 75. There are 51
geometric points in total; length and point count are different here.

## Finite table and root-cover geometry

Normalize each F₅ representative by setting its first nonzero coordinate
to 1. The discriminant of the binary quadratic Az²+Bxz+Cx² is Q,
because −4 = 1 in F₅. Here S denotes two distinct F₅-roots and N a
conjugate pair in F₂₅\F₅.
The retained certificate enumerates all 25 lines; an explicit row-by-row
table is unnecessary for either the classification or the proof below.

The six hyperelliptic branch values are exactly P¹(F₅). Therefore the
15 split quadratics correspond to the unordered pairs of these six
values. The remaining ten correspond to the (26−6)/2 conjugate pairs.
The divisor of s is the pullback of the binary quadratic's root divisor;
this includes the root at infinity when C = 0.

Let Z be the normalization of the quadratic-root cover, equivalently
k(Z) = k(X)(√f); multiplying f by a nonzero scalar does not change its
geometric isomorphism class. This cover is connected. Indeed f is neither
a square in k(x) nor h times a square in k(x): the odd-valuation support
of f consists of exactly two values, whereas that of h consists of six.
These are the two possible ways f could become a square in k(x)(√h).

| Type | Lines | div(s) | Z → X | g(Z) | p-rank(Z) |
|---|---:|---|---|---:|---:|
| Split | 15 | 2P + 2R | étale, degree 2 | 3 | 1 |
| Nonsplit | 10 | P₁+P₂+P₃+P₄ | branched at four points | 5 | 3 |

The genera follow from Riemann–Hurwitz. The root differential on Z has
zero orders 1 at each of the four points above the split divisor, and
zero order 2 at each of the four ramification points in the nonsplit case.

## Exact p-rank verification

The Cartier matrix of X is zero: h² = x¹⁰−2x⁶+x² has no terms at
the indices 5i−j for 1 ≤ i,j ≤ 2. Thus X has p-rank zero (indeed it
is superspecial).

The biquadratic cover Z → P¹ has intermediate curves X, t²=f (genus
zero), and W: u²=g, where g=hf/gcd(h,f)². The usual character
decomposition gives a degree-a-power-of-two Jacobian isogeny
J(Z) ∼ J(X) × J(W), so p-rank(Z)=p-rank(W). The exact enumeration below
checks that all fifteen split W are ordinary elliptic curves and all ten
nonsplit W are ordinary genus-three curves.

For concrete representatives, f=x gives W: u²=x⁴−1 and Cartier matrix
[3]. For f=x²+2, W has equation u²=x⁷+2x⁵+4x³+3x and matrix

    [4 0 4]
    [0 2 0]
    [1 0 4]

whose determinant is 4 in F₅. Since entries lie in F₅, transpose
conventions for Hasse–Witt versus Cartier do not affect the invertibility
or stable ranks used here.

## Reproducible Sage certificate

Executed with `sage -python` on 2026-09-05. This embedded code is the
complete certificate; no separate generated script is needed.

```python
from sage.all import *
F = GF(5)
R = PolynomialRing(F, names=('A','B','C'))
A,B,C = R.gens()
P = PolynomialRing(R, 'x'); x = P.gen()
f = A+B*x+C*x*x; h = x**5-x; Q = A*C+B*B
assert [(f**3*h**2)[i] for i in (4,9,14)] == [3*A*Q,3*B*Q,3*C*Q]
I = R.ideal([A**5-3*A*Q, B**5-3*B*Q, C**5-3*C*Q])
assert I.vector_space_dimension() == 125

S = PolynomialRing(F, 'x'); x = S.gen(); h = x**5-x
assert matrix(F, 2, 2, lambda i,j: (h**2)[5*(i+1)-(j+1)]).is_zero()
counts = {}; table = []
for a in F:
    for b in F:
        for c in F:
            v = (a,b,c)
            if not any(v) or next(t for t in v if t) != 1:
                continue
            q = a*c+b*b
            if not q:
                continue
            kind = 'S' if q.is_square() else 'N'
            f = a+b*x+c*x*x
            g = (h*f)//gcd(h,f)**2
            d = (g.degree()-1)//2
            M = matrix(F, d, d, lambda i,j: (g**2)[5*(i+1)-(j+1)])
            rank = (M**d).rank()
            key = (kind,d,rank)
            counts[key] = counts.get(key,0)+1
            table.append((tuple(map(int,v)), int(q), kind))
assert len(table) == 25
assert counts == {('S',1,1):15, ('N',3,3):10}
print(table)
print('scheme length=125; nonzero reduced points=50; origin length=75')
print(counts)
```

The p-rank values concern these root covers only. They provide no
classification of further covers and no exclusion of a common étale
cover with another target.
