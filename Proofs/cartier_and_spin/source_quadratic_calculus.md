# One residue calculus for the source quadratic energies

30 September2026.
[Statement](../../Theorems/cartier_and_spin/source_quadratic_calculus.md).
This consolidates the low weighted moments, translation invariants,
affine correction, remainder center, twisted square and split cubic
endpoint calculation. All arguments are symbolic.

## Two moment families

F_W=phi H_W, and phi is invertible in B since F=tau modulo phi.
At each simple source root the residue of W^j H_W/F dW is w^j/phi.
For 0<=j<p its numerator has degree at most N-p-1+j<=N-2, so it
has zero residue at infinity and no other finite poles. This proves
Tr(w^j/phi)=0.

For the second family use W^j H_W/(F phi) dW, again with zero
residue at infinity. After purely inseparable scalar extension let
z^p=-q. At the only extra pole z, the polar part reduces modulo phi
to W^j S_W/(tau (W-z)^p) dW, where S=sum s_jW^j. Its residue is
the (p-1)-st Taylor coefficient of W^j S_W divided by tau. Terms
W^m with p<=m<=2p-3 have zero such coefficient: W^p contributes
only constant and degree-p terms around z, and m-p<=p-3. Thus only
the W^(p-1) coefficient contributes. It is zero for j=0 and
(p-j)s_(p-j)=-j s_(p-j) otherwise. Residue reciprocity gives the
second family, which descends to K.

Trace commutes with differentiation in a finite separable algebra,
and dphi=dq. Differentiating the first-family identities for j=1,2
therefore gives Tr(dw/phi)=s dq/tau and Tr(w dw/phi)=c dq/tau.
Only division by two is used.

## Centering and translation

For r=c/s and z=w-r the moments give
\[
\operatorname{Tr}(z/\phi)=\operatorname{Tr}(z^2/\phi)=0,
\qquad \operatorname{Tr}(z^2/\phi^2)=2(c-rs)/\tau=0.
\]
Differentiating the second vanishing first-family moment gives
Tr(z dz/phi)=0. Expansion of (dw-dr)^2 proves the stated E_c.
Under F'(W')=a^N F((W'-b)/a), polynomial division gives
\[
q'=a^p q-b^p,\quad \tau'=a^N\tau,\quad
s'=a^{N-2p+1}s,\quad c'=a^{N-2p+1}(ac+bs).
\]
Hence r'=ar+b and z'=az. Expanding d(az)^2/(a^p phi) and using
Tr(z dz/phi)=Tr(z^2/phi)=0 proves E_c's covariance; multiplication
by s' gives R's weight. The cleared formula extends across s=0.
If s is identically zero, ds=0 as well, so R is zero there.

On that boundary E0=E1=0. The binomial translation law is immediate
from delta(w+b)=delta(w)+delta(b), since phi is unchanged. Writing
h=delta(b),
\[
E'_2=E_2,\quad E'_3=E_3+3hE_2,\quad
E'_4=E_4+4hE_3+6h^2E_2.
\]
Substitution cancels both h and h^2 in 3E2E4-2E3^2. In
characteristic five it equals 3(E2E4+E3^2). This argument also
applies over an arbitrary differential field under the displayed
source hypotheses; no one-variable geometry is needed for it.

## The affine correction keeps its equation normalization

In the degree-2p presentation s=0 and c'=a^2c. Expansion of
dw'=a dw+w da+db, using Tr(w^j/phi)=0 for j<=2 and
Tr(dw/phi)=0, leaves exactly
\[
E'=a^{2-p}E+2a^{1-p}c\,da\,dq/\tau.
\]
Since dq'=a^p dq and tau'=a^(2p)tau,
\[
\frac{dq'\,dc'}{\tau'}
=a^{2-p}\frac{dq\,dc}{\tau}
+2a^{1-p}c\,da\,dq/\tau.
\]
Subtraction proves Qaff's weight, including c=0. Its correction
depends on the stated normalization of the equation: multiplying F
by g changes dc/tau to dc/tau+c dg/(g tau). This is why the
twisted correction below must not be identified with Qaff.

## The twisted correction is a square

Differentiate Tr(w^2/phi^2)=2c/tau and divide by two:
\[
d(c/\tau)=\operatorname{Tr}(w\,dw/\phi^2)
-dq\operatorname{Tr}(w^2/\phi^3).
\]
Multiplication by -4dq supplies precisely the cross and last terms
in (dw-2w dq/phi)^2/phi. The second square form follows from
p-2=-2 in K. Multiplying F by g multiplies c and tau by g, so
Qsharp is equation-scale independent. When s=0, translations keep
c,tau,dq and E unchanged, proving its translation invariance.

For the local bound put e=(p+1)/2. A unit root contributes regularly.
A small integral root has ord(w)>=1 and ord(phi)=e, since e<p.
Thus w phi^(p-2) has order at least
\[
1+e(p-2)=p(p-1)/2.
\]
This integer is divisible by p, so differentiation cannot lower
this lower bound: the possible first term differentiates to zero.
Its squared differential divided by phi^(2p-3) has order at least
p(p-1)-e(2p-3)=(3-p)/2. Each summand satisfies the bound separately;
neither tau nor a critical-root count enters the argument.

## The older cubic correction and its useful endpoint jets

For p=5, Qtilde=Qsharp-2dq dc/tau. If H is integral and tau has
order three, the additional term has order at least 2+0-3=-1.
This proves the older simple-pole bound directly from the square.
Replacing c by the W^3 coefficient of H changes it by a multiple
of q, of order at least three; its differential has order at least
two, so both changed correction terms are regular. In the degree-ten
trace-zero presentation the first two terms have Qaff's weight,
and c dq dtau/tau^2 has weight a^-3 because d(a^10)=0.

To retain the coefficient information, let e0=H(0) mod u. If e0=0,
the reduction of F is divisible by W^6, so at least six split roots
are small. A unit leading coefficient then forces ord(F(0))>=6,
whereas F(0)=qH(0)+tau has order three. Hence e0!=0 and exactly
five roots are small. Their product forces e0q3+tau3=0. Unit roots
contribute regularly to both moment families. For small roots
w_i=u a_i+u^2 b_i+O(u^3), the order-minus-one coefficient of
Tr(w^2/phi)=0 gives sum a_i^2=0. Writing
q=q3 u^3+q4 u^4+O(u^5), the order-minus-three coefficient of
Tr(w^2/phi^2) is
2 sum a_i b_i/q3^2-2q4 sum a_i^2/q3^3. The q4 term vanishes
by the first identity. Comparing with 2c/tau gives
\[
2\sum_i a_i b_i/q_3^2=2c(0)/\tau_3,
\quad \sum_i a_i b_i=-q_3c(0)/e_0.
\]
This reuses the coefficient calculus instead of a separate Newton-sum
proof, and requires no distinctness of the a_i.

Finally, at the integral points with tau a unit, phi(w_i) is a unit:
otherwise reducing F(w_i)=0 contradicts tau!=0 in the residue field.
All asserted integral expressions then follow term by term, with
the indicated coefficient correction integral. Invariance transfers
E2 and I across meromorphic translations; the individual translated
E3,E4 need not be integral. No global pole bound for I or negative-
degree vanishing is inferred. Fixed-endpoint and infinity residues
still belong in global source-to-critical computations.

Focused review retained the order-p auxiliary pole, arbitrary source
degree, coefficient boundary s=0 and the two different equation
normalizations. No simultaneous Galois closure or separable surrogate
for either finite etale endpoint map is used.
