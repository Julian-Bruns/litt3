# Proof: dormant first integrals and Cartier blocks

Canonical [statement](../../Theorems/atlases/dormant_first_integral_charts.md).

## Solve the differential equation over its constant field

Write v=Dr. Differentiating D^2r=3r^2 gives D^3r=rv and
D^4r=v^2+3r^3=v^2-2r^3. Its derivative is zero. Since D^5=0 and
ker D=K^5, this gives c in C0.

If c=0 and r!=0, then v^2=2r^3 and v!=0. For s=3r/v,

    Ds=3*(v^2-r*D^2r)/v^2=1,        s^2=2/r.

Thus b=x-s belongs to C0 and r=2/(x-b)^2. Conversely every such expression
solves the equation and has c=0. The displayed recovery of s proves uniqueness.

Suppose c!=0. Set h=r^5 and s=rv/c. Then h is a nonzero constant and

    Ds=(v^2+r*D^2r)/c=1,
    c^2*s^2=r^2*v^2=2h+c*r^2.

Therefore b=x-s belongs to C0 and r^2=c*s^2+3h/c=q. Taking fifth powers
gives q^5=h^2, which after multiplying by c^5 is exactly the asserted
equation on c,h,b. Also r=q^3/h because r^6/r^5=r.

Conversely a triple satisfying that equation gives q^5=h^2. For r=q^3/h,
one gets r^2=q and r^5=h, so r!=0. Differentiation gives r*Dr=c*s and

    (Dr)^2=c^2*s^2/r^2=c+2r^3.

Differentiating r*Dr=c*s now yields r*D^2r=3r^3, hence D^2r=3r^2.
The reconstruction has precisely the prescribed c,h,b.

Geometrically (r,Dr) lies on v^2=2u^3+c. For c!=0 this is a smooth cubic;
the derivation du=v, dv=3u^2 has fifth power zero. The useful rational
function uv/c has derivative1. This does not rationally parametrize the
elliptic curve over its ground field: the reconstruction also constrains
Frobenius powers and works in the purely inseparable extension K/C0.

## Preserve the equation, not just its geometric solutions

Direct differentiation, using D^5=0, gives

    (Dr)^2-2r^3-D^4r = -D^2(D^2r-3r^2)-r(D^2r-3r^2),
    D((Dr)^2-2r^3-D^4r)=2(Dr)(D^2r-3r^2).

Thus E=0 implies J=0, and J=0 implies E=0 if Dr is invertible. The
necessity of a family qualification is visible at r=0: the linearizations
are D^2 for E and -D^4 for J. Replacing one scheme by the other without
checking the unit condition would change infinitesimal multiplicities.

## Uniform nonvanishing by partial fractions

The components1,y,y^2 over k(x) are preserved by D, hence by D^4. It suffices
to show that D^4 of the invariant component r0 does not vanish. Set

    H=2x^8+B-F'',
    r0=-2D(F'/F)+H/F.

Because deg F=10 in characteristic5, deg F''<=7. Consequently H has
degree8 and leading coefficient2, so H is nonzero and deg H<deg F.
The derivative term is killed by D^4 since D^5=0. Over an algebraic closure,
write H/F=sum_alpha R_alpha/(x-alpha). The roots alpha are distinct and
at least one R_alpha is nonzero, because H is not divisible by F. Then

    D^4(H/F)=4*sum_alpha R_alpha/(x-alpha)^5 != 0.

Distinct pole locations prohibit cancellation. This proves D^4r!=0 for
the ENTIRE family without computing a matrix or assuming dormancy.

More generally a proper rational function with poles of order at most2
has D^4 equal to zero exactly when all simple-pole coefficients vanish.
The double-pole terms are killed, whereas the simple-pole terms survive
with distinct fifth-order poles.

## The global map is three Cartier blocks

Use Elkin's operator C on differentials, with
C(P dx)=sum_j P_(5j+4)^(1/5) x^j dx for a polynomial P.
This is the defining formula in
[Elkin, Section3, preceding Remark3.1](https://arxiv.org/pdf/0708.0431#page=5).
Write C_x(P)=C(P dx)/dx. Its product rule gives D^4P=-C_x(P)^5.

With H=2x^8+B-F'', rewrite the three components as

    r=-2D(F'/F)+H/F+C*y/F+A*y^2/F^2,
    H/F=(1/F)^5 H F^4,
    C*y/F=(y^2/F)^5 C F,
    A*y^2/F^2=(y/F)^5 A F^2.

Four derivatives kill the first term and commute with the fifth-power
factors. Thus the unique fifth root of D^4r is explicitly

    gamma=-(C_x(H F^4)+C_x(A F^2)y+C_x(C F)y^2)/F.       (1)

The three polynomial degrees before Cartier are at most48,30,14.
Coefficient extraction immediately gives the bounds8,5,2 for G0,G1,G2.
This replaces the repeated differential recurrences and separate pole
bounds by the ordinary Cartier rule. Formula(1) holds for every
squarefree monic degree-ten F and every potential in the stated chart.

## Rank on the fixed curve

Before coefficient fifth roots, the linear map is the direct sum

    B -> (4[x^(5i+4)] B F^4)_(i=0,...,8),
    A -> (4[x^(5i+4)] A F^2)_(i=0,...,5),
    C -> (4[x^(5i+4)] C F)_(i=0,...,2).

The B-block is injective for every squarefree F by the same simple-pole
argument as above, so it has rank8. Nonvanishing of the affine offset
is already proved uniformly; it needs no separate matrix witness.

For the fixed F over F25=F5[a]/(a^2+4a+2), the C-block columns
0,1,4 have determinant2a+2, and the A-block columns0,1,2,3,4,9 have
determinant a+1. Rows and columns are numbered from zero, and column j
means the monomial x^j. Both determinants are nonzero. Thus the total
linear rank is8+6+3=17 and the augmented rank is18.

The [short verifier](../../scripts/connections/dormant_first_integral.sage)
reconstructs these two minors and checks all24 coefficient directions
and the affine offset independently by four differentiations:

```sh
sage scripts/connections/dormant_first_integral.sage
```

The block formula reproduces every entry and offset of the former full
matrix certificate. The first-integral field classification remains an
author proof; the computation verifies the fixed-curve specialization.
The c!=0 chart covers every geometric dormant point, while its global
regularity constraints are still those of the original scalar chart.
