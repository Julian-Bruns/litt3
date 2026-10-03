# Ordinary admissible opers give full Barsotti--Tate groups

Version1,20 September2026. Work over $k=\overline{\mathbf F}_5$.
Let $C/k$ be a smooth proper connected curve of genus $g\ge2$.
Let $(E,\nabla,L)$ be a determinant-trivial rank-two oper, with
$L^2=\omega_C$, nowhere-zero nilpotent $5$-curvature, and ordinary
projectivization in the INDIGENOUS sense. Write
\[
I=\ker\psi,\qquad \kappa=I\otimes L^5.
\]
The line $\kappa$ is flat two-torsion. Choose a flat line $N$ with
$N^4=\kappa$ and $N^8=\mathcal O_C$, including the horizontal
trivializations. There are compatible scalar choices for the natural
rank-one maps $F_0,V_0$ on $E'=E\otimes N$ such that
\[
(E',\nabla',F_0,V_0,L\otimes N)
=\mathbf D(G[5])_C
\]
for a GLOBAL height-two, dimension-one $5$-divisible group $G/C$.
In particular $G$ is everywhere versal. Its determinant character
can be normalized to the Teichmuller lift of the finite character
of $N^2$. The curve $C$ is not replaced by a cover.

All Frobenius arrows are actual semilinear crystalline arrows. In
relative notation they include the coefficient twists. No isomorphism
$C\simeq C^{(1)}$ over $k$ is assumed.

## The complete ambiguity and uniqueness

Fix the PROJECTIVE oper $r$ above. The isomorphism classes of actual
everywhere-versal height-two, dimension-one BT1 groups inducing $r$
form a torsor under
\[
H^1_{\mathrm{et}}(C,\mathbf F_5^\times).
\tag{1}
\]
The action is tensor product by the corresponding rank-one etale
$\mathbf F_5$-local system. In particular there are exactly $4^{2g}$
geometric classes. There is no extra scalar parameter for the pair
$F_0,V_0$ and no nontrivial self-twist.

EVERY one of these BT1 groups extends to a full group on $C$. After
normalizing determinants, it has exactly one marked extension at
every finite level, and exactly one full marked tower. Here uniqueness
uses the [absolute extension torsor](versal_bt_extension_torsor.md):
its zeroth and first cohomology both vanish for the ordinary oper.
This gives existence and uniqueness starting at EVERY actual normalized
finite level, without a global next-level reference. Full towers with arbitrary higher determinant characters
are not being counted.

For either selected genus-two endpoint, the established
[85-active classification](../projective_connections/genus_two_active_critical_quartics.md)
therefore gives exactly
\[
85\cdot4^4=21\,760
\]
geometric isomorphism classes of everywhere-versal height-two,
dimension-one BT1 groups, and the same number of determinant-normalized
full towers. This counts groups over the FIXED curve, not modulo
automorphisms of that curve and not just groups rational over a
specified finite subfield.

The full-group construction is the returned Pro effectivity proof.
Its extension from genus two to arbitrary genus uses the same
canonical-lifting theorem and unchanged lattice calculation. The
torsor, exhaustion and counting statements are local continuations.
This is endpoint effectivity: it neither constructs a common oper
from a bare span nor makes its higher groups compatible on the source.
[Proof](../../Proofs/deformations/ordinary_oper_bt_effectivity.md).
