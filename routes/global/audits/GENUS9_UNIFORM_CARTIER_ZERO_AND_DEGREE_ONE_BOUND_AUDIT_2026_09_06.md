# Uniform Cartier zeros on file76 X: independent audit

Verdict: **PASS**. Auditor: `/root/genus9_uniform_cartier_zero_audit`.
Date: 2026-09-06.

Scope: the proof and executable certificate linked in
[the theorem](../../../Solutions/Sol_fixed_x_cartier_eigenforms.md),
and its stated primitive-weight-one consequence using the separately
[audited contact bound](SHARED_SIMPLE_FORM_CONTACT_DEGREE_BOUND_AUDIT_2026_09_06.md).

1. The modulus and all eleven coefficients match file76's certificate
   exactly. An additional exact check verifies square-freeness. The tame
   cubic cover has genus nine and one point at infinity. There
   ord(x)=-3, ord(y)=-10, ord(dx)=-4; the last leading coefficient
   is nonzero in characteristic five. At a finite branch point y is
   a parameter and dx/y^2 is a unit. Thus the nine stated regular
   forms are independent and exhaust the genus-nine space. Their
   infinity orders have different residues modulo three.
2. Cartier swaps the two cubic characters (inverse fifth power swaps
   the characters), so a nonzero eigenvalue forces both A and B
   nonzero. Uniform multiplicity divides 16. For order congruent to
   four modulo five, Cartier has exact smaller order (e-4)/5,
   excluding e=4. The possible positive infinity orders from the
   two summands exclude e=2,8; A nonzero excludes e=16 there.
   Order zero at infinity consequently forces deg A=2. Scaling A
   monic preserves the nonzero-eigenvalue property.
3. Direct use of Cartier(h^5 eta)=h Cartier(eta) gives precisely
   F and F^3 in the N and M formulas, with index 5i+4-j. Taking
   fifth powers of the eigen-equation gives (5) with t=lambda^(-5).
   Entrywise fifth power is indeed inverse fifth power on this F25;
   an additional matrix check verifies Mr^([5])=M. With A monic,
   t=b^5, A=(u^5,v^5,1), B=b Mr U, the first equation becomes
   U^([25])=b^6 N Mr U. Hence c=b^3 gives exactly c^2, with no
   missing coefficient twist. Conversely any geometric solution of
   (6) and any cube root b of c reconstructs the eigen-equation.
   Its final equation forces c nonzero, so no saturation is needed.
4. The divisor of dx/y^2 is 16 times infinity. Pushing the even
   principal divisor down under the norm preserves even coefficients,
   including at ramification points. The cubic norm has plus sign:
   Norm(Ay+B)=B^3+F A^3. Its degree is 16 and its leading coefficient
   is one because deg(B^3)<=15. Thus an even differential divisor
   necessarily gives a monic square norm over the algebraic closure.
5. The quotient computation is exact, even if the quotient has
   nilpotents. Descending coefficients 15 through 8 determine the
   unique possible monic square root since 2 is invertible. Lifting
   its residual coefficients and adjoining them to I is valid for
   every geometric solution. A fresh Sage run returned dimension 0
   and Groebner basis [1] after adjoining the constant residual alone,
   in 6.6 seconds. This excludes all geometric solutions, not just
   F25-rational points. No sign, power, chart, or quotient-lift error
   was found.
6. In the stated coreless primitive-weight-one branch the intersection
   has one-dimensional degree one, stable under Cartier. Ordinarity
   of file76 Y forces the common Cartier eigenvalue nonzero. Each
   multiplicity stratum is a clump, so clump uniqueness forces the
   same uniform multiplicity on both endpoints. The theorem makes
   it one. Using file76's established Hom(JX,JY)=0 and joint
   minimality, the contact bound with e=d=1, n=2, m=4 gives
   deg(Z->Y)<=20*8=160 and deg(Z->X)<=20*24=480.

Nonbreaking limitations: the square-norm condition is used only as
a necessary condition. This audit does not assert a bound for higher
primitive weights, a span without positive shared tensors, arbitrary
cored spans, or nonminimal covers. It neither excludes the remaining
bounded-degree branch nor solves Litt3. The established file76 endpoint
arithmetic and structural clump/intersection results are dependencies;
they are not being replaced by this finite-algebra calculation.
