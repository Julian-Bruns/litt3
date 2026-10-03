# Exact coefficient occupancy for a principal marked phase

Version1, 1 October2026. On the fixed marked genus-nine curve, write the
twelve finite marked points as four triples
$(R_i,R_{i+4},R_{i+8})$, $0\le i<4$, and retain $O$.
Let $I\subset\mathbf Z^8$ be the exact principal relation lattice of
[the marked-divisor theorem](marked_divisor_relation_lattice.md).
For a phase $w=(a_i,b_i)_{i=0}^3\in I$ put
\[
\beta_i=(a_i-\ell_i,b_i-\ell_i,-\ell_i),\quad
\ell_i=\min(0,a_i,b_i),\quad m_i=\max\beta_i,
\]
\[
S=\sum_i\sum_k\beta_{ik},\qquad
A=\sum_i\left(3m_i-\sum_k\beta_{ik}\right),\qquad M=\max_i m_i.
\]
Thus $S=N(w)$ and $A=N(-w)$ for the exact effective gauge.

Fix $n\ge10$ and $q=\lfloor n/5\rfloor$. There is an effective divisor
$B$ of degree $n$, supported on the thirteen marked points, with phase
$w$ and every coefficient at most $q$, if and only if
\[
q\ge M,\qquad S\le n,\qquad A\le13q-n.
\]
All such divisors, with no duplicates, have finite triples
$\beta_i+c_i(1,1,1)$ and infinity coefficient $c_\infty$, where
\[
0\le c_i\le q-m_i,\quad 0\le c_\infty\le q,\qquad
n=S+3\sum_i c_i+c_\infty.
\]
Because $w\in I$, every divisor in this coefficient description
satisfies $B\sim nO$. The description decides only coefficient
occupancy and principality, not actual source realization.

For a fixed phase its least permitted $n\ge10$ is exactly
\[
\min_{0\le r\le4}
\left[5\max\left\{2,M,
\left\lceil\frac{S-r}{5}\right\rceil,
\left\lceil\frac{A+r}{8}\right\rceil\right\}+r\right].
\]
For $q<2$, the three inequalities are necessary, and additionally the
least nonnegative residue of $n-S$ modulo three must be at most $q$;
these four conditions are necessary and sufficient.

Every actual admissible source with $5(E-G-4h^*O)\sim0$ supplies such
a phase through $h_*E=5B$, by the
[all-degree principal norm theorem](uniform_admissible_norm.md).
In particular a nonzero phase requires $n\ge1,617,894$.
Below that threshold all finite occupancies are equal in each complete
cubic fiber:
\[
B=c_\infty O+\sum_{i=0}^3c_i(R_i+R_{i+4}+R_{i+8}),\qquad
n=c_\infty+3\sum_i c_i.
\]
The coefficient cap and the actual admissible divisor conditions still
apply. This is a necessary presieve for one actual map; it does not
produce either map of an unmarked common cover.

[Proof](../../Proofs/cartier_and_spin/admissible_projected_occupancy_gauge.md).
