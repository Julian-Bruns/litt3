# Proof: the FL class remembers the marked first lift

[Statement](../Theorems/Thm_admissible_two_leg_w2_lifts.md).
Author /root,2026-09-09.

Write F_C:C→C^(1) and T=F_C^*T_(C^(1)). The classical Cartier sequence
identifies the affine space of normalized FL extension classes

    0→(T,nabla_can)→(G,nabla)→(O,d)→0

with the torsor of marked W_2(k)-liftings of C^(1).
[Mochizuki II Proposition1.2](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf)
is this torsor isomorphism; the construction and proof on printed
pp.58–60 were read directly. Normalization uses the fixed nonzero
Cartier boundary, not an arbitrary scalar of an extension.

For an admissible nilpotent projective connection, the adjoint bundle
and its p-curvature are intrinsic. Proposition2.5 of the same paper
(printed pp.68–69, proof read) constructs its FL-bundle as the kernel
of the dual p-curvature map. It is an exact inverse to projectivization
on FL-bundles having indigenous projectivization. Tensoring a rank-two
oper realization by a square-trivial line changes neither adjoint nor
this construction. Therefore r determines ONE normalized FL class,
and equality of these classes is equivalent to equality of projective
connections. The Frobenius-twisted W2 convention follows Proposition1.2.
For a modern review distinguishing length-two from full Witt lifting,
see [Hoshi2025, Introduction and Section3](https://www.jstage.jst.go.jp/article/kyushujm/79/2/79_209/_pdf/-char/en).

We spell out functoriality rather than invoking the ordinary full-Witt
compatibility theorem. A marked lifting C' of C^(1) defines its FL class
by differences, divided by5, of local lifts of F_C into C'. Choose any
auxiliary lifting of C to form these local Frobenius lifts. The class
does not depend on that auxiliary lift: changing it contributes a
derivation applied to a Frobenius-pulled-back function, hence zero.
This is the proof preceding Proposition1.2.

Let a:W→C be finite etale. Lift a to the chosen auxiliary lift of C,
and lift a^(1) to C'; both exist uniquely by invariance of finite etale
covers under a nilpotent thickening. The Frobenius square in
characteristic5 is Cartesian because a is etale. Each chosen local
Frobenius lift on C consequently lifts uniquely through the etale
target cover to a local map on W. The differences divided by5 are the
pullbacks of the original differences under
a^*T≅F_W^*T_(W^(1)). The differential/connection terms likewise pull back.
Thus the FL class of the lifted source is exactly a^*FL(C').

On the other hand, p-curvature and its locally free kernel commute with
etale pullback. Hence FL(a^*r)=a^*FL(r). Applying the torsor isomorphism
proves the one-leg statement. Apply it separately to both ACTUAL maps
in the given span: their lifted sources coincide with the specified
special-fiber identification exactly when their FL classes coincide,
and Proposition2.5 makes that equivalent to a^*r_C=b^*r_B.

Marked lift isomorphisms, when they exist, are unique here because
H^0(W^(1),T_(W^(1)))=0. The two independently lifted maps are therefore
defined on one marked W2 source. Untwisting every object by inverse
Witt Frobenius gives a simultaneous W2 lift of the original span.

Everything stops at length two. Proposition1.2 identifies one
Frobenius-obstruction torsor; it is not a compatible infinite sequence
of such identifications. The upper ordinariness assumption in III
Corollary3.5 remains necessary to the separate full canonical-lift
argument. No full-Witt or characteristic-zero conclusion is drawn here.
