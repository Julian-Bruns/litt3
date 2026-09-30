# The Cartier kernel generates a rank-three bundle of degree thirteen

Let $X/\overline{\mathbf F}_5$ be the fixed genus-nine curve, let
$C=X^{(1)}$, and let $B_X$ be its rank-four bundle of locally exact
differentials on $C$. Write $O$ for the point at infinity on $C$,
and $R$ for the reduced divisor of its ten cubic branch points.
Let $U\subset B_X$ be the saturation of the evaluation image
\[
H^0(C,B_X)\otimes\mathcal O_C\longrightarrow B_X.
\]
Then $U$ has rank three and
\[
\det U\simeq\mathcal O_C(R+3O)\simeq\mathcal O_C(13O).
\]
The evaluation map is injective. Its local elementary-divisor
valuations are $(0,0,1)$ at every cubic branch point and $(0,1,2)$
at infinity; it is a subbundle inclusion elsewhere.

For the canonical alternating pairing $B_X\otimes B_X\to\omega_C$,
the annihilator is a line bundle
\[
U^\perp\simeq\mathcal O_C(-3O),\qquad
B_X/U\simeq\mathcal O_C(19O).
\]
These assertions retain the scalar Frobenius twist.

Now suppose $X\xleftarrow f Z\xrightarrow g Y$ is ANY actual
finite bi-étale span with $g(Y)=2$. The rank-three subbundle
$f^{(1)*}U$ cannot descend through $g^{(1)}$. More sharply, inside
$B_Z=g^{(1)*}B_Y$, its complete one-step transport through the
$g$-fibers generically spans ALL of $B_Z$.

Here complete transport means the image of the actual trace morphism
\[
g^{(1)*}g^{(1)}_*(f^{(1)*}U)\longrightarrow B_Z,
\]
using $B_Z=g^{(1)*}B_Y$ and the finite étale trace. Its generic rank
is four, even when five divides a covering degree. No division by
that degree is used.

In addition, on every finite étale cover $D\to X$, a global section
of $B_D$ pairing to zero with all three pulled-back Cartier-kernel
forms is zero. This is a statement about the whole pairings, not
their traces to a second endpoint.

## The unsaturated transport fills in four rounds

Suppose further that the actual span is coreless and has no singleton
clump on $Y$. These hypotheses hold for any hypothetical span of either
selected pair. Retain the ACTUAL evaluation image $M_0$ on $Z^{(1)}$,
without taking its saturation. For a subsheaf $A\subset B_Z$, set
\[
T_f(A)=f^{(1)*}\operatorname{im}
 (\operatorname{Tr}_f:f^{(1)}_*A\longrightarrow B_X),
\]
and define $T_g$ similarly. Put
\[
g^{(1)*}J_0=T_g(M_0),\qquad
g^{(1)*}J_{j+1}=T_gT_f(g^{(1)*}J_j).
\]
Every $J_j\subset B_Y$ has rank four and
\[
0\le\operatorname{length}(B_Y/J_j)\le4.
\]
Every round before $J_j=B_Y$ strictly decreases that length. In
particular
\[
J_4=B_Y.
\]
The bound is independent of both covering degrees, including their
five-parts. It does not assert finite spectral closure or existence
of a clump: it proves that this finite linear defect disappears.

The more general [finite-coefficient theorem](../shared_tensors/common_finite_coefficients.md)
excludes EVERY nonzero compatible map to $B$ from strongly semistable
degree-zero common coefficients. Retaining one of the original exact
forms is unnecessary for that exclusion.

Version3,20 September2026. Author proof using the previously certified
kernel net and its simple Wronskian. No clump or common-cover exclusion
is asserted. [Proof](../../Proofs/cartier_and_spin/cartier_kernel_generated_subbundle.md).
