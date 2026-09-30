# Weighted residues determine the center

30 September2026.
[Statement](../../Theorems/cartier_and_spin/frobenius_remainder_centered_energy.md).
This proof is symbolic and independent of the source degree.

## The two moment families

Differentiation in W gives F_W=(W^p+q)H_W. Since F is separable and
tau!=0, phi is invertible in B. The source residues of
\[
\frac{W^jH_W}{F}\,dW
\]
sum to Tr(w^j/phi). For 0<=j<p its numerator has degree at most
N-p-1+j<=N-2, so its residue at infinity is zero. There are no other
finite poles. This proves the first family, including the cases
where the derivative has smaller degree.

For the second family use
\[
\frac{W^jH_W}{F(W^p+q)}\,dW.
\]
It again has zero residue at infinity for 0<=j<p. After purely
inseparable scalar extension, let z^p=-q. At the only additional
pole z, reducing the numerator and denominator modulo W^p+q replaces
H_W by the derivative of S=sum s_jW^j and F by tau. Its residue is
therefore tau^-1 times the coefficient of (W-z)^(p-1) in W^jS_W.

The degree of this polynomial is at most 2p-3. Terms W^m with
p<=m<=2p-3 have zero (p-1)-st Taylor coefficient: writing
W^m=W^p W^(m-p), the Frobenius factor has only constant and degree-p
terms at z. Only its W^(p-1) coefficient matters. For j=0 this is
zero; for 1<=j<p it is (p-j)s_(p-j)=-j s_(p-j). The source trace
is the negative of the extra residue, proving the formulas. The
identity descends to K since all displayed coefficients lie in K.

Trace commutes with differentiation for a finite separable algebra.
Because d(phi)=dq, differentiation of the j=1,2 first moments gives
\[
\operatorname{Tr}(dw/\phi)=s\,dq/\tau,
\qquad
\operatorname{Tr}(w\,dw/\phi)=c\,dq/\tau.
\]
Only division by two is used here.

## Centering kills both affine cross terms

Set r=c/s and u=w-r. The first moment family implies
Tr(u/phi)=Tr(u^2/phi)=0. The second family gives
\[
\operatorname{Tr}(u^2/\phi^2)
=2(c-rs)/\tau=0.
\]
Differentiating Tr(u^2/phi)=0 now yields Tr(u du/phi)=0. Expansion
of (dw-dr)^2 proves the displayed formula for E_c, since
Tr(1/phi)=0 and Tr(dw/phi)=s dq/tau.

Under the specified affine change,
\[
q'=a^p q-b^p,\quad \tau'=a^N\tau,
\quad H'(W')=a^{N-p}H((W'-b)/a).
\]
Polynomial division commutes with this substitution. Consequently
\[
s'=a^{N-2p+1}s,
\quad c'=a^{N-2p+1}(a c+b s).
\]
The second formula uses -(p-1)=1 in the base field. Thus r'=ar+b,
u'=au and phi'=a^p phi. The identity
\[
\operatorname{Tr}\frac{d(au)^2}{a^p\phi}
=a^{2-p}\operatorname{Tr}\frac{du^2}{\phi}
\]
follows by expanding and using Tr(u du/phi)=Tr(u^2/phi)=0.
Multiplying by s' gives the claimed weight N-3p+3 for R_F.

## The coefficient boundary and integral roots

The cleared formula divides only by tau, not by s. The covariance
identity consequently remains valid at s=0 as an identity of rational
differentials, or after any specialization where F stays separable
and tau stays nonzero. If s is identically zero on the base curve,
then ds=0 as well and R_F is zero. This is why the construction does
not supersede the distinct invariant on the trace-zero boundary.

At a point in the regularity assertion, phi(w_i) is a unit for every
split integral root: reducing F(w_i)=0 would otherwise contradict
that tau is a unit. Each summand dw_i^2/phi(w_i) and every coefficient
in the cleared correction is therefore regular. This proof retains
the actual split source roots and introduces no inverse critical
discriminant. It makes no claim at the missing nonunit or pole loci.
