# A canonical centered energy in arbitrary source degree

30 September2026. Let K be a one-variable function field over a perfect
field of odd characteristic p. Suppose the separable polynomial
\[
F(W)=(W^p+q)H(W)+\tau,\qquad \tau\ne0,\quad \deg F=N
\]
has degree N>=p, and put B=K[W]/(F), w=W mod F and phi=w^p+q.
Write the polynomial remainder
\[
H(W)\bmod(W^p+q)=\sum_{j=0}^{p-1}s_jW^j.
\]
All traces below are from the finite separable K-algebra B. Then
\[
\operatorname{Tr}(w^j/\phi)=0\quad(0\le j<p),\qquad
\operatorname{Tr}(1/\phi^2)=0,
\]
\[
\operatorname{Tr}(w^j/\phi^2)=j s_{p-j}/\tau
\quad(1\le j<p).
\]

Put s=s_(p-1) and c=s_(p-2). On the locus s!=0, the canonical source
center r=c/s gives a quadratic differential
\[
\mathcal E_c=
\operatorname{Tr}\frac{(dw-dr)^2}{\phi}
=\operatorname{Tr}\frac{dw^2}{\phi}
-\frac{2dq}{\tau}\left(dc-\frac c s ds\right).
\]
For the affine coordinate change W'=aW+b, with a!=0, use the defining
polynomial F'(W')=a^N F((W'-b)/a). Then r'=ar+b and
\[
\mathcal E_c'=a^{2-p}\mathcal E_c.
\]
The cleared expression
\[
\mathcal R_F=
s\operatorname{Tr}\frac{dw^2}{\phi}
-\frac{2dq}{\tau}(s\,dc-c\,ds)
\]
extends across the coefficient divisor s=0 and obeys
\[
\mathcal R_{F'}=a^{N-3p+3}\mathcal R_F.
\]
At a smooth base point where q,H,tau are integral, tau is a unit and
all source roots split integrally, R_F is regular. This last assertion
does not require s or a critical discriminant to be a unit.

In characteristic five, s=s4, c=s3 and the affine weight is N-12.
For degree ten this supplies a coordinate-covariant tensor in the
cubic-derivative sector s4!=0. On the specialization s4 identically
zero the cleared expression is identically zero; the earlier
trace-zero corrected energy remains a separate invariant there.
No bound at zeros of tau or at nonintegral source roots, and no
global parameter or common-cover exclusion, is asserted.

[Proof](../../Proofs/cartier_and_spin/frobenius_remainder_centered_energy.md).
