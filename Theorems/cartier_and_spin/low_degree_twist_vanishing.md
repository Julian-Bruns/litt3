# Quadratic, cubic and quartic twists vanish for the actual degree-one bundle

Version6,3October2026. For the actual rank-two degree-one bundle
K specified in explicit_degree_one_etale_sections,
\[
H^0(X,\operatorname{Sym}^2K(O))=0,\qquad
H^0(X,\operatorname{Sym}^6K)=H^0(X,\operatorname{Sym}^9K)
=H^0(X,\operatorname{Sym}^{12}K)=0.
\]
In addition, $H^0(X,\operatorname{Sym}^3K(3O))=0$.
The later [sharp line bound](small_shift_line_twist_vanishing.md) gives
\[
H^0(X,K(3O)\otimes L)=0
\quad\text{for every }L\in\operatorname{Pic}^0(X),
\]
and hence all smaller shifts. K has maximum line degree minus four.
The quadratic proof uses that bound and cubic symmetry; the shifted
cubic proof restricts the already required later cubic section basis.
The same cubic orbit-product argument gives geometric all-twist vanishing:
\[
H^0(X,\operatorname{Sym}^mK\otimes L)=0\quad(m=2,3,4)
\quad\text{for every }L\in\operatorname{Pic}^0(X).
\]
Consequently \(\operatorname{Hom}(R,K)=0\) for every irreducible
finite étale coefficient \(R\) of rank three that is projectively
orthogonal or imprimitive. In the first case a nondegenerate
symmetric pairing \(R\otimes R\to T\) may use any finite character
\(T\); in the second, the three lines are permuted by monodromy.
Five-divisible finite monodromy is included. More generally, no
rank-three irreducible finite coefficient admitting a nonzero
semi-invariant in any of its first four symmetric powers maps to K.
No irreducible rank-four finite coefficient whose monodromy permutes
four lines maps to K either. This latter assertion does not include
every imprimitive rank-four representation: two permuted rank-two
blocks are a separate possibility.

Any rank-three finite coefficient mapping nontrivially to \(K\)
must therefore have primitive monodromy and no semi-invariant of
degree at most four. Such sources, rank two and the remaining ranks
at least four remain undecided. This is not a common-cover decision.

[Proof](../../Proofs/cartier_and_spin/low_degree_twist_vanishing.md).
