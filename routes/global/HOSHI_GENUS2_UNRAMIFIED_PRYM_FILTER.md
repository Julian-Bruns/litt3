# The fifteen-class elliptic-Prym filter for the explicit genus-two quotient

**Status:** author proof and exact finite computation, 2026-09-05; not
independently audited. This computes only the auxiliary étale covers
\(B'/B\), not the genus-six twists \(X/B\).

For the [explicit quotient](HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL.md)

\[
 B:\quad v^2=F(t)=2t^6+2t^4+3t^2+4,
 \qquad f(B)=1,
\]

exactly **two** of its fifteen geometric nontrivial unramified quadratic
classes produce a p-rank-one cover \(B'\). With
\(\mathbf F_{25}=\mathbf F_5(r)\), \(r^2=3\), representatives are

\[
 \boxed{q_\pm(t)=t^2\pm rt+1,\qquad
         k(B'_\pm)=k(B)(\sqrt{q_\pm(t)}).}
\]

They are exchanged by arithmetic Frobenius \(r\mapsto-r\). All thirteen
remaining covers have p-rank two. The complete
[fifteen-case certificate](HOSHI_GENUS2_UNRAMIFIED_PRYM_FILTER_CERTIFICATE.py)
uses exact arithmetic and fifteen scalar Cartier tests.

## Why the quartic test computes the actual p-rank

The six distinct roots of \(F\), in a fixed order, are

\[
 4r,\quad3r+4,\quad3r+1,\quad2r+4,\quad2r+1,\quad r.
\]

For each pair \(i<j\), let \(q_{ij}=(t-r_i)(t-r_j)\) and
\(R_{ij}=\prod_{e\ne i,j}(t-r_e)\), so \(F=2q_{ij}R_{ij}\).
The normalized cover obtained by adjoining \(\sqrt{q_{ij}}\) is a
connected étale double cover of \(B\): all divisor orders of \(q_{ij}\)
on \(B\) are even, and it is not a square in \(k(B)\). The latter also
follows directly because neither \(q_{ij}\) nor \(q_{ij}/F\) is a square
in \(k(t)\). These fifteen classes are the fifteen nonzero elements of
\(J_B[2]\).

Its Klein-four presentation over \(\mathbf P^1_t\) has the other
quadratic quotients of genera zero and one, the latter represented by
\(e^2=2R_{ij}(t)\). The Jacobian decomposition has power-of-two isogeny
degree, so in characteristic five

\[
                      f(B'_{ij})=f(B)+f(e^2=R_{ij}).
\]

Multiplying the quartic by a nonzero constant does not affect this
geometric p-rank. For a squarefree quartic \(R\), its genus-one curve is
supersingular precisely when the coefficient of \(t^4\) in \(R^2\)
vanishes. Thus each cover is tested by one exact scalar.

The only zero scalars occur for pairs \((1,2)\) and \((3,4)\) in
zero-based indexing, giving \(q_-\) and \(q_+\), respectively. For
example, the complement of \(q_+\) is

\[
 R_+(t)=t^4-rt^3+3t^2+3rt+2,
 \qquad [t^4]R_+(t)^2=0.
\]

The second survivor is its Frobenius conjugate. No calculation of
\(f(X)\), no Tango test on a twist, and no étale-descent counterexample
is asserted by this filter alone.
