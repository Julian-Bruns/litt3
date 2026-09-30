# Actual small-degree marked incidence respects the cubic symmetry

Version1,30 September2026. Retain the fixed curve X and an actual
same-source tensor comparison h1,h2:T->X from
[actual norm self-comparison](actual_norm_self_comparison.md).
Let both maps have degree n and let M be their thirteen-by-thirteen
nonnegative marked incidence matrix. Its rows and columns have sum n.
Let G be the permutation matrix fixing O and sending R_j to R_(j+4).

If n<=788051, then
\[
MG=GM,
\qquad M_{\gamma a,\gamma b}=M_{a,b}.
\]
Thus the ENTIRE incidence matrix has simultaneous cubic symmetry,
not just its O-row and O-column. This conclusion also holds whenever
the comparison function is nonconstant and its degree delta<=50842,
because the accepted actual-map inequality gives 2n<=31delta.

There is a further rational linear restriction. Let F be the permutation
fixing O and sending R_j to R_(j+1), and put
\[
V_- =\ker(1+G+G^2)\subset\mathbf Q^{13}.
\]
Then M preserves V_-, commutes there with F, and
\[
M|_{V_-}\in\mathbf Q[F|_{V_-}]
 \simeq\mathbf Q[T]/(T^8+T^4+1).
\]
The remaining five-dimensional invariant block is not claimed to commute
with F. No assertion that a formal or combinatorial symmetry lifts to
an automorphism of T is made.

This is a new actual-map consequence of the established Jacobian and
marked-divisor inputs, requiring no new numerical calculation. It does
not give unrestricted norm invariance, field recognition, or an unmarked
common-cover decision.

[Proof](../../Proofs/cartier_and_spin/actual_marked_incidence_symmetry.md).
