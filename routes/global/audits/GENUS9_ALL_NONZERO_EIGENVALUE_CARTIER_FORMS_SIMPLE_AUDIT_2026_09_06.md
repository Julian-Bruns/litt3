# Genus-nine Cartier eigenforms: independent major audit

Auditor: /root/genus9_all_eigenforms_simple_audit. Date: 2026-09-06.
Verdict: PASS for every Cartier eigenform with NONZERO EIGENVALUE and
for the stated disjointness consequence, using the retained audited
simple-root/core theorem and established ordinary-Y/Jacobian hypotheses.

Reviewed [the proof](../../../Solutions/Sol_fixed_x_cartier_eigenforms.md)
and [standalone certificate](../GENUS9_CARTIER_EIGENFORM_SIMPLE_ZERO_TEST.sage)
from scratch. The defining polynomial and F25 modulus agree coefficient
by coefficient with file76. No prior routine audit records were used.

The two Cartier blocks are correct: write A/y=(AF^3)/y^10 and
B/y^2=(BF)/y^5, then apply the fifth-power coefficient rule. This gives
A^[5]=tNB and B^[5]=tMA with t=lambda^(-5). The regular basis has the
claimed dimensions 3+6 and covers all regular differentials.

The observability argument covers EVERY nonzero-eigenvalue form:
e3V=0 and V^[25]=rho HV imply e3HV=e3H^2V=0; invertibility of O
then excludes V!=0. Normalizing the quadratic coefficient is legitimate.
The substitutions B=b M^[5]U and c=b^3 give U^[25]=c^2HU exactly.

The exponents 2,52,1302 follow by iterating the 25-semilinear equation.
Cayley--Hamilton gives the displayed degree-1302 polynomial with the
correct signs. Conversely, applying O to U^[25]-c^2HU gives three zero
coordinates from the reconstruction and that polynomial. Its roots are
nonzero and separable. Thus the five quotient fields exhaust the whole
algebraic-closure chart; they are not a finite-field sampling argument.
The three choices of b above each c give the same norm polynomial.

Independent standalone replay completed successfully in 67.11 seconds:
det(O)=a+4; factor degrees 1,1,52,624,624; every repeated-root gcd had
degree zero. Additional replay assertions checked det(H)!=0, the exact
factor list, the derivative identity, and the empty bad-factor list.
The retained script now asserts these reported invariants and fails if
any bad factor occurs, addressing the original print-only failure path.

The norm is B^3+FA^3, monic of degree16. Infinity has form order zero,
since Ay has pole16 and B has pole at most15. At every finite point
dx/y^2 is a unit differential, including branch points. The norm
valuation is the sum of the nonnegative orders over each geometric
fiber. Squarefreeness therefore excludes every multiple zero, and the
canonical degree gives sixteen simple zeros.

For any actual common etale cover, the shared regular-form space is
Cartier-stable. Ordinarity of Y makes its restricted Cartier operator
injective, hence bijective. Frobenius/Lang supplies a nonzero eigenvector
over the algebraically closed field. Injectivity and Cartier compatibility
of differential pullback descend it to X; etaleness preserves its simple
zeros. The retained simple-root/core theorem and low-zero logarithmic
lemma then give a positive-genus core, contradicting Hom(JX,JY)=0.
This needs neither minimality nor corelessness of the original span.
It proves disjoint pulled-back regular one-form spaces, not nonexistence
of a common cover.

Scope correction communicated and incorporated: “nonzero Cartier
eigenform” alone could include eigenvalue zero. Such a stronger statement
would be false: a nonzero degree-at-most-four B in ker(N) exists by
dimension, and B dx/y^2 has Cartier zero and an infinity zero of order
at least four. The theorem title now explicitly requires nonzero
eigenvalue, as its mathematical statement already did.
