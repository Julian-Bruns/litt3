# The skew Atiyah obstruction and a finite common-oper descent chain

Version1,20 September2026. Let $k=\overline{\mathbf F}_5$ and use
an actual clumpless finite etale span $X\xleftarrow fZ\xrightarrow gY$
of smooth projective hyperbolic curves, with $g(Y)=2$. All common
objects retain their specified comparison on this SAME source.
On the first twists put
\[
B=F_*\mathcal O/\mathcal O,\qquad
T=F_*\omega^{-2},\qquad W=F_*\omega^{-1},\qquad
\kappa_B=a(B)-\tfrac12\operatorname{id}_B\otimes a(\omega).
\]
The canonical embedding $W\subset\mathfrak{so}(T)$ is a Lagrangian
Lie subbundle for the trace pairing. The only possible proper
nonzero common subbundle of $W$ has rank three and degree zero on
$Y^{(1)}$; it is unique if it exists.

If $\kappa_B=0$, that subbundle $K$ exists, is horizontal for the
induced dormant connection, and its bracket gives
\[
\Lambda^2K\simeq K,\qquad
K\simeq\operatorname{End}^0(Q),\qquad Q=W/K.
\]
Here $Q$ is the actual common canonical-determinant Bol bundle of
a regular dormant projective oper. In particular
\[
0\longrightarrow\omega^3\longrightarrow F^*Q
\longrightarrow\omega^2\longrightarrow0
\]
has the oper second fundamental isomorphism. The induced connection
on $K$ gives a dormant projective connection on $Q$ itself.

More precisely, the following conditions are equivalent:

1. $\kappa_B=0$, or equivalently $T$ has a common connection.
2. There is a common regular dormant projective oper, with its
   canonical-determinant Bol bundle $Q$ on the first twist, and an
   ACTUAL common bundle $R$ on the second twist such that
\[
\det R=\omega,\qquad F^*R\simeq Q\omega^2.
\tag{1}
\]
The datum in (1) is a second projective Cartier descent. Its existence
is not implied by existence of the first dormant oper. No spin line
has to be common.

There is also a finite-field bound. Suppose the WHOLE span is defined
over $\mathbf F_q$, where $q=5^s$. Starting with any common Bol bundle
$Q_0$, successive normalized common antecedents
\[
F^*Q_{i+1}=Q_i\omega^2,\qquad \det Q_i=\omega
\tag{2}
\]
are unique when they exist. They stay over this same field, on their
specified relative twists. Every finite chain has
\[
\#\{Q_i\}\le s(q^3+q^2+q+1).
\tag{3}
\]
Thus a maximal such common chain terminates with a NONZERO projective
Atiyah obstruction. The bound does not place that obstruction at
the first step and does not prove $\kappa_B\ne0$ universally.

For the explicit endpoint
$Y_\alpha:v^2=u(u-1)(u-2)(u-3)(u-\alpha)$ over $\mathbf F_{125}$,
$\alpha^3+\alpha+1=0$, the stronger first-step conclusion
$\kappa_B\ne0$ holds whenever the whole span is defined over
$\mathbf F_{125^r}$ with $5\nmid r$. It follows from the known
degree-five [dormant-residue exclusion](../deformations/frobenius_residue_escape.md)
of every common regular connection over that field, together with
the equivalence above.
There is no restriction on the covering degrees.

The Lagrangian detection and arithmetic subcase are the returned
Pro result. The identification with $\operatorname{End}^0(Q)$,
equivalence (1), and bound (3) are local continuations. Neither a
clump nor an unmarked common-cover exclusion is proved.
[Proof](../../Proofs/cartier_and_spin/common_projective_atiyah_detection.md).
