# Proof: the moving coarse wild140 family

Version1, 3 October2026. [Independent whole review PASS](../../Research/audits/WILD140_MOVING_COARSE_MAP_FAMILY_AUDIT_2026_10_03.md). [Statement](../../Theorems/quotient_geometry/wild140_moving_coarse_map_family.md).

Since t∉F₅, r and K are nonzero and Yₜ is smooth. The coordinate x=1/(z−t) gives
\[
y_0^2=\frac{x\prod_{a=0}^3(1+(t-a)x)}K
=x^5+\frac{4r^3}Kx^4+\frac{r^2}Kx^3+\frac{4r}Kx^2+\frac1Kx.
\]
Substitution x=w+4/r kills the coefficients of w³,w²,w. Its constant is obtained by evaluating at x=4/r: each factor 1+(t−a)x equals (a+1)/r, so the constant is1/(r⁵K). This proves the translated model and the q,s formulas.

The four-pair G formula differentiates exactly to dG=cF³σ with σ=dw/y₀ and divσ=2P, as proved in the [common-completion refinement](../cartier_and_spin/wild140_exceptional_common_completion_refinement.md). F has exact pole7P. Since v²=2s≠s, its seven zeros are simple: two lie at w=0, while the other five satisfy y₀=−v and w⁵+qw⁴−s=0. At the latter points, y₀F′=2qw⁴; at the former, y₀F′=s±v√s. All seven values are nonzero.

For the displayed G formula, the correction coefficients are K₀=4cs²/q,K₅=3cs/q,K₁₀=C−3c/q. The exact reduction calculations from the refinement give
\[
G(R)^2=\lambda\,(y_0(R)F'(R))^5,
\qquad\lambda=3c^2/(q^2s)\ne0
\]
at all seven zeros of F. In particular G is nonzero there. The leading w¹⁰ coefficient is K₁₀; all other terms have smaller pole order. It could vanish only when C²=9c²/q², equivalently q⁵=4s. Under the assumed inequality G has exact pole20P. Its zeros are disjoint from the zeros of F. At any finite zero of G, F and σ are units, so dG=cF³σ is nonzero and the zero is simple. There are therefore exactly twenty such zeros.

Consequently β=G⁷/F²⁰ has seven poles of order20, hence degree140. It is separating because
\[
d\beta=2cG^6F^{-17}\sigma\ne0.
\]
At each pole, the differential order is−17, giving different−17+40=23. At each zero its order is6 and index7 is tame. At P the generator pole orders give ord_P(dβ)=−120+119+2=1. The ratio β itself is a unit at P. Thus its first nonconstant local term is quadratic and its ramification index there is two. Elsewhere the displayed differential is a unit. This proves the complete ledger; the check 7·23+20·6+1−2·140=2 agrees with genus two.

The [weak completed-extension invariant](../../Theorems/quotient_geometry/weak_local_completed_extension_invariant.md) identifies the local scalar as
\[
\mathcal I_R=-\frac{(y_0(R)F'(R))^5}{(2c)^5G(R)^2}
=-\frac1{(2c)^5\lambda}.
\]
It is independent of R. Therefore the seven completed pole extensions are isomorphic over the SAME coordinate β. This establishes a local compatibility property of the explicit coarse maps; it constructs no global Γ.

Finally q⁵/s=4r²⁰/(r⁴−1)⁴, so q⁵=4s is equivalent to the stated polynomial of degree20. In the BACKUP field with α³+α+1=0, q=[15]=3α and s=[9]=4+α. Since α⁵=4α²+α+1, q⁵=2α²+3α+3=[68], whereas4s=4α+1=[21]. This proves the two endpoint applicability observations without a new point census. The parameter t varies in a nonempty open subset, so these coarse maps form a genuine one-dimensional algebraic family after adjoining the two square roots. No claim about actual canonical carriers or common covers follows from that family.
