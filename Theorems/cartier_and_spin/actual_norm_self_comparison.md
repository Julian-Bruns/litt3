# Actual self-comparisons constrain both marked norm profiles

Version1,29 September2026. Accepted incoming Pro result; its programs were
not replayed during integration, following the user's instruction.
Use the fixed genus-nine curve, its thirteen marked points
R={O,R0,...,R11}, and tensor tau with divisor16R. Let h1,h2:T->X
be actual finite etale maps of degree n from the SAME smooth projective
curve, with proportional tensor pullbacks and distinct embedded endpoint
fields. Let r:T->T0 be their common factor, of degree d, so T0 is jointly
minimal. The comparison function z has
div(z)=h2*O-h1*O. Put delta=deg(z)>0.

Let M_ab count points t with h1(t)=Ra and h2(t)=Rb; every row and
column has sum n. Its O-column and O-row have O-entry n-delta and
twelve finite entries m_(i,j), i=1,2. For each i define
S_i=(n-delta)^2+sum_j m_(i,j)^2. Then
\[
0<n^2-S_i,\qquad 2\mid(n^2-S_i),\qquad
31S_i\le29n^2+2nd.
\]
The full report retains additional nonnegative ramification terms.
Since d divides the gcd G of all entries of M, the observable necessary
inequality31S_i<=29n^2+2nG also holds.

These inequalities arise from ACTUAL self-comparisons. Remove the common
factor locus from T x_(hi,X,hi) T. Every remaining connected component
has two actual etale X-maps, tensor scalar1 and a nonconstant comparison
function. Their aggregate endpoint matrices are
\[
Q_1=M^tM-ndI,\qquad Q_2=MM^t-ndI,
\]
their aggregate endpoint degree is n(n-d), and their aggregate comparison
degree is n^2-S_i. No simultaneous Galois closure is used.

When d=1, the normalization of the image of (hi,z):T->X x P1 is T.
Its singularity length is (n-1)delta. After subtracting the transverse
contacts forced by the zero and pole fibres of z, the remaining contact
length E_i satisfies
\[
2E_i=n^2-S_i,\qquad E_i\ge n(n-1)/31.
\]
Thus concentration has an actual branch-contact interpretation.

This excludes some infinite families of abstract marked incidence
matrices, but not all noninvariant norm profiles. Norm invariance and the
unmarked common-cover problem remain open.

[Proof and incoming evidence](../../Proofs/cartier_and_spin/actual_norm_self_comparison.md).
