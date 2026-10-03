# Low-genus Raynaud cosets and actual cover families

Version3, 3 October2026. The all-characteristic dimension theorem
replaces the older codimension-one cases. The genus-four Wronskian
and actual-cover arguments retain their earlier audits.

The [general dimension theorem](raynaud_rank_one_dimension.md)
excludes translated abelian divisors in Raynaud theta for every
hyperbolic curve, in every characteristic. The useful additional
small-genus assertion is the following. If \(g(C)=4\), \(p=5\) or
\(7\), and a two-dimensional abelian coset is contained in
\(\Theta_{B_C}\), its generic defect is exactly one. This includes
every translated inherited Jacobian direction on an étale triple
cover of a genus-two curve in characteristic five. Defect-one
exceptional translates are not excluded.

The section-independence inputs have a uniform form. On any
genus-\(G\ge2\) curve and for any degree-zero line \(N\), every pair
of independent global sections of \(B_C\otimes N\) is independent
over the curve's function field if \(p>G-1\). Every triple is
independent if \(p>3(G-1)/2\).

For the actual-cover application, let \(Y\) have genus two in
ANY characteristic \(p>0\), and let \(\pi:U\to Y\) be the identity
or a connected finite étale double cover. For every
\(L_0\in J(U^{(1)})\),
\[
\operatorname{generic}_{M\in J(Y^{(1)})}
h^0(U^{(1)},B_U\otimes L_0\otimes\pi^{(1)*}M)=0.
\tag{1}
\]
No ordinariness or torsion-order hypothesis is required.

Let \(V\to U\) be a connected abelian Galois étale cover and
\(W\to V\) a connected Galois étale cover with \(p\)-group.
There is no degree bound, and the abelian group may have a
\(p\)-primary part. Then
\[
\operatorname{generic}_{M\in J(Y^{(1)})}
h^0(W^{(1)},B_W\otimes(W\to Y)^{(1)*}M)=0.
\tag{2}
\]
Equivalently, (2) holds for a connected étale cover \(Z\to Y\)
whose ACTUAL Galois-closure group \(G\) has a normal \(p\)-subgroup
\(R\) such that \(G/R\) has an abelian subgroup of index at most
two. Neither cyclicity nor an inversion conjugation action is needed.

For every actual span \(X\leftarrow Z\rightarrow Y\) in this
monodromy class, the full mixed Raynaud family has generic defect
zero. Both original étale maps retain the same source \(Z\).
Joint minimality, corelessness, Hom-zero and a bound on \(a(Z)\)
are unnecessary. Properness of this family does not itself exclude
a common cover; the general mixed vanishing problem remains open.

[Proof](../../../Proofs/jacobians/theta_divisors/low_genus_raynaud_cosets.md).
