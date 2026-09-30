# Two-sided source support from common-eigenvector obstructions

Version1,26 September2026. Use the actual matched residual tensor H
from [middle-character correction rigidity](middle_character_correction_rigidity.md).
Its exact block form, in the retained row and column bases, is
\[
H(b)=\begin{pmatrix}b_0I_{15}+U(b_2,\ldots,b_9)\\
b_1I_{15}+V(b_2,\ldots,b_9)\end{pmatrix}.
\]
For every geometric b!=0 with b2=b3=b4=0, H(b) is injective.
Both b0 and b1 are unrestricted in this statement.

Consequently, every nonzero matched middle kernel requires
(b2,b3,b4)!=0. In the original source convention this is
(a3,a4,a5)!=0. Together with the earlier closed-boundary theorem,
the actual middle quotient window requires BOTH
\[
(a_1,a_2,a_3)\ne0,\qquad(a_3,a_4,a_5)\ne0.
\]
Equivalently, the nonzero polynomial
A_u(x)=a1+a2*x+a3*x^2+a4*x^3+a5*x^4 has degree at least two
and vanishing order at zero at most two. This notation refers to the
source u=y^2*x^(-5)*A_u(x), not to the correction polynomial.

The new exclusion uses polynomial identities over geometric source
strata. It does not assume a finite coefficient field or a bound on
the original maps. The remaining support cases, complete return window
and both unmarked common-cover problems remain unresolved.

[Proof and independently replayed certificates](../../Proofs/cartier_and_spin/middle_common_eigenvector_boundary.md).
