# Quotient rigidity for common strongly semistable bundles

Version4,1October2026. Let $k=\overline{\mathbf F}_p$ and let
$X\xleftarrow f Z\xrightarrow g Y$ be an actual coreless finite
étale span of smooth projective connected curves.

## Quotients preserve slope

Let $E_X,E_Y$ be strongly semistable bundles of arbitrary slope,
with a specified common pullback. Every compatible locally free
quotient $E_X\twoheadrightarrow I_X$, $E_Y\twoheadrightarrow I_Y$
has
\[
\mu(I_X)=\mu(E_X),\qquad \mu(I_Y)=\mu(E_Y).
\]
The quotients are strongly semistable. The same holds for compatible
saturated subbundles. In particular the actual image sheaves of
compatible morphisms from $E$ to ANY common vector bundle have
the slope of $E$ and are strongly semistable. No saturation of
those images in the target is asserted.

For a nonzero compatible morphism between strongly semistable
common bundles $E,H$, let $r$ be its generic rank. The actual
image $I$ and its saturation $J\subset H$ have respective slopes
$\mu(E)$ and $\mu(H)$. Their determinant defect is a common
effective divisor pair, of degree
\[
\deg D_Y=r\bigl(\mu(H_Y)-\mu(E_Y)\bigr).
\]
If the slopes differ, this divisor is nonzero and its support is
the unique clump. In the absence of a clump, common morphisms
between different slopes vanish.

## Degree-zero coefficients and positive lines

Let $J_X,J_Y$
be strongly semistable degree-zero vector bundles, with an actual
isomorphism $f^*J_X\simeq g^*J_Y$. Let $L_X,L_Y$ be compatible
line bundles of positive degree. Suppose nonzero maps
\[
J_X\longrightarrow L_X,\qquad J_Y\longrightarrow L_Y
\]
agree under the specified pullback identifications.

The maps factor through their common image line bundles $T_X,T_Y$,
which have degree zero. Their zero divisors form a nonzero common
effective divisor pair satisfying
\[
f^*D_X=g^*D_Y,\qquad \deg D_Y=\deg L_Y.
\]
The image lines are torsion. If the coefficients are already
finite-étale-trivial, these are finite étale character quotients.
No Frobenius multiplier remains in the divisor degree.

Assume now that $p$ is odd and $g(Y)=2$. The unique clump forced by
these maps has size $r$ on $Y$, and
\[
r\mid\deg L_Y,
\qquad r\equiv-1\pmod p,
\]
except that $p=5$ also allows $r=1$. In particular, in
characteristic five with singleton clumps excluded, there is NO
nonzero compatible map from such $J_X,J_Y$ to $\omega_X,\omega_Y$.
The same exclusion holds without a singleton hypothesis when $p\ge7$.

For either selected characteristic-five candidate pair, this implies
\[
\operatorname{Hom}_{\rm common}(J,F_*\omega)=0,
\qquad \operatorname{Hom}_{\rm common}(J,B)=0
\]
for every strongly semistable degree-zero common coefficient on the
Frobenius-twisted span, of arbitrary rank. The notation means pairs
of morphisms agreeing on the actual source; it does not mean all
one-endpoint Hom spaces vanish. In particular it includes essentially
finite coefficients with local monodromy, not only étale ones.

## A stronger restriction for the Cartier bundle

In characteristic $p$, let $B$ denote the rank-$p-1$ bundle of
locally exact differentials on the Frobenius-twisted span. Suppose
a common strongly semistable bundle $E$ of ANY slope has a nonzero
compatible morphism to $B$. Then
\[
\mu(E_Y)\in\mathbf Z,\qquad
p\mu(E_Y)\le 2g(Y)-2.
\]
Indeed the actual image rank is strictly less than $p$; there is
no restriction on the rank of the original coefficient $E$.
For either selected characteristic-five candidate, the degree-zero
case above then strengthens this to
\[
\mu(E_Y)\le-1.
\]
Thus a common strongly semistable coefficient of nonnegative slope
cannot map nontrivially to $B$. This applies to every compatible
strongly semistable subbundle or generator, not only essentially
finite ones. It does not assert this for arbitrary semistable bundles:
$B$ itself is a common positive-slope counterexample to that extension.

The same nonnegative-slope vanishing holds at every height for
the successive Frobenius quotients
\[
B^{[e]}_C=(F_C^e)_*\mathcal O_C/\mathcal O_{C^{(e)}},
\qquad e\ge1,
\]
with the appropriate relative twists on the span. Their canonical
filtrations have Frobenius pushforwards of $B$ as successive
quotients. This does not assert that any of these positive-degree
bundles is strongly semistable.

No existence of a common coefficient is asserted. One-endpoint
finite-coefficient presentations of $B$ may exist on both endpoints
without any compatible common presentation.

## All slopes vanish in the no-clump branch

Assume $p$ is odd, there is no clump, and
$p\nmid g(C)-1$ at least at one endpoint. For every COMMON strongly
semistable coefficient $E$ of ANY slope and rank,
\[
\operatorname{Hom}_{\rm common}(E,B)=0.
\]
The same vanishing holds for every higher Frobenius quotient
$B^{[e]}$, $e\ge1$, with the appropriate scalar and relative twists.
This stronger no-clump conclusion does not replace the retained
clump-case slope restriction above. It does not concern separate
one-leg coefficient presentations and constructs no common coefficient.

[Proof](../../Proofs/shared_tensors/common_finite_coefficients.md).
