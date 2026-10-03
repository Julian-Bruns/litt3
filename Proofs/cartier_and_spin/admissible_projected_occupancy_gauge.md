# Proof of the principal marked-phase occupancy gauge

[Statement](../../Theorems/cartier_and_spin/admissible_projected_occupancy_gauge.md).
No calculation or new lattice enumeration is used. The exact marked
relation lattice and its minimum effective gauge are established inputs.

## Effective representatives of a fixed phase

If the finite triple coefficients are $(n_i,n_{i+4},n_{i+8})$, their
phase is $(n_i-n_{i+8},n_{i+4}-n_{i+8})=(a_i,b_i)$.
Every integral triple with this phase is a common shift of $(a_i,b_i,0)$.
Its least effective shift subtracts $\ell_i=\min(0,a_i,b_i)$.
Thus all effective triples are uniquely
$\beta_i+c_i(1,1,1)$ with $c_i\ge0$. Their maximum coefficient is
$m_i+c_i$, so the cap is equivalent to $0\le c_i\le q-m_i$.
The infinity coefficient is independently between zero and $q$.
The degree is exactly $S+3\sum c_i+c_\infty$.

The cap intervals are nonempty exactly when $q\ge M$.
Their integer sums fill every value
\[
0\le C=\sum_i c_i\le C_{\max}=4q-\sum_i m_i.
\]
This follows successively from the fact that sums of integer intervals
are integer intervals. For fixed $C$, the total degree fills
$[S+3C,S+3C+q]$. When $q\ge2$, consecutive such integer intervals
have no missing integer. Their union is
\[
[S,S+3C_{\max}+q]=[S,13q-A].
\]
Hence the three inequalities are exact. If $q=0$ or $1$, the same
union misses precisely residues larger than $q$ modulo three relative
to $S$; the stated residue condition restores sufficiency.

The inverse phase has normalized triple $m_i(1,1,1)-\beta_i$.
Consequently its effective gauge is $A$, while the forward gauge is
$S$. This also makes the forward/backward symmetry explicit.

## Least degree and actual-source scope

Write $n=5q+r$ with $0\le r\le4$. The three exact inequalities become
\[
q\ge M,\qquad
q\ge\left\lceil(S-r)/5\right\rceil,\qquad
q\ge\left\lceil(A+r)/8\right\rceil.
\]
Together with $q\ge2$, these give the stated exact minimum for each
residue and then for $n\ge10$.

The actual uniform norm theorem gives $h_*E=5B$ and the coefficient
bound $B_P\le\lfloor n/5\rfloor$ because the actual cover is
unramified over the marked points and $E$ is reduced. With its torsion
hypothesis, the all-degree principal upgrade gives $B\sim nO$.
The marked phase must therefore lie in the exact lattice $I$.
Conversely membership in $I$ certifies principality of the supported
degree-zero divisor only; it says nothing about a covering source,
selected sheets, $G$, a primitive equation or étaleness.

For nonzero $w\in I$ the established minimum is $N(w)\ge1,617,894$.
Since the least finite effective mass is $S=N(w)$ and the total degree
is at least $S$, a nonzero phase requires the displayed threshold.
The zero phase has all three coefficients equal in every finite fiber,
yielding the stated invariant support. No converse realization is used.
