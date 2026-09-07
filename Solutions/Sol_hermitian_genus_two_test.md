# Proof: the free clock-and-shift quotient

[Statement](../Theorems/Thm_hermitian_genus_two_test.md).

## The group and its quotient

The two matrices D and P have determinant1, preserve the standard
Hermitian form over F25, and commute up to a scalar cube root of unity.
Their projective images generate C3 x C3. Every nonidentity projective
element has a representative D^i P^j with three distinct eigenvalues
1,zeta,zeta^2: this is immediate for j=0, and for j!=0 follows from its
cyclic monomial matrix, whose characteristic polynomial is u^3-1.
For a unitary matrix with these eigenvalues its three eigenlines are
pairwise Hermitian-orthogonal. The form is nondegenerate, so none of
these lines is isotropic. They are exactly the projective fixed points,
and none is on H. The action is free. Since9 is prime to5, the quotient
map is finite etale, and Riemann--Hurwitz gives g(C)=2.

Here are its functions explicitly. Put

    a=X^3, b=Y^3, c=Z^3, w=XYZ,
    t=(a+b+c)/w, v=(a-b)(b-c)(c-a)/w^3.

The quotient by D is the complete intersection a^2+b^2+c^2=0,
abc=w^3 in P3. For example, in the chart Z=1 the original coordinates
are recovered by a cube root of a, followed by y=w/x; the field degree
is3. The remaining generator cycles a,b,c. On w!=0 their ratios to w
are roots of

    u^3-t u^2+3t^2 u-1.

The discriminant is t^6+3, giving v^2=t^6+3. Adjoining these three roots
to k(t,v) has degree at most3: the discriminant square restricts the
permutation group to A3. The cyclic group acts faithfully on this
field, so the degree is exactly3 and k(t,v) is precisely its invariant
field. The degree-six polynomial t^6+3 has no repeated roots; its
smooth projective double cover has genus2, as also computed above.

Both matrices lie in SU3(5), so the quotient atlas factors through
[H/PSU3(5)]. This assertion uses the actual free quotient, not a putative
cover with the same numerical ramification profile.

## Acyclicity of the associated V

On H the normalized bundle is E_H=O_H(1) tensor k^3, with distinguished
section e=(X,Y,Z), and V_H=E_H/O_H. The form sum u_i v_i^5 has values
in O_H(6)=omega_H^2 and is everywhere nonsingular. The determinant is
O_H(3)=omega_H, equivariantly: the defining equation is invariant and
the chosen matrices have determinant1. Scalar matrices act oppositely
on O(1) and k^3, so E_H and its distinguished section descend through
the projective group G. This is the untwisted normalized atlas bundle.

The sequence O_H->O_H(1)^3->V_H gives

    H0(H,V_H)=End(k^3)/k Id.

Indeed the only possible extra sections are the kernel of
H1(O_H)->H1(O_H(1))^3. Its dual is multiplication by the three coordinates,
H0(O_H(2))^3->H0(O_H(3)), which is surjective. The action on End(k^3)
is conjugation. A matrix commuting with D is diagonal; if it also
commutes with P it is scalar. Since9 is invertible in k, taking
G-invariants is exact. Consequently

    H0(C,V)=H0(H,V_H)^G=0.

No general assertion that acyclicity descends through arbitrary covers,
or that ordinary Jacobians control common covers, is used.

## Complete small oper calculation

The local regularity argument at every finite branch point and both
infinities, the complete three-variable curvature ideal, and the exact
Schwarzian identification are in
[the computation proof](../Research/GENUS_TWO_HERMITIAN_OPERS.md).
Its short [Sage script](../scripts/genus_two_hermitian_opers.sage) checks
the five points in the original curvature equation and rank3 Jacobians,
and checks the quotient potential in k(H), not just at sample points.
The lexicographic ideal is

    (b0+b2^2, b1^2-2b2^3-1, b1 b2, b2^4-2b2).

It has length5 and the five points stated in the theorem. The actual
quotient gives (0,1,0). To check its full automorphism orbit without a
classification theorem, let B={b in F25:b^6=2}. Fix three distinct
members of B, and send them to each of the120 ordered triples of
distinct members of B. These determine every possible branch-preserving
Mobius transformation, without duplicates. The script checks all120
preserve B. For phi=(a t+b)/(c t+d), it also checks directly that

    (phi(t)^6+3)(c t+d)^6/(t^6+3)

is a nonzero constant. Its square root gives an actual automorphism
of the smooth projective double cover C. Since the Schwarzian of phi
is zero, the potential transforms as phi'^2 r(phi). Subtracting the
fixed base potential gives each of the five tuples exactly24 times.
This finite computation proves all five are realized by actual atlases;
it does not equate all atlases with just these automorphism translates.

This is a positive test for the general intrinsic construction. Its
existence is not evidence that the fixed genus-nine curve has an atlas.
