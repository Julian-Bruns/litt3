# Low-genus Raynaud cosets and actual cover families

Version2. Independently audited, including the genus-four extension.

In characteristics two, three and five, the later
[abelian-component theorem](raynaud_abelian_components.md) now
proves the same codimension-one vanishing in every genus. The
results below retain the other characteristics and the stronger
genus-four codimension-two assertion, together with their cover
applications.

Let \(C\) be a smooth projective connected curve of genus two or
three over an algebraically closed field of odd characteristic.
Its Raynaud theta divisor \(\Theta_{B_C}\subset J(C^{(1)})\)
contains no translate of an abelian subvariety of codimension one.
The curve need not be ordinary. The same absence of translated
abelian divisors holds in genus four when the characteristic is
at least five. In genus two, restriction to every positive-dimensional
abelian coset is therefore proper.

There is a sharper genus-four conclusion in characteristics five
and seven. If a translate of a two-dimensional abelian subvariety
is contained in \(\Theta_{B_C}\), its generic cohomology dimension
is exactly one. No such translate has generic defect two or three.
This assertion does not require ordinariness or a specified covering
map. In particular it applies to every étale degree-three cover
of a genus-two curve in characteristic five, including every
translated inherited Jacobian direction. It does not prove that
these defect-one exceptional translates are absent.

This gives a uniform consequence for actual covers of genus-two
curves. Let \(Y\) have genus two, and let
\(\pi:U\to Y\) be either the identity or a connected finite étale
double cover. For every \(L_0\in J(U^{(1)})\),
\[
\operatorname{generic}_{M\in J(Y^{(1)})}
h^0(U^{(1)},B_U\otimes L_0\otimes\pi^{(1)*}M)=0.
\tag{1}
\]
There are no exceptional torsion orders in (1).

Let \(V\to U\) be any connected abelian Galois étale cover,
and let \(W\to V\) be a connected Galois étale cover with
\(p\)-group Galois group. Neither group has a degree bound.
Then the inherited \(Y\)-direction is proper on \(W\):
\[
\operatorname{generic}_{M\in J(Y^{(1)})}
h^0(W^{(1)},B_W\otimes (W\to Y)^{(1)*}M)=0.
\tag{2}
\]
The abelian group is allowed to have a \(p\)-primary part.

Equivalently, (2) holds for a connected étale cover \(Z\to Y\)
whose actual Galois-closure group \(G\) has a normal \(p\)-subgroup
\(R\) such that \(G/R\) has an abelian subgroup of index at most
two. The abelian subgroup need not be cyclic, and the quotient's
conjugation action need not be inversion.

In particular, for every actual span \(X\leftarrow Z\rightarrow Y\)
in this monodromy class, the full mixed Raynaud family has generic
defect zero. This uses neither joint minimality, corelessness,
\(\operatorname{Hom}(JX,JY)=0\), a bound on \(a(Z)\), nor
ordinariness of either endpoint. The two original maps still
have the same \(Z\). It applies to both candidate pairs.

Properness of this cohomology family does not itself exclude a
common cover. Groups outside the displayed monodromy class and
the general mixed vanishing question remain unresolved.

[Proof](../../../Proofs/jacobians/theta_divisors/low_genus_raynaud_cosets.md).
