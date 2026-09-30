# Actual étaleness and the critical-scale different

The statement is [here](../../Theorems/cartier_and_spin/degree140_actual_etale_scale_bound.md).
This proof uses the accepted [two actual profiles](admissible_degree_ten_two_profiles.md),
[constant critical geometry](degree140_primitive_scale_geometry.md),
[root-nine critical geometry](degree140_root9_critical_scale_budget.md),
[endpoint-content structure](degree140_root9_endpoint_content_structure.md),
and [unique actual content scale](root9_content_etale_scale.md).
Its local assertions were independently reviewed in the
[audit](../../Research/audits/ACTUAL_ETALE_SCALE_BOUND_2026_09_29.md).

## A split-polynomial observation

Over k[[T]], let F(U) have unit leading coefficient and all roots
u_i integral. At an integral critical coordinate c on a normalized
finite extension, if F(c) vanishes, the residue of c is a repeated
root of the reduction. At least two factors c-u_i have positive
integral valuation, so ord F(c)>=2. This permits ramification in
the extension containing c.

Suppose F_lambda is affine-linear in lambda and its scale derivative
at c is a unit. Then F_lambda0(c) is a unit times lambda0-Lambda(c),
where Lambda is the critical-value map. Consequently its ramification
index over an actual split value lambda0 is at least two. Actual
étaleness gives local splitting over k((T)); the integral models below
are needed to apply this observation.

## Every finite nonzero actual fibre is ramified

Use the accepted translated primitive and write
\[
f_lambda=lambda*v*phi^2+phi*S+t^3,
\quad phi=W^5+Q,\quad
S=g_0W^3+g_1W^2+g_2W+g_3.
\]
The connected critical curve C is S'=0, and
Lambda=-(phi*S+t^3)/(v*phi^2). Off t*v=0, a pole of W maps
to scale zero, while phi=0 maps to infinity. Thus a finite nonzero
scale has W integral, phi and v units. The actual degree-ten source
has unit leading coefficient and integral split roots. The observation
applies, including the ordinary cubic branch points in these translated
regular coordinates.

At a t-endpoint, use the established local model
\[
F_lambda=lambda V(T)Phi^2+Phi S+E(T),\quad
Phi=W^5+mT^3+O(T^4),
\]
with V(0),m,D0=g3(0) nonzero, g2(0)=0 and ord(Phi(0,T)g3+E)>=5.
Set A=3g0(0), B=2g1(0), C1=[T]g2 and ell0=[T^5](Phi(0,T)g3+E).
The first rescaled polynomial is
\[
p(z)=D0*z^5+(mB/2)z^2+mC1*z+ell0,
\quad p'(z)=m(Bz+C1).
\]
At a primitive ratio p is squarefree. Indeed the universal divided
resultant residue contains the factor
J=B^5*ell0-D0*C1^5+2mB^4*C1^2, and has the form
J(B^5*lambda*V(0)-A^3B^3-A^5D0), up to units. A repeated root
forces J=0 even when B=0; hence it forces content. No division by A
or B is used in this implication.

Endpoint poles of W again map to scale zero. Normalize ord(T)=1.
For 0<r=ord(W)<1, the numerator Phi*S+E has unique lowest term
D0*W^5, of order5r: competitors have orders at least r+4,2r+3,5.
The denominator has order10r if r<3/5, order6 if r>3/5, and
at least6 if r=3/5. Thus Lambda is a pole in all three cases.
For r>=1, finite Lambda forces p((W/T)(0))=0. Dividing S'=0
by T forces B(W/T)(0)+C1=0, impossible by squarefreeness.
Consequently every finite nonzero critical-scale point over an
endpoint has W a unit, and the split-polynomial observation applies.

At the root-nine marked branch, take a uniformizer T with
v=T^3 times a unit. Actual étaleness and the accepted local profile
give three W-roots with pole one and seven integral roots. The W^7
coefficient g1 is a unit, since the product of the three poles is the
unique lowest term of the third elementary symmetric function. The
W^8 coefficient g0 has order m>=1. The nonsplit critical quadratic
ensures g0 is not the zero function.

