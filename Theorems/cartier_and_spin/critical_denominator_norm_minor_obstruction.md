# Fixed quotient sections constrain the entire critical denominator

ID: `critical_denominator_norm_minor_obstruction`. Version1, 2 October2026.
Author proof; focused independent prose review PASS, recorded in
[the audit](../../Research/experiments/oct02_m9_uniform/NORM_MINOR_OBSTRUCTION_AUDIT.md).

Let $k$ be algebraically closed, let $x:C\to\mathbf P^1$ be a
finite separable map from a smooth connected projective curve, and put
$C_0=x^{-1}(\mathbf A^1)$ and $R=H^0(C_0,\mathcal O_C)$.
Let $V\subset R[T]_{<m}$ be an $r$-dimensional $k$-space, with
$1\le r\le m$, whose coefficient vectors have rank $r$ over $k(C)$.
Choose a constant basis and form its $m\times r$ coefficient matrix.
Let $D_V(x)$ be the monic gcd of the norms to $k(x)$ of its nonzero
$r\times r$ minors. This is a nonzero polynomial, independent of the
chosen constant basis up to the monic normalization.

Suppose $0\ne v(T)\in V$, $c\in k(C)$, and
$(T-c)v(T)\in R[T]$. Let $\delta_c\in k[x]$ be the monic generator
of the ideal of polynomials $J$ such that $Jc\in R$. Then
$\delta_c\mid D_V$.

The conclusion retains every denominator multiplicity, including at
ramified fibers of x. It requires no bound on the covering degree or
restriction on the characteristic, and no denominator root is inverted.
For $r=m$ a single norm of a determinant suffices. For $r<m$ the gcd
of the maximal-minor norms gives the same obstruction.

In particular, for any polynomial family of proposed minimum clearing
polynomials $\delta_\lambda$, a unit Bezout identity for the remainder
coefficients of $D_V$ modulo $\delta_\lambda$ excludes every geometric
parameter in that family. This is a necessary denominator test for an
actual factorization, not a construction of a source or a second map.

[Proof](../../Proofs/cartier_and_spin/critical_denominator_norm_minor_obstruction.md).
