# General two-prime rectangles and exact axis descent

Date: 2026-09-05.
Authors: `/root` (extensions and proposed applications) and
`/root/gluing_cohomology_rigidity` (derivation and proof checks).
Status: collaborative author proof; not independently audited.
The coprime-product descent input is credited to its linked author below.
No novelty, core-existence, or cofinality claim is made. Earlier notes
and the fixed curves are unchanged.

## 1. A broader conditional rectangle theorem

Work over \(k=\overline{\mathbf F}_p\). Fix actual finite étale maps
\[
 X\xleftarrow{f}Z\xrightarrow{g}Y
\]
between smooth proper connected hyperbolic curves. Put
\(A_X=J(X^{(1)})\), \(A_Y=J(Y^{(1)})\), and assume that
\[
 D=\{(L,M):
 H^0(Z^{(1)},\mathcal B_Z\otimes(f^{(1)})^*L
                         \otimes(g^{(1)})^*M)\ne0\}
       \subset A_X\times A_Y                              \tag{1.1}
\]
is proper. Here
\(\mathcal B_Z=F_{Z/k*}\mathcal O_Z/\mathcal O_{Z^{(1)}}\).
Properness is an additional hypothesis, not a conclusion from the
other assumptions.
The curves \(X,Y\) may coincide, and self-correspondences with \(f=g\)
are not excluded.

Choose distinct primes \(\ell_X,\ell_Y\ne p\).

**Theorem A.** Each of the following choices gives an ordinary mixed
block after a finite initial rectangle.

1. If both Jacobians are geometrically simple, use their maximal
   abelian exponent-\(\ell_X^m\) and exponent-\(\ell_Y^n\) towers.
   **No nonisogeny or Hom-zero assumption is needed.** More generally,
   any prescribed finite-rank pro-\(\ell_X\) and pro-\(\ell_Y\) abelian
   directions work in this case.
2. For arbitrary Jacobians, choose Haar-generic cyclic
   \(\mathbf Z_{\ell_X}\)- and \(\mathbf Z_{\ell_Y}\)-directions.
   A product of two open dense full-measure sets of directions suffices.

More precisely, let \(X_m/X,Y_n/Y\) denote the chosen actual towers.
There are cutoffs \(a,b\) such that compatible connected components
\[
 W_{m,n}\subset Z\times_X X_m\times_Y Y_n,
        \qquad m\ge a,\ n\ge b,
\]
retain finite étale maps to \(Z,X_m,Y_n\), and
\[
 \operatorname{Gal}(W_{m,n}/W_{a,b})=K_X\times K_Y,
\]
where the two full tail groups have coprime orders. Their quotients
are \(W_{a,n}\) and \(W_{m,b}\). The quotient
\[
 J(W_{m,n})/
 \bigl(\operatorname{Im}J(W_{m,b})+
       \operatorname{Im}J(W_{a,n})\bigr)                  \tag{1.2}
\]
is ordinary. Equivalently, the rational projector
\((1-e_{K_X})(1-e_{K_Y})\), with
\(e_K=|K|^{-1}\sum_{h\in K}h\), has ordinary image. In particular,
\[
 \Delta(W_{m,n})=\Delta(W_{m,b})+\Delta(W_{a,n})
                                  -\Delta(W_{a,b}),       \tag{1.3}
\]
where \(\Delta=g-f\). These assertions hold for every compatible
connected-component choice.

## 2. Distinct primes separate the axis intersections

