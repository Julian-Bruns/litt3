# Complete exclusion of the multiphase quartic endpoint determinant

Version1, 27 September2026. Work with the specified coefficient fields
K=F_(5^14), F=F_(5^56), eta=[22], beta^2=beta+3, and
bar(x)=x^(5^7) on K. Let alpha satisfy
alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0, and let zeta be the
specified primitive29th root with polynomial (4,22,7,20,21,7,24,1)
over F25. Ascending rows c=(22,7,9,23), e=(1,3,8,15) define
\[
C_{i,j}=c(\alpha^{25^i})\zeta^{5j},\qquad
E_{i,j}=e(\alpha^{25^i})\zeta^{8j}.
\]
Let Q,H be independently chosen multisets of four labels in
Z/4 times Z/29. Repetitions and shared labels are allowed. Suppose
each multiset uses at least two phases and neither is invariant under
(i,j)->(i+2,j). Write C_Q,E_Q,C_H,E_H for their unaveraged sums.

There are no x,y in K satisfying
\[
(E_Q/\eta-\bar x)(E_H/\eta-x)
 -(C_Q/\eta-y)(C_H/\eta-\bar y)=0.
\]
In particular there are no such moments and nonzero epsilon in F
satisfying both original equations
\[
\epsilon(E_Q-\eta\bar x)=C_H-\eta\bar y,
\qquad
\epsilon(C_Q-\eta y)=E_H-\eta x.
\]
The exclusion does not use an orientation of epsilon, integer pole
weights, a covering-degree bound, or either additional fourth trace.
It closes the entire requested oriented coefficient system, including
all vanishing scalar-coordinate and affine-rank boundaries.

The proof includes a complete exact endpoint computation, not a
purely theoretical argument:38,805,460,512 orbit-pair tests in the
generic sieve and9,740,288 tests covering the singular norm boundary.
The independent replay scope is recorded separately from those totals.
No assertion extracting a tensor from an unmarked common cover is made.

[Proof and verification](../../Proofs/cartier_and_spin/quartic_endpoint_moment_exclusion.md).
