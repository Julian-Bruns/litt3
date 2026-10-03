# The BT difference bundle is the actual indigenous tangent bundle

Version2,3 October2026. Let $H/C$ be an actual everywhere-versal
height-two, dimension-one BT1 on a smooth proper hyperbolic curve
over $\overline{\mathbf F}_5$, generically ordinary with reduced
supersingular divisor $S$. Let $r$ be its admissible active projective
oper and let $s=E(r)/3$ be the normalized quartic with divisor $2S$.

Use the coherent kernel $\mathcal B_H$ of
[the actual extension torsor](versal_bt_extension_torsor.md).
Let $\mathcal E_r^{\rm abs}$ denote the
[rank-four indigenous tangent bundle](../projective_connections/tangent_bundle_cyclic_refinements.md)
constructed using ABSOLUTE Frobenius pushforward. Equivalently it is
the relative bundle with its scalar-Frobenius transport retained;
no identification of $C$ with its relative twist is imposed.

There is a canonical, etale-pullback-compatible isomorphism
\[
\mathscr D_H:\mathcal B_H\xrightarrow{\sim}\mathcal E_r^{\rm abs}.
\tag{1}
\]
It is explicit. In a separating local coordinate $u$, write
$s=s_u(du)^4$, and represent a tangent section by $v(du)^2$.
Then
\[
\mathscr D_H(h)=
\left(h''+\frac{s_u'}{s_u}h'\right)(du)^2,
\qquad
\mathscr D_H^{-1}(v)=\frac{v''-rv}{s_u}.
\tag{2}
\]
The formulas are initially rational. On the indicated kernels,
the first is regular and the second has at most simple poles on
$S$. They are maps of the actual coherent bundles, not only an
equality of global kernel dimensions.

Consequently $\mathcal B_H$ has a canonical-valued perfect
alternating pairing, and is polystable of slope $g(C)-1$. It is
stable exactly when the canonical Hasse-root double is connected;
if that double splits it is the sum of the two nonisomorphic
dormant tangent bundles. In particular the actual obstruction to
extending a fixed normalized BT$_N$ is intrinsically a functional
\[
e_N(A_N)\in H^1(C,\mathcal B_H)
\simeq H^0(C,\mathcal B_H)^*
\simeq T_{\rm nil}(C,r)^*,
\tag{3}
\]
with the scalar convention in (1). This does NOT identify it with
any earlier higher-Witt obstruction functional.

For ANY actual finite etale map $q:D\to C$, Serre duality gives
\[
\langle q^*e,v\rangle_D=\langle e,\operatorname{Tr}_q v\rangle_C,
\quad v\in H^0(D,q^*\mathcal B_H).
\tag{4}
\]
Thus, if $q^*A_N$ has a next-level extension, its actual absolute
class annihilates the image of the tangent trace. In particular,
surjectivity of that trace implies next-level EXISTENCE downstairs,
without a Galois or degree restriction. It does not descend the
specified upper object.

For EVERY five-group Galois cover, of order $d$, the tangent trace
is surjective exactly when the defect has maximal growth:
\[
\operatorname{Tr}_q\text{ is onto}
\quad\Longleftrightarrow\quad
h^0(D,q^*\mathcal B_H)=d\,h^0(C,\mathcal B_H).
\tag{5}
\]
This is equivalent to injectivity of pullback on $H^1(\mathcal B_H)$.
A particular absolute class can vanish under pullback even when the
trace is not onto.

On a cyclic five-power cover, the trace image is exactly the span
of the full-length blocks in the actual tangent module. This
recovers the maximal-growth criterion and block obstruction count
of [the five-group result](bt_p_cover_cartier_obstruction.md), now
directly from a bundle isomorphism. Neither trace surjectivity nor
annihilation of the remaining directions is asserted in general.
Both original common-cover problems remain unresolved.

[Proof](../../Proofs/deformations/bt_cartier_tangent_identification.md).