The equation S'=0 has one regular branch and one W-pole branch of
order m. On the latter, g0*W=g1 to leading order in characteristic5,
so S has leading term2g1*W^2 and ord(Lambda)=3m-3. The other
summand has strictly higher order. The scale quadratic's leading
coefficient vanishes here; primitivity makes another coefficient a
unit. Both its roots cannot be integral, so the regular-coordinate
branch is a pole of Lambda. A finite nonzero scale can therefore
occur only on the W-pole branch with m=1.

Put Z=T*W and replace f by T^7*f(T,Z/T). At an actual scale its
leading coefficient lambda*v/T^3 is a unit. All ten roots are
integral, including three units. At the critical point the Z-derivative
vanishes, and the scale derivative T^7*v*((Z/T)^5+Q)^2 is a unit
because7+3-10=0. The observation applies once again. Both critical
points over O are poles of Lambda, so no finite fibre is omitted.

## The different budget

For a primitive ratio, Lambda:C->P1 is separable of degree140,
g(C)<=33, and its finite different has degree at most275 in the
constant family and277 in the root-nine family. The preceding argument
shows that every point above a nonzero actual étale scale has index
at least two. Such a fibre has at most70 points and contributes at
least140-70=70 to the different. Four fibres would contribute280,
which is impossible. Wild contributions only strengthen the bound.

Positive content is already excluded in the constant family. In the
root-nine family it is simple and single-sheet over t-endpoints;
the actual splitting condition there forces one scale. This proves
the three-scale bound for every allowed ratio.

## Frobenius on the normalized cubic twist

With the chart conventions in the statement, accepted source covariance
under y=w*z puts the source over k0(mu), k0=K(H,q), on q*z^3=P(x).
The residual differs only by a nonzero ratio-dependent scalar. Thus
Frobenius over k0 permutes actual scales, and every mu-orbit has
size at most three. The half-divisor class is defined over k0(mu),
as halving an even integral divisor commutes with coefficient Frobenius.

Let F denote Frobenius25 on J(X)[2]. The accepted
[binary Frobenius theorem](../jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md)
says its characteristic polynomial is irreducible of degree18 and
its order is171. Its centralizer is F_(2^18). The cubic deck map
gamma commutes with F and satisfies1+gamma+gamma^2=0, since its
quotient is P1. Hence gamma is F^57 or F^114.

For d=[k0:K], the cubic twist's Frobenius acts as F^(4d)*gamma^j.
Every nonzero two-torsion class therefore has orbit length
\[
171/gcd(171,4d+57j).
\]
This length divides the actual scale orbit, which is at most three.
It is consequently1 or3; thus57 divides4d+57j and hence d.
The sign choice in the cubic twist has no effect. The zero class
is not excluded, and means geometrically square residual on X_q.

## A rational content sheet fixes the cubic twist

For an actual positive-content root-nine ratio, choose an endpoint b
supporting content. The three endpoints belong to K. The established
single-sheet theorem says the coefficient-content divisor has exactly
one point above b. It is defined by coefficients over k0=K(H,q), so
that unique geometric point is k0-rational. Its z-coordinate z_b
satisfies q*z_b^3=P(b). Replacing z by z_b*v identifies X_q over k0
with the fixed cubic twist P(b)*v^3=P(x), which is defined over K.

At most one actual nonzero scale exists at this ratio. Frobenius over
k0 preserves actual étaleness and the normalized family, so that scale
mu is k0-rational. Its discriminant-half class is therefore defined
over k0 on the fixed K-twist just identified.

Frobenius of this fixed twist over K acts on geometric two-torsion as
F^4*gamma^j0=F^(4+57j0), for some j0 in{0,1,2}. Each possible
exponent4,61,118 is coprime to171. Thus every nonzero two-torsion
class has orbit exactly171 under this K-Frobenius. A class defined
over k0, an extension of K of degree d, forces171 to divide d.
This new version2 implication needs no further computation and does
not presume that an arbitrary cubic twist is trivial over k0.
