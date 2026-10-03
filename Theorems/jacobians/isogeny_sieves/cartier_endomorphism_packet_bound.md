# Cartier excess detects an admissible endomorphism packet

Version2,3 October2026. The original first-height argument retains
its audit; the inherited-kernel and all-height extension has focused
local review.

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
This set is nonempty. For every finite Cartier height e>=1, put
\(a_e(C)=\dim\ker(C_C^e)\), with the scalar Frobenius twists understood.
Then
\[
\boxed{a_e(Z)-a_e(Y)\ge\min_{\chi\in\mathcal I}c_\chi.}
\]
The same bound holds for the stable defects
\(\Delta(C)=g(C)-f_p(C)\). The original first-height bound is
sharpened by retaining the entire inherited kernel.
If \(\kappa=[K\cap\mathbf Q^{\mathrm{ab}}:\mathbf Q]\),
then
\(a_e(Z)-a_e(Y)\ge\lceil d/((h-1)\kappa)\rceil\) at every height,
and likewise for \(\Delta(Z)-\Delta(Y)\).

For the fixed genus-nine \(X\) used by both candidate pairs,
\(a(X)=3\) and \(K\cap\mathbf Q^{\mathrm{ab}}=\mathbf Q(\zeta_3)\).
Consequently every such Galois cover of **any** genus-two curve
which maps separably to \(X\) satisfies \(a_e(Z)-a_e(Y)\ge5\)
for every e and for the stable
p-rank defect. If \(3\nmid|G|\), the stronger excess bound is nine.

Thus the a-number-four common-source case is impossible when the
actual genus-two leg is Galois of degree prime to five. Together
with the [Galois Raynaud gap](../theta_divisors/galois_raynaud_rank_gap.md),
this leaves both legs non-Galois in the current excess-one
nonvanishing bottleneck. No assertion about all possible source
a-numbers or Galois closures of p-divisible order is made.

[Proof](../../../Proofs/jacobians/isogeny_sieves/cartier_endomorphism_packet_bound.md).
