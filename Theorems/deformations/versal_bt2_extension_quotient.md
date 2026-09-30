# The BT2 extension quotient and its ordinary pole invariant

Version2,20 September2026. Let $C/\overline{\mathbf F}_5$ be smooth,
projective and connected, of genus at least two. Let $H/C$ be an
actual everywhere-versal height-two, dimension-one BT1, generically
ordinary, with reduced nonordinary divisor $S$. Assume a global
marked BT2 extension exists. Determinants are normalized to the
Teichmuller lift of the possibly nontrivial determinant character
of $H$; its level-one marking is retained.

Put
\[
E_C=\operatorname{Ext}^1_{\mathbf F_5,C_{\rm fppf}}(H,H),\qquad
Q_C=E_C/jH^1_{\rm et}(C,\mathbf F_5).
\]
Here $j$ tensors a constant-sheaf self-extension with $H$.
After fixing a reference, normalized marked BT2 isomorphism classes
are a torsor identified with $Q_C$. This is the returned reduction;
vanishing of $Q_C$ is not a consequence of this reduction alone.
The later [Cartier rigidity theorem](versal_bt_cartier_rigidity.md)
proves it when the induced indigenous connection is ordinary.

There are three further conclusions.

1. Let $\mathscr E_C$ be the etale sheafification of
$U\mapsto\operatorname{Ext}^1_{\mathbf F_5,U_{\rm fppf}}(H_U,H_U)$.
Then $j$ is injective and
\[
Q_C\simeq H^0(C_{\rm et},\mathscr E_C).
\tag{1}
\]
Thus quotienting scalar twists removes the entire ordinary etale
gluing ambiguity. The remaining group consists of local extension
classes compatible across the curve.

2. Set $U=C-S$. There is a natural additive ordinary comparison
invariant
\[
\Delta_C:Q_C\longrightarrow\Gamma(U,\mathcal O_U)\subset k(C).
\tag{2}
\]
For a difference class $[B]-[A]$, it is computed etale-locally on
$U$ using Kummer parameters $q_A,q_B$ and $r$ with $q_B=q_A r^5$:
\[
c=\frac{d\log r}{d\log q_A},\qquad \Delta_C([B]-[A])=c^5-c.
\tag{3}
\]
The denominator is nowhere zero by versality. Allowed basis changes
alter $c$ by an element of $\mathbf F_5$; (3) is intrinsic.
The invariant vanishes precisely when the normalized marked groups
are isomorphic over $U$. If it extends regularly to all of $C$,
it is zero. Consequently every nonzero generic object difference
has a pole at a nonordinary point. The reduction by itself leaves
a possible kernel supported at $S$; the subsequent
[valuative theorem](versal_bt_valuative_comparison.md) eliminates it.

3. For actual finite etale maps $X\xleftarrow fZ\xrightarrow gY$
and compatible versal BT1 groups, choose normalized endpoint BT2
extensions separately. Their difference gives a choice-independent
class
\[
o_{f,g}\in Q_Z/(f^*Q_X+g^*Q_Y).
\tag{4}
\]
Compatible choices exist on the ORIGINAL $Z$ if and only if (4)
is zero. The invariants (2) commute with etale pullback, giving a
necessary rational-function obstruction modulo the two endpoint
images. The subsequent valuative theorem makes it sufficient as
well, retaining the ACTUAL endpoint images.

These conclusions do not construct a compatible next level. Both
local questions have now been resolved: a supplied generic comparison
extends, while actual simple poles occur. The
[sharp simple-pole theorem](versal_bt_unitroot_ramification.md) and
[Cartier criterion](versal_bt_cartier_rigidity.md) control the global
image. The subsequent
[realization theorem](versal_bt_cartier_realization.md) identifies
that image with the ENTIRE Cartier kernel. Compatibility on a
nonordinary common source remains a separate possible obstruction.
[Proof](../../Proofs/deformations/versal_bt2_extension_quotient.md).
