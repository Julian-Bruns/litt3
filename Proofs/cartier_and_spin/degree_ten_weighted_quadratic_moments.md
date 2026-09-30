# Keeping the small critical algebra instead of taking higher powers

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree_ten_weighted_quadratic_moments.md).
At a selected finite point translate by a constant to write its
small roots as w_i=c0+a_i r+b_i r2+O(r3). Their derivatives have
leading coefficients a_i. The universal weighted second moment
gives sum a_i2=0. Consequently the possible pole-three coefficient
of Jj is c0^j times this same zero sum. Each Jj has pole at most
two there, so t2 removes these poles.

At a root pole of order m>=1 in the regular finite frame, its
contribution to Jj has order at least(3-j)m-2. This is nonnegative
for j=0,1, and at least-1 for j=2. A pole of the last type lies
in h_*G, and v removes it. Integral roots with phi a unit cause
no poles. This retains the actual individual source roots.

At infinity let w_s denote the short frame, a=(B0-L0)/y, so
w=w_s+a, with ord(a)=-17 and ord(da)=-18. Define
\[
\mu_j=\operatorname{Tr}(w_s^j/\phi),\quad
\nu_j=\operatorname{Tr}(w_s^j dw_s/\phi),\quad
\xi_j=\operatorname{Tr}(w_s^j(dw_s)^2/\phi).
\]
The constant Frobenius remainder gives mu_j=0 for0<=j<=4.
Differentiating mu_(j+1)=0 gives
\[
\nu_j=\frac{df}{j+1}\operatorname{Tr}(w_s^{j+1}/\phi^2).
\]
For j=0,1,2 the known normalized moment bounds imply
ord(nu_j)>=7-2j. Direct split-root bounds give
ord(xi_j)>=4-2j: for j=0 the leading small-root square cancels;
for j=1,2 the small-root bounds are2,1 and the large-root bounds
are2,0 respectively. Expanding the finite-frame moment yields
\[
J_j=\sum_{k=0}^j\binom jk a^{j-k}\xi_k
 +2da\sum_{k=0}^j\binom jk a^{j-k}\nu_k.
\]
The term with (da)2 is zero because all relevant mu_k vanish.
The first sum has order at least4-17j, and the second at least
-11-17j. Therefore ord(Jj)>=-11-17j in general. Clearing the
finite supports and using div(omega0²)=32O gives61,78,105.

In the trace-zero sector nu0=E1=0 identically. For j>=1 the
second sum starts at k=1 and has order at least4-17j too; for
j=0 it vanishes. Thus the sharper infinity bounds are4-17j,
which give46,63,80+deg_O(v) as stated.

For the scale degree multiply the quadratic source-residue
differential by W^j. This multiplies neither its critical denominator
nor the order-four Frobenius pole. Its order at infinity is
O(W^(j+deg(S)+1-pm)), so the stated inequality removes an infinity
residue. The critical Artin algebra gives a numerator of degree
at most d-1; the Frobenius pole contributes at most floor(3/m)
in scale. Multiplication by Delta proves the claim, with nilpotents
of D retained exactly as in the unweighted proof.

Finally the residue functional on K[W]/D is
ell(h)=[W^(d-1)](h mod D)/lc(D). The pairing(h,g)->ell(hg)
is nondegenerate: in descending degree its matrix is triangular
along the anti-diagonal with nonzero diagonal entries. Hence
ell(h),ell(Wh),...,ell(W^(d-1)h) determine h. This remains true
for multiple roots, in contrast with a reduced-point trace alone.
It does not remove the distinct global normalization and pole
conditions at the zeros of disc(D).

In the explicit local cubic example of the centered-cubic theorem,
r=u3, w=u+O(u4), phi=1+O(u3). The unweighted quadratic trace is
regular, but
\[
J_1=\frac13 r^{-1}(dr)^2+\text{regular terms}.
\]
Thus already one extra weight detects this missed branch, with
the same scale-numerator bound as J0. No global exclusion is
deduced from this local example.
