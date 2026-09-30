# Full Cartier monodromy and its projective alternative

Version4,23 September2026. Let $k$ be algebraically closed of
characteristic $p\ge5$, and let $X\leftarrow Z\to Y$ be an ACTUAL
finite bi-etale span of smooth proper hyperbolic curves with no
clump. Assume $p\nmid g(C)-1$ for at least one endpoint $C$.
Let $H\subset\mathcal G=\operatorname{Aut}(k[t]/t^p)$ be the
algebraic monodromy of the ACTUAL common algebra $F_*\mathcal O$
on the first twists, with evaluation at a source point.
For comparisons across heights use absolute Frobenius with its
scalar action retained, rather than identifying relative twists
as $k$-curves.

The entire group, including its reduced and infinitesimal parts,
is determined by the two branches:

1. If there is no common regular projective connection, then
\[
H=\mathcal G.
\]
More strongly, at EVERY height $r\ge1$, the monodromy of the
actual common algebra $F_*^{[r]}\mathcal O$ is
\[
H_r=\operatorname{Aut}(k[t]/t^{p^r}).
\]
These identifications retain the actual intermediate Frobenius
subalgebras and their restriction maps, after compatible fiber
coordinates. Thus the entire coordinate-group tower is forced,
not only its infinitesimal-height lower bound.

2. If there is a common dormant projective oper, choose a fiber
coordinate in which its adjoint subalgebra is
$\langle\partial_t,t\partial_t,t^2\partial_t\rangle$.
Then
\[
H=\mathcal N
=\operatorname{Norm}_{\mathcal G}
  \langle\partial_t,t\partial_t,t^2\partial_t\rangle
\simeq F_{\mathrm{PGL}_2}^{-1}(B^{(1)}),
\]
where $B\subset\mathrm{PGL}_2$ stabilizes $0\in\mathbf P^1$.
Its action is by fractional linear substitutions preserving
$t^p=0$; in matrix coordinates this is the condition $b^p=0$.

Thus the two possible reduced groups have dimensions $p-1$ and two,
respectively. In the second case $H[F]\simeq\mathrm{SL}_2[F]$;
in the first it is the full order-$p^p$ coordinate Frobenius kernel.
These are statements about the original source comparisons, not
about a constant group acting on either curve.

The geometric input beyond the Lie-algebra calculation is that
the height-r Frobenius quotient of the actual algebra-frame torsor
is the ordinary order-$(p^r-1)$ coordinate-jet torsor of the endpoint curve.
A proper reduced jet group would give, after a finite Frobenius
pullback, either a common connection on $\omega$ or a common
projective connection. The first is impossible; the latter
descends by the absence of common positive canonical tensors.

This identifies the full group in each surviving branch. It does
not exclude either branch or solve either common-cover candidate.
In particular the full coordinate model is forced in the
no-common-oper case at every height, rather than merely compatible with its
subbundle ranks.

For characteristic five and a genus-two endpoint, the
[proper-subbundle criterion](cartier_witt_oper_subbundle.md)
detects the oper branch intrinsically. The group calculation here
uses no genus-two rank bound.

[Proof](../../Proofs/cartier_and_spin/first_cartier_full_monodromy.md).
