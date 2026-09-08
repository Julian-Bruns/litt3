# Quadratic twists: fixed Tango structures and exact p-rank bridges

Version 2, 2026-09-08. Consolidates the original rank bridge and the
stronger invariant-structure theorem. AUTHOR proof, 2026-09-05, by /root
and /root/gluing_cohomology_rigidity; the latter separately checked
descent and the affine action. No new independent audit. The original
rank-bridge proof through the audited positive-rank descent theorem is
retained in Section 3, not replaced by an evidence upgrade.

Work over an algebraically closed field of odd characteristic p.
Curves are smooth projective connected; γ is p-rank and Tan denotes
[embedded maximal Tango structures](111_P_RANK_ONE_TANGO_DESCENT.md).

## 1. Both actual etale legs and the exact rank identity

Let Y→B be a RAMIFIED double cover with involution τ, and B'→B a
connected ETALE double cover with involution ε; assume g(B)≥2. Put

\[
 W=Y\times_B B',\qquad X=W/\langle(\tau,\epsilon)\rangle.
\]

The quadratic function fields are distinct, since just one is ramified,
hence linearly disjoint. Therefore W is connected and, being etale over
Y, smooth. The product involution is free because ε is free. Thus

\[
 q:W\to Y,\qquad r:W\to X
\]

are BOTH connected finite etale doubles from the SAME projective source.
The characters of Y/B and B'/B multiply to that of X/B. The latter
unramified character does not change inertia, so X/B has the same branch
divisor as Y/B, and g(X)=g(Y), g(W)=2g(Y)−1.

The Klein-four cover W/B has intermediate quotients Y,X,B'. Character
idempotents give the actual Jacobian isogeny

\[
 J(W)\times J(B)^2\sim J(Y)\times J(X)\times J(B'),
 \quad
 \boxed{\gamma(W)=\gamma(Y)+\gamma(X)+\gamma(B')-2\gamma(B).} \tag{1}
\]

Indeed J(B) is the trivial character factor, and each other character
appears once among the three intermediate Jacobians. The denominators
are powers of two; p-rank is isogeny-invariant and additive. Norm after
pullback is [2], so γ(Y),γ(X),γ(B') are each at least γ(B).

## 2. Invariant structures and the minimal-rank criterion

Write a=(τ,1), b=(1,ε), G=〈a,b〉 and let τ_Y,τ_X be the residual
involutions of Y/B,X/B. There are canonical bijections, with NO rank
hypothesis,

\[
 \boxed{\operatorname{Tan}(Y)^{\tau_Y}
       \simeq\operatorname{Tan}(W)^G
       \simeq\operatorname{Tan}(X)^{\tau_X}.}             \tag{2}
\]

A τ_Y-fixed canonical connection pulls back to a G-fixed one.
Conversely the specified connection on the fixed bundle ω_W, with its
canonical action, descends through the FREE b-quotient; zero p-curvature
and the Cartier-zero condition descend faithfully flat locally. The
remaining a-action gives τ_Y-invariance. These operations are inverse.
Use the free ab-quotient for X. No descent through either RAMIFIED leg
to B is asserted. Equivalently, invariant embedded lines inherit the
ambient canonical linearization and its actual cocycle.

For ANY double cover C→B with involution τ, if γ(C)=γ(B), then τ fixes
EVERY regular dormant connection on ω_C, including when that rank is
zero. Pullback identifies the Cartier-fixed F_p-spaces V_B≅V_C, hence τ
acts trivially on V_C. If the connection torsor is nonempty, put
δ=τ^*∇−∇∈V_C. Then 0=δ+τ^*δ=2δ, so δ=0. This neither assumes an
invariant torsor origin nor asserts that the torsor is nonempty.

Consequently

\[
 \operatorname{Tan}(Y)^{\tau_Y}=\varnothing,\quad
 \gamma(X)=\gamma(B)
 \quad\Longrightarrow\quad\operatorname{Tan}(X)=\varnothing. \tag{3}
\]

If Tan(Y)≠∅, its pullback supplies a Tango structure on W, and r is
then an actual failure of unrestricted etale descent. This criterion
places NO restriction on γ(B') and allows γ(B)=0.

## 3. The original positive-rank bridge, with its separate proof

The older sufficient assumptions were

\[
 \gamma(B)=s>0,\quad \gamma(X)=\gamma(B')=s,\quad
 \operatorname{Tan}(Y)\ne\varnothing,\quad
 \operatorname{Tan}(Y)^{\tau_Y}=\varnothing.
\]

They imply the same failure of descent. Here is the retained original
argument. Equation (1) gives γ(W)=γ(Y)>0. The audited
[positive-rank-preserving theorem](115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT.md)
makes q^*:Tan(Y)→Tan(W) a bijection. Since q∘ab=τ_Y∘q, no Tango
structure on W is fixed by ab. A structure on X would pull back to
one, a contradiction; pulling back from Y proves nonemptiness on W.
Thus both the existence and nonexistence assertions hold independently
of the stronger argument in Section 2.

By (1) and the three rank inequalities, γ(W)=γ(Y) is equivalent to
γ(X)=γ(B')=γ(B). It is an exact condition on the constructed double
covers, not a premise about an unspecified Galois closure.

## 4. Completed auxiliary test and its limitation

The [Hoshi model and reflection calculation](HOSHI_GENUS6_EXACT_TANGO_COUNT.md)
give g(Y)=6, γ(Y)=4, g(B)=2, γ(B)=1, and ten Tango structures exchanged
in five pairs by τ_Y. Thus EVERY unramified twist has no τ_X-fixed
Tango structure; any Tango structures it has occur in pairs.

The [complete fifteen-class calculation and selected zero-Tango theorem](HOSHI_GENUS6_TWIST_WITH_NO_MAXIMAL_TANGO.md)
give thirteen twists of rank five and two of rank three, not one.
Only two auxiliary B' have rank one, and their X have rank five.
Hence neither rank criterion above proves nonexistence in that packet.
Nevertheless direct exhaustive Tango testing proves that one of those
rank-five twists (and its Frobenius conjugate) has no Tango structure.
That actual projective counterexample supersedes the historical open
test, not the conditional theorems. These auxiliary curves share W;
they do not disprove Litt or change the project's fixed pair.
