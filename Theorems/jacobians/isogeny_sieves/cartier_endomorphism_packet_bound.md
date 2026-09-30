# Cartier-kernel size detects an admissible endomorphism packet

Version1. Independently audited.

Let \(q:Z\to Y\) be a connected finite étale Galois cover, with
group \(G\) of order prime to \(p\), over an algebraically closed
field of characteristic \(p>0\). Write \(h=g(Y)\ge2\). Suppose
there is a finite separable map \(f:Z\to X\), where
\(J(X)\) is geometrically simple of dimension \(d>h\), has
endomorphism algebra a number field \(K\), and \(a(X)>0\).

For a nontrivial complex irreducible character \(\chi\) of \(G\),
put \(c_\chi=\chi(1)\), \(F_\chi=\mathbf Q(\chi)\),
\(a_\chi=[F_\chi\cap K:\mathbf Q]\), and let \(e_K(\chi)\)
be its Schur index over \(F_\chi K\). Define the admissible set by
\[
\mathcal I=\{\chi\ne1:
d\le(h-1)a_\chi c_\chi/e_K(\chi)\}.
\]
This set is nonempty, and
\[
\boxed{a(Z)\ge\min_{\chi\in\mathcal I}c_\chi.}
\]
In particular, if \(\kappa=[K\cap\mathbf Q^{\mathrm{ab}}:\mathbf Q]\),
then \(a(Z)\ge\lceil d/((h-1)\kappa)\rceil\).

For the fixed genus-nine \(X\) used by both candidate pairs,
\(a(X)=3\) and \(K\cap\mathbf Q^{\mathrm{ab}}=\mathbf Q(\zeta_3)\).
Consequently every such Galois cover of **any** genus-two curve
which maps separably to \(X\) satisfies \(a(Z)\ge5\). If
\(3\nmid|G|\), the stronger bound is \(a(Z)\ge9\).

Thus the a-number-four common-source case is impossible when the
actual genus-two leg is Galois of degree prime to five. Together
with the [Galois Raynaud gap](../theta_divisors/galois_raynaud_rank_gap.md),
this leaves both legs non-Galois in the current excess-one
nonvanishing bottleneck. No assertion about all possible source
a-numbers or Galois closures of p-divisible order is made.

[Proof](../../../Proofs/jacobians/isogeny_sieves/cartier_endomorphism_packet_bound.md).
