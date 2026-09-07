# Proof: linear certificates, then one Frobenius fixed-point equation

[Statement](../Theorems/Thm_genus_two_atlas_dynamics.md).
All coefficients below use a^2+4a+2=0. The finite script
[genus_two_atlas_dynamics.sage](../scripts/genus_two_atlas_dynamics.sage)
independently checks every saved certificate against the13 ORIGINAL
intrinsic equations, not against a candidate Groebner basis.

## Exact necessary linear restrictions

In the audited tensor's coordinates p0,...,p3,b0,...,b3 the following
four polynomials belong to the original ideal:

    p0+(2a+1)p3,                 p1-a p2+p3,
    b0+(2a+1)b2-(2a+2)b3,       b1+(2a+1)b2-(2a+1)b3.       (1)

The two b restrictions are constant linear combinations of the12
extension equations: their coefficient rows annihilate the universal
tensor image, whose dimension is10. After these substitutions the eight
zero-component equations span, in particular, lp*b2^5 and lp*b3^5
for either displayed p-linear polynomial lp. The fifth power of the
bilinear normalization gives lp in the original ideal. The saved
13-generator polynomial certificates perform precisely this operation;
their largest multiplier degree is10. The final script verifies the
four complete polynomial identities literally by expansion.

Set x=b2,y=b3,s=p2,t=p3 and make the substitutions (1). The twelve
equations have constant row span of dimension3. With

    A=x^5+(a+2)y^5, B=(-2a+2)x^5+(-a-1)y^5,

they are exactly the span of sA+tB and

    x-s x^5+(-2a-2)t x^5+(2a+1)s y^5+(2a-1)t y^5,
    y+(-a-1)s x^5-2a t x^5-2s y^5+(2a-2)t y^5.            (2)

The last equation is ell=1, where

    ell=(-a-1)sx+(2a-1)tx+(-2a-1)sy-a ty.

These are full row-space equalities checked in polynomial coefficients,
not only pointwise implications at sampled parameters.

## All projective directions, including infinity

Normalization implies (x,y)!=0. The two linear forms defining A,B in
x^5,y^5 are independent. Thus sA+tB=0 is exactly

    (s,t)=c(B,-A).

Substitution into (2) gives x=cQ1(x^5,y^5),y=cQ2(x^5,y^5).
The normalization becomes cE(x,y)=1, where

    E=-2a(x^5 y+x y^5+y^6).

The quadratics Q1,Q2 are coprime. They therefore define an everywhere
defined degree10 morphism after the fifth powers. Its fixed-point
polynomial is

    F=xQ2(x^5,y^5)-yQ1(x^5,y^5).

It has degree11. Its two derivatives are Q2(x^5,y^5) and -Q1(x^5,y^5),
which have no common projective zero; all eleven roots are simple.
Moreover F(1,0)=a+1!=0 and gcd(F,E)=1, checked exactly. Thus every
direction has y!=0, and none fails the normalization condition. No
root at infinity has been silently omitted from this affine chart.

Put z=x/y. Exact substitution gives

    phi(Q1(z^5,1)/Q2(z^5,1))=phi(z)^10,
    phi(z)=((a+1)z+3a+4)/(z+a+4).

This supplies the alternative list0,infinity,mu9 in the phi-coordinate.
The infinity here is a valid point in the phi-coordinate, not a missing
point in the preceding z-chart.

## Explicit reconstruction of every normalized solution

The monic affine polynomial is

    f(z)=z^11+(a+2)z^10+(3a+3)z^6+(2a+1)z^5
          +(3a+1)z+4a+2.

For each of its eleven roots z, set

    c=1/Q2(z^5,1),
    h=c E(z,1),              choose any lambda with lambda^3=h.

Both c and h are nonzero. In k[z]/(f) the latter is explicitly

    h=(2a+4)z^7+a z^6+4a z^5+(3a+2)z^2+(a+2)z.

Take

    x=lambda z,             y=lambda,
    s=lambda^-4 c B(z,1),   t=-lambda^-4 c A(z,1),

where A(z,1)=z^5+a+2 and B(z,1)=(-2a+2)z^5-a-1. Recover the eight
coordinates using (1). These solve all thirteen equations: the scaling
of c in the fixed-point equations is lambda^-9, and ell scales as
lambda^-3, so the cube condition makes ell=1.

Conversely any normalized solution has a unique direction z and
lambda=y. The equations force exactly these formulas. The solution
algebra is therefore

    k[z,lambda]/(f(z), lambda^3-h(z)).                       (3)

Its dimension is33. It is reduced because f is squarefree, h is a unit,
and3 is invertible. The script substitutes the universal eight-tuple
into all13 original polynomials in the WHOLE algebra (3). Along with
the necessary restrictions and reversible derivation, this proves
completeness without the unfinished26-generator ideal-lift calculation.

Over F25 the polynomial f has five linear and two irreducible cubic
factors. In each residue field h is a cube, checked by
h^((25^d-1)/3)=1, d=1 or3. Thus the normalized residue degrees are
fifteen of degree1 and six of degree3. Every geometric multiplicity is1.

## General lesson and exact boundary

A morphism P1->P1 of degree d with zero differential has exactly d+1
simple fixed points: its homogeneous fixed-point equation has degree
d+1, and its derivatives cannot vanish together since the morphism has
no base point. An everywhere nondegenerate normalization then preserves
these points. The small example realizes this mechanism with d=10.

Thus replacing an overdetermined atlas incidence by a complete invariant
projective self-map could FORCE existence, not exclusion. The genus-nine
tensor has full universal output rank96; it does not admit the first
constant-annihilator reduction used here. No invariant projective line
or analogous self-map has been established for that tensor. This is a
precise positive test and a structural warning, not a general atlas theorem.
