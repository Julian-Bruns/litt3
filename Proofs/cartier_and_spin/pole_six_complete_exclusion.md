# Proof of the complete pole-degree-six exclusion

24 September 2026. The completed Pro reply is preserved, with its original
manifest, under
[degree55 evidence](../../../litt3-computation-data/degree55_rank_support_replies_20260924/originals/degree55/degree55_quadratic/REPORT.md).
The precise representative and trace formulas are also stated in the
[submitted problem](../../Research/requests/degree55_rank_support_seven_points_2026_09_24/01_degree55_tensor_model.md).
The earlier seven-row enumeration is an established input, not recomputed
or strengthened by this reply.

## Forced local coefficients

The representative field is
\[
E=\mathbf F_{25}[t,\alpha]/(t^7+t+1,A(\alpha)),
\quad A=(1,21,14,22,13),\quad \beta^2-\beta-3=0.
\]
Use the basis \(\alpha^i t^j\), \(0\le i<4,0\le j<7\), with F25-coded
entries. The two defining extensions have coprime degrees seven and four
over F25; their irreducibility is checked by exact Frobenius/gcd tests.
Consequently a nonzero coordinate is nonzero over the whole algebraic closure.

Let \(T=\operatorname{Tr}(x_1)/2\) and
\(U=\epsilon^{-1}s^3\operatorname{Tr}(x_2)/2\). These rational functions
are fixed by the representative's endpoint and common-pole data. Complete
at the zero endpoint labelled by \(\alpha\), and set
\(X=x_1\), \(Y=\epsilon^{-1}s^3x_2\).
The quadratic conjugates satisfy
\[
\widehat X=2T-X,\qquad\widehat Y=2U-Y.
\]
Their constant coefficients are
\((\rho,L)=(\alpha,L_*(\alpha))\) and
\((\widehat\rho,\widehat L)=(\alpha^{625},L_*(\alpha^{625}))\),
where \(L_*=(21,19,20,22)\). Both branches satisfy
\[
A(X)=K_s(Y),\quad A(2T-X)=K_s(2U-Y),
\]
\[
K_s(Z)=A_4sZ^4+A_3\epsilon^{-1}s^4Z^3+
A_2\epsilon^{-2}s^7Z^2+A_1\epsilon^{-3}s^{10}Z+
A_0\epsilon^{-4}s^{13}.
\]
The first coefficient gives \(X_1=A_4L^4/A'(\rho)\).
For orders \(j=2,3,4\), the new coefficients \(X_j,Y_{j-1}\)
have the SAME coefficient matrix
\[
M=\begin{pmatrix}A'(\rho)&-4A_4L^3\\
-A'(\widehat\rho)&4A_4\widehat L^3\end{pmatrix},
\quad\det M=[19]+[15]\alpha+[12]\alpha^2+[2]\alpha^3\ne0.
\]
Subtract the known terms in both equations and solve this two-by-two
linear system. This uniquely determines \(X\bmod s^5\) and
\(Y\bmod s^4\), over any extension field. In particular no uncomputed
coefficient or field extension can change the obstruction below.

## The incompatible differential coefficient

Put
\[
\widehat P(s,Y)=\sum_{i=0}^{10}P_i\epsilon^i s^{30-3i}Y^i.
\]
The second tensor identity requires
\[
\epsilon^{20}(sY'-3Y)^3P(X)^2-(X')^3\widehat P(s,Y)^2=0.
\]
The forced coefficients give zero in orders zero, one and two, and the
following nonzero coefficient in order three. Rows index the power of
alpha, columns the power of t, and entries are F25 codes:
\[
\Omega=\begin{pmatrix}
8&3&8&24&16&21&6\\
8&5&2&3&11&5&8\\
6&12&15&19&8&8&23\\
4&13&16&11&4&4&23
\end{pmatrix}.
\]
In particular its constant coordinate is \([8]\ne0\). The contradiction
uses only the fixed traces, the quartic identity and the differential
identity. It is independent of the quotient genus and of the additional
ramification condition. Arithmetic conjugation excludes all seven rows.
The previously proved exhaustive reduction therefore excludes the entire
comparison-pole-degree-six branch.

## Verification and scope

The standard-library verifier reconstructs the fields, all trace jets,
the recurrence, both quartic identities and both sides of the differential
identity. A separate C++ program uses a sextic elimination and Newton
iteration. Both were run locally; the secondary certificate reproduced
byte-for-byte and both algorithms agreed. The local log is
[here](../../../litt3-computation-data/degree55_rank_support_replies_20260924/logs/degree55_replay.log).
The original certificate records every coefficient, residual and input.

Pole degrees three and six are now both excluded at arbitrary covering
degree. The semigroup bound leaves pole degree nine as the first remaining
possibility. It does not bound all comparison degrees or solve either
unmarked common-cover problem.
