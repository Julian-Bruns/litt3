# The skew Atiyah obstruction and a finite common-oper descent chain

Version2,3 October2026. Let $k=\overline{\mathbf F}_5$ and use
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
Lie subbundle for the trace pairing. The proper common subbundles
of $W$ are described by the
[intrinsic Witt criterion](cartier_witt_oper_subbundle.md).
The following conditions are equivalent:

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
are unique when they exist. Every $Q_i$ is geometrically stable,
and its first unstable Frobenius pullback has index EXACTLY $i+1$.
They stay over the SAME field on their specified relative twists.

Let $d$ be any period of the endpoint's coefficient Frobenius twists
up to $\mathbf F_q$-isomorphism. Every finite chain satisfies
\[
\#\{Q_i\}\le d(q^3+q^2+q+1).
\tag{3}
\]
One can always take $d=s$. If $Y$ has a model over
$\mathbf F_{5^d}$ with $d\mid s$, that $d$ suffices; for the explicit
backup over $\mathbf F_{125^r}$ one can take $d=3$.
Thus a maximal common chain terminates with a NONZERO projective
Atiyah obstruction. This need not occur at its first step.

For the explicit endpoint
$Y_\alpha:v^2=u(u-1)(u-2)(u-3)(u-\alpha)$ over $\mathbf F_{125}$,
$\alpha^3+\alpha+1=0$, the stronger first-step conclusion
$\kappa_B\ne0$ holds whenever the whole span is defined over
$\mathbf F_{125^r}$ with $5\nmid r$. It follows from the known
degree-five [dormant-residue exclusion](../deformations/frobenius_residue_escape.md)
of every common regular connection over that field, together with
the equivalence above.
There is no restriction on the covering degrees.

No clump or unmarked common-cover exclusion follows.
[Proof](../../Proofs/cartier_and_spin/common_projective_atiyah_detection.md).
