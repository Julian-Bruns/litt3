# Source moments, affine centers and twisted quadratic energies

Version1,30 September2026. Let K be a one-variable function field over
a perfect field of odd characteristic p. Suppose
\[
F(W)=(W^p+q)H(W)+\tau,\qquad \tau\ne0,\qquad \deg F=N\ge p
\]
is separable. In the finite etale K-algebra B=K[W]/(F), put
w=W mod F and phi=w^p+q. Write
\[
H\bmod(W^p+q)=\sum_{j=0}^{p-1}s_jW^j,\qquad s=s_{p-1},\quad c=s_{p-2}.
\]
All traces are B/K; differentials are relative to the constant field,
and their products are symmetric products on the base curve.
The coefficient-moment and E_m assertions also hold over arbitrary
differential fields with the same separable polynomial hypotheses.

## Coefficient-moment calculus

The following identities hold independently of N:
\[
\operatorname{Tr}(w^j/\phi)=0\quad(0\le j<p),\qquad
\operatorname{Tr}(1/\phi^2)=0,\qquad
\operatorname{Tr}(w^j/\phi^2)=j s_{p-j}/\tau\quad(1\le j<p).
\]
Consequently
\[
\operatorname{Tr}(dw/\phi)=s\,dq/\tau,\qquad
\operatorname{Tr}(w\,dw/\phi)=c\,dq/\tau.
\]
These are identities in the actual separable source algebra, including
disconnected algebras; no critical-discriminant inverse is introduced.

## Center and trace-zero boundary

Put E=Tr(dw^2/phi). Where s!=0, r=c/s is a canonical affine center:
\[
\mathcal E_c=\operatorname{Tr}\frac{(dw-dr)^2}{\phi}
=E-\frac{2dq}{\tau}\left(dc-\frac c s ds\right).
\]
For W'=aW+b and F'(W')=a^N F((W'-b)/a), one has r'=ar+b and
\[
\mathcal E_c'=a^{2-p}\mathcal E_c,\qquad
\mathcal R_F=sE-\frac{2dq}{\tau}(s\,dc-c\,ds),\qquad
\mathcal R_{F'}=a^{N-3p+3}\mathcal R_F.
\]
The cleared R has no denominator s. If s is identically zero, R is
identically zero and the following invariants remain separate.

On s=0, for a base derivation delta define
\[
E_m=\operatorname{Tr}((\delta w)^m/\phi).
\]
Then E0=E1=0, and under w'=w+b, q'=q-b^p,
\[
E'_m=\sum_{j=0}^m\binom mj(\delta b)^{m-j}E_j.
\]
For p>=5, E2 and 3E2E4-2E3^2 are invariant; in characteristic
five the latter is 3I with I=E2E4+E3^2.

For p>=5 and the original degree-2p presentation
\[
F=\kappa(W^p+q)^2+(W^p+q)S+\tau,\quad
\kappa\tau\ne0,\quad \deg S\le p-2,
\]
c is the W^(p-2) coefficient of S and
\[
\mathcal Q^{\mathrm{aff}}=E-dq\,dc/\tau
\]
obeys Qaff'=a^(2-p)Qaff under the exact presentation
q'=a^p q-b^p, S'(W')=a^p S((W'-b)/a), tau'=a^(2p)tau,
kappa'=kappa. This includes c=0 and meromorphic a,b, and supplies
the corresponding tensor gluing law. No regularity across poles of
these changes of frame is presumed.

## Twisted square and endpoint bounds

In every odd characteristic,
\[
\mathcal Q^\sharp=E-4dq\,d(c/\tau)
=\operatorname{Tr}\frac{(dw-2w\,dq/\phi)^2}{\phi}
=\operatorname{Tr}\frac{d(w\phi^{p-2})^2}{\phi^{2p-3}}.
\]
It is independent of multiplying F by a nonzero base function, and
is invariant under every meromorphic source translation when s=0.
No affine scaling covariance is asserted for Qsharp. It is distinct
from Qaff and from the centered energy.

Suppose locally every source root is split in k[[u]] and q has exact
order (p+1)/2. Then Qsharp has pole order at most (p-3)/2, with no
condition on tau's order, the number of small roots or deg H.

In characteristic five Qsharp=E+dq d(c/tau). If also H is integral
with unit leading coefficient and tau has exact order three, then
\[
\widetilde{\mathcal Q}
=E-\frac{dq\,dc}{\tau}-\frac{c\,dq\,d\tau}{\tau^2}
=\mathcal Q^\sharp-\frac{2dq\,dc}{\tau}
\]
has at most a simple pole. Reading c instead as the W^3 coefficient
of H gives the same bound. In the degree-ten presentation above,
Qtilde has affine weight a^-3. As a reusable endpoint jet consequence,
write q=q3 u^3+O(u^4), tau=tau3 u^3+O(u^4), e0=H(0) mod u.
Exactly five roots are small; if w_i=u a_i+u^2 b_i+O(u^3), then
\[
e_0q_3+\tau_3=0,\qquad
\sum_i a_i^2=0,\qquad
\sum_i a_i b_i=-q_3c(0)/e_0.
\]
Repeated leading coefficients a_i are permitted.
A constant translation first removes q(0) whenever q-q(0) has
exact order three over an algebraically closed residue field.

Where q,H,tau are integral, tau is a unit and all source roots split
integrally, R is regular without requiring s to be a unit. On s=0,
E2 and I are integral if delta preserves the base ring and phi(w_i)
are units, and remain integral after meromorphic translations. Qaff
is regular under its integral coefficient and unit denominator
hypotheses. These are local statements; global pole bounds and the
unmarked common-cover problem remain separate. The degree-ten global
specialization is in [the global energy theorem](degree_ten_global_corrected_source_energy.md).

[Proof](../../Proofs/cartier_and_spin/source_quadratic_calculus.md).
