# Proof: a quadratic transformation of the universal quintic

[Statement](../../Theorems/projective_connections/genus_two_dormant_parameter_curve.md).

## 1. The smooth normalization and its degree-five map

Write P_t(T)=2 Psi_t(T), the monic polynomial of the
[universal dormant theorem](genus_two_dormant_quintic.md).
Put s=T-3t+1. Direct substitution gives
\[
P_t(3t-1+s)
=-s^3t^2+(s^4-2s^3+1)t+(s^5+s^4-s^3-s+1).
\]
The discriminant of this quadratic in t is
\[
(s^4-2s^3+1)^2
 +4s^3(s^5+s^4-s^3-s+1)=1+3s^4.
\]
Thus w=-2s^3t+s^4-2s^3+1 and the stated inverse formulas
identify the two function fields. The quartic has four distinct
geometric roots, so its double cover of the s-line is smooth of
genus one after projective normalization and is geometrically
connected. It has the rational point (s,w)=(0,1).

The poles of t give its degree without a resultant or a function-field
genus algorithm. At (0,-1) the numerator is a unit and s is a local
parameter, so the pole has order three. At each of the two geometric
points above s=infinity, w has pole order two and s has pole order
one; the displayed t has pole order one. At (0,1) its numerator
vanishes to order at least three, so there is no pole. Hence the
degree is five, and the infinity fiber has type (3,1,1). In particular
the map is separable, since a purely inseparable degree-five map
would have ramification index five everywhere. Its three poles
have tame indices.

The original monic quintic is therefore irreducible even over
bar(F5)(t). Its affine algebra is finite étale away from
0,1,2,3, by the exact discriminant
\[
\operatorname{Disc}_T(P_t)
=-[t(t-1)(t-2)(t-3)]^2.
\]
Here P is monic, so its resultant with its derivative equals this
discriminant even though characteristic five lowers the derivative
degree. Each of the four exceptional finite fibers factors as
one linear factor cubed times a separable quadratic. At its triple
point the partial derivative with respect to t is nonzero. Thus
the total curve is smooth there and t-a has order three. These
fibers again have type (3,1,1), all tame. There is no other
ramification. The five contributions of two also recover genus one
from Riemann--Hurwitz.

The [short checker](../../scripts/genus_two/check_dormant_parameter_curve.py)
verifies both birational identities, the resultant, all finite
factorizations and the nonzero parameter derivatives. Its
[receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/dormant_parameter_curve.json)
retains exact coefficients and source hash. The smooth quartic and
pole calculation prove the normalization; no numerical genus output
is required.

## 2. Arithmetic and geometric monodromy

The discriminant is a square already in F5(t), since -1=4.
Thus both monodromy groups lie in A5. Geometric connectedness makes
the geometric group transitive on five letters, hence its order
divisible by five. Tame inertia at any branch point is a 3-cycle,
so its order is also divisible by three. A subgroup of A5 with
order divisible by15 has order15,30 or60. Order15 would have a
normal Sylow5 subgroup, whose normalizer in A5 has order10.
Order30 would give an index-two quotient of A5, impossible because
3-cycles generate A5. Hence the geometric group is A5. The arithmetic
group lies between it and A5 and is therefore the same. In particular,
the Galois closure has no enlarged constant field.

Its inertia groups all have order three; taking the Galois closure
introduces no wild inertia. Riemann--Hurwitz gives
\[
2g-2=60\left(-2+5\left(1-\frac13\right)\right)=80.
\]
Thus g=41.

## 3. Verschiebung gives a much smaller connection equation

On the quartic normalization use (0,1) as origin. The formulas
\[
x=2(w+1)/s^2,\quad y=4(w+1)/s^3,\qquad
s=2x/y,\quad w=(x^2-3)/(x^2+3)
\]
give inverse birational maps to E_0:y^2=x^3+3x. Both curves are
smooth and projective, so the maps extend to an isomorphism. The
origin goes to the point at infinity. Substitution in t gives
\[
z=(t+1)^{-1}=xy/(2x^2+3).
\]
The five poles of z are the origin and the four points with x=1
or -1. They are simple and rational over F5.

The curve E_0 has ten F5-points, hence Frobenius trace -4 and
Verschiebung V=[-4]-pi. It has degree5, is separable, and its
invariant differential multiplier is one. The multiplication-by-five
formula has x-coordinate
\[
x([5]P)=\frac{x^{25}+2x^{15}+x^5}{x^{20}+3x^{10}+1}.
\]
Taking its rational fifth root gives the stated V_x. The choice
V_y=V_x'(x)y has differential multiplier one, fixing the possible
sign. In particular V is the actual dual isogeny, and its kernel
consists of the five poles of z. A direct rational-function identity
then gives
\[
z^5-z=3V_xV_y,\qquad
(z^5-z)^4=V_x^6(V_x^2+3)^2.
\]
These identities, including the elliptic equation for (V_x,V_y)
and the multiplication-by-five formula, are checked symbolically in
the [isogeny checker](../../scripts/genus_two/check_dormant_isogeny_quotient.py).
Its [receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/dormant_isogeny_quotient.json)
records the small rational functions and exact identities.

