# Proof: compact norm and critical quadratic

[Statement](../../Theorems/cartier_and_spin/degree140_constant_compact_norm.md).
Sections12–15 of the
[retained report](../../../litt3-computation-data/finite_loci_v4_replies_20260926/extracted/constant_a0_boundary/constant140/REPORT.md)
give the complete coordinate construction and certificates.

## Exact norm compression

Write the barred fixed-degree resultant as D(lambda), and
D/t^5=e0+e1 y+e2 y^2. With H=hw,q=w^3,lambda=w mu, define
\[
E_j=q^{16}w^{j-2}e_j(H/w,w,w\mu,x).
\]
The cubic source covariance makes this independent of w. Its support
has H-degree at most12 and q-degree at most60 before interpolation.
Performing polynomial division by t^5 over the coefficient ring,
its remainder obeys the same bounds. All7137 divisions on a13-by61
tensor grid have zero remainder, proving the global divisibility.
The full coefficient grid has335439 entries and is roundtripped.
The retained sparse array has89481 nonzero terms.

Set r=y/w, so r^3=P/q. Then
\[
D/t^5=q^{-16}w^2(E_0+E_1r+E_2r^2).
\]
The cubic norm formula, multiplied by the defining q^48 normalization
of W, gives the stated compact identity in the full parameter ring.

## Nonsquare critical discriminant

The discriminant Delta has no finite poles and exact pole32 at O.
A square root would therefore be a+by, deg a<=5,deg b<=2. Writing
Delta=delta0+delta1 y+delta2 y^2 forces
delta1^2-4delta0delta2=0. After the nonzero q,w normalization, let
p_i(H,q) be its x-coefficients. The retained independent certificate
has78 terms in three multipliers, and is exactly
\[
c_{12}p_{12}+c_{13}p_{13}+c_{14}p_{14}=q^4.
\]
It excludes all geometric H with q!=0, without a further pivot.
The coefficient construction and literal polynomial identity are
independently checked by `elimination/src/verify_new.py`.

## Universal discriminant identity

Over F5 put
\[
S=2aZ^3+3bZ^2+cZ+d,\quad D=aZ^2+bZ+c,
\quad f=\lambda(Z^5+Q)^2+(Z^5+Q)S+C.
\]
Write Res_(10,2)(f,D)=D0+D1 lambda+D2 lambda^2, and set
\[
\Delta=b^2+ac,\quad T=c^5-Qb^5+Q^2a^5,\quad U=2Qa^5-b^5,
\]
\[
\Theta=Qa^3+d\Delta+2bc^2,\quad V=T\Theta+C\Delta U.
\]
Then D2=T^2 and
\[
D_1^2-4D_2D_0=\Delta^3V^2.
\]
To prove it, work first with the two roots z1,z2 of D. Put s=z1-z2,
so s^2=Delta/a^2, and Ui=zi^5+Q,Si=S(zi). Reduction modulo D gives
U1U2=T/a^5, U1+U2=U/a^5,
U1S2-U2S1=Delta Theta s/a^4, U1-U2=Delta^2s/a^4.
The scale discriminant is
a^20(U1^2(U2S2+C)-U2^2(U1S1+C))^2. Substitution proves the formula.
Both sides are polynomials, so the identity includes all coefficient
drops and zero-discriminant specializations. An independent sparse
expansion over F5 also checks all144 terms.

For the actual chart use a=3g2,b=2g3,c=g4,d=g5,Q=Qbar,C=t^3.
Here dQbar=A^2 dx/y^2 is nonzero, so Z^5+Qbar is irreducible and
cannot share a root with the nonzero quadratic D. Thus T!=0. If V=0,
the scale resultant would be T^2(lambda-r)^2. Its norm after division
by t^5 would then be t^3 times a square. Since deg_x t=3, this has
odd infinity valuation for every constant scale except a possible
identically zero value. The actual residual has exact degree140
independent of scale, a contradiction. Hence V!=0 and the scale
quadratic has nonsquare discriminant.

Irreducibility with an indeterminate scale does not preclude a square
specialization. For example x(lambda-1)^2+(lambda-1)+x^2 has nonsquare
scale discriminant1-4x^3, but its lambda=1 value is x^2. Norm squareness
also need not imply squareness on X. Neither invalid implication is
used or offered as an exclusion of the remaining finite locus.

Provenance and focused local verification are recorded in the
[integration audit](../../Research/audits/FINITE_LOCI_V4_REPLIES_2026_09_26.md).
