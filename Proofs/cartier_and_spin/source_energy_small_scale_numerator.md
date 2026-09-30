# A residue decomposition bounds the scale degree

Version2,30 September2026.
[Statement](../../Theorems/cartier_and_spin/source_energy_small_scale_numerator.md).
All derivatives delta below hold W and lambda constant. The proof
uses the source equation itself and no square-locus computation.

## One rational differential has the source energies as residues

Define the rational function
\[
\Lambda(W)=-\frac{\phi S+\tau}{v\phi^m},\qquad
F_\lambda=v\phi^m(\lambda-\Lambda).
\]
Since phi_W=0, we have Lambda_W=-D/(v phi^(m-1)). At a source root,
implicit differentiation gives
\[
\delta w=-\frac{v\phi(w)^{m-1}\delta\Lambda(w)}{D(w)}.
\]
Consider the W-differential
\[
\Omega=
\frac{v\phi^{m-2}(\delta\Lambda)^2}
     {D(\lambda-\Lambda)}\,dW.
\]
Its residue at each simple source root is (delta w)^2/phi(w).
Consequently the sum of these source residues is E2(lambda).

At infinity, Lambda has order at least p(m-1)-deg S. For generic
lambda the rational coefficient of Omega is O(W^(deg S+1-pm)),
hence O(W^(-p)) or better. Its residue at infinity is zero. The
remaining possible poles are the roots of D and the root of phi.

## The critical part has denominator of degree d

First suppose D has simple roots c_i. They are disjoint from phi,
and their residues are
\[
\frac{v\phi(c_i)^{m-2}(\delta\Lambda(c_i))^2}
 {D_W(c_i)(\lambda-\Lambda(c_i))}.
\]
Their sum is a proper rational function of lambda whose denominator
divides product_i(lambda-Lambda(c_i)). Up to a nonzero K scalar this
product is Delta(lambda), since
F_lambda(c_i)=v phi(c_i)^m(lambda-Lambda(c_i)). Thus multiplying the
critical part by Delta leaves degree at most d-1.

The same conclusion holds directly for multiple roots. In the
d-dimensional Artin algebra K[W]/D, phi is a unit and multiplication
by lambda-Lambda has matrix lambda I-M. Its inverse has denominator
det(lambda I-M) and adjugate numerator of degree at most d-1. The
sum of the residues at D is a K-linear functional of this inverse:
reduce v phi^(m-2)(delta Lambda)^2/(lambda-Lambda) modulo D and take
its W^(d-1) coefficient divided by the leading coefficient of D.
This polynomial residue rule retains the full local multiplicities.
The determinant is a nonzero constant multiple of Delta. Thus the
same degree bound holds without a discriminant denominator, a
simple-root assumption or a specialization argument. For d=0 the
critical residue part is empty.

## The Frobenius pole contributes at most an affine scale term

Put A=phi S+tau and
\[
B=v\phi\,\delta A-A(\phi\,\delta v+m v\,\delta q).
\]
Then delta Lambda=-B/(v^2 phi^(m+1)), and cancellation in Omega gives
the particularly small polar expression
\[
\Omega=\frac{B^2}{v^2\phi^4D F_\lambda}\,dW.
\]
Its pole along phi has order at most four in phi, independently of
the source degree mp. Since D is a unit along phi, only the expansion
of F_lambda^-1 modulo phi^4 matters for this residue. It is
\[
(\tau+\phi S+\lambda v\phi^m)^{-1}\pmod{\phi^4}.
\]
For m=2 or3 this expression has degree at most one in lambda:
any term with lambda^2 contains phi^(2m), which is zero modulo phi^4.
For m>=4 it is independent of lambda. Neither B nor D depends on
lambda. The entire phi-pole residue therefore has the same scale
degree bound.

The residue theorem gives E2 as the negative of the critical residue
sum and the phi-pole residue. Multiplication by Delta proves the
claimed bound. Subtracting a lambda-independent correction adds only
a degree-d term and does not change it.

## A direct exact computation in the small source algebra

There is also a reconstruction which avoids resolving the critical
curve. Let L=lambda v be the leading coefficient, N=mp, and let
J=lambda v phi^(m-1)+S. In the source algebra, phi^-1=-J/tau.
Choose V with V D=1 mod F. The standard polynomial residue formula
then gives
\[
E_2=\frac1{L\tau^2}[W^{N-1}]
 \left((\delta F)^2J^2V\bmod F\right).
\]
The remainder is defined using the monic associate of F. To obtain V,
first reduce F modulo D and invert that remainder in K(lambda)[W]/D;
the resulting Bezout identity gives V. For degree ten this small
auxiliary algebra has dimension two or three, not the degree of the
residual square polynomial.

The proved scale bound permits exact interpolation from d+2 good
nonzero scale values when m=2 or3, after multiplication by the known
Delta. Coefficients can remain in the exact rational function field
of the base and of the geometric parameters. This is an algorithmic
consequence of the bound, not evidence from a finite sample, and no
global parameter elimination is claimed in this theorem.

## The full small-moment extension

For 1<=r<=p use instead the W-differential
\[
\Omega_r=
\frac{B^r}{v^r\phi^{2r}D^{r-1}F_\lambda}\,dW.
\]
Implicit differentiation and F_W=phi D show that its source
residues are exactly (delta w)^r/phi. Equivalently, before inserting
the expression for B its coefficient is
(-1)^r v^(r-1) phi^((m-1)(r-1)-1) (delta Lambda)^r /
(D^(r-1)(lambda-Lambda)). The sign cancels the sign in the
derivative of Lambda, giving the displayed formula for every r.

At infinity its rational coefficient is
O(W^(deg(S)+r-1-pm)). As deg(S)<=p-1, m>=2 and r<=p, this is
O(W^-2) or better, and hence there is no infinity residue.

The critical residue is computed in the Artin algebra
K[W]/D^(r-1), of dimension d(r-1). The determinant of multiplication
by lambda-Lambda is a nonzero scalar multiple of Delta^(r-1).
Its adjugate has degree at most d(r-1)-1. The polynomial-residue
functional gives the same bound for the critical residue numerator,
retaining every nilpotent and without a discriminant inverse.
For r=1 there is no critical part.

At phi, only the inverse of F modulo phi^(2r) enters. Since tau is
a unit there, expanding
(tau+phi S+lambda v phi^m)^-1 modulo phi^(2r) has scale degree
at most floor((2r-1)/m). Multiplication by Delta^(r-1) gives the
announced bound. This proof is unchanged at repeated roots of D.

For r=3,m=2,d=2 this degree is 4+2=6; for r=4 it is 6+3=9.
The new moment calculation is symbolic. It does not claim that its
global pole restrictions, even combined, suffice for etaleness.
