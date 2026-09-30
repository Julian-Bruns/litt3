# Source differential moments have small scale numerators

Version2,30 September2026. Let K be a one-variable function field of odd
characteristic p, with a nonzero derivation delta, and let lambda be
a constant indeterminate. Put
\[
\phi=W^p+q,\quad
F_\lambda=\lambda v\phi^m+\phi S+\tau,
\quad m\ge2,\quad \deg S\le p-1,
\]
where v,tau are nonzero in K and D=S_W is nonzero of degree d.
Assume gcd(D,phi)=1. Let
\[
\Delta(\lambda)=\operatorname{Res}_W(F_\lambda,D).
\]
It is a nonzero polynomial of degree d in lambda. On the separable
source algebra B_lambda=K(lambda)[W]/(F_lambda), write
\[
E_2(\lambda)=\operatorname{Tr}_{B_\lambda/K(\lambda)}
\frac{(\delta w)^2}{\phi(w)}.
\]
Then
\[
\Delta(\lambda)E_2(\lambda)\in K[\lambda],\qquad
\deg_\lambda(\Delta E_2)\le
\begin{cases}d+1,&m=2,3,\\d,&m\ge4.\end{cases}
\]
The assertion includes multiple roots of D, without inverting its
discriminant. A correction to E2 which is independent of lambda obeys
the same numerator bound after multiplication by Delta.

More generally, for 1<=r<=p define
\[
E_r(\lambda)=\operatorname{Tr}((\delta w)^r/\phi(w)).
\]
Then
\[
\Delta^{r-1}E_r\in K[\lambda],\qquad
\deg_\lambda(\Delta^{r-1}E_r)
 \le (r-1)d+\left\lfloor\frac{2r-1}{m}\right\rfloor.
\]
In characteristic five with m=2 and d=2, the cubic and quartic
moments have numerator degrees at most six and nine respectively.
They are distinct necessary tests; regularity of the quadratic
moment alone need not detect tame cubic ramification.

In characteristic five and degree ten, the resulting numerator has
degree at most three for a quadratic derivative, and at most four
for a cubic derivative. This applies before choosing a residual-degree
stratum. In particular the corrected quadratic energy for the
[uniform degree-ten condition](degree_ten_global_corrected_source_energy.md)
has a cubic scale numerator.

The assertion is an exact calculation bound, not the vanishing of
that numerator or a decision of its coefficient locus. Actual etaleness
still supplies the separate global regularity and pole restrictions.

[Proof](../../Proofs/cartier_and_spin/source_energy_small_scale_numerator.md).