Use the finite-support Boxall decomposition from
[Section 2 of the preceding rectangle note](ORDINARY_MIXED_BLOCKS_IN_TWO_LEG_ABELIAN_RECTANGLES.md#2-finite-support-torsion-cosets-give-horizontal-and-vertical-strips):
with \(S=\{\ell_X,\ell_Y\}\),
\[
 D(k)\cap(A_X\times A_Y)[S^\infty](k)
       =\bigcup_{i=1}^s\bigl(t_i+B_i[S^\infty](k)\bigr),
       \qquad t_i+B_i\subset D.                           \tag{2.1}
\]
Every \(B_i\) is a proper abelian subvariety because \(D\) is proper.
Unlike the earlier nonisogenous case, these subvarieties may include
diagonals and graphs of isogenies.

For any abelian subvariety \(B\subset A_X\times A_Y\), put
\[
 K_X=(B\cap(A_X\times0))_{\mathrm{red}},\qquad
 K_Y=(B\cap(0\times A_Y))_{\mathrm{red}},
\]
viewed as possibly disconnected reduced subgroups of the two axes.
Then, on geometric points,
\[
 \begin{split}
 B\cap\bigl(A_X[\ell_X^\infty]\times A_Y[\ell_Y^\infty]\bigr)
   =K_X[\ell_X^\infty]\times K_Y[\ell_Y^\infty].           \tag{2.2}
 \end{split}
\]
Indeed, if \((x,y)\in B\) has orders dividing \(\ell_X^u,\ell_Y^v\),
the Chinese remainder theorem supplies an integer acting as one on
\(x\) and zero on \(y\). Thus \((x,0)\in B\), and then \((0,y)\in B\).
The converse is immediate. The same proof works after restricting the
axes to any subgroups \(\Gamma_X,\Gamma_Y\) of their respective primary
torsion.

If a coset \(t+B\) meets \(H=\Gamma_X\times\Gamma_Y\), choose
\(h=(h_X,h_Y)\) in that intersection. Then
\[
 (t+B)\cap H
   =h+\bigl((\Gamma_X\cap K_X)\times(\Gamma_Y\cap K_Y)\bigr).
                                                               \tag{2.3}
\]
All torsion notation here is pointwise. Nonreduced kernels add no
geometric prime-to-\(p\) points. The reduced groups \(K_X,K_Y\) are
smooth; their identity components \(C_X,C_Y\) are abelian subvarieties,
and their component groups are finite.

If \(A_X,A_Y\) are simple, each \(K_X,K_Y\) is either finite or the
whole axis. A proper \(B\) cannot contain both axes. Hence one factor
on the right of (2.3) is finite, without any nonisogeny assumption.
Finitely many cosets therefore give uniform coordinate-order cutoffs.

## 3. Generic cyclic directions for arbitrary Jacobians

For each \(B_i\), form \(C_{i,X}=K_{i,X}^0\) and
\(C_{i,Y}=K_{i,Y}^0\). Choose a cyclic Prüfer direction
\(\Gamma_X\subset A_X[\ell_X^\infty]\) whose rational Tate line is not
contained in \(V_{\ell_X}C_{i,X}\) whenever \(C_{i,X}\ne A_X\).
Make the analogous choice on the Y-axis.

These are finitely many proper linear-subspace exclusions. Their
complement is open dense and has full measure in the corresponding
\(\ell\)-adic projective space. This is genericity of Tate directions,
not a claim about generic curves over a finite field.

For each proper \(C_{i,X}\), the group \(\Gamma_X\cap K_{i,X}\) is
finite. Otherwise it would equal \(\Gamma_X\), since every proper
subgroup of a rank-one Prüfer group is finite. Its image in the finite
component group \(K_{i,X}/C_{i,X}\) would then be zero, because a
divisible group has no nonzero finite quotient. Thus
\(\Gamma_X\subset C_{i,X}\), contrary to the chosen Tate direction.
The same reasoning applies to Y.

For every proper \(B_i\), at least one of \(C_{i,X},C_{i,Y}\) is proper;
otherwise \(B_i\) contains both full axes. Therefore (2.3) again has
a finite factor. After discarding empty intersections, choose one
representative \(h_i\) in each of the finitely many remaining cosets.
Its finite coordinate orders, together with those of the finite factors,
give cutoffs \(a_\theta,b_\theta\) such that
\[
 \begin{gathered}
 L\in\Gamma_X,\quad M\in\Gamma_Y,\\
 L\notin\Gamma_X[\ell_X^{a_\theta}],\quad
 M\notin\Gamma_Y[\ell_Y^{b_\theta}]
       \quad\Longrightarrow\quad (L,M)\notin D.           \tag{3.1}
 \end{gathered}
\]
No arithmetic-Frobenius invariance of either direction is required.

## 4. Ordinary mixed blocks on actual components

For both cases of Theorem A, (3.1) is the required high-high avoidance.
Character decomposition on the full, possibly disconnected rectangle
has Frobenius kernel at \((L,M)\) equal, up to scalar twist, to the
space in (1.1). Semilinear Frobenius sends labels to \((L^p,M^p)\),
preserving both coordinate orders. Thus the whole high-high block has
bijective Frobenius, not merely a bounded first kernel.

The component and projector proof of
[Sections 4--5 of the preceding rectangle note](ORDINARY_MIXED_BLOCKS_IN_TWO_LEG_ABELIAN_RECTANGLES.md#4-actual-connected-components-and-the-finite-initial-stage)
works for any chosen finite-rank pro-\(\ell\) abelian quotient, including
cyclic ones. Explicitly, one may take
\[
 a\ge\max(a_\theta,v_{\ell_X}(\deg f)),\qquad
 b\ge\max(b_\theta,v_{\ell_Y}(\deg g)).                    \tag{4.1}
\]
The image of \(\pi_1(Z)\) in each chosen abelian deck lattice has index
dividing the corresponding covering degree. Consequently the full
tail kernels beyond (4.1) preserve every component. The connected
axis components have coprime Galois degrees over \(Z\), so their fiber
product is connected and has the asserted product tail group.

The averaging projector \((1-e_{K_X})(1-e_{K_Y})\) selects the high-high
block and restricts componentwise. Its image is ordinary, proving
(1.2); the four commuting axis projectors give (1.3). All maps used
are actual étale maps. Individual components are not assumed to carry
the full original deck group.

## 5. Exact union of axis map sets

Let \(T/k\) be hyperbolic and suppose \(J(T)\) has no ordinary simple
isogeny factor. There is no nonzero homomorphism from the ordinary
mixed factor to \(J(T)\). Hence every nonconstant \(r:W_{m,n}\to T\)
satisfies the mixed-Jacobian vanishing hypothesis of
[the coprime-product descent theorem](COPRIME_PRODUCT_MIXED_JACOBIAN_VANISHING_FORCES_DESCENT.md).
It descends through one entire tail factor. If \(r\) is étale, its
descended map is étale as well.

Writing \(\operatorname{Et}(U,T)\) for actual finite étale maps and
identifying maps with their pullbacks, one obtains the exact identities
\[
 \operatorname{Et}(W_{m,n},T)
  =\operatorname{Et}(W_{m,b},T)\cup\operatorname{Et}(W_{a,n},T),
                                                               \tag{5.1}
\]
\[
 \operatorname{Et}(W_{m,b},T)\cap\operatorname{Et}(W_{a,n},T)
       =\operatorname{Et}(W_{a,b},T).                     \tag{5.2}
\]
For (5.2), a map descending through both factors is fixed by their
product and thus descends to the corner. Equivalently, the two axis
fields intersect in \(k(W_{a,b})\). Each finite-level set is finite:
the étale degree is fixed by Riemann--Hurwitz, and the tangent space
of the corresponding fixed-degree Hom scheme is
\(H^0(U,r^*T_T)=0\).

Passing to the direct limit, all such target maps arising anywhere in
the rectangle tower form the union of the maps arising along its two
boundary towers. This is a finite union of towers, not a finite set of
targets or a uniform finite-level stabilization theorem.

There is also an exact one-sided minimal-image statement. Write
\(W=P\times_B Q\) for a stabilized rectangle and retain its specified
projection \(q_Q\). For an étale map \(r:W\to T\), the minimal joint
image of \((r,q_Q)\) is either \(Q\), if \(r\) descends to \(Q\), or
\[
                         P'\times_B Q,                  \tag{5.3}
\]
where \(P'\) is the normalization of
\(k(B)r_P^*k(T)\subset k(P)\) for a descent \(r_P:P\to T\).
Both \(P'\to B\) and \(P'\to T\) are étale intermediate maps, and
(5.3) is connected because its two degrees over \(B\) are coprime.
Its field is exactly \(k(Q)r^*k(T)\), so it is the genuine minimal
joint image, not merely a dominating auxiliary curve.

## 6. What is not proved about all minimal correspondences

For fixed boundary curves \(P,Q\) over \(B\), their connected product
\(P\times_B Q\) is the unique minimal correspondence whose two maps
commute with the specified maps to \(B\). This follows directly from
the fiber-product universal property and the compositum of the two
function fields.

Arbitrary minimal correspondences between \(P,Q\) need not have that
compatibility, or admit a refinement in these rectangles. Moreover,
the boundary Jacobians generally have ordinary factors, so they are
not automatically allowable targets in Section 5. When two allowable
target maps both come from a rectangle, their separate descents can
choose opposite axes; separate descent does not imply joint descent
to one axis. Maps already descending to \(Z\) are fully compatible
with every conclusion here and give no contradiction.

Iteration does not repair these missing hypotheses automatically.
An axis has no remaining mixed direction in the same grid. New
rectangles require new properness/transversality input, and no uniform
decreasing complexity or bounded recursion depth has been proved.

There is also a concrete obstruction to cofinality among all étale
covers. Covers in one grid are abelian over its corner. Finite chains
of abelian refinements have solvable Galois closure over that corner:
inductively, the compositum of the conjugate abelian top extensions
has abelian Galois group over the preceding Galois closure. Subcovers
and finite composita remain in the solvable class.

In characteristic 5 every hyperbolic corner nevertheless has an
étale Galois cover with group \(\operatorname{SL}_2(\mathbf F_7)\),
which has order 336 and is nontrivial and perfect. Indeed the
prime-to-5 fundamental group has the usual surface-group finite
quotients: see Milne, *Étale Cohomology*, Remark I.5.2(j), p. 39 of
[the author's revised Chapter I](https://www.jmilne.org/math/Books/ECpup1.pdf),
and [prime-to-p specialization, Stacks Theorem 58.30.3](https://stacks.math.columbia.edu/tag/0C0R).
Send two of the surface generators to elementary upper and lower
unipotent generators of \(\operatorname{SL}_2(\mathbf F_7)\), and all
their paired generators to one. The surface relation is satisfied.
These elementary matrices generate the group. Conjugation by
\(\operatorname{diag}(2,4)\) shows that all upper and lower unipotents
are commutators (the corresponding nonzero multipliers are 3 and 1),
so the group is perfect. Its cover cannot be dominated, over the
corner, by any iterated abelian refinement.

This last example proves failure of cover-theoretic cofinality; it
does **not** by itself construct a new minimal correspondence between
the prescribed boundary curves. Extra source refinements can disappear
upon taking a minimal joint image. A coverage theorem specifically
for minimal correspondences would therefore be additional input.
