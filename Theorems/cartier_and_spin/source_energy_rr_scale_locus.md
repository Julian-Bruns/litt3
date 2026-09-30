# Exact Riemann--Roch matrix for a scale-energy test

30 September2026. Let k be algebraically closed, X a smooth proper
curve with K=k(X), and let U be an r-dimensional k-space of rational
quadratic differentials on X. Suppose a rational family of such
differentials has the form
\[
Q_\lambda=P(\lambda)/\Delta(\lambda),
\quad P\in\Omega_K^{\otimes2}[\lambda],\quad
\Delta\in K[\lambda],\quad\deg\Delta\le d,\quad\deg P\le d+1.
\]
For any fixed coefficient specialization and scales with
Delta(lambda)!=0 in K, the condition Q_lambda in U is an exact
polynomial determinantal condition of bounded scale degree.

Choose a basis u1,...,ur of U and a finite-dimensional k-space W
containing all coefficients of P and all Delta_j*u_i. In a basis
of W form the matrix
\[
\mathsf M(\lambda)=
[\Delta(\lambda)u_1\ \cdots\ \Delta(\lambda)u_r\ P(\lambda)].
\]
Its first r columns have rank r at every allowed scale. Consequently
Q_lambda lies in U if and only if all (r+1)-minors vanish. Each
minor has degree at most dr+d+1. If one of them is nonzero, the
allowed geometric scale set is finite with at most dr+d+1 points.
The same bound holds for the scheme length on that allowed open.

One may compute its ideal using univariate polynomial row and column
operations instead of expanding all minors. After Smith reduction
of the first r columns, the last dim(W)-r coordinates of the
transformed P generate the membership ideal, localized away from
the Smith diagonal zeros. Those discarded scales are exactly where
Delta(lambda) is the zero function; they are not discriminant-of-D
or source-coefficient pivot assumptions.

For degree-ten trace-zero source energies, d=2 and the fixed global
space has dimension28. This supplies an exact degree-at-most59
scale test before any residual-degree stratification. It is a new
way to compute that NECESSARY energy locus; it does not assert the
locus is finite without a nonzero minor, empty, or sufficient for
an actual etale source. The smaller degree140 bounds and exclusions
already proved are not weakened by this generic algorithmic bound.

[Proof](../../Proofs/cartier_and_spin/source_energy_rr_scale_locus.md).
