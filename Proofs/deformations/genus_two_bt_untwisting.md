# Proof: one lost level per intrinsic Frobenius untwist

[Statement](../../Theorems/deformations/genus_two_bt_untwisting.md).
The full-group case and its two-map consequence follow from
[unramified BT untwisting](unramified_bt_genus_two.md) with \(f=1\).
Only the truncated construction and its cutoff are proved here.
All Frobenius pullbacks below are absolute; they commute with the
specified maps.

## The degree test at a nonzero Kodaira--Spencer step

The Hodge and conjugate line filtrations of the Dieudonné crystal
modulo \(p\) give \(\deg H=0\). The Hasse map
\(L\to F_C^*L\), for \(L=\omega_G\), is generically nonzero and has
a zero, so \(d=\deg L>0\). The Kodaira--Spencer map is
\(\kappa:L\to M\otimes\omega_C\), with \(\deg M=-d\).
If \(\kappa\ne0\), its zero divisor has degree \(2-2d\).
Thus \(d=1\) on a genus-two curve and \(\kappa\) is everywhere
an isomorphism. These filtrations and the degree test apply to every
BT\(_N\) with \(N\ge1\).

## Intrinsic untwisting at finite level

Let \(G\) be a generically ordinary BT\(_N\), \(N\ge2\), with
\(\kappa=0\). After a finite separable extension of the function
field, trivialize the multiplicative and étale parts. The ordinary
extension is represented by a Kummer parameter
\(q\in K_\eta^\times/K_\eta^{\times p^N}\). Its first-order variation
along a derivation is \(dq/q\): pullback replaces \(q\) by
\(q(1+\epsilon\,dq/q)\), and \(p^N\)-th powers have zero
\(\epsilon\)-coefficient. Thus zero Kodaira--Spencer means
\(q\in K_\eta^p\), exactly the splitting of its order-\(p\)
extension. The splitting is unique and descends from the separable
extension.

Let \(K\subset G[p]\) be the finite flat closure of its unique
generically étale subgroup of order \(p\). Define
\[
G_1=(G/K)[p^{N-1}].
\tag{1}
\]
This is a BT\(_{N-1}\) group. Locally extend \(G\) to the
\(p^N\)-torsion of a full group \(\widetilde G\), and form
\(\widetilde G/K\). Its \(p^{N-1}\)-torsion lies in the image of
\(G\): if \(p^{N-1}b=0\) and \(x\) lifts \(b\), then
\(p^{N-1}x\in K\), so \(p^Nx=0\). Formula (1) is therefore
precisely \((\widetilde G/K)[p^{N-1}]\) locally. This verifies
flatness and the truncated BT identities. Local full-group
extensions may be taken after faithfully flat ind-étale
localization, using smooth surjective truncation maps and their
limit presentation in
[Lau, Section 1.3](https://arxiv.org/pdf/1006.2723).
Only finite-level assertions are descended.

There is a canonical isomorphism
\[
F_C^*G_1\simeq G[p^{N-1}].
\tag{2}
\]
Multiplication by \(p\) factors through \(B=G/K\), giving a
surjection \(\psi:B\to G[p^{N-1}]\). Its kernel is \(G[p]/K\),
generically connected of order \(p\). On a local full-group
quotient \(\widetilde B=\widetilde G/K\), the corresponding
complementary isogeny has kernel \(\ker F_{\widetilde B}\):
both finite flat subgroups are the closure of that same generic
subgroup. Its restriction to \(B\) therefore factors through
relative Frobenius. The Frobenius image of \(B\) is \(F_C^*G_1\),
as follows either from this complementary isogeny or from its
order \(p^{2N-2}\) and containment in the \(p^{N-1}\)-torsion
of \(\widetilde B^{(p)}\). The induced map to \(G[p^{N-1}]\)
is an isomorphism. It is defined by \([p]\), the unique \(K\),
and relative Frobenius, so the local maps glue. In particular
(1)--(2) commute with isomorphisms and finite étale pullback.

The Hodge line is unchanged by passing to a positive lower
truncation. Equation (2) divides its degree by \(p\), and mixed
fibers persist. After \(j\) zero-Kodaira--Spencer steps, the
remaining level is \(N-j\) and its Hodge degree is \(d/p^j\).

Suppose \(N\ge a+2\), where \(a=v_p(d)\). If the process had not
stopped by step \(a\), at least two levels would remain; one more
step would produce a Hodge line of nonintegral degree. At the
stopping step the preceding degree test forces degree one and
everywhere-versality. Hence the stopping step is exactly \(a\),
\(d=p^a\), and iteration of (2) proves the theorem's identity.

## Both actual maps and the deformation cutoff

For compatible groups on an actual span, vanishing or nonvanishing
of Kodaira--Spencer agrees after pullback. The intrinsic quotient
construction makes every untwisting compatible. Once the genus-two
group is everywhere versal, so are its common pullback and the
other endpoint group. The conservative bound of
[compatible BT lifting](compatible_bt_lifting.md) at level \(N-a\)
gives a lift over \(W_m\) when \(N-a\ge m+2\); its refinement clause
returns the original two maps.

If \(p^e=0\) in the joint deformation ring, a map to \(W_{e+1}\)
is impossible. Thus \(N-a\le e+2\), or \(a\ge N-e-2\).
Unbounded \(N\) with bounded \(a\) gives arbitrarily long Witt
lifts, and the existing joint-ring criterion gives a possibly
ramified full lift. No inverse limit of finite group choices is
used.
