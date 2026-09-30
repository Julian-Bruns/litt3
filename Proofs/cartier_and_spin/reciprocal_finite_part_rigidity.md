# Proof: reciprocal finite parts determine an impossible pole polynomial

[Statement](../../Theorems/cartier_and_spin/reciprocal_finite_part_rigidity.md).
This is the reusable theoretical part of the pole-fifteen reply.
Its proof was independently audited; supplementary coefficient checks
are not a substitute for the argument with arbitrary geometric scalars.

Suppose R is nonzero. Boundedness at infinity and vanishing at zero
force it to have a pole. The reciprocal identity identifies its poles
with the reciprocals of the poles of S. At such a pole c write A for
the residue of R and A2 for that of S at c^-1. Since
\[
\frac{1}{t^{-1}-c^{-1}}=-\frac{c^2}{t-c}-c,
\]
the residue and finite part of lambda t^7 S(t^-1) at c are
-lambda c^9 A2=A and A/c, respectively. Comparing finite parts gives
\[
A=a c^4+b c^5.
\tag{1}
\]
Let C be the monic polynomial of the ACTUAL poles of R, and s=deg C.
It is squarefree and C(0)!=0. The numerator RC has degree at most s
and vanishes at zero to order at least three; consequently s>=3.

Set w=a t^4+b t^5. Equation(1) implies R-wC'/C is polynomial,
of degree at most four. At zero, reciprocity gives
R=a t^3+b t^4+O(t^7). At infinity boundedness fixes the degree-four
coefficient of the polynomial part. Hence
\[
R=(a t^4+b t^5)\frac{C'}C+a t^3-bs t^4.
\tag{2}
\]
At a simple root c, the finite part of C'/C is C''(c)/(2C'(c)).
Substitution in the prescribed finite part of R shows that every
root of C annihilates t(a+bt)C''+[a+(3s+1)bt]C'. Its degree is at
most s and its leading coefficient is 4bs^2. Thus
\[
t(a+bt)C''+[a+(3s+1)bt]C'-4bs^2C=0.
\tag{3}
\]
No division by a,b,s or a+bc was made. If C=sum C_j t^j, this is
exactly the recurrence
\[
a(j+1)^2C_{j+1}+b(j-s)^2C_j=0.
\tag{4}
\]
If a=b=0, all residues in(1) vanish. If exactly one of a,b is zero,
(4), together with C(0)!=0, forces C in k[t^5], contradicting its
nonconstant squarefreeness.

Otherwise put rho=-b/a and r=s mod5, with 0<=r<=4. Reading(4)
in consecutive blocks of five coefficients gives
\[
C(t)=V(t^5)\Phi_r(\rho t),\qquad
\Phi_r(u)=\sum_{j=0}^r\binom rj^2u^j.
\tag{5}
\]
Indeed within a block the multiplier is rho((j-r)/(j+1))^2;
the equation at the fifth boundary imposes no condition on the
next block's first coefficient. Thus(5) retains all Frobenius
blocks, rather than assuming them absent. Squarefreeness makes
V constant and s=r<=4. But
\[
\Phi_3(u)=(1-u)^2(1+u),\qquad \Phi_4(u)=(1-u)^4.
\]
Hence s<=2, contrary to s>=3. Therefore R=0. Reciprocity makes
S(u)=-lambda^-1(a u^4+b u^3); boundedness at infinity forces
a=b=0 and S=0.

The received proof and exact supplementary checks are retained in
[the report](../../../litt3-computation-data/critical_descent_replies_20260927/extracted/pole15/pole15_cubic_descent/REPORT.md),
Sections6–7. No numerical enumeration is a dependency of this lemma.
