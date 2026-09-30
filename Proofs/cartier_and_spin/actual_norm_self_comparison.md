# Proof: use the actual off-diagonal fibre products

[Statement](../../Theorems/cartier_and_spin/actual_norm_self_comparison.md).
The accepted full proof is in sections52--57 of the
[incoming report](../../../litt3-computation-data/september29_evening_replies/marked_norm/marked_norm_analysis/REPORT.md).
Sections2,14--17 establish its common-factor, primitivity and comparison
ramification inputs. The archive's reported exact outputs are accepted;
no verification replay is claimed here.

The maps T->T0 and T0->X are etale because either composite to X is
etale. Inside T x_X T the locus T x_T0 T is open and closed. Removing
it therefore retains smooth proper components etale over each copy of T.
The comparison on the remainder is z(q)/z(p), or its reciprocal for
the other projection. If it were constant on a component, proportional
theta recognition would make its two endpoint maps differ by a cubic
automorphism. The tensor scalar is1, forcing that automorphism to be
the identity. Joint minimality then puts the component in the deleted
locus. Thus every remaining comparison is nonconstant.

Counting the two intermediate marked labels gives M^tM or MM^t.
The deleted common-factor locus contributes exactly nd to each diagonal
entry. Each row sum is n(n-d). The O-diagonal of the resulting matrix
is S_i-nd, so subtracting it from the row sum gives n^2-S_i for the
comparison degree. It is positive. Its parity follows from the symmetric
matrix, or directly from n^2-S_i modulo2 and the profile sum n.

For every actual component the incoming all-degree overlap theorem is
2N+N3+5H<=31Delta with N3,H nonnegative. Sum this inequality over the
components, substitute N=n(n-d) and Delta=n^2-S_i, and rearrange.
The entries of the original incidence matrix are d times those on T0,
which proves d|G and the observable weakening.

For the contact interpretation, the jointly minimal image of (hi,z) has
bidegrees n,delta. Adjunction on X x P1 gives arithmetic genus
n*delta+8n-delta+1; normalization T has genus8n+1. Hence its total
singularity length is (n-1)delta. Each branch is smooth since hi is etale.
The zero/pole fibres force
binom(delta,2)+sum_j binom(m_(i,j),2) transverse pair contacts.
Their excess and all contacts elsewhere have total E_i. Subtraction
gives2E_i=2n*delta-delta^2-sum m_(i,j)^2=n^2-S_i. This proves the
displayed contact bound without replacing the original maps by abstract
divisor data.

The report's positive matrix relaxation at small concentration still
passes these constraints. Consequently these results are not a proof of
norm invariance, much less existence or nonexistence of an unmarked span.
