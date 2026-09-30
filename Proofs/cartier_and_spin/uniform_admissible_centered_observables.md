# Weighted moments bound both branches without a degree cutoff

30 September2026.
[Statement](../../Theorems/cartier_and_spin/uniform_admissible_centered_observables.md).
Let E1=Tr(db/phi). The general remainder identities give
\[
\operatorname{Tr}(1/\phi)=\operatorname{Tr}(1/\phi^2)=0,
\quad E_1=df\,z,
\quad z=s_4/\tau,\quad c=s_3/\tau.
\]
Under a base translation b'=b+a, phi is unchanged and
\[
z'=z,\qquad c'=c+az,\qquad E_2'=E_2+2\,da\,df\,z.
\]
Substitution shows that R'=R. Equivalently, this is the cleared
centered energy divided by tau. It introduces no inverse of s4.

## Finite points outside the selected zeros

Use a regular primitive frame w,q as in the all-degree energy proof.
If w is integral and phi is a unit, every trace summand and its
differential is regular. If w has pole m>=1, q is regular and phi
has pole5m. The summands w/phi^2 and w^2/phi^2 then have orders
9m and8m, while dw^2/phi has order at least3m-2>=1. Again the
traces are regular. Translation invariance permits these local
frames without creating poles in z or R.

## The two negative coefficients of the first moment

At a finite selected base point take a parameter r and translate so
q=q3 r^3+O(r^4), q3!=0. For the source roots reducing to zero write
\[
w_i=a_i r+b_i r^2+c_i r^3+O(r^4).
\]
All other source roots contribute regular terms to the moments
Tr(w/phi) and Tr(w^2/phi), even if they are poles. The coefficient
of r^-2 in Tr(w/phi)=0 forces sum a_i=0. Its r^-1 coefficient then
forces sum b_i=0. Likewise the r^-1 coefficient of Tr(w^2/phi)=0
forces sum a_i^2=0.

For phi=q+w_i^5, these three cancellations imply
\[
\operatorname{ord}(z)\ge-3,\qquad
\operatorname{ord}(c)\ge-3,\qquad
\operatorname{ord}(E_2)\ge-2.
\]
For z, the only potentially lower orders are r^-5 sum a_i and
r^-4 sum b_i; for c the potentially lower r^-4 term is a multiple
of sum a_i^2. Contributions from w_i^5/q start two orders later
and do not change these conclusions. The same last sum removes
the possible r^-3 term of E2.

If z and c both have poles at most three, their Wronskian
z dc-c dz has pole at most six: the putative order-minus-seven
coefficient cancels identically. Since df has order two here,
\[
\operatorname{ord}(\mathcal R)\ge-5.
\]
Therefore A^3 removes every finite pole of z, and A^5 removes every
finite pole of R. This proof does not bound or enumerate the number
of roots in a selected cluster.

## Infinity

Use the short frame with q=q_-7 u^-7+O(u^-6). Selected roots have
pole at most one; write them as w_i=a_i u^-1+b_i+O(u). All other
roots have pole m>=2. In Tr(w/phi)=0, the coefficients at u^6
and u^7 imply sum a_i=sum b_i=0, because the large roots start
at order eight. In Tr(w^2/phi)=0, the coefficient at u^5 implies
sum a_i^2=0, because the large roots start at order six.

The same expansions now give
\[
\operatorname{ord}_O(z)\ge15,\qquad
\operatorname{ord}_O(c)\ge13,\qquad
\operatorname{ord}_O(E_2)\ge4.
\]
Indeed the small-root contributions to z start at orders13 and14
with the two vanishing sums; to c at order12 with sum a_i^2; and
to E2 at order3 with that same sum. Large roots contribute to z,c
from orders18,16, and to E2 from order4.

As ord(df)=-8, the definition of R gives ord_O(R)>=19: both
z E2 and df(z dc-c dz) have at least this order. Since A has pole
twelve, A^3 z has pole at most21, and A^5 R has pole at most41.
The finite analysis proves the global assertions. Finally
div(omega0^2)=32O converts the second pole bound to L(73O). The
displayed monomial bases follow from pole(x)=3 and pole(y)=10.

There is no theorem here that either observable separates actual
covers or forces the quartic coefficient to vanish. In particular,
bounded target dimension does not bound the degree of a source.
