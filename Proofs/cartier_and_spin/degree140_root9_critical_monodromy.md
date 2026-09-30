# Critical norm-square exclusion and its Galois consequence

[Statement](../../Theorems/cartier_and_spin/degree140_root9_critical_monodromy.md).
Use the accepted normalized source in the
[critical nondescent proof](degree140_root9_critical_nondescent.md).
On q*z^3=P(x), write Delta/w^2=d0+d1*z+d2*z^2, with degrees
(10,7,4) and fixed nonzero leading coefficient B of d2. The normalized
cubic norm, multiplied by the square q^2, is
\[
N=q^2d0^3+qP d1^3+P^2d2^3-3qP d0d1d2.
\]
It has degree32 and leading coefficient B^3. Multiplication by these
nonzero parameter scalars does not affect geometric squareness.

## Eight necessary polynomial equations

Clear the common coefficient denominator D, whose factors are original
chart units, and put A(T)=D*T^32*N(1/T). Its constant coefficient
D*B^3 is a unit. If N is square, its normalized square root is a
polynomial of degree16. In characteristic5, A^13 agrees with a
nonzero scalar multiple of that normalized root through order24:
after dividing by A(0), the identity (A^13)^2=A^26 agrees with A
modulo T25. Hence coefficients17 through24 of A^13 vanish.

The [exact constructor](../../scripts/arithmetic/root9_critical_norm_square_20260929.sage)
uses A^13=A^3*(A^2)^5, including coefficient Frobenius. It removes
only common powers of factors of D from those eight coefficients.
Call the resulting polynomials p17,...,p24 in K[H,q]. In particular
their first three bidegrees in(H,q) are
\[
(50,116),\quad(53,122),\quad(56,129).
\]
No candidate is removed by these original unit factors.

## Two global resultants suffice

Take the fixed-degree Sylvester determinants in H
\[
R18=Res_H(p17,p18),\qquad R19=Res_H(p17,p19).
\]
The determinant degrees in q are bounded by12248 and12946. These
follow immediately from the displayed bidegrees: each Sylvester term
uses n coefficients of the first polynomial and m of the second.
The adjugate identity places each determinant in the corresponding
two-generator ideal, including leading-degree drops.

The [native exact construction](../../scripts/arithmetic/root9_critical_resultants_20260929.cpp)
reconstructs both entire polynomials on15024 distinct roots of unity
in K. Their orders divide390624, and15024 exceeds both degree bounds.
The inverse Fourier transform therefore recovers the global
coefficients, not just values at a finite selection of ratios.
Fixed-degree resultants retain simultaneous leading-degree drops;
their implementation is checked against literal Sylvester determinants.
The reconstructed polynomial degrees are9745 and10244.

Their exact monic gcd is
\[
q^{2652}(q-q_0)^{790},\qquad q_0=\langle118020\rangle.
\]
Both q and q-q0 are original coefficient-denominator units. A saved
univariate Bezout identity expresses this gcd as U*R18+V*R19.
It proves that the localized ideal(p17,p18,p19) is the whole ring.
Thus none of the eight-equation square candidates exists, with no
restriction to K-rational ratios and no reducedness assumption.

The [focused independent checker](../../scripts/arithmetic/verify_root9_critical_norm_exclusion_20260929.sage)
passed: every exported tail coefficient matches the symbolic rows;
the univariate Bezout identity is verified literally; every gcd factor
divides the original coefficient denominator; and six additional
fixed Sylvester determinants agree at three further field nodes.
These controls supplement, rather than replace, the global degree
bounds. The earlier accepted source programs were not replayed.
The [evidence](../../../litt3-computation-data/conceptual_continuation_20260929/root9_critical/norm_square/)
contains exact rows, resultants, Bezout coefficients and execution
receipts. The abandoned three-variable Groebner calculation supplies
no part of the conclusion.

## The three square classes are independent

Let gamma generate the cyclic cubic extension k(X)/k(x), and let d
be Delta's class in k(X)^*/k(X)^{*2}. Its cyclic span is a quotient
of the regular F2[C3]-module. Since3 is invertible in F2, that module
is the direct sum of the trivial line and the irreducible dimension-two
module. A cyclic span can have dimension one,two or three.

Dimension one would make d invariant. Its norm then pulls back to
d+gamma(d)+gamma^2(d)=d, so d would descend from k(x), contrary to
[critical nondescent](degree140_root9_critical_nondescent.md).
Dimension two would have zero invariant sum, contrary to the norm
nonsquareness just proved: an odd-degree cubic extension cannot make
a downstairs nonsquare into a square. Hence the dimension is three.

Adjoining square roots of the three conjugates gives a degree-eight
Kummer extension of k(X). A lift of gamma cyclically permutes these
roots and has order three; the complete Galois group over k(x) is
(C2)^3 semidirect C3. The diagonal C2 is central, and the even-parity
V4 summand is cyclically permuted, giving C2 times A4. Every step
concerns this critical cover; it asserts no simultaneous Galois closure
for the original two-map problem.
