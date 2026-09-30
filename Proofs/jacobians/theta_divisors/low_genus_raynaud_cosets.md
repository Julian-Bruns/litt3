# Proof: low genus, Wronskians, and abelian covers

[Statement](../../../Theorems/jacobians/theta_divisors/low_genus_raynaud_cosets.md).
The argument uses the audited
[Raynaud family dimension bound](raynaud_rank_one_dimension.md).
It replaces the former possible fourth-order exceptions after
an étale double cover. No ordinary-Prym hypothesis or finite
torsion calculation is needed.

For codimension-one vanishing in characteristics two, three or
five, the shorter general proof is now the
[abelian-component argument](raynaud_abelian_components.md).
The section-independence calculations here remain needed for the
other characteristics and the genus-four codimension-two result.

## 1. The generic number of sections is at most \(g(C)-1\)

Write \(G=g(C)\), and let \(N\in J(C^{(1)})\). The defining
Frobenius sequence, after twisting, is
\[
0\longrightarrow N
\longrightarrow F_{C/k*}F_{C/k}^*N
\longrightarrow B_C\otimes N\longrightarrow0.
\tag{3}
\]
Outside the finite kernel of \(F_C^*:J(C^{(1)})\to J(C)\),
both \(N\) and \(F_C^*N\) are nontrivial degree-zero lines.
They have no sections. Thus
\[
H^0(B_C\otimes N)\hookrightarrow H^1(N),
\qquad h^0(B_C\otimes N)\le G-1.
\tag{4}
\]
Every positive-dimensional abelian coset meets this open set.

Let \(A+L_0\) be an abelian divisor coset contained in
\(\Theta_{B_C}\), so that \(\dim A=G-1\).
Its generic defect is positive. The rank-one dimension theorem
excludes defect one on this coset and on every opposite translate.
For \(G=2\), this already contradicts (4).

## 2. A generic pencil in genus three is independent

For \(G=3\), equations (4) and the preceding exclusion force
generic defect exactly two. We show that two independent global
sections of \(B_C\otimes N\), for any degree-zero \(N\),
are independent over the function field of \(C^{(1)}\).

Otherwise they generate generically a line. Saturate that image
to a line subbundle \(S\subset B_C\otimes N\). It has at least
two independent sections. A line with two sections on a
positive-genus curve has degree at least two: removing their
common zeros gives a nonconstant map to \(\mathbf P^1\),
and a degree-one such map would make the smooth curve rational.

On the other hand the nonzero map
\(S\otimes N^{-1}\to B_C\hookrightarrow F_*\omega_C\)
gives by Frobenius adjunction
\[
p\deg S\le\deg\omega_C=4.
\tag{5}
\]
For odd \(p\), this gives \(\deg S\le1\), a contradiction.
The argument applies equally to both opposite cosets.

The \(s=2\) Wronskian dimension bound now gives
\[
2=\dim A\le\frac{3(p-1)}{2p}<2,
\tag{6}
\]
which is impossible. This proves the genus-three assertion.
It excludes containment set-theoretically, independently of
any component multiplicity.

## 3. Three sections in genus four

Suppose \(G=4\) and \(p\ge5\). The line-subbundle argument
in Section 2 now gives \(p\deg S\le6\), hence again
\(\deg S\le1\). Thus every pair of independent global sections
of \(B_C\otimes N\) is independent over the function field.

Let \(W\) be a three-dimensional space of global sections. If
its generic evaluation rank were two, its saturated image would
be a rank-two bundle \(S\subset B_C\otimes N\). The map
\[
\bigwedge^2W\longrightarrow H^0(C^{(1)},\det S)
\tag{6a}
\]
is injective. Indeed, every nonzero bivector in a three-dimensional
vector space is decomposable; a nonzero element in this kernel
would give a pair of independent global sections whose evaluations
are dependent, contrary to the preceding paragraph. Therefore
\(h^0(\det S)\ge3\).

The order-two Wronskian is nonzero on \(\det S\) because the
evaluation rank is two. Its Frobenius adjoint is a nonzero map
of lines
\[
F_C^*(\det S)\longrightarrow
\omega_C^{\otimes3}\otimes F_C^*N^{\otimes2}.
\tag{6b}
\]
Consequently \(p\deg\det S\le18\), so \(\deg\det S\le3\).
But a line of degree at most three on a genus-four curve cannot
have three sections: if it has three, Riemann--Roch makes it
special and Clifford's inequality gives
\(h^0\le1+\deg/2<3\). This contradiction proves that the
evaluation of every such \(W\) has rank three. Rank one was
already excluded by the pair argument.

On a positive-dimensional coset the generic defect is at most
three by (4). Each possible positive defect \(s=1,2,3\)
therefore satisfies the independent-section dimension bound on
both opposite cosets. For an abelian divisor this would give
\[
3\le\frac{3(p-1)(s+1)}{2ps}<3,
\tag{6c}
\]
which is impossible. This proves the genus-four assertion for
every \(p\ge5\).

For a two-dimensional coset, defect three is impossible since
its upper dimension bound is \(2(p-1)/p<2\). Defect two has
upper bound \(9(p-1)/(4p)\), strictly less than two for
\(p=5,7\). Thus in these two characteristics every bad
two-dimensional coset has generic defect exactly one. This
argument does not exclude that remaining value.

## 4. All translates on the double-cover axis

An étale double cover of a genus-two curve has genus three.
Since \(p\ne2\), the norm identity
\(\operatorname{Nm}_\pi\pi^*=[2]\) makes
\(\pi^*:J(Y^{(1)})\to J(U^{(1)})\) have finite kernel.
Its image \(A\) has dimension two, hence codimension one.
For every fixed \(L_0\), Sections 1--2 exclude
\(L_0+A\subset\Theta_{B_U}\). The good locus is open, so
its pullback to \(J(Y^{(1)})\) is a nonempty open set.
This is exactly (1). If \(\pi\) is the identity, the same
assertion is Raynaud's properness theorem for the full Jacobian.

This conclusion is stronger than a finite list of permissible
bad translates: the list is empty. There is no restriction to
odd-order characters, and no remaining fourth-order case.

## 5. An abelian layer and \(p\)-group refinements

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

## 6. The original source and the monodromy formulation

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
Section 5 gives a nonempty open of twists with zero cohomology
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
