# Proof: faithful specialization prevents an inseparable factor

[Statement](../../Theorems/quotient_geometry/galois_good_reduction.md).
Extend the coefficient field so that both curves have smooth proper
models and the geometric deck group is constant.

The generic map extends to the models. To see this, choose a section
of the target after further finite extension, embed its good model
into its relative Jacobian, and use the Neron mapping property of
that abelian scheme. The image of the resulting map lies in the
curve: its defining ideal vanishes generically, and the source is
flat. This is the same extension argument as in the
[prime-to-characteristic map lemma](tame_covers/auxiliary_atlas_good_reduction.md).

Pulling back an ample line bundle shows that the special map has
the same positive degree $d$ as the generic map. Thus it is a finite
map, with no assertion of separability yet.

Each of the $d$ deck automorphisms extends to the good stable model
of $D$. They remain distinct on the special fiber. Indeed the
automorphism functor of a smooth curve of genus at least two is
unramified: its tangent space is $H^0(D_0,T_{D_0})=0$. Two sections
of this separated unramified functor agreeing on the closed fiber
agree on an open neighborhood of it, hence on the trait. This also
proves injectivity of specialization for wild-order automorphisms.

The $d$ distinct specialized automorphisms fix the special target.
For any finite extension of function fields, its automorphism group
has order at most its separable degree. Consequently the special
map has separable degree at least $d$, and its total degree is $d$.
It is therefore separable. Constancy of the genera and the generic
etaleness give
\[
2g(D_0)-2=d(2g(C_0)-2).
\]
Riemann--Hurwitz makes the special different zero. The extended
map is proper and fiberwise quasi-finite, hence finite; it is etale
on both fibers and therefore finite etale over $R$.

For the atlas consequence, use the actual generic fiber product
$D=C\times_{\mathscr S}H$. Its map to $H$ is a torsor under the
prime-to-characteristic deck group of $C\to\mathscr S$.
Prime-to-characteristic specialization of the fundamental group
of the good proper curve $H$ extends this torsor after finite
extension. Thus every connected component $D'$ has good reduction.
This uses [SGA1 X3.8](https://grothendiecksga.com/read/sga1/en/X.html).

The other projection is a torsor under the possibly wild group of
$H\to\mathscr S$. A connected component $D'\to C$ is still a
Galois etale cover, with the subgroup stabilizing that component
as its deck group. Apply the preceding lemma to the good models
of $D'$ and $C$. Both original projection maps now extend etale.

Hyperbolicity cannot be dropped from the faithful-specialization
step: translations on elliptic curves can specialize to the identity.
Nor does good reduction of two curves alone make an arbitrary
non-Galois special map separable. The full set of actual deck
automorphisms is what removes that possibility here.
