# Proof: maximal two-cover of the prescribed genus-two family

[Statement](../../../Theorems/jacobians/ordinary_covers/genus_two_maximal_two_cover.md).
The family calculation is local to this work; the ordinary p-cover
step is Crew's Corollary1.8.3. Work over any algebraically closed field
of characteristic5.

## 1. The actual maximal cover, including infinity

The five square classes u−a, a∈{0,1,2,3,t}, are independent by their
valuations, so T_t→P1 has group (C2)^5. Inertia is one sign change at
each finite branch point and the simultaneous sign change at infinity:
the quotients (u−a)/(u−b) are local squares there. None belongs to the
kernel of the product character defining Y_t. Thus T_t→Y_t is étale
of degree16 and genus17. Kummer theory gives dim_F2 J(Y_t)[2]=4, so
this connected cover realizes the maximal elementary abelian two-cover.

## 2. One affine orbit gives all elliptic exceptions

The quadratic sign quotients are indexed by the nonempty even subsets
of the six branch points. Subsets of size2 give genus0; the fifteen
four-subsets give elliptic curves; the full set gives Y_t. Tame descent
identifies each character's differential space with its quotient's.
Since the signs lie in F5, Cartier preserves these spaces. Consequently
a(T_t) is the sum of the a-numbers of Y_t and the fifteen elliptic
quotients, counted by their characters even when some are isomorphic.

The coordinate x=1/(u−4) sends the fixed five branch points to F5.
The moving point is s=1/(t−4), with s=∞ when t=4. Smoothness means
s∉F5. For the Legendre curve z²=x(x−1)(x−λ), the Hasse polynomial is

    [x^4](x(x−1)(x−λ))²=λ²−λ+1.

Its two roots lie in F25\F5. Thus every elliptic quotient with four
F5-rational branch points is ordinary. This handles all fifteen when
s=∞ and five when s is finite.

Each remaining quotient has branch set I∪{s}, where I is one of the
ten triples in F5. A projectivity over F5 sends I to {∞,0,1}, so it
has exactly two supersingular parameters s, both in F25\F5. These
twenty incidences are preserved by AGL1(F5). That group acts freely,
hence transitively, on the twenty points of F25\F5: as+b=s forces
a=1,b=0. Every such parameter therefore occurs exactly once. This
proves the entire elliptic contribution without a coefficient table.

For Y_t the usual two-by-two Cartier coefficient matrix is

    (t+1) [[1-2t,-2t],[-2,t-2]],
    determinant=3(t+1)^4.

Its rank is2 except at t=4, where it is0. Together with the elliptic
contribution this proves the stated a-number formula. The affine-orbit
argument proves the complete elliptic exception set directly; no
fifteen-row coefficient enumeration or exception-product computation
is needed.

## 3. The general unbounded p-group step

For smooth projective connected curves in characteristic p, an étale
Galois p-group cover is ordinary exactly when its base is:
[Crew, Étale p-covers in characteristic p, Corollary1.8.3](https://numdam.org/item/CM_1984__52_1_31_0.pdf#page=7).
Ordinariness descends under any separable cover, since pullback of
regular differentials is injective and commutes with Cartier.

Take the Galois closure W of the actual Y_t-leg and put V=W/P.
The elementary two-cover V is a quotient of ordinary T_t. Hence V,
and then W by Crew, is ordinary. The actual étale map W→Z→X pulls
back a nonzero Cartier-zero form from nonordinary X, a contradiction.

## 4. The fixed genus-nine endpoint needs no separate calculation

For X:y³=F(x) with F squarefree of degree10 in characteristic5,
Elkin's eigenspace dimensions are (d_1,d_2)=(3,6), including the
branch exponent2 at infinity; his permutation σ interchanges1 and2.
[Elkin, The rank of the Cartier operator on cyclic covers of the projective line, Theorem1.1 and equation(1.2)](https://arxiv.org/pdf/0708.0431#page=3)
therefore give rank Cartier≤min(3,6)+min(6,3)=6. Since g(X)=9,
a(X)≥3, for every such F.

Bounded medium audit of the affine-orbit replacement: PASS,
/root/audit_finite_rank_condensation,2026-09-14. The original cover,
Cartier matrix and endpoint argument retain author status.