We must check that U=V_x^2 retains the connection, rather than
merely defining another degree-five cover. Write a=z^5-z. From U
and a recover the two coordinates on the target of V by
\[
V_x=\frac{a^2}{4U(U+3)},\qquad V_y=\frac{a}{3V_x}.
\]
Thus k(z,U) contains V^*k(E_0). The latter has prime index5 in
k(E_0). Moreover z does not belong to it: otherwise the degree-five
map z would factor through V with a degree-one map E_0 to P1,
impossible for a genus-one curve. Consequently k(z,U)=k(E_0).
Since [k(E_0):k(z)]=5, the polynomial U^3(U+3)^2-(z^5-z)^4
is the complete generic connection equation.

This identification extends over EVERY ordinary smooth parameter.
Here A is nonzero; the new monic quintic has discriminant -A^3, so
its scheme is finite étale. The original dormant scheme is also
finite étale on this open set by the original discriminant identity.
The function U has poles only above t=4, which has been removed.
It therefore gives a morphism of these finite étale covers, which
is an isomorphism because it is an isomorphism generically. This
also establishes the statement over every field of definition.

## 4. Exact first-height incidence and its group interpretation

The previously proved
[first-height family classification](../deformations/pointed_extensions_frobenius.md)
limits ordinary first-height pointed incidence to sixty cubic
parameters. We now keep the dormant parameter itself. The following
small linear equations test every possible two-torsion twist.

For a torsion label R dividing F, put M=R or F/R and
\[
q=\sqrt M\,h(u)/F,\qquad
\deg h\le\lfloor(4-\deg M)/2\rfloor.
\]
On the étale two-torsion cover this is the coefficient of a global
quadratic differential with the required twist. Its two-jet is
horizontal precisely when q''=r_T q. This follows from the actual
dormant jet realization in
[pointed Frobenius, Sections1--2](../deformations/pointed_extensions_frobenius.md).
The same polynomial bases also follow directly from the
[two-torsion cohomology dictionary](../deformations/genus_two_pointed_polynomial_test.md).
Set a=M'/(2M)-F'/F. After clearing denominators, the complete equation
is the linear polynomial identity
\[
F^2h''+2aF^2h'+(a'+a^2-r_T)F^2h=0.
\]
Its three coefficients are polynomials because M divides F. The
two M-components exhaust the global quadratic differentials. There
is no omitted regularity condition or choice of integral repair.

The [incidence checker](../../scripts/genus_two/check_pointed_dormant_elliptic_locus.py)
executes these equations for all five dormant points above each of
the sixty possible ordinary parameters, and above t=4. It works
in F_(5^9), which splits all these dormant fibers; the fact that
each fiber has five roots is checked. Every returned kernel is
checked entrywise against the original polynomial equation. The
[complete receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/pointed_dormant_elliptic_locus.json)
has all305 pairs, including the nonrational cubic-factor roots.
Exactly sixty ordinary pairs have a nonzero kernel, each in one
twist and of dimension one. All five pairs above t=4 have three
such twists, each of dimension one. These are all possibilities
by the previously established family classification.

For each of the65 pairs the checker also verifies that its point
P on E_0 is F125-rational and satisfies [65]P=0. The elliptic curve
has130 F125-points. Its group is abelian of order2*5*13, so has
exactly65 odd-order points. The65 distinct detected points exhaust
that subgroup, proving the asserted equality, not just an inclusion.

Here is its isogeny description. Put C=1+pi+pi^2. Then
\[
\deg C=\frac{\#E_0(\mathbf F_{125})}{\#E_0(\mathbf F_5)}=13.
\]
Its differential is one, so C is separable, and (pi-1)C=pi^3-1
makes its kernel F125-rational. The separable kernel of V has
order5 and is F5-rational. Since5 and13 are coprime, ker(CV)
is their direct sum and equals the odd-order subgroup just found.

Finally the three distinct values x(Q)^2 for nonzero Q in ker C
are exactly the roots of
\[
D(U)=U^3+4U^2+3U+4.
\]
The isogeny checker verifies this on all130 rational points. Each
root has four preimages on E_0, so those twelve points exhaust the
nonzero geometric kernel of C. Consequently, away from ker V,
P is in ker(CV) exactly when D(V_x(P)^2)=0. The exceptional kernel
ker V lies precisely over t=4. This proves the short ordinary
incidence equation in the statement.

These finite first-height equations do not determine higher
Frobenius incidence. In particular, they must not be extended by
replacing65 with another guessed torsion order.
