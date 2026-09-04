# Linear algebra on the clean repeated branch

## Status

`proved-text`.  This note fixes the coefficient algebra and determinant
normalization used by the repeated-layer certificates.

## The étale cubic algebra

Work over \(k=\overline{\mathbb F}_5\), and fix a geometric point of the
old-data parameter space on which the repeated tangent cubic \(h(t)\) has
nonzero discriminant.  Put

\[
 A=k[t]/(h(t)),\qquad s=t\bmod h.
\]

Then \(A\simeq k^3\), and \(1,s,s^2\) is a \(k\)-basis.  A response at the
three repeated branches is therefore an element of \(A\), or equivalently a
three-component column.  For \(a,b,c\in A\), write

\[
 [a,b,c]=\det_k(a,b,c)
\]

for the determinant of their coordinate columns in the basis
\(1,s,s^2\).

If the original residual matrix is written instead in the three
branch-evaluation coordinates, its determinant differs from this one by the
nonzero Vandermonde determinant of the three distinct roots of \(h\).
Therefore determinant nonvanishing and every ratio identity used below are
unchanged by the choice of coordinates.

## Common-unit normalization

Suppose \(p\in A^\times\) is the common response column and write
\(a=pU_a\), \(b=pU_b\), and \(c=pU_c\).  Multiplication by \(p\) is a
\(k\)-linear automorphism \(m_p:A\to A\), so

\[
 [a,b,c]
 =\det(m_p)[U_a,U_b,U_c]
 =N_{A/k}(p)[U_a,U_b,U_c].
\]

In particular, the common factor is the nonzero scalar \(N_{A/k}(p)\).
It is not \(p^3\) unless \(p\in k\).  Consequently, if two determinants are
obtained from triples normalized by the same \(p\), any identity between the
normalized determinants gives the same identity between the original
determinants.

This is the only normalization principle needed in files `83`, `92`, `96`,
and `104`.
