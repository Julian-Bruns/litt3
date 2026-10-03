# Simultaneous section and Cartier-kernel growth on cyclic étale refinements

Version3, 3 October2026. The finite-family argument and actual
two-map pullback retain their bounded review. The Raynaud
specialization now holds in every characteristic and genus.

Work over \(k=\overline{\mathbf F}_p\). Let C be a smooth projective
connected curve and \(E_1,\ldots,E_s\) any finite collection of
vector bundles on C. Suppose that for each i the locus
\[
\{L\in J(C):H^0(C,E_i\otimes L)\ne0\}
\]
contains an irreducible positive-dimensional subvariety \(T_i\)
of an abelian subvariety \(A_i\subseteq J(C)\), and \(T_i\) is
contained in no translate of a proper abelian subvariety of \(A_i\).

For every finite prime set S there is a nested tower of connected
cyclic finite étale covers \(q_j:C_j\to C\), with degrees prime
to p and S, such that
\[
h^0(C_j,q_j^*E_i)\ge h^0(C,E_i)+j
\qquad(1\le i\le s).
\tag{1}
\]
The new degree factors can be chosen pairwise coprime. No stability,
degree or Euler-characteristic assumption on the \(E_i\) is needed.

If an actual finite étale leg \(g:Z\to C\) is specified, the degrees
can also avoid its prime divisors. Every actual fiber product
\(Z_j=Z\times_C C_j\) is then connected, and
\[
h^0(Z_j,q_{Z,j}^*g^*E_i)\ge h^0(Z,g^*E_i)+j.
\tag{2}
\]
Both composite endpoint maps of any actual bi-étale span through
g remain finite étale from this same source.

There also exist nontrivial tame torsion lines \(L_1,\ldots,L_s\)
of pairwise coprime exact orders such that
\[
H^0(C,E_i\otimes L_i)\ne0.
\]
Their direct sum is a rank-s bundle trivialized by a single
connected cyclic étale cover and passes all s section tests.
It is generally reducible. These constructions do not supply
a common cover of independently specified endpoint curves.

## Raynaud specialization

For a curve \(C\) of genus at least two put
\(B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}}\),
\(a(C)=h^0(C^{(1)},B_C)\), and
\(\Delta(C)=g(C)-f_p(C)\). Apply the preceding theorem to
\(B_C\) on \(C^{(1)}\), then pull its cyclic covers back by relative
Frobenius. Every irreducible component of \(\Theta_C\) is
positive-dimensional and generates the whole Jacobian up to
translation: the [dimension theorem](../theta_divisors/raynaud_rank_one_dimension.md)
excludes abelian divisor translates, and a component has dimension
\(g(C)-1\). Thus the geometric hypothesis holds for EVERY hyperbolic
curve over \(\overline{\mathbf F}_p\), for every prime p.
The resulting prime-avoiding cyclic covers satisfy
\[
a(C_j)\ge a(C)+j,\qquad \Delta(C_j)\ge a(C)+j.
\]

For an actual finite étale leg \(g:Z\to C\), choose the new degrees
coprime to \(\deg g\). Then \(Z_j=Z\times_C C_j\) is connected and
\(a(Z_j),\Delta(Z_j)\ge a(Z)+j\). Both maps of any original
bi-étale span remain finite étale from this same \(Z_j\).
The towers use infinitely many new primes and give no uniform
normalized defect bound or common-cover exclusion.

[Proof](../../../Proofs/jacobians/ordinary_covers/prime_avoiding_section_growth.md).
[Raynaud specialization proof](../../../Proofs/jacobians/ordinary_covers/prime_avoiding_cyclic_defect.md).
