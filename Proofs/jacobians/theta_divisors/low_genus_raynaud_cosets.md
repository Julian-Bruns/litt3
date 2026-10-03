# Proof: independent sections and actual cover families

[Statement](../../../Theorems/jacobians/theta_divisors/low_genus_raynaud_cosets.md).
The [dimension theorem](raynaud_rank_one_dimension.md) now gives
codimension-one properness in every genus and characteristic.
The [earlier audit](../../../Research/audits/LOW_GENUS_RAYNAUD_COSETS_AUDIT_2026_09_15.md)
covers the genus-four calculation and the character/p-group arguments.
The new all-characteristic cover consequence uses only the strengthened
dimension input and the finite kernel of multiplication by two.

## 1. Fixed genus bounds independent global sections

For \(N\) outside the finite kernel of
\(F_C^*:J(C^{(1)})\to J(C)\), the Frobenius sequence
\[
0\longrightarrow N\longrightarrow F_{C/k*}F_{C/k}^*N
\longrightarrow B_C\otimes N\longrightarrow0
\]
gives \(H^0(B_C\otimes N)\hookrightarrow H^1(N)\), so its
dimension is at most \(G-1\). Every positive-dimensional abelian
coset meets this open set.

If two independent global sections were dependent over the curve's
function field, their saturated image would be a line
\(S\subset B_C\otimes N\) with at least two sections. Such a line
has degree at least two: remove the base divisor of a pencil,
and degree one would make the smooth curve rational.
Frobenius adjunction gives a nonzero map
\[
F_C^*(S\otimes N^{-1})\longrightarrow\omega_C,
\qquad p\deg S\le2(G-1).
\]
This is impossible for \(p>G-1\), proving the pair assertion.

Now assume \(p>3(G-1)/2\) and take three independent sections.
Their evaluation cannot have rank one by the pair assertion.
If its saturated image had rank two, call it \(S\).
Every nonzero bivector in a three-dimensional vector space is
decomposable, so the map
\[
\bigwedge^2W\longrightarrow H^0(\det S)
\]
is injective: a kernel bivector would give a dependent pair.
Thus \(\det S\) has at least three sections. Its nonzero order-two
Wronskian gives
\[
F_C^*\det S\longrightarrow
\omega_C^3\otimes F_C^*N^2,\qquad p\deg\det S\le6(G-1).
\]
Hence \(\deg\det S<4\). On a hyperbolic curve a line of degree
at most three cannot have three sections: Riemann--Roch gives
at most two if nonspecial, and Clifford gives at most
\(1+\deg/2<3\) if special. This contradiction proves the
triple assertion.

For \(G=4\), \(p\ge5\), the generic defect on a positive-dimensional
coset is at most three and all its generic sections are independent
on both opposite families. The Wronskian dimension bound gives
\(d\le3(p-1)(s+1)/(2ps)\).
If \(d=2\), defect three is impossible since the bound is
\(2(p-1)/p<2\). Defect two is impossible for \(p=5,7\), since
\(9(p-1)/(4p)<2\). Thus every bad two-dimensional coset in those
characteristics has defect exactly one.

## 2. All translates on the double-cover axis

An étale double cover of a genus-two curve has genus three.
The norm identity
\(\operatorname{Nm}_\pi\pi^*=[2]\) makes
\(\pi^*:J(Y^{(1)})\to J(U^{(1)})\) have finite kernel.
Its image \(A\) has dimension two, hence codimension one.
This remains true in characteristic two, with the full possibly
nonreduced kernel. For every fixed \(L_0\), the general dimension
theorem excludes
\(L_0+A\subset\Theta_{B_U}\). The good locus is open, so
its pullback to \(J(Y^{(1)})\) is a nonempty open set.
This is exactly (1). If \(\pi\) is the identity, the same
assertion is Raynaud's properness theorem for the full Jacobian.

This conclusion is stronger than a finite list of permissible
bad translates: the list is empty. There is no restriction to
odd-order characters, and no remaining fourth-order case.

## 3. An abelian layer and \(p\)-group refinements

First suppose \(h:V\to U\) is abelian Galois of degree prime
to \(p\), with group \(H\). On scalar Frobenius twists its
character decomposition and étale base change give
\[
h^{(1)}_*\mathcal O_{V^{(1)}}=
\bigoplus_{\chi\in H^\vee}L_\chi,\qquad
h^0(B_V\otimes h^{(1)*}\pi^{(1)*}M)
=\sum_{\chi\in H^\vee}
h^0(B_U\otimes L_\chi\otimes\pi^{(1)*}M).
\tag{7}
\]
Every summand vanishes on a nonempty open set by (1).
There are finitely many characters, so those opens have a
nonempty intersection in the irreducible parameter Jacobian.
Thus the inherited direction is proper on \(V\).

Here is the \(p\)-group step in the needed generality. If
\(r:D\to C\) is a Galois étale cover with finite \(p\)-group
\(P\), then \(r_*\mathcal O_D\) is associated to the regular
\(k[P]\)-representation. Every simple representation of a
finite \(p\)-group in characteristic \(p\) is trivial. A
composition series therefore descends to a filtration of
\(r_*\mathcal O_D\) with all successive quotients \(\mathcal O_C\).
For any vector bundle \(E\), the projection formula and this
filtration imply
\[
H^0(C,E)=0\quad\Longrightarrow\quad H^0(D,r^*E)=0.
\tag{8}
\]
The converse follows from injectivity of faithfully flat
pullback. This is an equality of vanishing loci, not an
averaging argument involving division by \(|P|\).

For an arbitrary finite abelian \(H\), first quotient its
cover by its \(p\)-primary subgroup. Formula (7) applies to
the prime-to-\(p\) quotient, and (8) applies to the remaining
\(p\)-group cover. It applies once more to \(W\to V\).
This proves (2).

## 4. The original source and the monodromy formulation

Let \(\widetilde Z\to Y\) be the actual Galois closure of
\(Z\to Y\), with group \(G\), and suppose \(R\triangleleft G\)
is a \(p\)-group such that \(\overline G=G/R\) has an abelian
subgroup \(H\) of index at most two. Put
\[
V=\widetilde Z/R,\qquad U=V/H.
\tag{9}
\]
The subgroup \(H\) is normal when its index is two.
Consequently \(U\to Y\) is either the identity or an étale
double cover, \(V\to U\) is abelian Galois, and
\(\widetilde Z\to V\) is Galois with \(p\)-group \(R\).
Section 3 gives a nonempty open of twists with zero cohomology
on \(\widetilde Z\). Pullback along the actual étale
\(\widetilde Z\to Z\) injects the cohomology on \(Z\), so
it vanishes on that same open.

For an actual span \(X\leftarrow Z\rightarrow Y\), this
produces a point with zero cohomology on the slice \(L=\mathcal O_X\)
of the full mixed family. Upper semicontinuity makes the mixed
generic defect zero. No descent or reconstruction of the
second map, and no simultaneous Galois closure, has been used.
The cover \(\widetilde Z\) is only the closure of the existing
\(Y\)-leg and still maps to \(X\) through the given \(Z\).
